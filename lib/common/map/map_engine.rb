# frozen_string_literal: true

# MapEngine: declarative replacement for mapdb StringProcs.
#
# A wayto/timeto value may be, in addition to a String or StringProc, a
# schema object (Hash/Array) interpreted by this engine:
#
#   timeto: { "cost" => 0.1, "requires" => ["setting:urchins", "not:hidden"] }
#           { "same_as" => "7:30714" }
#           { "event" => "instability", "key" => 2300 }
#
#   wayto:  [ { "do" => "send", "cmd" => "..." }, { "do" => "move", "cmd" => "..." } ]
#           { "strategy" => "table_join", "table" => "Ant Hill" }
#
# Cost evaluation is pure (no game commands). Crossing execution reuses the
# same primitives StringProcs call today (fput, move, dothistimeout, waitrt?).
# Unknown vocabulary never raises out of routing: an unknown requirement,
# step, or strategy makes the edge not routable / not crossable, which is the
# forward-compatibility contract for older clients reading newer map data.

module Lich
  module Common
    module MapEngine
      StepFailed = Class.new(StandardError)

      DEFAULT_AWAIT_TIMEOUT = 10
      MAX_LOOP_ITERATIONS   = 50

      # Event cost tables, name -> callable returning the table (or nil while
      # the event script is not running). Registered here rather than read
      # directly so the schema never names a global variable.
      @event_tables = {
        'instability' => proc { $mapdb_instability_timeto }
      }

      # Pass caches for 'pass:A+B' requirements, populated by strategies as an
      # explicit pre-trip phase; cost evaluation only reads them.
      @pass_cache = {}

      class << self
        attr_reader :event_tables, :pass_cache

        def register_event_table(name, &block)
          @event_tables[name.to_s] = block
        end

        # Loader entry points -------------------------------------------------

        def build_timeto(value)
          value.is_a?(Hash) ? Cost.new(value) : value
        end

        def build_wayto(value)
          (value.is_a?(Hash) || value.is_a?(Array)) ? Crossing.new(value) : value
        end

        # timeto evaluation ---------------------------------------------------

        # Resolve a schema cost entry to a Numeric or nil (edge not routable).
        # `seen` guards same_as reference cycles.
        def resolve_cost(entry, seen = nil)
          return entry if entry.is_a?(Numeric)
          return entry.call if entry.is_a?(StringProc)
          return nil unless entry.is_a?(Hash)

          if (ref = entry['same_as'])
            seen ||= []
            return nil if seen.include?(ref)
            seen << ref
            room_id, dest = ref.split(':', 2)
            room = Map[room_id.to_i]
            return nil unless room
            return resolve_cost(unwrap(room.timeto[dest]), seen)
          end

          if (ev = entry['event'])
            table_source = @event_tables[ev]
            table = table_source && table_source.call
            return table && table[entry['key']]
          end

          ok = Array(entry['requires']).all? { |req| requirement?(req) }
          return entry['cost'] if ok
          entry['else'] ? resolve_cost(entry['else'], seen) : nil
        end

        def requirement?(req)
          return false unless req.is_a?(String)
          kind, arg, extra = req.split(':', 3)
          case kind
          when 'setting'
            setting_on?(arg, extra)
          when 'grant'
            t = uservar("mapdb_#{arg}")
            !t.nil? && Time.now.to_i < t.to_i
          when 'not'
            !status?(arg)
          when 'is'
            status?(arg)
          when 'pass'
            towns = arg.to_s.split('+').sort
            expires = @pass_cache[towns]
            !expires.nil? && expires > (Time.now + 10)
          when 'prof'
            # Permissive when Stats is unavailable, mirroring the corpus's
            # (!defined?(Stats.prof) or Stats.prof == '...') idiom.
            stat = char_stat(:prof)
            stat.nil? || stat == arg
          when 'race'
            stat = char_stat(:race)
            stat.nil? || stat == arg
          when 'gender'
            stat = char_stat(:gender)
            stat.nil? || stat == arg
          when 'citizenship'
            defined?(Char) && Char.respond_to?(:citizenship) && Char.citizenship == arg
          when 'spell'
            defined?(Spell) && Spell[arg =~ /^\d+$/ ? arg.to_i : arg].active?
          when 'climate'
            defined?(Room) && Room.current&.climate == arg
          when 'month'
            Time.now.month == arg.to_i
          when 'var'
            name, expected = arg.to_s.split('=', 2)
            value = uservar("mapdb_#{name}")
            expected ? value.to_s == expected : !value.nil? && value != false
          else
            false # unknown vocabulary => not routable
          end
        end

        # Crossing execution --------------------------------------------------

        def cross(raw)
          if raw.is_a?(Hash) && raw['strategy']
            Strategies.run(raw)
          else
            steps = raw.is_a?(Array) ? raw : Array(raw['steps'])
            steps.each { |step| run_step(step) }
            true
          end
        end

        def run_step(step)
          raise StepFailed, "malformed step #{step.inspect}" unless step.is_a?(Hash)

          case step['do']
          when 'send'
            fput step['cmd']
          when 'move'
            move step['cmd']
          when 'await'
            run_await(step)
          when 'wait_rt'
            waitrt?
          when 'sleep'
            sleep step['seconds'].to_f
          when 'wait_room_change'
            start = XMLData.room_id
            timeout = (step['timeout'] || 30).to_f
            deadline = Time.now + timeout
            sleep 0.1 while XMLData.room_id == start && Time.now < deadline
            raise StepFailed, 'wait_room_change timed out' if XMLData.room_id == start
          when 'if'
            branch = condition?(step['when']) ? step['then'] : step['else']
            Array(branch).each { |s| run_step(s) }
          when 'empty_hands'
            empty_hands
          when 'fill_hands'
            fill_hands
          when 'replan'
            $go2_restart = true
          when 'repeat'
            run_repeat(step)
          else
            raise StepFailed, "unknown step #{step['do'].inspect}"
          end
        end

        # Bounded loop: runs its steps up to `times` iterations (hard-capped),
        # stopping early when `until_room` is reached or, with
        # `until_room_change`, when the room differs from the one at loop
        # entry. Bad data can waste a route, never hang Lich.
        def run_repeat(step)
          times = step['times'].to_i
          times = MAX_LOOP_ITERATIONS if times < 1 || times > MAX_LOOP_ITERATIONS
          start = XMLData.room_id
          times.times do
            break if step['until_room'] && XMLData.room_id == step['until_room'].to_i
            break if step['until_room_change'] && XMLData.room_id != start
            Array(step['steps']).each { |s| run_step(s) }
          end
        end

        def run_await(step)
          pattern = compile_pattern(step['for'])
          raise StepFailed, "bad pattern #{step['for'].inspect}" unless pattern
          timeout = (step['timeout'] || DEFAULT_AWAIT_TIMEOUT).to_f
          hit = dothistimeout(step['cmd'], timeout, pattern)
          unless hit
            case step['on_timeout'] || 'continue'
            when 'fail'
              raise StepFailed, "await timed out: #{step['cmd']}"
            when 'retry'
              hit = dothistimeout(step['cmd'], timeout, pattern)
              raise StepFailed, "await retry timed out: #{step['cmd']}" unless hit
            end
          end
          if hit && (br = step['if_match'])
            sub = compile_pattern(br['pattern'])
            Array(br['steps']).each { |s| run_step(s) } if sub && hit =~ sub
          end
          hit
        end

        def condition?(cond)
          return false unless cond.is_a?(String)
          kind, arg = cond.split(':', 2)
          case kind
          when 'spell'
            Spell[arg =~ /^\d+$/ ? arg.to_i : arg].active?
          when 'status'
            status?(arg)
          when 'setting'
            setting_on?(arg)
          else
            false
          end
        end

        # Pattern cache: compiled once per unique source; a pattern that fails
        # to compile is remembered as invalid (edge not crossable, no raise
        # storm on retries).
        def compile_pattern(source)
          return nil unless source.is_a?(String)
          @pattern_cache ||= {}
          return @pattern_cache[source] if @pattern_cache.key?(source)
          @pattern_cache[source] = begin
            Regexp.new(source)
          rescue RegexpError, ArgumentError
            nil
          end
        end

        # Shared helpers ------------------------------------------------------

        def setting_on?(name, tokens = nil)
          value = uservar("mapdb_use_#{name}")
          on = (value == true) || value.to_s =~ /^(?:yes|true)$/i
          return on unless tokens
          on || value.to_s.split(',').map(&:strip).include?(tokens)
        end

        def status?(name)
          case name
          when 'hidden'    then defined?(hidden?) ? hidden? : false
          when 'invisible' then defined?(invisible?) ? invisible? : false
          when 'sitting'   then defined?(sitting?) ? sitting? : false
          else false
          end
        end

        def char_stat(name)
          return nil unless defined?(Stats) && Stats.respond_to?(name)
          Stats.send(name)
        end

        def uservar(name)
          return nil unless defined?(UserVars)
          UserVars.respond_to?(name) ? UserVars.send(name) : nil
        end

        def unwrap(value)
          value.is_a?(Cost) || value.is_a?(Crossing) ? value.raw : value
        end
      end

      # Wraps a schema timeto Hash. Duck-types as a callable edge weight so
      # existing dispatch (`respond_to?(:call)`) treats it like a StringProc.
      class Cost
        attr_reader :raw

        def initialize(raw)
          @raw = raw
        end

        def call(*_args)
          MapEngine.resolve_cost(@raw)
        end

        def to_json(*args)
          @raw.to_json(*args)
        end

        def inspect
          "MapEngine::Cost.new(#{@raw.inspect})"
        end
      end

      # Wraps a schema wayto value (step Array or strategy Hash). Mirrors
      # StringProc's Proc masquerade so go2's `when Proc then way.call`
      # dispatch executes schema edges without modification.
      class Crossing
        attr_reader :raw

        def initialize(raw)
          @raw = raw
        end

        def call(*_args)
          MapEngine.cross(@raw)
        rescue StepFailed => e
          respond "--- MapEngine: crossing failed: #{e.message}" if defined?(respond)
          false
        end

        def kind_of?(type)
          Proc.new {}.kind_of?(type)
        end

        def class
          Proc
        end

        def to_json(*args)
          @raw.to_json(*args)
        end

        def inspect
          "MapEngine::Crossing.new(#{@raw.inspect})"
        end
      end

      # Named strategies: multi-phase travel services implemented in reviewed
      # Lich code, referenced from map data by name + parameters.
      module Strategies
        REGISTRY = {}
        REQUIRED_PARAMS = {}

        def self.register(name, klass, required_params = [])
          REGISTRY[name.to_s] = klass
          REQUIRED_PARAMS[name.to_s] = required_params
        end

        def self.known?(name)
          REGISTRY.key?(name.to_s)
        end

        def self.run(params)
          klass = REGISTRY[params['strategy'].to_s]
          raise StepFailed, "unknown strategy #{params['strategy'].inspect}" unless klass
          klass.new(params).run
        end

        # Replaces the 479 per-table StringProcs: go to a private table,
        # accepting the invitation when the response asks for one.
        class TableJoin
          HEAD_OVER = /You (?:and your group )?head over to/
          INVITED   = /waves.*you.*(?:invites|inviting) you(?: and your group)? to (?:join|come sit at)/

          def initialize(params)
            @table = params['table']
          end

          def run
            raise StepFailed, 'table_join requires a table name' unless @table
            cmd = "go #{@table} table"
            hit = dothistimeout(cmd, 25, Regexp.union(HEAD_OVER, INVITED))
            fput cmd if hit && hit =~ INVITED
            !hit.nil?
          end
        end
        register 'table_join', TableJoin, %w[table]
      end

      # Pure, offline validation of schema entries: structure, vocabulary, and
      # regex compilation. Suitable for submission CI and a local lint command.
      module Validator
        STEP_NAMES = %w[send move await wait_rt sleep wait_room_change if empty_hands fill_hands replan repeat].freeze
        REQUIREMENT_KINDS = %w[setting grant not is pass prof race gender citizenship spell climate month var].freeze
        CONDITION_KINDS = %w[spell status setting].freeze
        ON_TIMEOUT = %w[continue fail retry].freeze

        module_function

        def errors_for_timeto(value)
          return [] unless value.is_a?(Hash)
          errors = []
          if (ref = value['same_as'])
            errors << "same_as must look like 'room:dest', got #{ref.inspect}" unless ref.is_a?(String) && ref =~ /^\d+:\d+$/
            return errors
          end
          if value['event']
            errors << 'event entry requires a key' unless value.key?('key')
            return errors
          end
          errors << 'cost entry requires a numeric cost' unless value['cost'].is_a?(Numeric)
          Array(value['requires']).each do |req|
            kind = req.to_s.split(':', 2).first
            errors << "unknown requirement kind #{kind.inspect}" unless REQUIREMENT_KINDS.include?(kind)
          end
          errors.concat(errors_for_timeto(value['else'])) if value['else']
          errors
        end

        def errors_for_wayto(value)
          if value.is_a?(Hash) && value['strategy']
            name = value['strategy']
            return ["unknown strategy #{name.inspect}"] unless Strategies.known?(name)
            missing = Strategies::REQUIRED_PARAMS[name].reject { |p| value.key?(p) }
            return missing.map { |p| "strategy #{name} missing required param #{p.inspect}" }
          end
          steps = value.is_a?(Array) ? value : Array(value.is_a?(Hash) ? value['steps'] : nil)
          return ['wayto schema entry must be a step list or strategy'] if steps.empty?
          steps.flat_map { |step| errors_for_step(step) }
        end

        def errors_for_step(step)
          return ["step must be an object, got #{step.inspect}"] unless step.is_a?(Hash)
          errors = []
          name = step['do']
          return ["unknown step #{name.inspect}"] unless STEP_NAMES.include?(name)
          case name
          when 'send', 'move'
            errors << "#{name} requires cmd" unless step['cmd'].is_a?(String)
          when 'await'
            errors << 'await requires cmd' unless step['cmd'].is_a?(String)
            errors << 'await requires a pattern (for)' unless step['for'].is_a?(String)
            errors << "invalid regex #{step['for'].inspect}" if step['for'].is_a?(String) && !compilable?(step['for'])
            if step['on_timeout'] && !ON_TIMEOUT.include?(step['on_timeout'])
              errors << "unknown on_timeout policy #{step['on_timeout'].inspect}"
            end
            if (br = step['if_match'])
              errors << "invalid if_match regex #{br['pattern'].inspect}" unless br.is_a?(Hash) && compilable?(br['pattern'])
              errors.concat(Array(br.is_a?(Hash) ? br['steps'] : nil).flat_map { |s| errors_for_step(s) })
            end
          when 'sleep'
            errors << 'sleep requires numeric seconds' unless step['seconds'].is_a?(Numeric)
          when 'if'
            kind = step['when'].to_s.split(':', 2).first
            errors << "unknown condition kind #{kind.inspect}" unless CONDITION_KINDS.include?(kind)
            errors.concat(Array(step['then']).flat_map { |s| errors_for_step(s) })
            errors.concat(Array(step['else']).flat_map { |s| errors_for_step(s) })
          when 'repeat'
            errors << 'repeat requires steps' if Array(step['steps']).empty?
            unless step['until_room'] || step['until_room_change'] || step['times'].is_a?(Numeric)
              errors << 'repeat requires times, until_room, or until_room_change'
            end
            errors.concat(Array(step['steps']).flat_map { |s| errors_for_step(s) })
          end
          errors
        end

        def compilable?(source)
          return false unless source.is_a?(String)
          Regexp.new(source)
          true
        rescue RegexpError, ArgumentError
          false
        end
      end
    end
  end
end
