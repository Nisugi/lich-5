# frozen_string_literal: true

#
# Combat Processor V2 - State machine approach for efficient parsing
# Transitions: SEEKING_ATTACK -> SEEKING_DAMAGE -> SEEKING_CRIT -> (repeat)
#

require_relative '../creature'
require_relative '../critranks'
require_relative 'observers'

module Lich
  module Gemstone
    module Combat
      module Processor
        # The floor positions are mutually exclusive: a creature is prone
        # OR sitting OR kneeling (or none), never several at once, and the
        # stand-up messagings are shared between them.
        POSITION_STATUSES = %w[prone sitting kneeling].freeze

        module_function

        # Process a chunk of game lines for combat events
        #
        # @param chunk [Array<String>] game lines
        # @param at [Time, nil] server time for this chunk (from the chunk's
        #   <prompt time=>). Duration estimates are anchored to this rather
        #   than to parse time, which the async worker can lag under load.
        def process(chunk, at: nil)
          events = parse_events(chunk)
          return if events.empty?

          at ||= prompt_time(chunk) || Time.now
          events.each do |event|
            event[:at] = at
            persist_event(event)
          end

          respond "[Combat] Processed #{events.size} events" if Tracker.debug?
        end

        PROMPT_TIME_PATTERN = /<prompt time="(\d+)"/.freeze

        # Extracts the server timestamp from a chunk's <prompt> tag.
        #
        # Chunks are segmented on the prompt, so the last match is this
        # chunk's own prompt.
        #
        # @return [Time, nil] the chunk's prompt time expressed on the LOCAL
        #   clock, or nil when the chunk has no prompt.
        #
        # The prompt stamp is the game SERVER's epoch, but every duration
        # estimate downstream (stun expiry, status timestamps) is compared
        # against local Time.now. XMLData tracks the skew between the two
        # clocks for exactly this reason - a raw Time.at(server_epoch) on a
        # machine 40s ahead of the server produces stun estimates that are
        # already expired the moment they land.
        def prompt_time(chunk)
          chunk.reverse_each do |line|
            if (m = PROMPT_TIME_PATTERN.match(line))
              offset = defined?(XMLData) ? XMLData.server_time_offset.to_f : 0.0
              return Time.at(m[1].to_i + offset)
            end
          end
          nil
        end

        # An event is worth persisting only if it has a target to apply data to
        # and any data to apply. Single predicate so every save site agrees
        # (previously three sites used three different criteria).
        def event_worth_saving?(event)
          return false unless event && event[:target][:id]

          !event[:damages].empty? || !event[:crits].empty? || !event[:statuses].empty?
        end

        # State machine parser
        def parse_events(lines)
          events = []
          current_event = nil
          parse_state = :seeking_attack
          current_target = nil

          lines.each_with_index do |line, index|
            next if line.strip.empty?

            # Extract creature target once per line; reused by the status
            # handler and the target-switch logic below
            line_target = Parser.extract_target_from_line(line)

            # Always check for status effects on every line (even outside combat)
            if Tracker.settings[:track_statuses]
              if (status_result = Parser.parse_status(line))
                if line_target && line_target[:id]
                  # Use ID-based lookup - this is most reliable
                  if status_result.is_a?(Hash)
                    apply_status_to_target(status_result[:status], line_target[:name], line_target[:id], status_result[:action])
                  else
                    # Legacy format - status_result is just the status symbol
                    apply_status_to_target(status_result, line_target[:name], line_target[:id], :add)
                  end
                elsif status_result.is_a?(Hash) && status_result[:target]
                  # Fallback to name-based lookup only if no ID available
                  apply_status_to_target(status_result[:status], status_result[:target], nil, status_result[:action])
                end
                respond "[Combat] Found status effect: #{status_result}" if Tracker.debug?
              end
            end

            # Always check for UCS events on every line
            if Tracker.settings[:track_ucs]
              if (ucs_result = Parser.parse_ucs(line))
                apply_ucs_to_target(ucs_result, current_target)
                respond "[Combat] Found UCS event: #{ucs_result}" if Tracker.debug?
              end
            end

            # Handle target switching (for multi-target attacks like volley)
            if line_target && parse_state != :seeking_attack
              # Check if this is a real target switch (different creature)
              if current_target && current_target[:id] != line_target[:id]
                # Save previous event if it has data
                if event_worth_saving?(current_event)
                  events << current_event
                  respond "[Combat] Saved event for #{current_event[:target][:name]}: #{current_event[:damages].size} damages, #{current_event[:crits].size} crits, #{current_event[:statuses].size} statuses" if Tracker.debug?
                end

                # Create new event for this target (inherit attack name from previous)
                current_event = {
                  name: current_event ? current_event[:name] : :unknown,
                  target: line_target,
                  damages: [],
                  crits: [],
                  statuses: []
                }
                current_target = line_target
                respond "[Combat] Switched to target: #{line_target[:name]} (#{line_target[:id]})" if Tracker.debug?

              elsif current_target.nil?
                # First target for current event - just set it, don't discard data
                current_event[:target] = line_target
                current_target = line_target
                respond "[Combat] Found target: #{line_target[:name]} (#{line_target[:id]})" if Tracker.debug?
              end
              # If current_target[:id] == line_target[:id], do nothing (same target)
            end

            # Attack check is needed in both states (a new attack while seeking
            # damage closes the previous event), so run it once per line. This
            # replaces the old `redo`, which re-ran the status/UCS handlers
            # above on the same line and double-applied their effects.
            attack = Parser.parse_attack(line)

            if attack
              # Save previous event before starting a new one
              if event_worth_saving?(current_event)
                events << current_event
                respond "[Combat] Completed event for #{current_event[:target][:name]}: #{current_event[:damages].size} damages, #{current_event[:crits].size} crits" if Tracker.debug?
              end

              current_event = {
                name: attack[:name],
                target: attack[:target] || {},
                damages: [],
                crits: [],
                statuses: []
              }
              current_target = current_event[:target][:id] ? current_event[:target] : nil

              respond "[Combat] Found attack: #{attack[:name]}" if Tracker.debug?
              parse_state = :seeking_damage
            elsif parse_state == :seeking_damage
              # Accumulate all damage lines for the current attack
              if (damage = Parser.parse_damage(line))
                current_event[:damages] << damage
                respond "[Combat] Found damage: #{damage}" if Tracker.debug?

                # When we find damage, look ahead 2-3 lines for related crit
                if Tracker.settings[:track_wounds]
                  (1..3).each do |offset|
                    next_line_index = index + offset
                    break if next_line_index >= lines.size

                    next_line = lines[next_line_index]

                    # Stop looking if we hit another damage line (belongs to next damage)
                    if Parser.parse_damage(next_line)
                      respond "[Combat] Stopped crit search - found next damage line" if Tracker.debug?
                      break
                    end

                    # Look for crit on this line
                    if (c = CritRanks.parse(next_line.gsub(/<.+?>/, '')).values.first)
                      # Keep the whole CritRanks hash rather than copying five
                      # keys out of it: it is already allocated, and the rest
                      # (stunned, roundtime, amputated, position, silenced,
                      # slowed, dazed, secondary_wound, ...) is state we would
                      # otherwise have to infer from messaging - or, for the
                      # UCS-only fields, could not obtain at all.
                      current_event[:crits] << c
                      respond "[Combat] Found critical hit: #{c[:location]} rank #{c[:wound_rank]}" if Tracker.debug?
                      break # Only take first crit found after this damage
                    end
                  end
                end
              end
            end
          end

          # Don't forget the last event
          events << current_event if event_worth_saving?(current_event)

          events
        end

        # Apply combat event to creature instance (same as before)
        def persist_event(event)
          target = event[:target]
          return unless target[:id]

          creature = Creature[target[:id].to_i]
          unless creature
            respond "[Combat] No creature found for ID #{target[:id]}" if Tracker.debug?
            return
          end

          respond "[Combat] Applying to #{creature.name} (#{target[:id]})" if Tracker.debug?

          # Apply direct damage
          total_damage = 0
          event[:damages].each do |damage|
            creature.add_damage(damage)
            total_damage += damage
            Observers.emit(:damage, id: creature.id, name: creature.name,
                                    attack: event[:name], amount: damage)
            respond "  +#{damage} damage" if Tracker.debug?
          end

          # Apply critical wounds
          if Tracker.settings[:track_wounds]
            event[:crits].each do |crit|
              if crit[:wound_rank] && crit[:wound_rank] > 0
                # Map CritRanks location to creature body part format
                body_part = map_critranks_to_body_part(crit[:location])
                if body_part
                  creature.add_injury(body_part, crit[:wound_rank])
                  Observers.emit(:wound, id: creature.id, name: creature.name,
                                         attack: event[:name], location: crit[:location],
                                         body_part: body_part, rank: crit[:wound_rank])
                  respond "  +wound: #{body_part} rank #{crit[:wound_rank]}" if Tracker.debug?
                else
                  respond "  !unknown body part: #{crit[:location]}" if Tracker.debug?
                end
              end

              # A crit can wound a second location (e.g. a strike that carries
              # through); previously only the primary was registered.
              if (secondary = crit[:secondary_wound])
                apply_secondary_wound(creature, secondary, event)
              end

              # Amputation is a distinct terminal state, not accumulated rank.
              if crit[:amputated] && (part = map_critranks_to_body_part(crit[:location]))
                creature.amputate!(part)
                Observers.emit(:amputation, id: creature.id, name: creature.name,
                                            attack: event[:name], location: crit[:location],
                                            body_part: part)
                respond "  +AMPUTATED: #{part}" if Tracker.debug?
              end

              # Check for fatal critical hit
              if crit[:fatal]
                creature.mark_fatal_crit!
                Observers.emit(:fatal_crit, id: creature.id, name: creature.name,
                                            attack: event[:name], location: crit[:location])
                respond "  +FATAL CRIT: #{crit[:location]} - creature died from crit, not HP loss" if Tracker.debug?
              end
            end
          end

          # Status effects: crit-table-derived and message-derived, under
          # one gate so they can never drift onto different flags.
          if Tracker.settings[:track_statuses]
            apply_crit_statuses(creature, event)
            event[:statuses].each do |status|
              creature.add_status(status)
              Observers.emit(:status, id: creature.id, name: creature.name,
                                      status: status, action: :add)
              respond "  +status: #{status}" if Tracker.debug?
            end
          end

          respond "  Total damage applied: #{total_damage}" if total_damage > 0 && Tracker.debug?
        end

        # Registers a crit's secondary wound location, when it has one.
        #
        # CritRanks may report secondary_wound as a bare rank (same location)
        # or as a {location:, rank:} pair; accept both.
        def apply_secondary_wound(creature, secondary, event)
          # bare (non-Hash) value with no location is ambiguous - skip
          # rather than guess
          return unless secondary.is_a?(Hash)

          location = secondary[:location] || secondary['location']
          # The tables key this :wound_rank ({ :location => "head",
          # :wound_rank => 3 }); reading :rank made every secondary wound
          # a silent no-op. :rank kept as a fallback for older data.
          rank = (secondary[:wound_rank] || secondary['wound_rank'] ||
                  secondary[:rank] || secondary['rank']).to_i
          return unless rank > 0

          # "both eyes" is a real table location with no single body part -
          # it is two wounds, one per eye.
          parts = if location.to_s.downcase.gsub(/[^a-z]/, '') == 'botheyes'
                    %w[leftEye rightEye]
                  else
                    [map_critranks_to_body_part(location)].compact
                  end
          if parts.empty?
            respond "  !unknown secondary wound location: #{location}" if Tracker.debug?
            return
          end

          parts.each do |part|
            creature.add_injury(part, rank)
            Observers.emit(:wound, id: creature.id, name: creature.name,
                                   attack: event[:name], location: location,
                                   body_part: part, rank: rank, secondary: true)
            respond "  +secondary wound: #{part} rank #{rank}" if Tracker.debug?
          end
        end

        # Applies the status effects a critical hit carries.
        #
        # Deliberately not gated behind :track_ucs. The crit *tables* only
        # populate roundtime/slowed/silenced/dazed for UCS attacks, but the
        # underlying states are general - silence from Silence (210) or a
        # silencing flare, slow from Slow (506), daze from various maneuvers.
        # Gating the state on the UCS flag would mean a non-UCS character sees
        # `silenced?` return false for a genuinely silenced creature, which is
        # worse than having no answer at all.
        #
        # Units differ inside one CritRanks hash: `stunned` is in ROUNDS,
        # `roundtime` is already in SECONDS.
        def apply_crit_statuses(creature, event)
          at = event[:at] || Time.now

          event[:crits].each do |crit|
            if crit[:stunned].to_i > 0
              # The boolean stays owned by <crtrStatus>/messaging; this records
              # the table-derived duration estimate beside it.
              creature.add_status('stunned')
              creature.add_stun_estimate(crit[:stunned], at: at)
              Observers.emit(:stun, id: creature.id, name: creature.name,
                                    attack: event[:name], rounds: crit[:stunned],
                                    seconds: crit[:stunned].to_i * CreatureInstance::STUN_ROUND_SECONDS)
            end

            # roundtime is in seconds already - do not scale it.
            if crit[:roundtime].to_i > 0
              creature.add_status('roundtime', crit[:roundtime].to_i)
              Observers.emit(:roundtime, id: creature.id, name: creature.name,
                                         attack: event[:name], seconds: crit[:roundtime].to_i)
            end

            # Position changes carry better provenance than the messaging
            # equivalents: /It is knocked to the ground!/ has no target
            # capture, while this crit is already bound to a creature id.
            if (pos = crit[:position])
              # Tables report "PRONE"/"KNEELING"/"SITTING"; the status
              # canon (messaging, <crtrStatus>, consumers) is lowercase.
              # add_status canonicalizes too, but the observer payload
              # must match what subscribers compare against.
              status = pos.to_s.downcase
              (POSITION_STATUSES - [status]).each { |s| creature.remove_status(s) }
              creature.add_status(status)
              Observers.emit(:status, id: creature.id, name: creature.name,
                                      status: status, action: :add)
            end

            %i[silenced slowed dazed sleeping crippled limb_favored].each do |flag|
              next unless crit[flag]

              creature.add_status(flag.to_s)
              Observers.emit(:status, id: creature.id, name: creature.name,
                                      status: flag.to_s, action: :add)
              respond "  +status: #{flag} (from crit)" if Tracker.debug?
            end
          end
        end

        # Apply UCS event to a creature
        def apply_ucs_to_target(ucs_result, current_target = nil)
          target_id = ucs_result[:target_id]

          # For tierup events, use current combat target if no ID in the event
          target_id ||= current_target[:id] if current_target && ucs_result[:type] == :tierup

          return unless target_id

          creature = Creature[target_id.to_i]
          return unless creature

          case ucs_result[:type]
          when :position
            creature.set_ucs_position(ucs_result[:value])
            respond "[Combat] Set UCS position #{ucs_result[:value]} on #{creature.name} (#{creature.id})" if Tracker.debug?

          when :tierup
            creature.set_ucs_tierup(ucs_result[:value])
            respond "[Combat] Set UCS tierup #{ucs_result[:value]} on #{creature.name} (#{creature.id})" if Tracker.debug?

          when :smite_on
            creature.smite!
            respond "[Combat] Applied smite to #{creature.name} (#{creature.id})" if Tracker.debug?

          when :smite_off
            creature.clear_smote
            respond "[Combat] Cleared smite from #{creature.name} (#{creature.id})" if Tracker.debug?
          end
          Observers.emit(:ucs, id: creature.id, name: creature.name,
                               kind: ucs_result[:type], value: ucs_result[:value])
        rescue => e
          respond "[Combat] Error applying UCS: #{e.message}" if Tracker.debug?
        end

        # Apply status effect directly to a creature (outside combat events)
        def apply_status_to_target(status, target_name_or_id, target_id = nil, action = :add)
          # Handle both name lookup and direct ID
          if target_id
            creature = Creature[target_id.to_i]
          else
            # Try to find creature by name - this is less reliable
            # but might work for some cases
            return unless defined?(Creature)
            creatures = Creature.all.select { |c| c.name&.downcase&.include?(target_name_or_id.downcase) }
            creature = creatures.first if creatures.size == 1
          end

          if creature
            if action == :remove
              # Position is one mutually-exclusive channel. The stand-up
              # messagings are shared between prone and sitting, and parse
              # returns the FIRST match (:prone, defined earlier) - so
              # removing only the reported status left 'sitting' (and
              # kneeling, which has no removal def at all) latched forever.
              # A creature that stood up is in no floor position, whichever
              # one the pattern happened to name.
              if POSITION_STATUSES.include?(status.to_s)
                POSITION_STATUSES.each { |s| creature.remove_status(s) }
              else
                creature.remove_status(status)
              end
              respond "[Combat] Removed status #{status} from #{creature.name} (#{creature.id})" if Tracker.debug?
            else
              # ...and adding one displaces the others: knocked prone while
              # sitting is prone, not both.
              if POSITION_STATUSES.include?(status.to_s)
                (POSITION_STATUSES - [status.to_s]).each { |s| creature.remove_status(s) }
              end
              creature.add_status(status)
              respond "[Combat] Applied status #{status} to #{creature.name} (#{creature.id})" if Tracker.debug?
            end
            Observers.emit(:status, id: creature.id, name: creature.name,
                                    status: status, action: action == :remove ? :remove : :add)
          else
            respond "[Combat] Could not find creature for status: #{status} -> #{target_name_or_id}" if Tracker.debug?
          end
        end

        # Map CritRanks location strings to creature body part constants
        def map_critranks_to_body_part(location)
          return nil unless location

          case location.to_s.downcase.gsub(/[^a-z]/, '')
          when 'leftarm', 'larm' then 'leftArm'
          when 'rightarm', 'rarm' then 'rightArm'
          when 'leftleg', 'lleg' then 'leftLeg'
          when 'rightleg', 'rleg' then 'rightLeg'
          when 'lefthand', 'lhand' then 'leftHand'
          when 'righthand', 'rhand' then 'rightHand'
          when 'leftfoot', 'lfoot' then 'leftFoot'
          when 'rightfoot', 'rfoot' then 'rightFoot'
          when 'lefteye', 'leye' then 'leftEye'
          when 'righteye', 'reye' then 'rightEye'
          when 'head' then 'head'
          when 'neck' then 'neck'
          when 'chest' then 'chest'
          when 'abdomen', 'abs' then 'abdomen'
          when 'back' then 'back'
          when 'nerves' then 'nerves'
          else
            # Try the location as-is in case it's already correct
            location.to_s if CreatureInstance::BODY_PARTS.include?(location.to_s)
          end
        end
      end
    end
  end
end
