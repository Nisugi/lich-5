# frozen_string_literal: true

# Runtime conversion of mapdb StringProcs.
#
# The mapdb ships as eval'd Ruby strings (";e ..."). Rather than eval them,
# Lich wraps each one at map load in a GuardedProc, which converts the body
# to MapEngine schema the first time the edge is used and executes the
# schema instead. The proc source is never eval'd and never edited: _dump
# still returns it verbatim, so saving a map or running mapmap round-trips
# byte-identically and a mapper's workflow is untouched.
#
# Conversion is memoized by source string. The mapdb duplicates proc bodies
# heavily - a full GS map has ~9,800 proc edges but only ~1,800 distinct
# bodies, and just ~150 distinct timeto bodies, which is what dijkstra
# actually touches - so a session converts each body once and then runs
# pure schema.
#
# Fail closed. A body no recognizer handles is refused, not eval'd:
#   timeto -> nil   (dijkstra already treats a nil cost as "not routable")
#   wayto  -> false (go2 treats the crossing as failed)
# Every refusal is recorded so `Map.conversion_report` can show which
# idioms need a recognizer.

require_relative '../class_exts/stringproc'
require_relative 'map_engine'
require_relative 'map_convert'

module Lich
  module Common
    module MapEngine
      class GuardedProc < StringProc
        # source => Cost | Crossing | String (plain move) | :refused
        @cache = {}
        # Manual-overlay hits are keyed by edge, not body, so they cache apart.
        @edge_cache = {}
        @refusals = {}

        class << self
          attr_reader :cache, :edge_cache, :refusals

          def reset!
            @cache = {}
            @edge_cache = {}
            @refusals = {}
            @converter = nil
          end

          # Edges whose proc could not be converted, clustered by normalized
          # body so a thousand copies of one unknown idiom report once.
          def refusal_clusters
            @refusals.map do |key, info|
              { cluster: key, field: info[:field], count: info[:edges].length,
                example: info[:edges].first, edges: info[:edges] }
            end.sort_by { |c| -c[:count] }
          end

          def note_refusal(field, body, room_id, dest)
            key = converter.cluster_key(body)
            entry = (@refusals[key] ||= { field: field, edges: [] })
            edge = [room_id, dest]
            entry[:edges] << edge unless entry[:edges].include?(edge)
            entry
          end

          # One converter instance, carrying the shipped manual overlay for
          # the game whose map is loaded. Built once: the game cannot change
          # within a session, and re-deriving it per call would put an
          # XMLData lookup on the dijkstra hot path.
          def converter
            @converter ||= MapConvert.new.tap { |c| c.load_shipped_manual(current_game) }
          end

          # Explicitly select the overlay - used by the loader, which knows
          # which game's map it is parsing, and by specs.
          def use_game(game)
            @converter = MapConvert.new.tap { |c| c.load_shipped_manual(game) }
          end

          def current_game
            defined?(XMLData) && XMLData.respond_to?(:game) ? XMLData.game.to_s : ''
          end
        end

        attr_reader :field, :room_id, :dest

        def initialize(source, field, room_id, dest)
          super(source)
          @field = field
          @room_id = room_id
          @dest = dest
        end

        def call(*_args)
          built = resolve
          case built
          when :refused then refuse
          when String   then move(built) # degenerate proc: a plain movement
          else built.call
          end
        end

        private

        # Convert once, then reuse. Manual entries are keyed by edge because
        # two rooms can share a body but need different hand-authored schema.
        def resolve
          cache = GuardedProc.cache
          edge_cache = GuardedProc.edge_cache
          edge_key = "#{@room_id}:#{@dest}"

          return edge_cache[edge_key] if edge_cache.key?(edge_key)
          if (manual = GuardedProc.converter.manual_for(@field, @room_id, @dest))
            return edge_cache[edge_key] = build(manual)
          end
          return cache[@string] if cache.key?(@string)

          cache[@string] = convert_body
        end

        def convert_body
          result = if @field == 'wayto'
                     GuardedProc.converter.convert_wayto(@string)
                   else
                     GuardedProc.converter.convert_timeto(@string)
                   end
          # nil: no recognizer matched. schema nil: recognized but deliberately
          # not converted (a virtual edge), which behaves as a refusal here
          # since there is nothing to execute.
          return record_refusal if result.nil? || result.schema.nil?

          schema = result.schema
          return schema if schema.is_a?(String) # plain move, execute directly

          schema = GuardedProc.converter.guard_trailing_replan(schema, @dest) if @field == 'wayto'
          errors = if @field == 'wayto'
                     MapEngine::Validator.errors_for_wayto(schema)
                   else
                     MapEngine::Validator.errors_for_timeto(schema)
                   end
          return record_refusal(errors) unless errors.empty?

          build(schema)
        end

        def build(schema)
          @field == 'wayto' ? MapEngine.build_wayto(schema, @dest) : MapEngine.build_timeto(schema)
        end

        def record_refusal(errors = nil)
          entry = GuardedProc.note_refusal(@field, @string, @room_id, @dest)
          if entry[:edges].length == 1 && defined?(respond)
            respond "--- MapEngine: cannot convert #{@field} #{@room_id}->#{@dest}" \
                    "#{errors ? " (#{errors.join('; ')})" : ''}; edge not routable."
          end
          :refused
        end

        # Refusal is not an error: the edge simply cannot be travelled, which
        # both callers already understand.
        def refuse
          @field == 'wayto' ? false : nil
        end
      end
    end
  end
end
