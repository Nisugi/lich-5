# frozen_string_literal: true

#
# Combat Parser - Core parsing methods for combat events
# Performance-optimized with lazy loading and selective pattern matching
#

require_relative 'defs/attacks'
require_relative 'defs/damage'
require_relative 'defs/flares'
require_relative 'defs/outcomes'
require_relative 'defs/sequences'
require_relative 'defs/statuses'
require_relative 'defs/ucs'

module Lich
  module Gemstone
    module Combat
      module Parser
        # Target link pattern - extract creatures/players from XML
        TARGET_LINK_PATTERN = /<a exist="(?<id>[^"]+)" noun="(?<noun>[^"]+)">(?<name>[^<]+)<\/a>/i.freeze

        # Bold tag pattern - creatures are wrapped in bold tags
        # Non-greedy match to avoid spanning multiple creatures
        # Allow zero or more characters before <a> tag (e.g., "a creature" or just "creature")
        BOLD_WRAPPER_PATTERN = /<pushBold\/>([^<]*<a exist="[^"]+"[^>]+>[^<]+<\/a>)<popBold\/>/i.freeze

        # NOTE ON SCALE: each def family gates itself with a small literal
        # union (PatternGate). A single combined prefilter union was tried
        # and measured SLOWER (58us vs 35us/line on real logs) - Ruby's
        # regex engine scans large alternations linearly, so one big union
        # costs more than several small ones. When def counts grow into the
        # hundreds-per-family, the proven fix is a first-word bucket index
        # (see CritRanks - 2,389 patterns, indexed by first literal word),
        # not a bigger union.

        class << self
          # Parse attack initiation
          def parse_attack(line)
            return nil if Definitions::Attacks.rejects?(line)

            Definitions::Attacks::ATTACK_LOOKUP.each do |pattern, name|
              if (match = pattern.match(line))
                target_info = extract_target_from_match(match) || extract_target_from_line(line)
                return {
                  name: name,
                  target: target_info || {},
                  damaging: true
                }
              end
            end
            nil
          end

          # Parse damage amounts using damage definitions
          def parse_damage(line)
            result = Definitions::Damage.parse(line)
            result ? result[:damage] : nil
          end

          # Parse a flare announce line (weapon scripts, enchants, GEFs,
          # flourishes). Returns name/damaging/aoe/spawns plus the flaring
          # weapon's { id:, name: } when the line links it.
          def parse_flare(line)
            Definitions::Flares.parse(line)
          end

          # Why a swing produced nothing: :evade, :block, :parry, :warded,
          # :miss, :fumble, :hindrance, :confused
          def parse_outcome(line)
            Definitions::Outcomes.parse(line)
          end

          # Roll lines: AS/DS, CS/TD, UAF/UDF, SMR - returns the full
          # breakdown { type:, as:, ds:, avd:, roll:, result: ... }
          def parse_resolution(line)
            Definitions::Resolutions.parse(line)
          end

          # Multi-part action brackets (mstrike, flurry, spawned casts)
          def parse_sequence_start(line)
            Definitions::Sequences.parse_start(line)
          end

          def parse_sequence_end(line)
            Definitions::Sequences.parse_end(line)
          end

          # The weapon a swing line names, in plain text (swing lines do
          # not link the weapon):  "You swing a kelyn-edged slim short
          # sword at <pushBold/>..." - used to claim pre-flares by weapon.
          SWING_WEAPON_PATTERN = /You(?: take aim and)? (?:swing|fire) (?:an? |your |some )?(?<weapon>[^<]+?) at </.freeze

          def parse_swing_weapon(line)
            SWING_WEAPON_PATTERN.match(line)&.[](:weapon)
          end

          # Parse status effects (optional - performance setting)
          def parse_status(line)
            return nil unless Tracker.settings[:track_statuses]

            # Return the full result including action field
            Definitions::Statuses.parse(line)
          end

          # Parse UCS events (position, tierup, smite)
          def parse_ucs(line)
            return nil unless Tracker.settings[:track_ucs]

            Definitions::UCS.parse(line)
          end

          # Extract creature target (must be wrapped in bold tags)
          def extract_creature_target(line)
            # Cheap gate: the wrapper pattern can't match without the bold tag,
            # and the substring check avoids two regexes on most lines
            return nil unless line.include?('<pushBold/>')

            # Check if line contains a bolded link
            bold_match = BOLD_WRAPPER_PATTERN.match(line)
            return nil unless bold_match

            # Extract the link from within the bold tags
            link_text = bold_match[1]
            link_match = TARGET_LINK_PATTERN.match(link_text)
            return nil unless link_match

            id = link_match[:id].to_i
            return nil if id <= 0 # Skip invalid IDs

            {
              id: id,
              noun: link_match[:noun],
              name: link_match[:name]
            }
          end

          # Try to extract target from regex match first, then from line
          def extract_target_from_match(match)
            return nil unless match.names.include?('target')
            target_text = match[:target]
            return nil if target_text.nil? || target_text.strip.empty?

            # Look for creature in target text
            if (target_match = TARGET_LINK_PATTERN.match(target_text))
              id = target_match[:id].to_i
              return nil if id < 0

              return {
                id: id,
                noun: target_match[:noun],
                name: target_match[:name]
              }
            end

            nil
          end

          def extract_target_from_line(line)
            # ONLY accept bolded creatures as targets
            # Non-bolded links are equipment, objects, or other non-combatants
            extract_creature_target(line)
          end
        end
      end
    end
  end
end
