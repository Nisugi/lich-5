# frozen_string_literal: true

# Multi-phase travel strategies for MapEngine.
#
# Each class here is a faithful port of a StringProc family from the mapdb,
# relocated into reviewed Lich code. Map edges reference a strategy by name
# and supply parameters; the shared state the procs kept in $globals lives as
# class-level state on the owning strategy instead.
#
# Every loop that was unbounded in the proc original carries an iteration cap:
# exhausting it raises StepFailed, which go2's existing error path turns into
# a re-route or report. Bad data may waste a route; it can never hang Lich.

require_relative 'map_engine'

module Lich
  module Common
    module MapEngine
      module Strategies
        # Waits for a bounty-escort child NPC to follow into the room, exactly
        # as the proc idiom `50.times { break if ...; sleep 0.1 } if child`.
        module EscortWait
          def bounty_child
            return nil unless defined?(bounty?) && bounty? =~ /^You have made contact with the child/
            GameObj.npcs.find { |npc| npc.noun == 'child' }
          end

          def wait_for_escort(child)
            return unless child
            50.times do
              break if GameObj.npcs.any? { |npc| npc.id == child.id }
              sleep 0.1
            end
          end
        end

        # The Confluence: a shifting two-zone (hot/cold) area whose exits are
        # randomized per visit. The proc learned the current layout into
        # $mapdb_confluence_* globals and steered by backward-chaining over the
        # learned graph. Ported with the learned state held on the class so it
        # survives across crossings within a session, as the globals did.
        #
        #   { "strategy" => "confluence_explorer", "target" => 23329 }
        #   { "strategy" => "confluence_explorer", "target" => "tranquility" }
        class ConfluenceExplorer
          include EscortWait

          HOT_ROOMS  = (23282..23303).to_a + (23329..23334).to_a
          COLD_ROOMS = (23304..23328).to_a
          MAX_MOVES = 300

          class << self
            attr_accessor :learned, :wander, :hot_tranquility, :cold_tranquility, :hot_pit, :cold_pit

            def reset!
              @learned = {}
              @wander = []
              @hot_tranquility = @cold_tranquility = @hot_pit = @cold_pit = nil
            end

            # Pure backward-chaining search over the learned exit graph: find a
            # direction out of `room_id` leading toward any of `targets`,
            # widening through rooms known to reach them. Exposed for tests.
            def dir_toward(learned, room_id, targets)
              tried = []
              30.times do
                if (dir = learned[room_id].keys.find { |d| targets.include?(learned[room_id][d]) })
                  return dir
                end
                targets.each { |t| tried.push(t) unless tried.include?(t) }
                prior = targets
                targets = learned.keys.find_all do |k|
                  learned[k].values.any? { |i| prior.include?(i) } && !tried.include?(k)
                end
                break if targets.empty?
              end
              nil
            end
          end
          reset!

          def initialize(params)
            @target = params['target']
          end

          def run
            klass = self.class
            klass.learned ||= {}
            klass.wander ||= []
            MAX_MOVES.times do
              start_room = Room.current
              return true if start_room.id == @target

              hot = HOT_ROOMS.include?(start_room.id)
              unless hot || COLD_ROOMS.include?(start_room.id)
                $go2_restart = true
                return false
              end

              note_landmarks(start_room, hot)
              if @target == 'tranquility' && GameObj.loot.any? { |o| o.name == 'point of elemental tranquility' }
                move 'go tranquility'
                $go2_restart = true
                return true
              end
              next unless sync_learned_exits(start_room)

              child = bounty_child
              dir = choose_direction(start_room, hot)
              result = move(dir.dup)
              wait_for_escort(child)

              if result == false
                recover_with_compass
              else
                end_room = Room.current
                next if end_room.id == start_room.id
                klass.learned[start_room.id][dir] = end_room.id
                klass.wander.delete(end_room.id)
                klass.wander.push(end_room.id)
              end
            end
            raise StepFailed, 'confluence_explorer exhausted its move budget'
          end

          private

          def note_landmarks(room, hot)
            klass = self.class
            if GameObj.loot.any? { |o| o.name == 'point of elemental tranquility' }
              hot ? klass.hot_tranquility = room.id : klass.cold_tranquility = room.id
            elsif klass.hot_tranquility == room.id
              klass.hot_tranquility = nil
            elsif klass.cold_tranquility == room.id
              klass.cold_tranquility = nil
            end
            if GameObj.loot.any? { |o| o.name == 'gaping bottomless pit' }
              hot ? klass.hot_pit = room.id : klass.cold_pit = room.id
            elsif klass.hot_pit == room.id
              klass.hot_pit = nil
            elsif klass.cold_pit == room.id
              klass.cold_pit = nil
            end
          end

          # Learn this room's exits; on inconsistency (layout shifted) drop the
          # whole learned graph, as the proc did. Returns false to retry the
          # outer loop when the room changed mid-read.
          def sync_learned_exits(room)
            klass = self.class
            if klass.learned[room.id].nil?
              exits = {}
              XMLData.room_exits.each { |d| exits[d] = nil }
              return false if Room.current != room
              klass.learned[room.id] = exits
            end
            if klass.learned[room.id].keys != XMLData.room_exits
              return false if Room.current != room
              klass.learned = {}
              return false
            end
            true
          end

          def choose_direction(room, hot)
            klass = self.class
            dir = target_direction(room, hot)
            dir ||= klass.dir_toward(klass.learned, room.id, [nil]) # nearest unexplored exit
            dir ||= klass.learned[room.id].keys.find { |d| !klass.wander.include?(klass.learned[room.id][d]) }
            if dir.nil?
              next_id = klass.wander.find { |i| klass.learned[room.id].values.include?(i) }
              dir = klass.learned[room.id].keys.find { |d| klass.learned[room.id][d] == next_id }
            end
            dir || XMLData.room_exits[rand(XMLData.room_exits.length)]
          end

          def target_direction(room, hot)
            klass = self.class
            if @target == 'tranquility'
              marker = hot ? klass.hot_tranquility : klass.cold_tranquility
              return marker ? klass.dir_toward(klass.learned, room.id, [marker]) : nil
            end
            crossing_zones = (hot && COLD_ROOMS.include?(@target)) || (!hot && HOT_ROOMS.include?(@target))
            if crossing_zones
              if GameObj.loot.any? { |o| o.name == 'gaping bottomless pit' }
                move 'go pit'
                return nil
              end
              marker = hot ? klass.hot_pit : klass.cold_pit
              return marker ? klass.dir_toward(klass.learned, room.id, [marker]) : nil
            end
            klass.dir_toward(klass.learned, room.id, [@target])
          end

          # Failed move: read the compass off a fresh look and take any exit.
          def recover_with_compass
            status_tags
            result = dothistimeout 'look', 5, /<compass>/
            status_tags
            options = result.to_s.scan(/<dir value="(.*?)"/).flatten
            move options[rand(options.length)] unless options.empty?
          end
        end
        register 'confluence_explorer', ConfluenceExplorer, %w[target]

        # Fixed guided walk through rooms with a per-room direction map (the
        # swim gauntlets, spider thread, and relatives). Optionally frees hands
        # on entry, waits for a bounty escort, and recovers when lost by
        # taking a random obvious path.
        #
        #   { "strategy" => "guided_route", "target" => 12677, "verb" => "swim",
        #     "dirs" => { "20786" => "down", "12662" => "whirlpool", ... },
        #     "hands_free_in" => [12662, 20786] }
        class GuidedRoute
          include EscortWait

          MAX_MOVES = 100

          def initialize(params)
            @target = params['target'].to_i
            @verb = params['verb']
            @dirs = (params['dirs'] || {}).transform_keys(&:to_i)
            @hands_free_in = Array(params['hands_free_in']).map(&:to_i)
            @escort = params['escort_wait']
          end

          def command_for(dir)
            @verb ? "#{@verb} #{dir}" : dir
          end

          def run
            raise StepFailed, 'guided_route requires a target and dirs' if @target.zero? || @dirs.empty?
            hands_freed = @hands_free_in.include?(Room.current.id)
            empty_hand if hands_freed
            child = @escort ? bounty_child : nil
            MAX_MOVES.times do
              break if Room.current.id == @target
              if (dir = @dirs[Room.current.id])
                put command_for(dir)
              else
                echo "guided_route: off the route in room #{Room.current.id}, groping for a path"
                put command_for(checkpaths[rand(checkpaths.length)])
              end
              sleep 1
              waitrt?
              wait_for_escort(child)
            end
            fill_hand if hands_freed
            return true if Room.current.id == @target
            raise StepFailed, 'guided_route exhausted its move budget'
          end
        end
        register 'guided_route', GuidedRoute, %w[target dirs]

        # Cyclic patrol along a fixed loop of rooms until a named object
        # appears in the room, then enters it (the Temple of Love mirror/door
        # family). Ends with a re-route since the loop exits somewhere new.
        #
        #   { "strategy" => "patrol_search", "rooms" => [2579, ...],
        #     "dirs" => ["southwest", "east", ...], "objects" => ["door", "mirror"] }
        class PatrolSearch
          MAX_MOVES = 200

          def initialize(params)
            @rooms = Array(params['rooms']).map { |r| r&.to_i } # nil = unmapped loop slot
            @dirs = Array(params['dirs'])
            @objects = Array(params['objects'])
            @enter = params['enter'] # optional step list; default is go <found>
          end

          def run
            raise StepFailed, 'patrol_search requires rooms, dirs, and objects' if @dirs.empty? || @objects.empty?
            index = @rooms.index(Room.current.id)
            raise StepFailed, "patrol_search started off-route in room #{Room.current.id}" if index.nil?

            found = nil
            MAX_MOVES.times do
              found = @objects.find { |o| checkloot.include?(o) }
              break if found
              move @dirs[index]
              index += 1
              index = 0 if index >= @dirs.length
            end
            raise StepFailed, 'patrol_search never found its exit object' unless found
            if @enter
              @enter.each { |s| MapEngine.run_step(s) }
            else
              move "go #{found}"
            end
            $go2_restart = true
            true
          end
        end
        register 'patrol_search', PatrolSearch, %w[rooms dirs objects]

        # The minotaur mazes: shifting mazes whose learned layout the procs
        # shared in $minotaur_maze_dirs. The learned graph persists on the
        # class across crossings, keyed per room, exactly as the global did.
        #
        #   { "strategy" => "shifting_maze", "target" => 6192,
        #     "rooms" => [6191, 6254, ...] }
        class ShiftingMaze
          include EscortWait

          MAX_MOVES = 100

          class << self
            attr_accessor :learned

            def reset!
              @learned = {}
            end
          end
          reset!

          def initialize(params)
            @target = params['target'].to_i
            @rooms = Array(params['rooms']).map(&:to_i)
          end

          def run
            raise StepFailed, 'shifting_maze requires a target and rooms' if @target.zero? || @rooms.empty?
            learned = self.class.learned
            MAX_MOVES.times do
              child = bounty_child
              start_room = Room.current
              return true if start_room.id == @target
              learned[start_room.id] ||= {}
              dir = pick_direction(learned, start_room.id)
              move dir.dup
              wait_for_escort(child)
              end_room = Room.current
              learned[start_room.id][dir] = end_room.id
              return true if end_room.id == @target
              step_back_inside(start_room, end_room, child) unless @rooms.include?(end_room.id)
            end
            raise StepFailed, 'shifting_maze exhausted its move budget'
          end

          private

          def pick_direction(learned, room_id)
            learned[room_id].keys.find { |d| learned[room_id][d] == @target } ||
              XMLData.room_exits.find { |d| learned[room_id][d].nil? } ||
              learned[room_id].keys.find { |d| learned[learned[room_id][d]]&.values&.include?(@target) } ||
              XMLData.room_exits[rand(XMLData.room_exits.length)]
          end

          # Stepped out of the maze: cross back in via the mapped edge.
          def step_back_inside(start_room, end_room, child)
            way = end_room.wayto[start_room.id.to_s]
            if way.respond_to?(:call)
              way.call
              wait_for_escort(child)
            elsif way.is_a?(String)
              move way.dup
              wait_for_escort(child)
            end
          end
        end
        register 'shifting_maze', ShiftingMaze, %w[target rooms]

        # Voln symbol-of-seeking travel: cycle the symbol's random destination
        # until the offered room's name matches the target room's title, then
        # confirm the teleport. Ported from the shared proc at room 3600.
        #
        #   { "strategy" => "voln_seeking", "target" => 12603 }
        class VolnSeeking
          ROOMNAME_PATTERN = %r{<style id="roomName" />(.*?)$}
          MAX_ATTEMPTS = 20

          def initialize(params)
            @target = params['target'].to_i
          end

          def run
            raise StepFailed, 'voln_seeking requires a target' if @target.zero?
            destination = Map[@target]
            raise StepFailed, "voln_seeking: unknown room #{@target}" unless destination

            need_roomname_off = ensure_roomnames_on
            script = Script.current
            save_downstream = script.want_downstream
            save_downstream_xml = script.want_downstream_xml
            script.want_downstream = false
            script.want_downstream_xml = true

            first_roomname = nil
            found = false
            begin
              MAX_ATTEMPTS.times do
                waitcastrt?
                put 'symbol of seeking'
                matchtimeout(6, 'Your vision is pulled away from you...')
                result = matchtimeout(6, ROOMNAME_PATTERN)
                next unless result

                offered = result.match(ROOMNAME_PATTERN)&.captures&.first
                next unless offered
                if offered[0] == '<'
                  need_roomname_off = true
                  fput 'flag roomname on'
                  next
                end
                offered.slice!(::Regexp.last_match(1)) if offered =~ /( \(\d+\))$/

                break if first_roomname == offered # cycled all the way around

                first_roomname ||= offered
                if destination.title.include?(offered)
                  found = true
                  break
                end
              end
            ensure
              script.want_downstream_xml = save_downstream_xml
              script.want_downstream = save_downstream
              fput 'set roomname off' if need_roomname_off
            end

            raise StepFailed, "voln_seeking: destination #{@target} never offered" unless found

            note_redforest_side if @target == 24_715
            dothistimeout('symbol of seeking confirm', 6, /^Your surroundings blur into a white fog/)
            true
          end

          private

          def ensure_roomnames_on
            last_roomdesc = $_SERVERBUFFER_.reverse.find do |line|
              line =~ %r{<resource picture="\d+"/><style id="roomName" ?/>\[[^\]]+\]} ||
                line =~ /You will no longer see room names\./
            end
            if last_roomdesc =~ /You will no longer see room names\./
              fput 'set roomname on'
              return true
            end
            false
          end

          # The Red Forest exists in two variants; remember which side this
          # character entered from so the return gates can cost correctly.
          def note_redforest_side
            UserVars.mapdb_redforest_location = 'WL' if Map.current.id == 3600
            UserVars.mapdb_redforest_location = 'EN' if Map.current.id == 10_125
          end
        end
        register 'voln_seeking', VolnSeeking, %w[target]

        # Icy slope descent (Pinefar/glacier family): wait out the ice when
        # unprepared, otherwise lean on Sigil of Resolve; on a slip ("Rushing
        # heedlessly"), cast Haste, stand, and ask go2 to re-route.
        #
        #   { "strategy" => "ice_slope", "cmd" => "down" }
        class IceSlope
          def initialize(params)
            @cmd = params['cmd']
          end

          def run
            raise StepFailed, 'ice_slope requires cmd' unless @cmd
            resolve = Spell['Sigil of Resolve']
            haste = Spell['Haste']
            if MapEngine.uservar('mapdb_ice_mode') == 'wait' || Skills.survival < 50 ||
               XMLData.encumbrance_value >= 50
              echo 'trying not to slip...'
              sleep 6
            elsif resolve.known? && resolve.affordable? && !resolve.active?
              resolve.cast
            end
            result = fput @cmd
            if result =~ /^Rushing heedlessly/
              haste.cast if haste.known? && haste.affordable? && !haste.active?
              fput 'stand'
              $go2_restart = true
            end
            true
          end
        end
        register 'ice_slope', IceSlope, %w[cmd]

        # Shared Chronomage day-pass state: a downstream hook that learns pass
        # ids, town pairs, and expiries from "look pass" text, plus the sack
        # scan that refreshes the cache. The proc original ran the scan inside
        # timeto evaluation (game commands during pathfinding); here the cost
        # gate only reads the cache and the crossing strategy owns the scan.
        module DayPass
          HOOK_NAME = 'mapdb_day_pass_monitor'
          MONTH_NUM = { 'Jan' => 1, 'Feb' => 2, 'Mar' => 3, 'Apr' => 4, 'May' => 5, 'Jun' => 6,
                        'Jul' => 7, 'Aug' => 8, 'Sep' => 9, 'Oct' => 10, 'Nov' => 11, 'Dec' => 12 }.freeze
          OPEN_REGEX = /^You open|^That is already open\.$|^There doesn't seem to be any way to do that\.$|^What were you referring to\?|^I could not find what you were referring to\./
          GET_REGEX = /^You (?:shield the opening of .*? from view as you |discreetly |carefully |deftly )?(?:remove|draw|grab|reach|slip|tuck|retrieve|already have|unsheathe|detach)|^Get what\?$|^Why don't you leave some for others\?$|^You need a free hand|^You already have that/
          PUT_REGEX = /^You (?:attempt to shield .*? from view as you |discreetly |carefully |absent-mindedly )?(?:put|place|slip|tuck|add|hang|drop|untie your|find an incomplete bundle|wipe off .*? and sheathe)|^A sigh of grateful pleasure can be heard as you feed .*? to your|^As you place|^I could not find what you were referring to\.$|^Your bundle would be too large|^The .+ is too large to be bundled\.|^As you place your|^The .*? is already a bundle|^Your .*? won't fit in .*?\.$|^You can't .+ It's closed!$|^You can't put/

          module_function

          def passes
            $mapdb_day_passes ||= {}
          end

          # Pure: does the cache hold a live pass for this town pair?
          def usable?(town_a, town_b)
            ensure_monitor
            passes.any? do |_id, h|
              h[:towns].include?(town_a) && h[:towns].include?(town_b) &&
                h[:expires] && h[:expires] > (Time.now + 10)
            end
          end

          def find_pass(town_a, town_b)
            passes.keys.find do |id|
              h = passes[id]
              h[:towns].include?(town_a) && h[:towns].include?(town_b) &&
                h[:expires] && h[:expires] > (Time.now + 10)
            end
          end

          # Installs the downstream hook that keeps the cache fresh from
          # "look pass" output. No game IO; safe from cost evaluation.
          def ensure_monitor
            return unless defined?(DownstreamHook) && DownstreamHook.respond_to?(:list)
            return if DownstreamHook.list.include?(HOOK_NAME)
            last_id = nil
            hook = proc do |s|
              if s =~ %r{^Bold calligraphy states simply, "This <a exist="(-?[0-9]+)" noun="pass">pass</a> entitles the original purchaser to one \(1\) day of unlimited travel between the towns of (.+?) and (.+?), commencing}
                last_id = ::Regexp.last_match(1)
                passes[last_id] = { :towns => [::Regexp.last_match(2), ::Regexp.last_match(3)] }
              elsif s =~ %r{^Bold red block letters spelling out "EXPIRED" appear to have been stamped across the face and reverse of the <a exist="(-?\d+)" noun="pass">pass}
                passes[::Regexp.last_match(1)] = { :towns => [], :expires => Time.now }
              elsif s =~ /^\[Your pass will expire on \w+ (\w+) *(\d+) (\d+):(\d+):(\d+) ET (\d+)\./
                if last_id
                  m = ::Regexp.last_match
                  passes[last_id][:expires] = Time.at(Time.new(m[6], MONTH_NUM[m[1]], m[2], m[3], m[4], m[5], '-05:00').to_i)
                  last_id = nil
                end
              elsif s =~ /quickly hands you a Chronomage day pass/
                UserVars.mapdb_find_day_pass = 'yes'
              end
              s
            end
            DownstreamHook.add(HOOK_NAME, hook)
            UserVars.mapdb_find_day_pass = 'yes'
          end

          def find_sack
            sack_name = UserVars.day_pass_sack
            return nil unless sack_name
            GameObj.inv.find { |obj| obj.noun == sack_name } ||
              GameObj.inv.find { |obj| obj.name == sack_name } ||
              GameObj.inv.find { |obj| obj.name =~ /\b#{Regexp.escape(sack_name)}$/i } ||
              GameObj.inv.find { |obj| obj.name =~ /\b#{sack_name.split(' ').collect { |n| Regexp.escape(n) }.join('.*\\b')}/i }
          end

          # Game IO: open the sack if needed, look at unknown passes so the
          # monitor learns them, prune ids no longer present. The crossing
          # strategy calls this; cost evaluation never does.
          def scan!
            ensure_monitor
            return unless UserVars.mapdb_find_day_pass == 'yes'
            sack = find_sack
            unless sack
              echo 'warning: day_pass_sack is not set or not found; cannot scan Chronomage day passes.'
              return
            end
            close_sack = false
            if sack.contents.nil?
              open_result = dothistimeout "open ##{sack.id}", 10, OPEN_REGEX
              if open_result =~ /^You open/
                close_sack = true
              else
                dothistimeout "look in ##{sack.id}", 10, /In the .*? you see/
              end
            end
            if sack.contents
              passes.keys.each do |id|
                passes.delete(id) unless sack.contents.any? { |obj| obj.id == id }
              end
              sack.contents.find_all { |obj| obj.name == 'Chronomage day pass' }.each do |pass|
                next if passes[pass.id]
                dothistimeout "look ##{pass.id}", 10,
                              /^Bold calligraphy states simply|^Bold red block letters spelling out "EXPIRED"|^I could not find/
              end
              UserVars.mapdb_find_day_pass = 'no'
            end
            dothistimeout "close ##{sack.id}", 3, /^You close/ if close_sack
          end
        end

        # Chronomage day-pass travel between town pairs. Parameters carry the
        # per-booth differences (NPC, ask keyword, booth moves, bank walk);
        # the shared program lives here once.
        #
        #   { "strategy" => "chronomage_day_pass",
        #     "towns" => ["Wehnimer's Landing", "Icemule Trace"],
        #     "buy_token" => "wl,imt", "npc" => "clerk", "ask" => "icemule",
        #     "enter" => "south", "exit" => "north",
        #     "bank_to" => ["up", "north", ...], "bank_from" => [...] }
        class ChronomageDayPass
          def initialize(params)
            @towns = Array(params['towns'])
            @buy_token = params['buy_token']
            @npc = params['npc']
            @ask = params['ask']
            @enter = params['enter']
            @exit = params['exit']
            @bank_to = Array(params['bank_to'])
            @bank_from = Array(params['bank_from'])
            @withdraw = params['withdraw'] || 5000
          end

          def buy_enabled?
            UserVars.mapdb_buy_day_pass.to_s =~ /^(?:yes|true)$|\b#{Regexp.escape(@buy_token.to_s)}\b/i
          end

          def run
            raise StepFailed, 'chronomage_day_pass requires two towns' unless @towns.length == 2
            DayPass.scan!
            sack = DayPass.find_sack
            raise StepFailed, 'chronomage_day_pass: day_pass_sack not found' unless sack

            close_sack = false
            if sack.contents.nil?
              open_result = dothistimeout "open ##{sack.id}", 10, DayPass::OPEN_REGEX
              if open_result =~ /^You open/
                close_sack = true
              else
                dothistimeout "look in ##{sack.id}", 10, /In the .*? you see/
              end
            end
            empty_hand
            drop_expired
            pass_id = DayPass.find_pass(@towns[0], @towns[1])
            if pass_id
              dothistimeout "get ##{pass_id}", 10, DayPass::GET_REGEX
            else
              pass_id = buy_pass
            end
            if pass_id
              dothistimeout "raise ##{pass_id}", 10,
                            /whirlwind of color subsides|pass is expired|not valid for departures|As you go to raise your pass, you realize|Raise what/
              dothistimeout "_drag ##{pass_id} ##{sack.id}", 10, DayPass::PUT_REGEX
            else
              DayPass.passes.clear
              UserVars.mapdb_find_day_pass = 'yes'
              $restart_go2 = true
            end
            fill_hand
            dothistimeout "close ##{sack.id}", 2, /^You close/ if close_sack
            !pass_id.nil?
          end

          private

          def drop_expired
            DayPass.passes.keys.each do |id|
              next unless DayPass.passes[id][:expires] && DayPass.passes[id][:expires] < (Time.now - 10)
              dothistimeout "_drag ##{id} drop", 2, /^As you let go|^You drop/
              DayPass.passes.delete(id)
            end
          end

          # Visit the booth NPC, banking for silvers when short (and allowed).
          # Returns the purchased pass id, or nil.
          def buy_pass
            return nil unless buy_enabled?
            move @enter
            fput 'unhide' if hidden? || invisible?
            ask_cmd = "ask #{@npc} for #{@ask}"
            dothistimeout ask_cmd, 10, /says to you/
            result = dothistimeout ask_cmd, 10, /don't have enough|quickly hands you/
            if result =~ /don't have enough/ && $go2_get_silvers && @bank_to.any?
              @bank_to.each { |dir| move dir }
              dothistimeout "withdraw #{@withdraw}", 10, /carefully records|through the books/
              @bank_from.each { |dir| move dir }
              fput 'unhide' if hidden? || invisible?
              result = dothistimeout ask_cmd, 10, /says to you|don't have enough|quickly hands you/
              result = dothistimeout ask_cmd, 10, /don't have enough|quickly hands you/ if result =~ /says to you/
            end
            if result =~ /quickly hands you/
              pass_id = GameObj.right_hand.noun == 'pass' ? GameObj.right_hand.id : nil
              pass_id ||= GameObj.left_hand.noun == 'pass' ? GameObj.left_hand.id : nil
              fput "look ##{pass_id}" # teaches the monitor this pass
              move @exit
              return pass_id
            end
            if result =~ /don't have enough/
              echo 'error: You are too poor to buy Chronomage day passes.  Turning off buy_day_pass setting.'
              sleep 3
              UserVars.mapdb_buy_day_pass = 'no'
            end
            nil
          end
        end
        register 'chronomage_day_pass', ChronomageDayPass, %w[towns npc ask enter exit]

        # Send each element of a user-configured UserVars list (the Mularos
        # lover ritual: personal command sequences stored per character).
        class UservarSends
          def initialize(params)
            @var = params['var']
          end

          def run
            list = UserVars.respond_to?(@var) ? UserVars.send(@var) : nil
            Array(list).each { |cmd| fput cmd.to_s }
            true
          end
        end
        register 'uservar_sends', UservarSends, %w[var]

        # Rogue Guild entrance: lean on the door, perform the character's
        # secret knock from UserVars.rogue_password, and enter.
        class RogueGuildDoor
          def initialize(_params); end

          def run
            password = UserVars.respond_to?(:rogue_password) ? UserVars.rogue_password : nil
            if password.nil? || password.empty?
              echo 'No Rogue Guild password has been set.'
              echo 'example:  ;vars set rogue_password=kick, slap, turn, scratch, kick, slap'
              raise StepFailed, 'rogue_guild_door: no password set'
            end
            fput 'lean door'
            password.split(/, */).each { |verb| fput "#{verb} door" }
            fput 'go door'
            true
          end
        end
        register 'rogue_guild_door', RogueGuildDoor
      end
    end
  end
end
