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
      # A crossing reached by travel_to cannot itself travel_to: bad data
      # wastes one route rather than routing in circles.
      MAX_TRAVEL_DEPTH      = 1

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
          when 'spells_known'
            # All of them, for gates that need a whole set rather than any one
            # of several alternatives.
            nums = arg.to_s.split(',').map { |n| n.strip.to_i }
            !nums.empty? && nums.all? { |num| Spell[num]&.known? }
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
          when 'climb_bonus'
            # Climbing bonus derated by how loaded down you are, against a
            # threshold: (1 - encumbrance%) * to_bonus(climbing) >= N. This is
            # a different test from climb_vs_encumbrance, which compares raw
            # ranks - keep both, the corpus uses each.
            (1 - (Char.percent_encumbrance / 100.0)) * Skills.to_bonus(Skills.climbing) >= arg.to_f
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
          clear_captures
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
          when 'for_each'
            run_for_each(step)
          when 'set'
            value = step['value'].is_a?(String) ? expand_tokens(step['value']) : step['value']
            value = value.to_i if step['value'] == '{map_id}'
            # raw: legacy UserVars outside the mapdb_ namespace (DR portals)
            name = step['raw'] ? step['var'].to_s : "mapdb_#{step['var']}"
            UserVars.send("#{name}=", value)
          when 'echo'
            echo step['msg'].to_s
          when 'cast_buff'
            run_cast_buff(step)
          when 'use_item'
            run_use_item(step)
          when 'borrow_item'
            run_borrow_item(step)
          when 'find_item'
            run_find_item(step)
          when 'travel_to'
            run_travel_to(step)
          when 'search_rooms'
            run_search_rooms(step)
          when 'return_item'
            run_return_item(step)
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
          # spell may be a single number or a preference list: cast the first
          # one this character actually knows (the "407, else 1207" idiom).
          spell = resolve_castable(step['spell'])
          raise StepFailed, "cast: unknown spell #{step['spell'].inspect}" unless spell
          # Retry on hindrance, plus any edge-specific failure text (gates that
          # shrug off the spell and have to be hit again).
          retry_on = step['retry_on'] ? compile_pattern(step['retry_on']) : nil
          MAX_LOOP_ITERATIONS.times do
            wait_until { spell.affordable? }
            result = cast(spell.num, step['target'])
            return true unless result =~ /Spell Hindrance/ || (retry_on && result =~ retry_on)
          end
          raise StepFailed, 'cast: spell hindrance persisted'
        end

        # Borrow an item, use it, put it back where it came from.
        #
        #   { "do": "use_item", "item": "{uservar:fwi_trinket}", "verb": "turn",
        #     "for": "You get the feeling|<nav rm=", "timeout": 5 }
        #
        # The container the item was stowed in is only discoverable from the
        # raw tag stream, so that work lives here in reviewed code rather than
        # in map data: the schema names the item and the verb, nothing else.
        # An item already in hand (or worn) is used in place and not put away.
        # Route to another room mid-crossing, using go2's own pathfinding
        # rather than a path baked into the map.
        #
        #   { "do": "travel_to", "room": 400 }
        #
        # Errand edges (fetch a ticket, visit a bank) walked hardcoded move
        # lists that duplicated graph the router already had, and silently
        # rotted when a room changed. This delegates instead.
        #
        # Guarded against re-entry: a crossing reached by travel_to cannot
        # itself travel_to, so bad data wastes one route instead of looping
        # forever (MAX_TRAVEL_DEPTH is 1 for that reason).
        def run_travel_to(step)
          # A tag ("bank", "alchemist") routes to the nearest such room, which
          # is how the procs navigated to services - the right one depends on
          # where you are, so it cannot be a fixed id.
          ref = step['room']
          if (tag = step['tag'])
            ref = Map.current&.find_nearest_by_tag(tag.to_s)
            raise StepFailed, "travel_to: no room tagged #{tag.inspect} nearby" unless ref
          end

          room = resolve_room_ref(ref)
          raise StepFailed, "travel_to: unknown room #{ref.inspect}" unless room
          return if at_room_ref?(ref)

          @travel_depth ||= 0
          if @travel_depth >= MAX_TRAVEL_DEPTH
            raise StepFailed, "travel_to: nested routing refused (room #{ref})"
          end

          @travel_depth += 1
          begin
            # This crossing is itself running under a go2, so count the ones
            # already present and wait for our new one to drop back to that,
            # rather than assuming any particular number.
            before = Script.running.count { |s| s.name == 'go2' }
            force_start_script('go2', [room.id.to_s])
            # Wait for it to register before waiting for it to finish, or the
            # finish check can fall through on the very first poll.
            started = Time.now
            sleep 0.1 until Script.running.count { |s| s.name == 'go2' } > before || Time.now - started > 5
            wait_while { Script.running.count { |s| s.name == 'go2' } > before }
            unless at_room_ref?(ref)
              raise StepFailed, "travel_to: did not reach room #{room.id}"
            end
          ensure
            @travel_depth -= 1
          end
        end

        # Visit rooms in turn until something shows up, then stop.
        #
        #   { "do": "search_rooms", "rooms": [18245, 20321, ...],
        #     "until": "loot_noun:doorframe" }
        #
        # The exit from these mazes appears in a room that varies per instance,
        # so the map lists where to look and the router does the walking - the
        # procs already did this, one force_start_script at a time.
        def run_search_rooms(step)
          rooms = Array(step['rooms'])
          raise StepFailed, 'search_rooms requires rooms' if rooms.empty?
          cond = step['until'].to_s
          raise StepFailed, 'search_rooms requires until' if cond.empty?

          return true if condition?(cond)

          rooms.each do |ref|
            next if at_room_ref?(ref)

            begin
              run_travel_to({ 'room' => ref })
            rescue StepFailed
              next # unreachable right now; try the next one
            end
            return true if condition?(cond)
          end
          raise StepFailed, "search_rooms: #{cond} not found in #{rooms.length} rooms"
        end

        # Find an item you own that satisfies a check, and get it into hand.
        # Some items are only distinguishable by looking at them - a boat
        # ticket is yours if its text carries your name - so candidates are
        # filtered by noun and then verified one at a time.
        #
        #   { "do": "find_item", "nouns": ["scrip", "scroll"],
        #     "verify": "look #{item}", "matching": "reads, \".*{char}" }
        #
        # Binds {capture:item}. Not finding one leaves it unbound rather than
        # failing, so an edge can offer a fallback.
        def run_find_item(step)
          nouns = Array(step['nouns']).map(&:to_s)
          raise StepFailed, 'find_item requires nouns' if nouns.empty?

          # `as` names the binding, for edges that look for more than one thing
          # and need to tell the results apart.
          slot = (step['as'] || 'item').to_s
          @captures ||= {}
          @captures[slot] = nil
          pattern = compile_pattern(expand_tokens(step['matching'].to_s))
          raise StepFailed, 'find_item requires a matching pattern' unless pattern

          hands = [GameObj.right_hand, GameObj.left_hand].compact.select { |o| o.id }
          candidates = hands.select { |o| nouns.include?(o.noun) }
          # Then anything already visible inside a container we can see into.
          GameObj.inv.each do |container|
            contents = container.contents
            next if contents.nil? || contents.empty?
            candidates.concat(contents.select { |o| nouns.include?(o.noun) })
          end

          found = candidates.find { |obj| verify_item(obj, step, pattern) }
          # Nothing visible matched: containers we have not looked inside may
          # still hold it. Open, check, and close the ones we opened.
          found ||= search_closed_containers(nouns, step, pattern)
          return unless found

          # Take it if it is not already in hand.
          unless hands.any? { |o| o.id == found.id }
            empty_hand if GameObj.right_hand.id && GameObj.left_hand.id
            fput "get ##{found.id}"
          end
          @captures[slot] = "##{found.id}"
        end

        # Look inside containers whose contents we cannot already see, leaving
        # each as we found it: a container we opened gets closed again.
        def search_closed_containers(nouns, step, pattern)
          GameObj.inv.each do |container|
            next unless container.contents.nil? || container.contents.empty?

            opened = dothistimeout("open ##{container.id}", 3,
                                   /^You open|^That is already open\.$/).to_s
            # Opening does not necessarily repopulate contents; looking does.
            dothistimeout("look in ##{container.id}", 3, /^In the|^There is nothing/)
            found = Array(container.contents)
                    .select { |o| nouns.include?(o.noun) }
                    .find { |o| verify_item(o, step, pattern) }
            fput "close ##{container.id}" if opened =~ /^You open/
            return found if found
          end
          nil
        end

        # `settles` names the lines that mean "answer received, but no" - a
        # look that reveals nothing. Without them the wait burns its full
        # timeout on every candidate that is not the one.
        def verify_item(obj, step, pattern)
          cmd = expand_tokens(step['verify'].to_s).gsub('{item}', "##{obj.id}")
          settle = step['settles'] ? compile_pattern(step['settles']) : nil
          wait_for = settle ? Regexp.union(pattern, settle) : pattern
          result = dothistimeout(cmd, (step['timeout'] || 3).to_f, wait_for)
          !result.nil? && result =~ pattern ? true : false
        end

        # Get the item into hand and remember where it came from. Binds
        # {capture:item} and {capture:container} for the steps that follow, so
        # an edge can compose whatever it needs between borrow and return:
        #
        #   { "do": "borrow_item", "item": "lockpick" },
        #   { "do": "send", "cmd": "pick shed" },
        #   { "do": "send", "cmd": "_drag #{capture:item} #{capture:container}" },
        #   { "do": "return_item" }
        #
        # An item already in hand is used in place: nothing is fetched and
        # return_item leaves it alone.
        def run_borrow_item(step)
          name = expand_tokens(step['item'].to_s)
          raise StepFailed, 'borrow_item requires an item' if name.empty?

          @captures ||= {}
          @borrowed = nil

          # Already in a hand: use it in place. GameObj[] searches worn items
          # too, so match on the hands rather than trusting a bare lookup - a
          # worn key still has to be removed before it can be used.
          held = [GameObj.right_hand, GameObj.left_hand].compact.find do |obj|
            obj.id && (obj.noun == name || obj.name == name)
          end
          if held
            @captures['item'] = "##{held.id}"
            @captures['container'] = nil
            return
          end

          # Worn or carried (GameObj.inv is that registry, hands excluded):
          # remove it, and remember to wear it again on return.
          worn = GameObj.inv.find { |obj| obj.noun == name || obj.name == name }
          if worn
            refill_worn = !GameObj.left_hand.id.nil? && !GameObj.right_hand.id.nil?
            empty_hand if refill_worn
            fput "remove ##{worn.id}"
            @borrowed = { 'name' => name, 'container' => nil, 'refill' => refill_worn, 'worn' => true }
            @captures['item'] = "##{worn.id}"
            @captures['container'] = nil
            return
          end

          refill = !GameObj.left_hand.id.nil? && !GameObj.right_hand.id.nil?
          empty_hand if refill
          container_id = fetch_item(name)
          held = GameObj[name]
          if held.nil?
            fill_hand if refill
            # Not routable rather than a raised diagnostic: an edge you cannot
            # cross without the item is simply not crossable right now.
            raise StepFailed, "borrow_item: could not find #{name.inspect}"
          end

          @borrowed = { 'name' => name, 'container' => container_id, 'refill' => refill }
          @captures['item'] = "##{held.id}"
          @captures['container'] = container_id ? "##{container_id}" : nil
        end

        # Put a borrowed item back where it came from (stowing when the
        # container is unknown) and refill the hand we emptied. A no-op when
        # the item was already in hand.
        def run_return_item(_step = nil)
          info = @borrowed
          @borrowed = nil
          return unless info

          # Ids are stable until logoff, but locker rooms reissue them freely,
          # so re-resolve rather than trusting the id we took on the way in.
          back = GameObj[info['name']]
          if back
            if info['worn']
              fput "wear ##{back.id}"
            elsif info['container']
              fput "put ##{back.id} in ##{info['container']}"
            else
              fput "stow ##{back.id}"
            end
          end
          fill_hand if info['refill']
        end

        # The common case - borrow, use once, return - as a single step.
        def run_use_item(step)
          run_borrow_item(step)
          verb = step['verb'] || 'turn'
          cmd = "#{verb} #{@captures['item']}"
          if (pattern = step['for'] ? compile_pattern(step['for']) : nil)
            dothistimeout(cmd, (step['timeout'] || DEFAULT_AWAIT_TIMEOUT).to_f, pattern)
          else
            fput cmd
          end
          run_return_item
        end

        # Get an item into hand, returning the id of the container it came out
        # of (nil when that cannot be determined). Reads the tag stream, which
        # is why use_item exists as a step instead of as map data.
        def fetch_item(name)
          flip = defined?(Script) && Script.current && !Script.current.want_downstream_xml
          status_tags if flip
          begin
            wanted = Regexp.new(name.split(' ').map { |w| Regexp.escape(w) }.join('.*'))
            result = dothistimeout("get my #{name}", 5, Regexp.union(/You.*?#{wanted}/, /^Get what/))
            return nil if result.nil? || result =~ /Get what/

            # The response lists the item and the container it left; the link
            # that is not the item itself is the container.
            links = result.to_s.split('</inv>').last.to_s
                          .scan(/<a exist="(-?\d+)" noun="[^"]+">([^<]+)<\/a>/)
            other = links.find { |_id, label| label !~ wanted }
            other && other[0]
          ensure
            status_tags if flip
          end
        end

        # Buff yourself before a crossing, skipping silently when the spell is
        # unknown or already up. Society spells (sigil of resolve) cost stamina
        # rather than mana, and the procs wait for it rather than give up;
        # `unless` names buffs whose presence makes this one redundant.
        def run_cast_buff(step)
          spell = Spell[step['spell']]
          return unless spell&.known? && !spell.active?
          return if Array(step['unless']).any? { |name| Spell[name]&.active? }

          if step['stamina']
            deadline = Time.now + (step['timeout'] || 60).to_f
            sleep 0.25 until stamina(spell.stamina_cost) || Time.now > deadline
            return unless stamina(spell.stamina_cost)
          elsif !spell.affordable?
            return
          end
          spell.cast
        end

        # A spell number, or the first known spell from a preference list.
        # Returns nil when the character knows none of them, which makes the
        # step fail rather than blindly casting something unavailable.
        def resolve_castable(spec)
          return Spell[spec] unless spec.is_a?(Array)
          spec.map { |num| Spell[num] }.compact.find(&:known?)
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
                .gsub(/\{capture:(\w+)\}/) { captures[::Regexp.last_match(1)].to_s }
                .gsub(/\{item_id:([^}]+)\}/) do
                  name = ::Regexp.last_match(1)
                  item = GameObj.inv.find { |obj| obj.name == name || obj.noun == name }
                  raise StepFailed, "item not in inventory: #{name}" unless item
                  "##{item.id}"
                end
                .gsub(/\{room_id:([^}]+)\}/) do
                  # Something in the room rather than something you own: shop
                  # fronts and other scenery you enter by id.
                  name = ::Regexp.last_match(1)
                  obj = (GameObj.loot.to_a + GameObj.room_desc.to_a)
                        .find { |o| o.name == name || o.noun == name }
                  raise StepFailed, "not in this room: #{name}" unless obj
                  "##{obj.id}"
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

        # Run the same steps once per item, with the item bound for the body
        # to interpolate:
        #
        #   { "do": "for_each", "as": "dir", "items": ["w", "s", "arch"],
        #     "steps": [ { "do": "send", "cmd": "tell familiar to go {capture:dir}" } ] }
        #
        # Without this, a proc's `list.each { |d| ... }` has to be unrolled at
        # build time, which multiplies the body by the list length - 48KB for
        # one edge in the case that prompted it.
        def run_for_each(step)
          items = Array(step['items'])
          raise StepFailed, 'for_each requires items' if items.empty?
          name = (step['as'] || 'item').to_s
          @captures ||= {}
          previous = @captures[name]
          # Mark loop context so a `break` inside the body is legal, as in repeat.
          (@loop_rooms ||= []).push(XMLData.room_id)
          begin
            # Bounded like every other loop, so bad data cannot run away.
            items.first(MAX_LOOP_ITERATIONS).each do |item|
              @captures[name] = item.to_s
              Array(step['steps']).each { |s| run_step(s) }
            end
          rescue BreakLoop
            nil
          ensure
            @loop_rooms.pop
            @captures[name] = previous
          end
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
          bind_captures(step, hit, pattern)
          if hit && (br = step['if_match'])
            sub = compile_pattern(br['pattern'])
            Array(br['steps']).each { |s| run_step(s) } if sub && hit =~ sub
          end
          hit
        end

        # Bind pieces of a matched line for later steps to interpolate:
        #   { "do": "await", "cmd": "look trail", "for": "heads off to the (\\w+)",
        #     "bind": { "dir": 1 } }        -> {capture:dir} == the captured word
        #   "bind": { "dir": "wall" }        -> named group (?<wall>...)
        # Bindings live for the current crossing only; an unbound name
        # interpolates as empty, which fails the command visibly rather than
        # sending a half-formed one silently.
        def bind_captures(step, hit, pattern)
          bind_scan(step, hit)
          spec = step['bind']
          return unless spec.is_a?(Hash)
          @captures ||= {}
          md = hit && pattern ? pattern.match(hit) : nil
          spec.each do |name, group|
            @captures[name.to_s] =
              case group
              when Integer then md && md[group]
              when String then md && md[group]
              when Hash then bind_ordinal(md, group)
              end
          end
        end

        # Pull several independent values out of one response:
        #
        #   "bind_all": { "yellow": "Yellow ([0-9])", "blue": "Blue ([0-9])" }
        #
        # Each name gets its own pattern scanned against the whole matched
        # text, so nothing is assumed about the order they appear in - the
        # grid-reading idiom, where a proc slices each value out separately.
        def bind_scan(step, hit)
          spec = step['bind_all']
          return unless spec.is_a?(Hash)
          @captures ||= {}
          spec.each do |name, source|
            re = compile_pattern(source)
            md = re && hit ? re.match(hit.to_s) : nil
            @captures[name.to_s] = md && (md[1] || md[0])
          end
        end

        # Ordinal binding: the rotating-staircase shape. A room line lists N
        # things; find which occurrence matches `equals` and bind the word for
        # that position from `words` (1st -> "steps", 2nd -> "second steps").
        #   "bind": { "which": { "group": "wall", "equals": "northern",
        #                        "words": ["steps", "second steps", ...] } }
        def bind_ordinal(md, spec)
          return nil unless md
          names = md.names
          group = spec['group'].to_s
          # Collect every occurrence of the repeated group, in order.
          values = if names.include?(group)
                     md.captures.each_with_index.select { |_, i| md.names[i] == group }.map(&:first)
                   else
                     md.captures
                   end
          index = values.index(spec['equals'])
          index && Array(spec['words'])[index]
        end

        def captures
          @captures ||= {}
        end

        def clear_captures
          @captures = {}
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
          when 'loot_noun'
            # checkloot's exact test: an item in the room has this noun. Not
            # loot_match, which is a regex over full names and matches wider.
            GameObj.loot.any? { |obj| obj.noun == expand_tokens(arg) }
          when 'room_object'
            # Scenery named in the room description, which is a different
            # registry from loot (things lying on the ground).
            GameObj.room_desc.any? { |obj| obj.noun == expand_tokens(arg) }
          when 'room_object_match'
            # Same registry, matched by full name: scenery that varies by
            # adjective ("a blue barrier" vs "a red barrier").
            re = compile_pattern(expand_tokens(arg))
            !re.nil? && GameObj.room_desc.any? { |obj| obj.name =~ re }
          when 'npc_match'
            # A creature in the room matches: loot is items, npcs are not.
            re = compile_pattern(expand_tokens(arg))
            !re.nil? && GameObj.npcs.any? { |obj| obj.name =~ re }
          when 'capture'
            # capture:NAME (bound and non-empty) or capture:NAME=VALUE
            name, expected = arg.to_s.split('=', 2)
            value = captures[name]
            expected ? value.to_s == expected : !value.to_s.empty?
          when 'capture_match'
            # capture_match:NAME=PATTERN - branch on which alternative a bound
            # line matched, which is what the procs do with their await result.
            name, pattern = arg.to_s.split('=', 2)
            re = compile_pattern(pattern)
            !re.nil? && captures[name].to_s =~ re ? true : false
          when 'room_loaded'
            # The room description has arrived. Transit rooms (fog spheres,
            # teleports) deliver an empty description until the game finishes
            # placing you, so this is "we have landed somewhere real".
            !XMLData.room_description.to_s.strip.empty?
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
          when 'prone'     then defined?(checkprone) ? checkprone : false
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
                        wait_castrt use_item borrow_item return_item find_item travel_to
                        search_rooms for_each].freeze
        REQUIREMENT_KINDS = %w[setting grant not is pass pass_buyable prof race gender citizenship spell climate
                               month var var_raw society seeking_enabled has_item no_script spell_known level
                               skill climb_vs_encumbrance climb_bonus global room_name location script_running subscription
                               edge drskill guild circle premium script_exists game dr_setting dr_spell_known
                               stamina spells_known].freeze
        FORMULA_NAMES = %w[haste_scaled].freeze
        CONDITION_KINDS = %w[spell status setting race_match ice_caution path paths_are has_item loot_match
                             in_room platinum capture capture_match room_loaded loot_noun
                             npc_match room_object room_object_match].freeze
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
            if step.key?('bind')
              if step['bind'].is_a?(Hash)
                step['bind'].each_value do |group|
                  ok = group.is_a?(Integer) || group.is_a?(String) ||
                       (group.is_a?(Hash) && group['group'] && group['equals'] && group['words'].is_a?(Array))
                  errors << "bind target must be a group number, group name, or ordinal spec: #{group.inspect}" unless ok
                end
              else
                errors << 'bind must be an object of name => group'
              end
            end
            if step.key?('bind_all')
              if step['bind_all'].is_a?(Hash)
                step['bind_all'].each_value do |source|
                  errors << "bind_all target must be a pattern: #{source.inspect}" unless source.is_a?(String)
                end
              else
                errors << 'bind_all must be an object of name => pattern'
              end
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
          when 'travel_to'
            if step['tag']
              errors << 'travel_to tag must be a string' unless step['tag'].is_a?(String)
            elsif !(step['room'].is_a?(Integer) || step['room'].to_s =~ /\A(?:u)?\d+\z/i)
              errors << 'travel_to requires room (id or uNNN) or tag'
            end
          when 'search_rooms'
            rooms = step['rooms']
            ok = rooms.is_a?(Array) && !rooms.empty? &&
                 rooms.all? { |r| r.is_a?(Integer) || r.to_s =~ /\A(?:u)?\d+\z/i }
            errors << 'search_rooms requires rooms (ids or uNNN)' unless ok
            if step['until']
              kind = step['until'].to_s.sub(/\Anot:/, '').split(':', 2).first
              unless CONDITION_KINDS.include?(kind) || REQUIREMENT_KINDS.include?(kind)
                errors << "unknown condition kind #{kind.inspect}"
              end
            else
              errors << 'search_rooms requires until'
            end
          when 'find_item'
            errors << 'find_item requires nouns' unless step['nouns'].is_a?(Array) && !step['nouns'].empty?
            errors << 'find_item requires verify' unless step['verify'].is_a?(String)
            errors << 'find_item requires matching' unless step['matching'].is_a?(String)
          when 'use_item', 'borrow_item'
            errors << "#{name} requires item" unless step['item'].is_a?(String)
            errors << "#{name} verb must be a string" if step['verb'] && !step['verb'].is_a?(String)
          when 'cast_buff'
            unless step['spell'].is_a?(Integer) || step['spell'].is_a?(String)
              errors << 'cast_buff requires a spell number or name'
            end
            if step['unless'] && !Array(step['unless']).all? { |n| n.is_a?(String) || n.is_a?(Integer) }
              errors << 'cast_buff unless must be spell names or numbers'
            end
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
          when 'for_each'
            errors << 'for_each requires steps' if Array(step['steps']).empty?
            unless step['items'].is_a?(Array) && !step['items'].empty?
              errors << 'for_each requires a non-empty items array'
            end
            errors << 'for_each as must be a string' if step['as'] && !step['as'].is_a?(String)
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
            spell = step['spell']
            ok = spell.is_a?(Integer) ||
                 (spell.is_a?(Array) && !spell.empty? && spell.all? { |n| n.is_a?(Integer) })
            errors << 'cast requires a numeric spell or a list of them' unless ok
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
