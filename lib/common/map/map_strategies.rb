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


        # One-off crossings relocated verbatim from mapdb StringProcs into
        # lib/common/map/map_crossings.rb (generated, reviewed code).
        class UniqueCrossing
          def initialize(params)
            @name = params['name']
          end

          def run
            UniqueCrossings.run(@name)
          end
        end
        register 'unique_crossing', UniqueCrossing, %w[name]
      end
    end
  end
end
