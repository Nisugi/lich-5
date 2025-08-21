# frozen_string_literal: true

#
# Status Effect Pattern Definitions
# Combat status effects like stun, prone, blind, etc.
#

module Lich
  module Gemstone
    module Combat
      module Definitions
        module Statuses
          StatusDef = Struct.new(:name, :add_patterns, :remove_patterns)

          # Core status effects with both add and remove patterns
          STATUS_EFFECTS = [
            StatusDef.new(:blind, 
              [/You blinded (?<target>[^!]+)!/].freeze,
              [
                /(?<target>.+?) regains .+? sight\./,
                /(?<target>.+?) can see again\./,
                /(?<target>.+?) blinks .+? eyes rapidly\./
              ].freeze
            ),
            StatusDef.new(:immobilized, 
              [/(?<target>.+?) form is entangled in an unseen force that restricts .+? movement\./].freeze,
              [
                /(?<target>.+?) breaks free from the entangling force\./,
                /(?<target>.+?) is no longer immobilized\./,
                /The moonbeam fades away\./
              ].freeze
            ),
            StatusDef.new(:prone, 
              [
                /It is knocked to the ground!/,
                /(?<target>.+?) is knocked to the ground!/,
                /(?<target>.+?) falls to the ground!/
              ].freeze,
              [
                /(?<target>.+?) stands back up\./,
                /(?<target>.+?) gets back to .+? feet\./,
                /(?<target>.+?) rises to .+? feet\./,
                /(?<target>.+?) stands up\./
              ].freeze
            ),
            StatusDef.new(:stunned, 
              [/The (?<target>.+?) is stunned!/].freeze,
              [
                /(?<target>.+?) shakes off the stun effect\./,
                /(?<target>.+?) regains .+? composure\./,
                /(?<target>.+?) is no longer stunned\./
              ].freeze
            ),
            StatusDef.new(:sunburst, 
              [/(?<target>.+?) reels and stumbles under the intense flare!/].freeze,
              [
                /(?<target>.+?) recovers from the intense flare\./,
                /(?<target>.+?) shakes off the blinding light\./
              ].freeze
            ),
            StatusDef.new(:webbed, 
              [/(?<target>.+?) becomes ensnared in thick strands of webbing!/].freeze,
              [
                /(?<target>.+?) breaks free of the webs\./,
                /(?<target>.+?) struggles free of the webs\./,
                /(?<target>.+?) tears through the webbing\./
              ].freeze
            ),
            StatusDef.new(:sleeping, 
              [
                /(?<target>.+?) falls into a deep slumber\./,
                /(?<target>.+?) falls asleep\./
              ].freeze,
              [
                /(?<target>.+?) wakes up\./,
                /(?<target>.+?) awakens\./,
                /(?<target>.+?) opens .+? eyes\./
              ].freeze
            ),
            StatusDef.new(:poisoned, 
              [/(?<target>.+?) appears to be suffering from a poison\./].freeze,
              [
                /(?<target>.+?) looks much better\./,
                /(?<target>.+?) recovers from the poison\./
              ].freeze
            )
          ].freeze

          # Create lookup tables for fast pattern matching
          ADD_LOOKUP = STATUS_EFFECTS.flat_map do |status_def|
            status_def.add_patterns.compact.map { |pattern| [pattern, status_def.name, :add] }
          end.freeze

          REMOVE_LOOKUP = STATUS_EFFECTS.flat_map do |status_def|
            status_def.remove_patterns.compact.map { |pattern| [pattern, status_def.name, :remove] }
          end.freeze

          ALL_LOOKUP = (ADD_LOOKUP + REMOVE_LOOKUP).freeze

          # Compiled regex for fast detection
          STATUS_DETECTOR = Regexp.union(ALL_LOOKUP.map(&:first)).freeze

          # Parse status effect from line
          def self.parse(line)
            ALL_LOOKUP.each do |pattern, name, action|
              if (match = pattern.match(line))
                result = { 
                  status: name, 
                  action: action  # :add or :remove
                }
                result[:target] = match[:target] if match.names.include?('target') && match[:target]
                return result
              end
            end
            nil
          end
        end
      end
    end
  end
end
