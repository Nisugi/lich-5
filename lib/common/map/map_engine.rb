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
      BreakLoop = Class.new(StandardError) # control flow: break out of the innermost repeat

      DEFAULT_AWAIT_TIMEOUT = 10
      MAX_LOOP_ITERATIONS   = 50

      # Legacy event globals a handful of edges write. Closed whitelist:
      # growing it is a reviewed Lich change, never a map-data change.
      SETTABLE_GLOBALS = %w[SILVERWOOD_TOWN].freeze

      # Event cost tables, name -> callable returning the table (or nil while
      # the event script is not running). Registered here rather than read
      # directly so the schema never names a global variable.
      @event_tables = {
        'instability' => proc { $mapdb_instability_timeto }
      }

      class << self
        attr_reader :event_tables

        def register_event_table(name, &block)
          @event_tables[name.to_s] = block
        end

        # Loader entry points -------------------------------------------------

        def build_timeto(value)
          value.is_a?(Hash) ? Cost.new(value) : value
        end

        def build_wayto(value, dest = nil)
          (value.is_a?(Hash) || value.is_a?(Array)) ? Crossing.new(value, dest) : value
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
            room_ref, dest = ref.split(':', 2)
            room = resolve_room_ref(room_ref)
            return nil unless room
            return resolve_cost(unwrap(room.timeto[dest]), seen)
          end

          if (ev = entry['event'])
            table_source = @event_tables[ev]
            table = table_source && table_source.call
            return table && table[entry['key']]
          end

          if (formula = entry['formula'])
            return resolve_formula(formula, entry)
          end

          ok = Array(entry['requires']).all? { |req| requirement?(req) }
          # An explicit null cost with passing requirements disables the edge
          # (the `cond ? nil : x` proc idiom); else-branches still apply when
          # the requirements fail.
          return entry['cost'] if ok
          entry['else'] ? resolve_cost(entry['else'], seen) : nil
        end

        # Named cost formulas for the handful of skill-scaled travel times.
        def resolve_formula(name, entry)
          case name
          when 'haste_scaled'
            # Haste-assisted crossing: walk time scales down with elemental
            # lore and MjE/level, floored at 40% of base. Spell lookup can
            # return nil (test instances, partial spell lists) - that means
            # the base cost, not an error.
            if defined?(Spell) && Spell['Haste']&.active?
              base = entry['base'].to_f
              factor = [((80 - ([Spells.majorelemental, Stats.level].min / 5) - (Skills.elair / 5)) / 100.0), 0.4].max
              (base * factor).floor + 0.2
            else
              entry['else'].is_a?(Hash) ? resolve_cost(entry['else']) : entry['else']
            end
          end
        end

        # Log each distinct failing cost entry once per session, so a broken
        # requirement is discoverable without spamming every dijkstra pass.
        def note_cost_error(raw, error)
          @cost_errors ||= {}
          key = raw.inspect
          return if @cost_errors[key]
          @cost_errors[key] = true
          echo "MapEngine: cost evaluation failed (edge treated as not routable): #{error.class}: #{error.message} for #{key}" if defined?(echo)
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
            # Bare names negate statuses (not:hidden); qualified requirements
            # negate recursively (not:subscription:premium).
            rest = req[4..]
            rest.include?(':') ? !requirement?(rest) : !status?(arg)
          when 'is'
            status?(arg)
          when 'pass'
            towns = arg.to_s.split('+')
            defined?(Strategies::DayPass) && towns.length == 2 &&
              Strategies::DayPass.usable?(towns[0], towns[1])
          when 'pass_buyable'
            uservar('mapdb_buy_day_pass').to_s =~ /^(?:yes|true)$|\b#{Regexp.escape(arg.to_s)}\b/i ? true : false
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
            defined?(Spell) && Spell[arg =~ /^\d+$/ ? arg.to_i : arg]&.active? ? true : false
          when 'climate'
            defined?(Room) && Room.current&.climate == arg
          when 'month'
            Time.now.month == arg.to_i
          when 'var'
            name, expected = arg.to_s.split('=', 2)
            var_check(uservar("mapdb_#{name}"), expected)
          when 'has_item'
            GameObj.inv.any? { |obj| obj.noun == arg || obj.name == arg }
          when 'no_script'
            arg.to_s.split(',').map(&:strip).none? { |name| Script.running?(name) }
          when 'var_raw'
            # Raw UserVars name (legacy variables outside the mapdb_ namespace)
            name, expected = arg.to_s.split('=', 2)
            value = defined?(UserVars) && UserVars.respond_to?(name) ? UserVars.send(name) : nil
            var_check(value, expected)
          when 'society'
            # society:NAME+RANK, society:NAME (any rank), society:+RANK (any society)
            society, rank = arg.to_s.split('+', 2)
            return false unless defined?(Society)
            (society.to_s.empty? || Society.status == society) &&
              (rank.nil? || rank.empty? || Society.rank == rank.to_i)
          when 'seeking_enabled'
            # go2's opt-in flag for symbol-of-seeking travel
            $go2_use_seeking ? true : false
          when 'spell_known'
            arg.to_s.split(',').any? { |num| Spell[num.strip.to_i]&.known? }
          when 'level'
            compare_number(defined?(Stats) ? Stats.level : XMLData.level, arg)
          when 'skill'
            # skill:climbing>=30 - permissive when Skills is unavailable,
            # mirroring the corpus's defined? guards.
            name, op_value = arg.to_s.split(/(?=[<>])/, 2)
            return true unless defined?(Skills) && Skills.respond_to?(name)
            compare_number(Skills.send(name), op_value)
          when 'climb_vs_encumbrance'
            # Skills.climbing >= max(encumbrance/1.25, MIN)
            Skills.climbing >= [XMLData.encumbrance_value / 1.25, arg.to_i].max
          when 'global'
            name, expected = arg.to_s.split('=', 2)
            return false unless SETTABLE_GLOBALS.include?(name)
            value = name == 'SILVERWOOD_TOWN' ? $SILVERWOOD_TOWN : nil
            expected ? value.to_s == expected : !value.nil?
          when 'room_name'
            re = compile_pattern(arg)
            !re.nil? && checkroom.to_s =~ re ? true : false
          when 'location'
            re = compile_pattern(arg)
            !re.nil? && Map.current&.location.to_s =~ re ? true : false
          when 'script_running'
            arg.to_s.split(',').any? { |name| Script.running?(name.strip) }
          when 'subscription'
            if defined?(Account) && Account.respond_to?(:subscription)
              Account.subscription.to_s.downcase == arg
            else
              # Legacy fallback: a set fwi trinket implies premium
              arg == 'premium' && uservar('mapdb_fwi_trinket').to_s != ''
            end
          when 'edge'
            room_ref, dest = arg.to_s.split(/[:+]/, 2)
            room = resolve_room_ref(room_ref)
            !room.nil? && !resolve_cost(unwrap(room.timeto[dest])).nil?
          when 'drskill'
            # drskill:Athletics>=100 (DRSkill.getmodrank)
            name, op_value = arg.to_s.split(/(?=[<>])/, 2)
            defined?(DRSkill) && compare_number(DRSkill.getmodrank(name), op_value)
          when 'guild'
            defined?(DRStats) && DRStats.guild == arg
          when 'circle'
            defined?(DRStats) && compare_number(DRStats.circle, arg)
          when 'premium'
            # DR premium access: paid subscription, the premium flag, or a
            # test instance named in the arg list (premium:DRT,DRX)
            (defined?(Account) && Account.respond_to?(:subscription) && Account.subscription.to_s.casecmp('premium').zero?) ||
              (uservar('premium') ? true : false) ||
              arg.to_s.split(',').map(&:strip).include?(XMLData.game)
          when 'script_exists'
            defined?(Script) && Script.respond_to?(:exists?) && Script.exists?(arg)
          when 'game'
            arg.to_s.split(',').map(&:strip).include?(XMLData.game)
          when 'dr_setting'
            defined?(get_settings) && get_settings.respond_to?(arg) && get_settings.send(arg) ? true : false
          when 'dr_spell_known'
            defined?(DRSpells) && DRSpells.known_spells[arg] ? true : false
          when 'stamina'
            compare_number(stamina, arg)
          else
            false # unknown vocabulary => not routable
          end
        end

        # Compare a number against an op-prefixed bound: '>=30', '>19', '<50'.
        def compare_number(value, spec)
          op, bound = spec.to_s.match(/\A(>=|<=|>|<|=)?\s*(\d+)\z/)&.captures
          return false unless bound
          case op
          when '>' then value.to_i > bound.to_i
          when '<' then value.to_i < bound.to_i
          when '<=' then value.to_i <= bound.to_i
          when nil, '=', '>=' then op == '>=' || op.nil? ? value.to_i >= bound.to_i : value.to_i == bound.to_i
          end
        end

        # Crossing execution --------------------------------------------------

        def cross(raw, dest = nil)
          if raw.is_a?(Hash) && raw['strategy']
            Strategies.run(raw, dest)
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
            fput expand_tokens(step['cmd'])
          when 'move'
            move expand_tokens(step['cmd'])
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
            met = if step['when_all']
                    Array(step['when_all']).all? { |c| condition?(c) }
                  else
                    condition?(step['when'])
                  end
            Array(met ? step['then'] : step['else']).each { |s| run_step(s) }
          when 'empty_hands'
            empty_hands
          when 'fill_hands'
            fill_hands
          when 'replan'
            $go2_restart = true
          when 'repeat'
            run_repeat(step)
          when 'set'
            value = step['value'].is_a?(String) ? expand_tokens(step['value']) : step['value']
            value = value.to_i if step['value'] == '{map_id}'
            # raw: legacy UserVars outside the mapdb_ namespace (DR portals)
            name = step['raw'] ? step['var'].to_s : "mapdb_#{step['var']}"
            UserVars.send("#{name}=", value)
          when 'echo'
            echo step['msg'].to_s
          when 'cast_buff'
            spell = Spell[step['spell']]
            spell.cast if spell && spell.known? && spell.affordable? && !spell.active?
          when 'cross'
            run_cross_edge(step)
          when 'move_with_group'
            run_move_with_group(step)
          when 'cast'
            run_cast(step)
          when 'move_random'
            run_move_random(step)
          when 'empty_hand'
            empty_hand
          when 'fill_hand'
            fill_hand
          when 'preserve_stance'
            run_preserve_stance(step)
          when 'escort_wait'
            run_escort_wait
          when 'break'
            raise StepFailed, 'break outside repeat' unless @loop_rooms&.any?
            raise BreakLoop
          when 'break_if_moved'
            raise BreakLoop if @loop_rooms&.any? && XMLData.room_id != @loop_rooms.last
          when 'set_global'
            run_set_global(step)
          when 'run_script'
            # DR travel delegation: run a named helper script to completion
            # (the start_script + wait_while idiom).
            start_script(step['script'], Array(step['args']).map(&:to_s))
            wait_while { running?(step['script']) }
          when 'wait_until'
            # Block until a condition holds, bounded like every other wait.
            deadline = Time.now + (step['timeout'] || 120).to_f
            sleep 0.25 until condition?(step['when']) || Time.now > deadline
            raise StepFailed, "wait_until timed out: #{step['when']}" unless condition?(step['when'])
          when 'wait_castrt'
            waitcastrt?
          when 'try_move'
            # Attempt a crossing command; when the room does not change, run
            # the fallback steps (the locked-door / blocked-way proc idiom).
            # With check: move, uses move()'s own failure detection instead.
            if step['check'] == 'move_result'
              Array(step['fallback']).each { |s| run_step(s) } if move(step['cmd']) == false
            else
              start = XMLData.room_id
              fput step['cmd']
              Array(step['fallback']).each { |s| run_step(s) } if XMLData.room_id == start
            end
          else
            raise StepFailed, "unknown step #{step['do'].inspect}"
          end
        end

        # Group-leader crossing: note who is following (from the room's
        # "X, Y and Z followed." line), make the move, then wait until every
        # follower has joined before continuing. Ported from the group-wait
        # proc family.
        def run_move_with_group(step)
          members = nil
          clear.reverse.each do |line|
            case line
            when /^Obvious (?:paths|exits)/
              break
            when /^([A-Za-z ,]+) followed\.$/
              members = ::Regexp.last_match(1).split(/, | and /)
              members.delete_if { |m| m =~ /^[Yy]our / }
              members = nil if members.empty?
              break
            end
          end
          move step['cmd']
          if members
            echo 'Waiting for your group...'
            while members.length.positive?
              if (get) =~ /^(?:You reach out and hold )?([A-Z][a-z]+)(?:'s hand| joins your group)\.$/
                members.delete(::Regexp.last_match(1))
              end
            end
          end
          waitrt?
        end

        # Cast a spell at an optional target, waiting for mana and retrying
        # through spell hindrance (the sanctum casting-loop idiom).
        def run_cast(step)
          spell = Spell[step['spell']]
          raise StepFailed, "cast: unknown spell #{step['spell'].inspect}" unless spell
          MAX_LOOP_ITERATIONS.times do
            wait_until { spell.affordable? }
            result = cast(step['spell'], step['target'])
            return true unless result =~ /Spell Hindrance/
          end
          raise StepFailed, 'cast: spell hindrance persisted'
        end

        # Move through a random obvious path, honoring optional include /
        # exclude filters (the fixed-maze wander idiom).
        def run_move_random(step)
          options = (step['among'] ? Array(step['among']) : checkpaths.dup)
          options -= Array(step['except']) if step['except']
          raise StepFailed, 'move_random: no eligible paths' if options.empty?
          choice = "#{step['prefix']}#{options[rand(options.length)]}"
          if step['send']
            fput choice
            waitrt?
          else
            move choice
          end
        end

        # Capture the current stance, run the nested steps, restore it after
        # (the stance save/restore crossing idiom). `stance` names the stance
        # to hold during the steps.
        def run_preserve_stance(step)
          saved = XMLData.stance_text
          wanted = step['stance'] || 'defensive'
          fput "stance #{wanted}" if saved.downcase != wanted.downcase
          Array(step['steps']).each { |s| run_step(s) }
          fput "stance #{saved.downcase}" if saved.downcase != wanted.downcase
        end

        # Wait for a bounty/task escortee NPC to follow into the room.
        def run_escort_wait
          npc = nil
          if defined?(bounty?) && bounty? =~ /^You have made contact with the child/
            npc = GameObj.npcs.find { |n| n.noun == 'child' }
          elsif defined?(Society) && Society.respond_to?(:task) &&
                Society.task.to_s =~ /find and rescue an official/
            npc = GameObj.npcs.find { |n| n.noun == 'official' }
          end
          return unless npc
          50.times do
            break if GameObj.npcs.any? { |n| n.id == npc.id }
            sleep 0.1
          end
        end

        def run_set_global(step)
          case step['var'].to_s
          when 'SILVERWOOD_TOWN' then $SILVERWOOD_TOWN = step['value']
          else raise StepFailed, "set_global: #{step['var'].inspect} not whitelisted"
          end
        end

        # Substitute tokens inside stored commands and patterns so map data
        # never embeds a specific character or setup:
        #   {char}          -> character name (regex-escaped)
        #   {map_id}        -> current mapdb room id
        #   {uservar:name}  -> UserVars.name
        #   {item_id:name}  -> #<id> of the named inventory item (raises if absent)
        def expand_tokens(source)
          return source unless source.is_a?(String)
          source.gsub('{char}', defined?(Char) ? Regexp.escape(Char.name.to_s) : '{char}')
                .gsub('{map_id}') { (defined?(Map) && Map.current&.id).to_s }
                .gsub(/\{uservar:(\w+)\}/) { uservar(::Regexp.last_match(1)).to_s }
                .gsub(/\{item_id:([^}]+)\}/) do
                  name = ::Regexp.last_match(1)
                  item = GameObj.inv.find { |obj| obj.name == name || obj.noun == name }
                  raise StepFailed, "item not in inventory: #{name}" unless item
                  "##{item.id}"
                end
        end

        # Follow another room's edge (the proc idiom Map[N].wayto['D'].call),
        # so shared crossings are stored once and referenced.
        def run_cross_edge(step)
          room = resolve_room_ref(step['room'])
          way = room && room.wayto[step['dest'].to_s]
          raise StepFailed, "cross: no edge #{step['room']} -> #{step['dest']}" if way.nil?
          way.respond_to?(:call) ? way.call : move(way)
        end

        # Bounded loop: runs its steps up to `times` iterations (hard-capped),
        # stopping early when `until_room` is reached or, with
        # `until_room_change`, when the room differs from the one at loop
        # entry. Bad data can waste a route, never hang Lich.
        def run_repeat(step)
          times = step['times'].to_i
          times = MAX_LOOP_ITERATIONS if times < 1 || times > MAX_LOOP_ITERATIONS
          # Change detection compares game uids (works even in unmapped rooms);
          # until_room targets are mapdb ids and must compare against Map.current.
          start = XMLData.room_id
          (@loop_rooms ||= []).push(start)
          times.times do
            break if step['until_room'] && at_room_ref?(step['until_room'])
            break if step['until_room_change'] && XMLData.room_id != start
            break if step['until'] && condition?(step['until'])
            Array(step['steps']).each { |s| run_step(s) }
          end
        rescue BreakLoop
          nil
        ensure
          @loop_rooms&.pop
        end

        # The current room's mapdb id.
        def current_map_id
          defined?(Map) && Map.respond_to?(:current) ? Map.current&.id : nil
        end

        # Room references are dual-currency: an integer/digits string is a
        # mapdb id; a "uNNN" string is a game uid (the game's ground truth,
        # stable across mapdb renumbering). Ambiguity resolves conservatively:
        # a uid mapping to zero or many mapdb rooms yields nil (not routable).
        def resolve_room_ref(ref)
          s = ref.to_s
          if s =~ /\Au(\d+)\z/i
            ids = Map.respond_to?(:ids_from_uid) ? Map.ids_from_uid(::Regexp.last_match(1).to_i) : []
            ids.length == 1 ? Map[ids.first] : nil
          else
            Map[s.to_i]
          end
        end

        # Is the character currently in the referenced room? Uid refs compare
        # against the live game stream directly - no mapdb lookup at all.
        def at_room_ref?(ref)
          s = ref.to_s
          if s =~ /\Au(\d+)\z/i
            XMLData.room_id == ::Regexp.last_match(1).to_i
          else
            current_map_id == s.to_i
          end
        end

        def run_await(step)
          pattern = compile_pattern(step['for'])
          raise StepFailed, "bad pattern #{step['for'].inspect}" unless pattern
          timeout = (step['timeout'] || DEFAULT_AWAIT_TIMEOUT).to_f
          # Passive form (no cmd): wait for the line without sending anything.
          hit = step['cmd'] ? dothistimeout(step['cmd'], timeout, pattern) : matchtimeout(timeout, pattern)
          unless hit
            what = step['cmd'] || "for #{step['for'].inspect}"
            case step['on_timeout'] || 'continue'
            when 'fail'
              raise StepFailed, "await timed out: #{what}"
            when 'retry'
              hit = dothistimeout(step['cmd'], timeout, pattern)
              raise StepFailed, "await retry timed out: #{what}" unless hit
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
          return !condition?(cond[4..]) if cond.start_with?('not:')
          kind, arg = cond.split(':', 2)
          case kind
          when 'spell'
            Spell[arg =~ /^\d+$/ ? arg.to_i : arg]&.active? ? true : false
          when 'status'
            status?(arg)
          when 'setting'
            setting_on?(arg)
          when 'race_match'
            re = compile_pattern(arg)
            !re.nil? && defined?(Stats) && Stats.race.to_s =~ re ? true : false
          when 'path'
            checkpaths.include?(arg)
          when 'paths_are'
            # Exact obvious-paths set, order-insensitive: paths_are:north,south
            checkpaths.sort == arg.to_s.split(',').map(&:strip).sort
          when 'has_item'
            GameObj.inv.any? { |obj| obj.noun == arg || obj.name == arg }
          when 'loot_match'
            re = compile_pattern(expand_tokens(arg))
            !re.nil? && GameObj.loot.any? { |obj| obj.name =~ re }
          when 'in_room'
            at_room_ref?(arg)
          when 'platinum'
            $platinum ? true : false
          when 'ice_caution'
            ice_caution?
          else
            # Conditions are a superset of requirements: skill/level/
            # citizenship/etc. work in if steps too.
            requirement?(cond)
          end
        end

        # The uniform icy-terrain caution gate from the Icemule approach procs:
        # wait out the ice unless the character is equipped to run it.
        def ice_caution?
          mode = uservar('mapdb_ice_mode')
          return true if mode == 'wait'
          return false if mode == 'run'
          XMLData.encumbrance_value > 50 ||
            (Skills.survival < 50 && !Spell['Haste']&.active?)
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
          when 'kneeling'  then defined?(kneeling?) ? kneeling? : false
          when 'standing'  then defined?(standing?) ? standing? : false
          when 'stunned'   then defined?(stunned?) ? stunned? : false
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

        # Truthiness for user variables: nil/false and the strings a user
        # types to mean "off" are all falsy.
        def var_check(value, expected)
          return value.to_s == expected if expected
          !value.nil? && value != false && value.to_s !~ /\A(?:no|false|)\z/i
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
        rescue StandardError => e
          # A raising cost inside dijkstra would abort the entire search and
          # fail every route. The contract is: evaluation errors mean this
          # edge is not routable, nothing more.
          MapEngine.note_cost_error(@raw, e)
          nil
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
        attr_reader :raw, :dest

        # dest is the edge's destination room (mapdb id) as loaded, letting
        # strategies skip a replan when the crossing landed exactly there.
        def initialize(raw, dest = nil)
          @raw = raw
          @dest = dest
        end

        def call(*_args)
          MapEngine.cross(@raw, @dest)
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

        # Ecosystem scripts introspect proc-like edges via _dump (mapmap's
        # room merge does `way.class == Proc and way._dump =~ ...`). Return
        # the schema JSON so display and id-searching work instead of
        # crashing. A script that rebuilds an edge from this text produces a
        # StringProc of JSON - harmless at runtime and caught by the
        # forbid-procs validator on submission; renumbering rooms inside
        # schema (cross/same_as/in_room ids) is a hand edit.
        def _dump(_level = nil)
          @raw.to_json
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

        def self.run(params, dest = nil)
          klass = REGISTRY[params['strategy'].to_s]
          raise StepFailed, "unknown strategy #{params['strategy'].inspect}" unless klass
          instance = klass.new(params)
          # Strategies that care about the edge destination declare run(dest);
          # the rest keep their zero-arg signature.
          instance.method(:run).arity.zero? ? instance.run : instance.run(dest)
        end
      end

      # Pure, offline validation of schema entries: structure, vocabulary, and
      # regex compilation. Suitable for submission CI and a local lint command.
      module Validator
        STEP_NAMES = %w[send move await wait_rt sleep wait_room_change if empty_hands fill_hands replan repeat
                        set echo cast_buff cross move_with_group try_move cast move_random empty_hand fill_hand
                        preserve_stance escort_wait break break_if_moved set_global run_script wait_until
                        wait_castrt].freeze
        REQUIREMENT_KINDS = %w[setting grant not is pass pass_buyable prof race gender citizenship spell climate
                               month var var_raw society seeking_enabled has_item no_script spell_known level
                               skill climb_vs_encumbrance global room_name location script_running subscription
                               edge drskill guild circle premium script_exists game dr_setting dr_spell_known
                               stamina].freeze
        FORMULA_NAMES = %w[haste_scaled].freeze
        CONDITION_KINDS = %w[spell status setting race_match ice_caution path paths_are has_item loot_match
                             in_room platinum].freeze
        ON_TIMEOUT = %w[continue fail retry].freeze

        module_function

        def errors_for_timeto(value)
          return [] unless value.is_a?(Hash)
          errors = []
          if (ref = value['same_as'])
            errors << "same_as must look like 'room:dest' (room may be uNNN), got #{ref.inspect}" unless ref.is_a?(String) && ref =~ /\A(?:u)?\d+:\d+\z/i
            return errors
          end
          if value['event']
            errors << 'event entry requires a key' unless value.key?('key')
            return errors
          end
          if (formula = value['formula'])
            errors << "unknown formula #{formula.inspect}" unless FORMULA_NAMES.include?(formula)
            errors << 'formula entry requires a numeric base' unless value['base'].is_a?(Numeric)
            return errors
          end
          # An explicit null cost (edge disabled when requirements pass) is
          # legal; a missing cost key is not.
          unless value.key?('cost') && (value['cost'].is_a?(Numeric) || value['cost'].nil?)
            errors << 'cost entry requires a numeric or explicit null cost'
          end
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
          # An explicit empty array is a valid no-op crossing (virtual edge).
          return [] if value.is_a?(Array) && value.empty?
          steps = value.is_a?(Array) ? value : Array(value.is_a?(Hash) ? value['steps'] : nil)
          return ['wayto schema entry must be a step list or strategy'] if steps.empty?
          steps.flat_map { |step| errors_for_step(step) }
        end

        def errors_for_step(step)
          return ["step must be an object, got #{step.inspect}"] unless step.is_a?(Hash)
          errors = []
          name = step['do']
          return ["unknown step #{name.inspect}"] unless STEP_NAMES.include?(name)
          # A literal #{...} in a command is an interpolation leak from
          # conversion - the proc's variable never made it into the data.
          # ({token} forms are ours and fine.)
          %w[cmd verb prefix].each do |key|
            if step[key].is_a?(String) && step[key].include?('#{')
              errors << "#{name || 'step'} #{key} contains unexpanded interpolation: #{step[key]}"
            end
          end
          case name
          when 'send', 'move'
            errors << "#{name} requires cmd" unless step['cmd'].is_a?(String)
          when 'await'
            errors << 'await cmd must be a string when present' if step.key?('cmd') && !step['cmd'].is_a?(String)
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
            conds = step['when_all'] ? Array(step['when_all']) : [step['when']]
            conds.each do |cond|
              kind = cond.to_s.sub(/\Anot:/, '').split(':', 2).first
              unless CONDITION_KINDS.include?(kind) || REQUIREMENT_KINDS.include?(kind)
                errors << "unknown condition kind #{kind.inspect}"
              end
            end
            errors.concat(Array(step['then']).flat_map { |s| errors_for_step(s) })
            errors.concat(Array(step['else']).flat_map { |s| errors_for_step(s) })
          when 'set'
            errors << 'set requires var' unless step['var'].is_a?(String)
          when 'cast_buff'
            errors << 'cast_buff requires a numeric spell' unless step['spell'].is_a?(Integer)
          when 'cross'
            unless (step['room'].is_a?(Integer) || step['room'].to_s =~ /\A(?:u)?\d+\z/i) && step['dest']
              errors << 'cross requires room (id or uNNN) and dest'
            end
          when 'repeat'
            errors << 'repeat requires steps' if Array(step['steps']).empty?
            unless step['until_room'] || step['until_room_change'] || step['until'] || step['times'].is_a?(Numeric)
              errors << 'repeat requires times, until, until_room, or until_room_change'
            end
            if step['until']
              kind = step['until'].to_s.sub(/\Anot:/, '').split(':', 2).first
              unless CONDITION_KINDS.include?(kind) || REQUIREMENT_KINDS.include?(kind)
                errors << "unknown condition kind #{kind.inspect}"
              end
            end
            errors.concat(Array(step['steps']).flat_map { |s| errors_for_step(s) })
          when 'move_with_group'
            errors << 'move_with_group requires cmd' unless step['cmd'].is_a?(String)
          when 'try_move'
            errors << 'try_move requires cmd' unless step['cmd'].is_a?(String)
            errors.concat(Array(step['fallback']).flat_map { |s| errors_for_step(s) })
          when 'run_script'
            errors << 'run_script requires script' unless step['script'].is_a?(String)
          when 'wait_until'
            kind = step['when'].to_s.sub(/\Anot:/, '').split(':', 2).first
            unless CONDITION_KINDS.include?(kind) || REQUIREMENT_KINDS.include?(kind)
              errors << "unknown condition kind #{kind.inspect}"
            end
          when 'cast'
            errors << 'cast requires a numeric spell' unless step['spell'].is_a?(Integer)
          when 'move_random'
            if step['among'] && !step['among'].is_a?(Array)
              errors << 'move_random among must be an array'
            end
          when 'preserve_stance'
            errors << 'preserve_stance requires steps' if Array(step['steps']).empty?
            errors.concat(Array(step['steps']).flat_map { |s| errors_for_step(s) })
          when 'set_global'
            unless MapEngine::SETTABLE_GLOBALS.include?(step['var'].to_s)
              errors << "set_global var #{step['var'].inspect} is not whitelisted"
            end
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
