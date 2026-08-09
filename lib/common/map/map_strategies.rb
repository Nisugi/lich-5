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
      end
    end
  end
end
