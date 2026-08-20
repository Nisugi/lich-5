# frozen_string_literal: true

#
# Flare Pattern Definitions
# Converted from ctparser/FLARE_DEFS to Lich::Gemstone::Combat namespace
#
# A flare is a proc that rides on an attack: weapon scripts, enchants,
# gloves, GEFs, flourishes. Each def carries:
#   damaging: whether a damage line is expected to follow (buff/utility
#             flares like acuity or tailwind never produce one)
#   aoe:      false when the flare is explicitly single-target even if
#             its parent attack is not
#   spawns:   the flare casts an imbedded spell as a SEPARATE attack
#             (e.g. Blink), so subsequent attack events in the same
#             chunk are its children rather than independent casts
#
# Timing is NOT declared here: whether a flare resolves before its swing
# (pre-flare, e.g. dispel gloves) or after (most flares) is determined
# positionally by the parser - a flare seen with no open attack event is
# held and claimed by the next swing. Position in the log is ground
# truth regardless of the flare's source.
#

require_relative 'pattern_gate'

module Lich
  module Gemstone
    module Combat
      module Definitions
        module Flares
          FlareDef = Struct.new(:name, :patterns, :damaging, :aoe, :spawns)

          FLARE_DEFS = [
            FlareDef.new(:acid, [
              /\*\* Your .+? releases? a spray of acid! \*\*/,
              /\*\* Your .+? releases? a spray of acid at (?<target>.+?)! \*\*/
            ].freeze, true, true, false),
            FlareDef.new(:acuity, [/Your .+? glows intensely with a verdant light!/].freeze, false, true, false),
            FlareDef.new(:air, [/\*\* Your .+? unleashes a blast of air! \*\*/].freeze, true, true, false),
            FlareDef.new(:air_flourish, [/\*\* A fierce whirlwind erupts around .+?, encircling (?<target>.+?) in a suffocating cyclone! \*\*/].freeze, true, true, false),
            FlareDef.new(:arcane_reflex, [/Vital energy infuses you, hastening your arcane reflexes!/].freeze, false, true, false),
            FlareDef.new(:blink, [/Your .+? suddenly lights up with hundreds of tiny blue sparks!/].freeze, true, false, true),
            FlareDef.new(:blessings_flourish, [
              /\*\* A crackling wave arcs across your body, striking (?<target>.+?) with lightning speed!  A spiritual resonance warms your core, lending you renewed strength! \*\*/,
              /\*\* Shimmering arcs of lightning stream from your hands, colliding with (?<target>.+?) in a rapid burst!  A stirring force ignites within you, augmenting your spirit! \*\*/,
              /\*\* Sparkling tendrils of energy weave around your limbs, shocking (?<target>.+?) in a bright flare!  The pulse leaves you feeling spiritually emboldened! \*\*/,
              /\*\* A faint hum courses through you as arcs of electricity coil around your arms, jolting (?<target>.+?) in a vivid burst!  The current resonates with your spirit, boosting your energy! \*\*/,
              /\*\* You feel a tingling surge channel through your arms, blasting (?<target>.+?) with crackling electricity!  A reassuring feeling of mental acuity settles over you! \*\*/,
              /\*\* Jagged sparks dance along your open palms, lashing out at (?<target>.+?) in a crackling surge!  Your resolve feels bolstered as the energy courses through you! \*\*/,
              /\*\* An electrified aura coalesces around you, crackling outward to shock (?<target>[^!]+)!  The charge resonates with your spirit, heightening your prowess! \*\*/,
              /\*\* Threads of charged light spiral around your arms, striking (?<target>.+?) with a pulsing shock!  A resonant force ripples through you, amplifying your spirit! \*\*/,
              /\*\* Sparks of crackling energy race along your fingertips, shocking (?<target>.+?) with a brilliant flash!  A surge of spiritual power rushes through your veins! \*\*/
            ].freeze, true, true, false),
            FlareDef.new(:breeze, [
              /(?<target>.+?) is buffeted by a burst of wind and pushed back!/,
              /(?<target>.+?) is buffeted by a sudden gust of wind!/,
              /A gust of wind shoves (?<target>.+?) back!/
            ].freeze, false, true, false),
            FlareDef.new(:briar, [/Vines of vicious briars whip out from your [^,]+, raking the \w+ with its thorns\.  The \w+ looks slightly ill as the glistening emerald coating from each briar works itself under its skin\./].freeze, true, true, false),
            FlareDef.new(:chameleon_shroud, [/A tenebrous shroud stitches itself into existence around you as you gracefully retreat into the shadows!/].freeze, false, true, false),
            FlareDef.new(:cold, [/Your .+? glows intensely with a cold blue light!/].freeze, true, true, false),
            FlareDef.new(:cold_gef, [/\*\* A vortex of razor-sharp ice gusts from .+? and coalesces around (?<target>[^!]+)! \*\*/].freeze, true, true, false),
            FlareDef.new(:concussive_blows, [/\*\* Your blow slams the (?<target>.+?) with concussive force! \*\*/].freeze, true, true, false),
            FlareDef.new(:disintegration, [/\*\* Your .+? releases a shimmering beam of disintegration! \*\*/].freeze, true, true, false),
            FlareDef.new(:dispel, [/\*\* Your .+? glows brightly for a moment, consuming the magical energies around (?<target>[^!]+)! \*\*/].freeze, true, false, false),
            FlareDef.new(:disruption, [/\*\* Your .+? releases a quivering wave of disruption! \*\*/].freeze, true, true, false),
            FlareDef.new(:earth_flourish, [/\*\* Chunks of earth violently orbit .+?, pelting (?<target>.+?) with heavy debris and stone! \*\*/].freeze, true, true, false),
            FlareDef.new(:earth_gef, [/\*\* A violent explosion of frenetic energy rumbles from .+? and pummels (?<target>[^!]+)! \*\*/].freeze, true, true, false),
            FlareDef.new(:energy, [%r{\*\* A beam of .+? energy emits from the tip of your .+? and collides with (?<target>.+?</a>) .+?! \*\*}].freeze, true, true, false),
            FlareDef.new(:ensorcell, [/\*\* Necrotic energy from your .+? overflows into you! \*\*/].freeze, false, true, false),
            FlareDef.new(:fire, [/\*\* Your .+? flares with a burst of flame! \*\*/].freeze, true, true, false),
            FlareDef.new(:fire_flourish, [/\*\* A blazing inferno erupts around .+?, engulfing (?<target>.+?) and scorching everything in its wake! \*\*/].freeze, true, true, false),
            FlareDef.new(:fire_gef, [/\*\* Burning orbs of pure flame burst from .+? and engulf (?<target>[^!]+)! \*\*/].freeze, true, true, false),
            FlareDef.new(:firewheel, [/\*\* Your .+? emits a fist-sized ball of lightning-suffused flames! \*\*/].freeze, true, true, false),
            FlareDef.new(:ghezyte, [/\*\* Cords of plasma-veined grey mist seep from your .+? and entangle (?<target>[^,]+), causing .+? to tremble violently! \*\*/].freeze, false, true, false),
            FlareDef.new(:grapple, [/\*\* Your .+? releases a twisted tendril of force! \*\*/].freeze, true, true, false),
            FlareDef.new(:guiding_light, [/\*\* Your .+? sprays with a burst of plasma energy! \*\*/].freeze, true, true, false),
            FlareDef.new(:holy_water, [/\*\* Your .+? sprays forth a shower of pure water! \*\*/].freeze, true, false, false),
            FlareDef.new(:hurl_boulder, [/You hurl a large boulder at (?<target>[^!]+)!/].freeze, true, false, false),
            FlareDef.new(:immolation, [/You bring a hand up to your lips and form a sign with your fingers as you whisper a quiet invocation for Immolation\.\.\./].freeze, true, false, false),
            FlareDef.new(:impact, [/\*\* Your .+? release a blast of vibrating energy at the (?<target>[^!]+)! \*\*/].freeze, true, true, false),
            FlareDef.new(:lightning, [/\*\* Your .+? emits a searing bolt of lightning! \*\*/].freeze, true, true, false),
            FlareDef.new(:lightning_gef, [/\*\* A vicious torrent of crackling lightning surges from .+? and strikes (?<target>[^!]+)! \*\*/].freeze, true, true, false),
            FlareDef.new(:magma, [/\*\* Your .+? expel a glob of molten magma at the (?<target>[^!]+)! \*\*/].freeze, true, true, false),
            FlareDef.new(:mana, [/You feel \d+ mana surge into you!/].freeze, false, true, false),
            FlareDef.new(:natures_decay, [
              /Soot brown specks of leaf mold trail in the wake of (?<target>.+?) movements, distorted by a murky haze\./,
              /The earthy, sweet aroma clinging to (?<target>.+?) grows more pervasive\./,
              /An earthy, sweet armoa clings to (?<target>.+?) in a murky haze\./,
              /An earthy, sweet aroma clings to (?<target>.+?) in a murky haze, accompanied by soot brown specks of leaf mold\./
            ].freeze, false, true, false),
            FlareDef.new(:necromancy_flourish, [/\*\* A sickly green aura radiates from .+? and seeps into (?<target>.+?) wounds! \*\*/].freeze, true, true, false),
            FlareDef.new(:parasite, [/A slender .+? and black tendril lashes out from .+? and slashes (?<target>.+?) .+?!/].freeze, true, true, false),
            FlareDef.new(:physical_prowess, [/The vitality of nature bestows you with a burst of strength!/].freeze, false, true, false),
            FlareDef.new(:plasma, [/\*\* Your .+? pulses with a burst of plasma energy! \*\*/].freeze, true, true, false),
            FlareDef.new(:psychic_assault, [/\*\* Your .+? unleashes a blast of psychic energy at the (?<target>[^!]+)! \*\*/].freeze, true, true, false),
            FlareDef.new(:religion_flourish, [/\*\* Divine flames kindle around .+?, leaping forth to engulf (?<target>.+?) in a sacred inferno! \*\*/].freeze, true, true, false),
            FlareDef.new(:rusalkan, [/Succumbing to the force of the tidal wave, (?<target>.+?) is thrown to the ground\./].freeze, false, true, false),
            FlareDef.new(:sigil_dispel, [/\*\* Tendrils of .+? lash out from your .+? toward (?<target>.+?) and cage .+? within bands of concentric geometry that constrict as one, shattering upon impact! \*\*/].freeze, true, false, false),
            FlareDef.new(:sigil_cast, [/\*\* Numerous sigils along your .+? abruptly flare to brilliance!  .+? surges from each, twining into an echo of your last spell\.\.\. \*\*/].freeze, true, false, true),
            FlareDef.new(:slashing_strikes, [%r{\*\* Your .+? finds its mark, slicing deep into (?<target>.+?)<popBold/> (?<location>.+?)! \*\*}].freeze, true, true, false),
            FlareDef.new(:somnis, [/\*\* For a split second, the striations of your .+? expand into a sinuous pearlescent mist that rushes towards the (?<target>[^,]+), enveloping .+? entirely and causing .+? to collapse, fast asleep! \*\*/].freeze, false, true, false),
            FlareDef.new(:sprite, [%r{\*\* The .+? sprite on your shoulder sends forth a cylindrical, .+? blast of magic at (?<target>.+?</a>) .+?! \*\*}].freeze, true, true, false),
            FlareDef.new(:steam, [
              /\*\* Your .+? erupts with a plume of steam! \*\*/,
              /\*\* Your .+? erupt with a plume of steam at the (?<target>[^!]+)! \*\*/
            ].freeze, true, true, false),
            FlareDef.new(:summoning_flourish, [/\*\* A radiant mist surrounds .+?, unfurling into a whip of plasma that wreathes (?<target>.+?) in its sizzling embrace! \*\*/].freeze, true, true, false),
            FlareDef.new(:tailwind, [
              /A favorable tailwind springs up behind you\./,
              /You shift position, taking advantage of a favorable tailwind\./,
              /The wind turns in your favor\./
            ].freeze, false, true, false),
            FlareDef.new(:telepathy_flourish, [/\*\* Rippling and half-seen, strands of psychic power unravel from .+? to strike at (?<target>.+?)! \*\*/].freeze, true, true, false),
            FlareDef.new(:terror, [/\*\* A wave of wicked power surges forth from your .+? and fills (?<target>.+?) with terror, .+? form trembling with unmitigated fear! \*\*/].freeze, false, true, false),
            FlareDef.new(:unbalance, [/\*\* Your .+? unleashes an invisible burst of force! \*\*/].freeze, true, true, false),
            FlareDef.new(:vacuum, [/\*\* As you hit, the edge of your .+? seems to fold inward upon itself drawing everything it touches along with it! \*\*/].freeze, true, true, false),
            FlareDef.new(:valence, [/\*\* A coil of spectral .+? energy bursts out of thin air and strikes (?<target>[^!]+)! \*\*/].freeze, true, true, false),
            FlareDef.new(:wall_of_thorns, [/One of the vines surrounding you lashes out at the (?<target>[^,]+), scraping a thorn across .+? body!  .+? flinches slightly./].freeze, false, true, false),
            FlareDef.new(:water, [/\*\* Your .+? shoot a blast of water! \*\*/].freeze, true, true, false),
            FlareDef.new(:water_flourish, [/\*\* A watery deluge erupts violently around .+?, crushing (?<target>.+?) with relentless force! \*\*/].freeze, true, true, false)
          ].freeze

          # [pattern, name, damaging, aoe, spawns] rows, one per pattern
          FLARE_LOOKUP = FLARE_DEFS.flat_map { |d|
            d.patterns.map { |rx| [rx, d.name, d.damaging, d.aoe, d.spawns] }
          }.freeze

          GATE, ALWAYS_SCAN = PatternGate.build(FLARE_LOOKUP.map(&:first))

          # Flare announce lines name the flaring weapon as a link:
          #   Your <a exist="393573117" noun="sword">slim short sword</a> ...
          # The exist id is the join key for claiming pre-flares by weapon.
          WEAPON_LINK = %r{Your <a exist="(?<id>\d+)" noun="[^"]+">(?<name>[^<]+)</a>}.freeze

          # Parse a flare announce line.
          #
          # @return [Hash, nil] { name:, damaging:, aoe:, spawns:, target:, weapon: }
          #   target is the named capture when the pattern has one (may be nil);
          #   weapon is { id:, name: } when the line links the flaring weapon.
          def self.parse(line)
            return nil unless GATE.match?(line) || ALWAYS_SCAN.any? { |rx| rx.match?(line) }

            FLARE_LOOKUP.each do |pattern, name, damaging, aoe, spawns|
              next unless (match = pattern.match(line))

              result = { name: name, damaging: damaging, aoe: aoe, spawns: spawns }
              result[:target] = match[:target] if match.names.include?('target') && match[:target]
              if (weapon = WEAPON_LINK.match(line))
                result[:weapon] = { id: weapon[:id].to_i, name: weapon[:name] }
              end
              return result
            end
            nil
          end
        end
      end
    end
  end
end
