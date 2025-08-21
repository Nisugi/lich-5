# frozen_string_literal: true

#
# Flare Pattern Definitions
# Weapon and spell flares - converted from ctparser/FlareDefs.rb
#

module Lich
  module Gemstone
    module Combat
      module Definitions
        module Flares
          FlareDef = Struct.new(:name, :damaging, :outcome, :aoe, :patterns)

          # Elemental weapon flares - most common
          ELEMENTAL_FLARES = [
            FlareDef.new(:fire, true, :damage, false, [
              /\*\* Your .+? flares with a burst of flame! \*\*/
            ].freeze),
            FlareDef.new(:cold, true, :damage, false, [
              /Your .+? glows intensely with a cold blue light!/
            ].freeze),
            FlareDef.new(:lightning, true, :damage, false, [
              /\*\* Your .+? emits a searing bolt of lightning! \*\*/
            ].freeze),
            FlareDef.new(:acid, true, :damage, false, [
              /\*\* Your .+? releases? a spray of acid! \*\*/,
              /\*\* Your .+? releases? a spray of acid at .+? \*\*/
            ].freeze),
            FlareDef.new(:air, true, :damage, false, [
              /\*\* Your .+? unleashes a blast of air! \*\*/
            ].freeze)
          ].freeze

          # Magical enhancement flares
          ENHANCEMENT_FLARES = [
            FlareDef.new(:acuity, false, :buff, false, [
              /Your .+? glows intensely with a verdant light!/
            ].freeze),
            FlareDef.new(:arcane_reflex, false, :buff, false, [
              /Vital energy infuses you, hastening your arcane reflexes!/
            ].freeze),
            FlareDef.new(:physical_prowess, false, :buff, false, [
              /The vitality of nature bestows you with a burst of strength!/
            ].freeze)
          ].freeze

          # Disruptive flares
          DISRUPTIVE_FLARES = [
            FlareDef.new(:disruption, true, :damage, false, [
              /\*\* Your .+? releases a quivering wave of disruption! \*\*/
            ].freeze),
            FlareDef.new(:unbalance, true, :damage, false, [
              /\*\* Your .+? unleashes an invisible burst of force! \*\*/
            ].freeze),
            FlareDef.new(:terror, false, :status, false, [
              /\*\* A wave of wicked power surges forth from your .+? and fills (?<target>.+?) with terror, .+? form trembling with unmitigated fear! \*\*/
            ].freeze)
          ].freeze

          # Special effect flares (performance impact - disabled by default)
          SPECIAL_FLARES = [
            FlareDef.new(:blink, true, :blink, false, [
              /Your .+? suddenly lights up with hundreds of tiny blue sparks!/
            ].freeze),
            FlareDef.new(:vacuum, true, :damage, false, [
              /\*\* As you hit, the edge of your .+? seems to fold inward upon itself drawing everything it touches along with it! \*\*/
            ].freeze),
            FlareDef.new(:sigil_dispel, true, :dispel, false, [
              /\*\* Tendrils of .+? lash out from your .+? toward (?<target>.+?) and cage .+? within bands of concentric geometry that constrict as one, shattering upon impact! \*\*/
            ].freeze)
          ].freeze

          # Return different sets based on settings
          def self.basic_flares
            ELEMENTAL_FLARES + ENHANCEMENT_FLARES
          end

          def self.all_flares
            ELEMENTAL_FLARES + ENHANCEMENT_FLARES + DISRUPTIVE_FLARES + SPECIAL_FLARES
          end

          # Create lookup tables for performance
          def self.create_lookup(flare_set = basic_flares)
            flare_set.flat_map do |flare_def|
              flare_def.patterns.compact.map do |pattern|
                [pattern, flare_def.name, flare_def.damaging, flare_def.aoe]
              end
            end.freeze
          end

          def self.create_detector(flare_set = basic_flares)
            Regexp.union(flare_set.flat_map(&:patterns).compact).freeze
          end
        end
      end
    end
  end
end
