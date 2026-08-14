# frozen_string_literal: true

#
# Combat Observers - subscription seam for parsed combat facts.
#
# The Creature registry is the public read model for "now" (Processor
# applies every parsed fact to CreatureInstance, and consumers read
# current state from there). Observers are the feed of "what just
# happened" - the three things state reads structurally cannot provide:
#
#   1. Edges, not levels: transition notifications, transients that occur
#      between polls (stunned-then-unstunned, brief statuses).
#   2. The ledger, not the balance: persist_event aggregates (damage
#      totals, wound ranks); the per-event detail is consumed at
#      application time and only exists here.
#   3. Persistence: registry entries are session-only and swept
#      (cleanup_max_age) - recording/logging scripts must capture events
#      at parse time.
#
# Contract for subscribers:
#   - Callbacks may run on AsyncProcessor worker threads. They must be
#     cheap and non-blocking, and must NEVER send game commands (fput /
#     Spell#cast / PSMS.use) - queue work for your own script thread.
#   - A raising subscriber is isolated and logged; it never breaks other
#     subscribers or the processor.
#
# Event types and payloads (all include :id, :name of the creature):
#   :damage     { id:, name:, attack:, amount: }
#   :wound      { id:, name:, attack:, location:, body_part:, rank: }
#   :fatal_crit { id:, name:, attack:, location: }
#   :status     { id:, name:, status:, action: :add | :remove }
#   :ucs        { id:, name:, kind: :position|:tierup|:smite_on|:smite_off, value: }
#
# @example
#   Combat::Tracker.on(:damage) { |type, data| my_queue << data }
#   handler = Combat::Tracker.on(:status, :wound) { |type, data| ... }
#   Combat::Tracker.off(handler)
#
module Lich
  module Gemstone
    module Combat
      module Observers
        @mutex = Mutex.new
        @subscribers = Hash.new { |h, k| h[k] = [] }

        class << self
          # Subscribe to one or more event types (or :any for everything).
          # Returns the block; keep it to unsubscribe via .off.
          def on(*types, &block)
            raise ArgumentError, 'block required' unless block

            types = [:any] if types.empty?
            @mutex.synchronize { types.each { |t| @subscribers[t.to_sym] << block } }
            block
          end

          # Remove a previously registered handler from all types.
          def off(handler)
            @mutex.synchronize { @subscribers.each_value { |list| list.delete(handler) } }
            nil
          end

          # Emit an event to type + :any subscribers. Subscriber errors are
          # isolated and logged, never raised to the caller (the processor).
          def emit(type, data)
            handlers = @mutex.synchronize { @subscribers[type].dup + @subscribers[:any].dup }
            handlers.each do |handler|
              begin
                handler.call(type, data)
              rescue StandardError => e
                Lich.log "error: Combat::Observers subscriber (#{type}): #{e.message}\n\t#{e.backtrace&.first}"
              end
            end
            nil
          end

          def any_for?(type)
            @mutex.synchronize { !@subscribers[type].empty? || !@subscribers[:any].empty? }
          end

          def clear!
            @mutex.synchronize { @subscribers.clear }
          end
        end
      end
    end
  end
end
