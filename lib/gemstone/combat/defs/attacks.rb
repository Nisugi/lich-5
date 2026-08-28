# frozen_string_literal: true

#
# Attack Pattern Definitions
# Converted from ctparser/AttackDefs.rb to Lich::Gemstone::Combat namespace
#

require_relative 'pattern_gate'

module Lich
  module Gemstone
    module Combat
      module Definitions
        module Attacks
          AttackDef = Struct.new(:name, :patterns)

          # Ordered BEFORE the generic swing defs: these lines end in
          # "and connect(s)!" (or aim at "your <item>") and the plain
          # "swings ... at ...!" patterns would swallow them with the tail
          # folded into the target capture.
          PRIORITY_ATTACKS = [
            AttackDef.new(:sunder_shield, [/You swing your .+? at (?<target>.+?)'s#{MK_POST} .+? and connect!/].freeze),
            AttackDef.new(:disarm_weapon, [
              /Choosing your opening, you attempt to disarm (?<target>.+?)'s#{MK_POST} (?<weapon>.+?) with your .+? and connects?!/,
              /(?<attacker>.+?) swings (?<weapon>.+?) at your .+? and connects!/
            ].freeze),
            AttackDef.new(:tackle, [/You hurl yourself at (?<target>.+?) and connect!/].freeze)
          ].freeze

          # Core attack patterns - most common combat actions
          BASIC_ATTACKS = [
            AttackDef.new(:attack, [
              /You(?<aimed> take aim and)? swing .+? at (?<target>[^!]+)!/,
              /You(?<aimed> take aim and)? (?:punch|jab|kick|grapple) with (?<weapon>.+?) at (?<target>[^!]+)!/
            ].freeze),
            AttackDef.new(:fire, [/You(?<aimed> take aim and)? fire .+? at (?<target>[^!]+)!/].freeze),
            AttackDef.new(:hurl, [/You(?<aimed> take aim and)? throw (?<weapon>.+?) at (?<target>[^!]+)!/].freeze),
            AttackDef.new(:grapple, [/You(?<aimed> make a precise)? attempt to grapple (?<target>[^!]+)!/].freeze),
            AttackDef.new(:jab, [/You(?<aimed> make a precise)? attempt to jab (?<target>[^!]+)!/].freeze),
            AttackDef.new(:kick, [/You(?<aimed> make a precise)? attempt to kick (?<target>[^!]+)!/].freeze),
            AttackDef.new(:punch, [/You(?<aimed> make a precise)? attempt to punch (?<target>[^!]+)!/].freeze),
            AttackDef.new(:wand, [/You wave your .+ at (?<target>[^\.]+)\./].freeze)
          ].freeze

          # Spell-based attacks
          SPELL_ATTACKS = [
            AttackDef.new(:balefire, [/You hurl a ball of greenish-black flame at (?<target>[^!]+)!/].freeze),
            # 302 Bane, living-target version (the undead version has
            # different messaging - not yet catalogued)
            AttackDef.new(:bane, [/A sickly, violet haze encompasses (?<target>.+?)\./].freeze),
            AttackDef.new(:blood_burst, [/Blood sprays from (?<target>.+?) neck in a crimson arc!/].freeze),
            AttackDef.new(:cold_snap, [/An airy mist rolls into the area, carrying a harsh chill with it./].freeze),
            AttackDef.new(:ethereal_censer, [/(?<target>.+?) becomes enveloped in the incense smoke!/].freeze),
            AttackDef.new(:divine_wrath, [
              /A shadowy figure briefly materializes behind (?<target>[^,]+), and a silent scream courses over .+? visage./,
              /Within the reddish haze, the man brings his forging-hammer sharply down upon the anvil, producing a loud clang\./
            ].freeze),
            AttackDef.new(:earthen_fury, [
              /Fiery debris explodes from the ground beneath (?<target>[^!]+)!/,
              /Craggy debris explodes from the ground beneath (?<target>[^!]+)!/,
              /The earth cracks beneath (?<target>[^,]+), releasing a column of frigid air!/,
              /Icy stalagmites burst from the ground beneath (?<target>[^!]+)!/
            ].freeze),
            AttackDef.new(:ewave, [/(?:An?|Some) (?<target>.+?) is buffeted by the (?:\w+ ethereal waves|formless black (?:waves|sphere))(?: and is knocked to the ground)?\./].freeze),
            AttackDef.new(:natures_fury, [/The surroundings advance upon (?<target>.+?) with relentless fury!/].freeze),
            AttackDef.new(:searing_light, [/The radiant burst of light engulfs (?<target>[^!]+)!/].freeze),
            AttackDef.new(:spikethorn, [/Dozens of long thorns suddenly grow out from the ground underneath (?<target>[^!]+)!/].freeze),
            AttackDef.new(:stone_fist, [/The (?:ground|floor) beneath (?<target>you|.+?) rumbles, then erupts in a shower of rubble that coalesces in to an? (?:enormous|large),? ?.*?hand(?: with .+? fingers)? in mid-air\./].freeze),
            AttackDef.new(:sunburst, [/The dazzling solar blaze flashes before (?<target>[^!]+)!/].freeze),
            AttackDef.new(:tangleweed, [
              /The (?<weed>.+?) lashes out violently at (?<target>[^,]+), dragging .+? to the (?:ground|floor)!/,
              /The (?<weed>.+?) lashes out at (?<target>[^,]+), wraps itself around .+? body and entangles .+? on the ground\./
            ].freeze),
            AttackDef.new(:tonis_bolt, [/You unleash a bolt of churning air at (?<target>[^!]+)!/].freeze),
            AttackDef.new(:unbalance, [/Bands of spectral mist ripple and surge beneath (?<target>[^!]+)!/].freeze),
            AttackDef.new(:web, [/Cloudy wisps swirl about (?<target>.+?)\./].freeze),
          ].freeze

          # Spell initiations catalogued from the wiki Messaging sections
          # (docs/COMBAT_DEFS_WIKI_CATALOG.md). Ordered AFTER SPELL_ATTACKS
          # so per-spell defs above (balefire, tonis_bolt) keep their names;
          # the generic 2p bolt def is LAST in this group for the same reason.
          WIKI_SPELL_ATTACKS = [
            AttackDef.new(:astral_spear, [/You project a thin spear of nacreous light at (?<target>[^!]+)!/].freeze),
            # 1106 Bone Shatter; the same "concentrate intently" wording is
            # used by energy runestave channels
            AttackDef.new(:bone_shatter, [
              /You concentrate intently on (?<target>[^,]+), and a pulse of .+? energy ripples toward #{MK_PRE}(?:it|him|her)#{MK_POST}!/,
              # 3p: a creature casts it at us (gigas skald, round-5 corpus)
              /(?<attacker>.+?) concentrates intently on (?<target>you|[^,]+), and a pulse of .+? energy ripples toward #{MK_PRE}(?:you|it|him|her)#{MK_POST}!/
            ].freeze),
            AttackDef.new(:curse, [
              /A thread of .+? magic issues forth from your hand toward (?<target>[^.]+)\./,
              /Holding (?<target>.+?) in your gaze, you utter a foul curse upon #{MK_PRE}(?:him|her|it)#{MK_POST}\./
            ].freeze),
            # 317 Divine Fury. Whole line - it began mid-sentence at "you
            # release ...". ground/floor varies by room.
            AttackDef.new(:divine_fury, [/Particles of dust and soot rise from the (?:ground|floor) at your feet as you release a pulsating, platinum ripple of energy toward (?<target>[^!]+)!/].freeze),
            # 717 Evil Eye cast line (per-target per-round; round-5)
            AttackDef.new(:evil_eye, [/You turn to stare at (?<target>[^.]+)\./].freeze),
            # Excalibur-style weapon spell surge: opens its own CS/TD (the
            # patron-aura flavor rides between); the actual swing opens
            # separately after. The fizzle form is a prefix - no def.
            AttackDef.new(:weapon_cast, [/As you attempt to strike with your (?<weapon>.+?), it sends a surge of power through you that quickly leaps out at (?:the )?(?<target>[^!]+)!/].freeze),
            AttackDef.new(:elemental_strike, [/A vortex of elemental energy suddenly strikes (?<target>[^!]+)!/].freeze),
            AttackDef.new(:fervent_reproach, [/With a quick flick of your wrists, the orbs dance through the air toward (?<target>[^!]+)!/].freeze),
            AttackDef.new(:force_projection, [/A translucent force moves outward from you and toward (?<target>[^.]+)\./].freeze),
            # 1630 Judgment. The summon is deity-specific and so is its strike
            # line - 35 catalogued forms (wiki Judgment_(1630) messaging).
            # Written whole rather than as an "ethereal .+?, striking X!"
            # fragment: four of them name no ethereal object at all (the
            # shadows, the claws, the silver arm, the two-headed serpent), so
            # the fragment MISSED those while matching any unrelated line
            # that happened to contain both words.
            AttackDef.new(:judgment, [
              /A chain of lightning erupts from the tip of the ethereal trident, striking (?<target>[^!]+)!/,
              /A strum of crimson notes float out from the strings of the ethereal lute, striking (?<target>[^!]+)!/,
              /A shockwave of golden energy ripples out from the head of the ethereal forging hammer, striking (?<target>[^!]+)!/,
              /A swarm of translucent bees spiral from the petals of the ethereal blossom, striking (?<target>[^!]+)!/,
              /A veil of grey vapor spews forth from the interior of the ethereal crystal ball, striking (?<target>[^!]+)!/,
              /A flare of silver energy blasts from the fist of the silver arm, striking (?<target>[^!]+)!/,
              /A blast of white energy bursts from the tip of the ethereal sceptre, striking (?<target>[^!]+)!/,
              /A flurry of golden snowflake-shaped motes unwind from the chain of the ethereal keys, striking (?<target>[^!]+)!/,
              /An arc of multihued light leaps from the parchment of the ethereal scroll, striking (?<target>[^!]+)!/,
              /A cloud of flame-hued petals drifts from the edge of the heart-shaped chakram, striking (?<target>[^!]+)!/,
              /A ray of brilliant sunlight gleams from the edge of the ethereal chakram, striking (?<target>[^!]+)!/,
              /A plume of silver starlit flames stream from the edge of (?:your|the) ethereal sword, striking (?<target>[^!]+)!/,
              /A volley of black shards gleam from the tip of the claws, striking (?<target>[^!]+)!/,
              /A curl of black flames unravel from the tip of the ethereal sceptre, striking (?<target>[^!]+)!/,
              /A flurry of parchment flies out from the inside of the ethereal tome, striking (?<target>[^!]+)!/,
              /A length of a green tentacle bursts out from the tendrils of mist, striking (?<target>[^!]+)!/,
              /A cloud of noxious black-green gas emits from the center of the ethereal pentacle, striking (?<target>[^!]+)!/,
              /A flurry of sanguine slivers fly from the edge of the ethereal whip, striking (?<target>[^!]+)!/,
              /A black jackal-shaped visage leaps from the shadows, striking (?<target>[^!]+)!/,
              /A barrage of purple essence flings from the surface of the ethereal shield, striking (?<target>[^!]+)!/,
              /A barrage of viridian essence sprays from the blade of the ethereal falarica, striking (?<target>[^!]+)!/,
              /A blast of multihued plasma flares out from the center of the ethereal sphere, striking (?<target>[^!]+)!/,
              /A chain of blazing fire whips out from the surface of the ethereal shield, striking (?<target>[^!]+)!/,
              /A gust of shimmering air blows from the edge of the ethereal feathered armband, striking (?<target>[^!]+)!/,
              /A number of green vines lash out from the center of the ethereal lily-shaped talisman, striking (?<target>[^!]+)!/,
              /A shaft of dark essence blazes from the center of the ethereal hourglass, striking (?<target>[^!]+)!/,
              /A simple beam of white energy flares out from the tip of the ethereal stiletto, striking (?<target>[^!]+)!/,
              /A spiral of multi-hued essence streams out from the edge of the ethereal boomerang, striking (?<target>[^!]+)!/,
              /A streak of ivory energy flares out from the blade of the ethereal dagger, striking (?<target>[^!]+)!/,
              /A succession of crimson energy is emitted from the two-headed serpent, striking (?<target>[^!]+)!/,
              /A surge of white fire blazes from the center of the ethereal shield, striking (?<target>[^!]+)!/,
              /A sweep of silver essence slashes out from the blade of the ethereal scythe, striking (?<target>[^!]+)!/,
              /A torrent of incarnadine essence streams out from the blade of the ethereal scimitar, striking (?<target>[^!]+)!/,
              /A trill of delicate, yellow notes drifts out from the end of the ethereal flute, striking (?<target>[^!]+)!/,
              /A wave of grey vibrations washes out from the inside of the ethereal conch shell, striking (?<target>[^!]+)!/,
              /An arc of silver-grey tendrils spiral out from the blade of the ethereal sickle, striking (?<target>[^!]+)!/
            ].freeze),
            AttackDef.new(:kais_smite, [/You attempt to smite (?<target>[^!]+)!/].freeze),
            # 708 Limb Disruption. Full line, with the leading article and the
            # possessive: a bare "<x> right leg explodes!" fragment also
            # matched OUR OWN limb ("Your right leg explodes!") and opened an
            # attack event against us.
            AttackDef.new(:limb_disruption, [/The (?<target>.+?)'s#{MK_POST} (?:right|left) (?:leg|arm|hand|eye) explodes!/].freeze),
            AttackDef.new(:moonbeam, [/You level a nebulous beam of shadowy luminescence at (?<target>[^!]+)!/].freeze),
            AttackDef.new(:pestilence, [
              /You exhale a virulent green mist toward (?<target>[^,]+), instantly infecting/,
              # 3p: a group member casts it. Without this the per-target
              # damage that follows had no event and was dropped - or worse,
              # was claimed by whatever event happened to still be open
              # (real-feed replay, GSIV-Nisugi 2026-01-01: Zoleta's 18 and 25
              # landed on the creature we were fighting).
              /(?<attacker>.+?) exhales a virulent green mist toward (?<target>[^,]+), instantly infecting/,
              # Per-round TICK forms. Pestilence keeps damaging its victim for
              # rounds after the cast, and each tick line carries BOTH its own
              # damage and the target - but with no def they had no event, so
              # the tick damage was dropped outright while the swing that
              # followed in the same chunk persisted normally (real-feed
              # replay: 59 and 44 lost against a tattooed gigas berserker).
              # Wiki Pestilence_(716) messaging plus the mist form from live
              # logs, which the wiki does not list.
              /(?<target>.+?) howls in pain as virulent green mist passes through #{MK_PRE}(?:his|her|its)#{MK_POST} form causing \d+ points of damage!/,
              /Boils rupture all over (?<target>.+?) causing \d+ points of damage!/,
              /Pustules break out all over (?<target>.+?) causing \d+ points of damage!/,
              /Pus-filled sores erupt on (?<target>.+?) causing \d+ points of damage!/,
              /(?<target>.+?) wails as painful boils form and erupt causing \d+ points of damage!/,
              /(?<target>.+?)'s#{MK_POST} skin hardens into a black rot and begins to crumble causing \d+ points of damage!/,
              /(?<target>.+?)'s#{MK_POST} skin necrotizes and falls away as an indiscernible mass causing \d+ points of damage!/,
              /(?<target>.+?) begins hemorrhaging from multiple orifices causing \d+ points of damage!/,
              /The sickly green miasma around (?<target>.+?) flares causing \d+ points of damage!/
            ].freeze),
            # 302 Smite, undead counterpart of the :bane living-target haze
            AttackDef.new(:smite_undead, [/A scintillating, blue-white aura encompasses (?<target>[^.]+)\./].freeze),
            AttackDef.new(:song_of_rage, [/A dull keening quickly crescendos into a singular shrill note focused directly at (?<target>[^.]+)\./].freeze),
            AttackDef.new(:stunning_shout, [/(?<target>.+?) is struck violently by the tightly focused sonic energy of your cacophonous shout!/].freeze),
            # shared cast line of targeted bard attack songs (1008, 1016...)
            AttackDef.new(:spellsong, [/You weave another verse into your harmony, directing the sound of your voice at (?<target>[^.]+)\./].freeze),
            AttackDef.new(:sunburst, [/A sudden burst of bright light emanates from your hand toward (?<target>[^!]+)!/].freeze),
            AttackDef.new(:templars_verdict, [/A column of violet flame envelops (?<target>.+?) in its searing embrace!/].freeze),
            AttackDef.new(:thought_lash, [/A crackling whip of energy lashes out at (?:the )?(?<target>[^!]+)!/].freeze),
            AttackDef.new(:web_bolt, [/You shoot strands of webbing at (?<target>[^!]+)!/].freeze),
            AttackDef.new(:wither, [/A nebulous haze shimmers into view around (?<target>[^,.]+)/].freeze),
            # generic 2p cast - "You gesture at X." opens warding spells the
            # same way the 3p "gestures at" does (logs/examples/moonbeam.txt,
            # wild_entropy.txt); second-to-LAST so specific spells name
            # themselves first
            AttackDef.new(:cast, [/You gesture at (?<target>[^.!]+)[.!]/].freeze),
            # generic 2p bolt - the standard initiation for the whole bolt
            # family (901/904/906/910/1707/1709/1710...); LAST so specific
            # bolt spells above name themselves first
            AttackDef.new(:bolt, [
              /You hurl (?:a|an|some) (?<bolt>.+?) at (?<target>[^!]+)!/,
              /You unleash a compact swirling vortex at (?<target>[^!]+)!/
            ].freeze)
          ].freeze

          # Ranged maneuvers (observed live on the forge test-server runs)
          RANGED_ATTACKS = [
            AttackDef.new(:barrage, [/Nocking another arrow to your bowstring, you swiftly draw back and loose again!/].freeze),
            # suppressing hail: non-damaging AoE, per-target SMR + root follow
            AttackDef.new(:pindown, [/Without bothering to aim, you loose a chaotic hail of arrows to pin down your foes!/].freeze),
            # Volley (multi-round AoE): the bow-raise line is the SEQUENCE
            # prefix, not an attack - see Sequences :volley. It prints once
            # per volley while the hail-shadow line that opens the sequence
            # prints once per ROUND (logs/examples/weapon_volley.txt: 4 bow
            # lines, 16 shadow lines). These per-arrow lines are the real
            # attack defs - each one names the target it struck.
            AttackDef.new(:volley, [
              /An arrow finds its mark!  (?<target>.+?) is hit!/,
              /An arrow pierces (?<target>[^!]+)!/,
              /An arrow skewers (?<target>[^!]+)!/,
              /(?<target>.+?) is struck by a falling arrow!/,
              /(?<target>.+?) is transfixed by an arrow's descent!/
            ].freeze)
          ].freeze

          # Weapon maneuvers
          WEAPON_ATTACKS = [
            AttackDef.new(:cripple, [
              # the sidle connect line ("You sidle in close and drag the
              # blade...") sits between the SMR and the damage - a hit line,
              # NEVER a def (it double-opened the event once markup-tolerant)
              /You reverse your grip on your .+? and dart toward (?<target>.+?) at an angle!/
            ].freeze),
            AttackDef.new(:flurry, [
              # blades? - single-weapon flurry uses the singular
              /Flowing with deadly grace, you smoothly reverse the direction of your blades? and slash again!/,
              /With fluid motion, you guide your flashing blades?, slicing toward (?<target>.+?) at the apex of (?:their|its) deadly arc!/,
              # dual-wield opener (logs/examples/weapon_flurry.txt)
              /You rotate your wrists, your .+? executing a casual spin to establish your flow as you advance upon (?<target>[^!]+)!/
            ].freeze),
            # Pummel (THB): menacing-step opener -> SMR -> the pummel line,
            # then per-hit AS rolls (logs/examples/weapon_pummel.txt)
            AttackDef.new(:pummel, [
              /You take a menacing step toward (?<target>.+?), sweeping your .+? out low to your side in your advance\./,
              /With deliberate brutality, you bring your .+? around to pummel (?<target>[^!]+)!/
            ].freeze),
            # Pulverize (THB AoE): untargeted opener; per-target rolls follow
            AttackDef.new(:pulverize, [/You wheel your .+? overhead before slamming it around in a wide arc to pulverize your foes!/].freeze),
            AttackDef.new(:dizzying_swing, [/You heft your .+? and, looping it once to build momentum, lash out in a strike at (?<target>.+?)'s#{MK_POST} head!/].freeze),
            # Guardant Thrusts (polearm): guard opener, then a lunge per
            # thrust (keep BEFORE :clash - clash's bare "You lunge at X!"
            # is comma-fenced away from this line's continuation)
            AttackDef.new(:guardant_thrust, [
              /Retaining a defensive profile, you raise your .+? in a hanging guard and prepare to unleash a barrage of guardant thrusts upon (?<target>[^!]+)!/,
              /You lunge at (?<target>.+?), guiding your .+? with both hands in a powerful thrust!/
            ].freeze),
            # Cyclone (polearm AoE): spin-up opener, three per-target forms
            AttackDef.new(:cyclone, [
              /You weave your .+? in a two-handed under arm spin, swiftly picking up speed until it becomes a blurred cyclone of [^!]+!/,
              /You whirl on (?<target>[^!]+)!/,
              /You redirect your .+? toward (?<target>[^!]+)!/,
              /Pivoting sharply, you lunge at (?<target>[^!]+)!/
            ].freeze),
            # Clash (multi-opponent brawl): untargeted opener, per-target
            # engagement lines. The lunge form is comma-fenced so guardant
            # thrust's "You lunge at X, guiding..." never files here.
            AttackDef.new(:clash, [
              /Steeling yourself for a brawl, you plunge into the fray!/,
              /You lunge at (?<target>[^!,]+)!/,
              /You launch yourself at (?<target>[^!,]+)!/,
              /You charge toward (?<target>[^!,]+)!/
            ].freeze),
            # Fury (UAC/brawling): its own opener; the "Relentless in your
            # assault" line that rides along in fury logs stays filed under
            # :relentless_assault (a separate PSM whose passive fires there)
            AttackDef.new(:fury, [/With a percussive snap, you shake out your arms in quick succession and bear down on (?<target>.+?) in a fury!/].freeze),
            AttackDef.new(:twinhammer, [/You raise your hands high, lace them together and bring them crashing down towards (?<target>[^!]+)!/].freeze),
            AttackDef.new(:wblade, [
              /You turn, blade spinning in your hand toward (?<target>[^!]+)!/,
              /You angle your blade at (?<target>.+?) in a crosswise slash!/,
              /In a fluid whirl, you sweep your blade at (?<target>[^!]+)!/,
              /Your blade licks out at (?<target>.+?) in a blurred arc!/,
              # AoE opener, dual-wield form (real-feed capture,
              # logs/examples/whirling_blade.txt) - no target on the line;
              # per-strike rolls and linked crit lines bind targets
              /With a broad flourish, you weave your .+? into a whirling display of coordination and menace!/
            ].freeze),
          ].freeze

          # Combat maneuvers (cmans, PSMs, techniques) - both persons where
          # the wiki documents them. Sources: docs/COMBAT_DEFS_WIKI_CATALOG.md
          MANEUVER_ATTACKS = [
            AttackDef.new(:haymaker, [
              /You clench your (?:right|left) fist and bring your arm back for a roundhouse punch aimed at (?<target>[^!]+)!/,
              /(?<attacker>.+?) clenches #{MK_PRE}(?:his|her|its)#{MK_POST} (?:right|left) fist and brings #{MK_PRE}(?:his|her|its)#{MK_POST} arm back for a roundhouse punch aimed at (?<target>[^!]+)!/
            ].freeze),
            AttackDef.new(:headbutt, [
              /You charge towards (?<target>.+?) and attempt to headbutt #{MK_PRE}(?:him|her|it)#{MK_POST}!/,
              /(?<attacker>.+?) charges towards you and attempts a headbutt!/
            ].freeze),
            AttackDef.new(:bull_rush, [
              /You rush towards (?<target>.+?) and connect with a shoulder check!/,
              /(?<attacker>.+?) rushes towards (?<target>.+?) and connects with a shoulder check!/
            ].freeze),
            AttackDef.new(:cutthroat, [
              /You spring from hiding and attempt to grasp (?<target>.+?) by the chin while slitting #{MK_PRE}(?:his|her|its)#{MK_POST} throat with your .+?!/,
              /You spring from hiding and attempt to cut (?<target>.+?)'s#{MK_POST} throat!/,
              /(?<attacker>.+?) springs upon (?<target>you|.+?) from behind and attempts to slit #{MK_PRE}(?:your|his|her|its)#{MK_POST} throat(?: with #{MK_PRE}(?:his|her|its)#{MK_POST} .+?)?!/
            ].freeze),
            AttackDef.new(:bearhug, [/(?<attacker>.+?) charges towards (?<target>you|.+?) and attempts to grasp #{MK_PRE}(?:you|him|her|it)#{MK_POST} in a ferocious bearhug!/].freeze),
            AttackDef.new(:charge, [
              /(?<attacker>.+?) rushes forward at (?<target>you|.+?) with #{MK_PRE}(?:his|her|its)#{MK_POST} .+? and attempts a charge!/,
              # 2p (logs/examples/weapon_charge.txt). The graded connect line
              # ("You lunge forward with an expert charge!") sits between the
              # SMR and the damage - a hit line, NEVER a def (double-open)
              /You rush forward at (?<target>.+?) with your .+? and attempt a charge!/
            ].freeze),
            AttackDef.new(:garrote, [
              /You fling your .+? around (?<target>.+?)'s#{MK_POST} neck and snap it taut\./,
              /(?<attacker>.+?) (?:jumps on your back and )?flings a (?<weapon>.+?) around your neck and snaps it taut\./
            ].freeze),
            AttackDef.new(:groin_kick, [
              # the short "kicks at" form is the ATTEMPT (opens the roll);
              # "and connects!" is the success line
              /(?<attacker>.+?) kicks at (?<target>your|.+?'s)#{MK_POST} groin!/,
              # 2p (logs/examples/cman_groin_kick.txt)
              /You attempt to deliver a kick to (?<target>.+?'s)#{MK_POST} groin!/,
              /(?<attacker>.+?) kicks #{MK_PRE}(?:his|her|its)#{MK_POST} leg at (?<target>your|.+?'s)#{MK_POST} groin and connects!/
            ].freeze),
            AttackDef.new(:dirtkick, [/You manage to kick a large clump of dust at (?<target>[^!]+)!/].freeze),
            # Feint: the SMR roll PRECEDES this line - the result line is the
            # only carrier of the target (logs/examples/cman_feint.txt)
            AttackDef.new(:feint, [
              /You feint (?:high|low|to the (?:left|right))\.\s+(?<target>.+?) buys the ruse/,
              /You feint (?:high|low|to the (?:left|right)), but (?<target>.+?) (?:isn't|is not) fooled/
            ].freeze),
            # Spell Thieve (cman sthieve): the ward-probe form with no attack
            # is a prefix - no roll follows it, so no def
            AttackDef.new(:spell_thieve, [/You hang back for a moment and concentrate on the magical wards surrounding (?<target>[^,]+), before sneaking in an attack/].freeze),
            # 2p leg sweep (logs/examples/cman_sweep.txt); 3p lives in
            # THIRD_PERSON_ATTACKS with the cartwheel wording
            AttackDef.new(:leg_sweep, [/You crouch and sweep a leg at (?<target>[^!]+)!/].freeze),
            AttackDef.new(:silent_strike, [/You quickly leap from hiding to deliver your attack!/].freeze),
            # 2p ambush re-emerge: printed per strike taken from hiding after
            # a shroud restealth, with the target arriving on the following
            # resisted/evade/roll lines (logs/examples/weapon_pulverize.txt).
            # "You leap from hiding to attack!" is NOT here: cman_garrote.txt
            # proves it a PREFIX - its SMR belongs to the maneuver line after.
            AttackDef.new(:ambush, [/You step from hiding and attack!/].freeze),
            AttackDef.new(:thrash, [
              /You rush (?<target>.+?), raising your .+? high to deliver a sound thrashing!/,
              # per-hit line between the rolls (logs/examples/weapon_thrash.txt)
              /You bring your .+? around in a tight arc to batter (?<target>.+?) into submission!/
            ].freeze),
            AttackDef.new(:smite, [/You level your .+? at (?<target>.+?) and call down the excoriating power of .+? to smite #{MK_PRE}(?:him|her|it)#{MK_POST}!/].freeze),
            AttackDef.new(:flurry_of_blows, [/You quickly pivot and follow up with a jab against (?<target>[^!]+)!/].freeze),
            AttackDef.new(:executioners_stance, [/Barely breaking your momentum, you continue on to attack (?<target>[^!]+)!/].freeze),
            AttackDef.new(:whirling_dervish, [/You deftly switch your ongoing (?:attack|assault) towards (?<target>[^!]+)!/].freeze),
            AttackDef.new(:subdual_strike, [/(?<attacker>.+?) springs from the shadows and strikes at you!/].freeze),
            AttackDef.new(:trip, [
              /With a fluid whirl, (?<attacker>.+?) plants (?<weapon>.+?) firmly into the ground near you and jerks the weapon sharply sideways\./,
              # 2p (logs/examples/cman_trip.txt); SMR between this and result
              /With a fluid whirl, you plant (?<weapon>.+?) firmly into the ground near (?<target>.+?) and jerk the weapon sharply sideways\./
            ].freeze),
            # 2p shield maneuvers (3p bash/charge/throw live in THIRD_PERSON_ATTACKS)
            AttackDef.new(:shield_bash, [/You lunge forward at (?<target>.+?) with your (?<weapon>.+?) and attempt a shield bash!/].freeze),
            AttackDef.new(:shield_pin, [/You attempt to expose a vulnerability with a diversionary shield bash on (?<target>[^!]+)!/].freeze),
            AttackDef.new(:shield_push, [/You raise your (?<weapon>.+?) before you and attempt to push (?<target>.+?) away!/].freeze),
            AttackDef.new(:shield_strike, [/You launch a quick bash with your (?<weapon>.+?) at (?<target>[^!]+)!/].freeze),
            AttackDef.new(:shield_charge, [/You raise your (?<weapon>.+?) before you and charge headlong towards (?<target>[^!]+)!/].freeze),
            # Assassinate (rogue): the uncoil line opens the event; the SMR
            # roll follows it directly, then the "carve into" hit line
            AttackDef.new(:eviscerate, [/You uncoil from the shadows, your (?<weapon>.+?) poised to eviscerate (?<target>[^!]+)!/].freeze),
            # Coup de Grace - messaging varies by weapon type; this is the
            # THW form, catalogue other weapon variants as they're observed
            AttackDef.new(:coup_de_grace, [/You lunge towards (?<target>.+?), intending to finish #{MK_PRE}(?:him|her|it)#{MK_POST} off!/].freeze),
            # "dark wings" equipment proc (SMR attack); name pending
            AttackDef.new(:shadow_barb, [/Your umbrous wings twitch sharply, launching a barbed shard of shadow that hisses through the air toward (?<target>[^!]+)!/].freeze),
            # Whirlwind (THW AoE, single round - not a sequence). Known to
            # have ~4 message variants; two catalogued so far plus the
            # per-target strike line, all under one name.
            AttackDef.new(:whirlwind, [
              /Twisting and spinning among your foes, you lash out again and again with the force of a reaping whirlwind!/,
              /You turn and sweep your (?<weapon>.+?) at (?<target>[^!]+)!/,
              /(?<target>.+?) is struck in your flurry of sweeping strikes!/
            ].freeze),
            # rogue KO-strike: SMR follows directly, then the paralyzed status
            AttackDef.new(:subdue, [/You spring from hiding and aim a blow at (?<target>.+?)'s#{MK_POST} head!/].freeze),
            # shield-strike PSM follow-up (its own SMR precedes; round-5)
            AttackDef.new(:relentless_assault, [
              /Relentless in your assault, you unleash a frenzy of violence upon (?<target>[^!]+)!/,
              /You assault (?<target>.+?) with an unrelenting fury!/
            ].freeze),
            # bard sonic disruption: the renewal verses are untargeted; this
            # per-target line sits between the CS/TD roll and the damage
            # (same shape as the volley per-arrow defs)
            AttackDef.new(:sonic_disruption, [/(?<target>.+?) reels under the force of the sonic vibrations!/].freeze),
            AttackDef.new(:hamstring, [/You lunge forward and try to hamstring (?<target>.+?) with your .+?!/].freeze),
            # Tremors: rollless AoE; per-target balance-loss + weakened follow
            AttackDef.new(:tremors, [
              /As (?:you|(?<attacker>.+?)) stomps? #{MK_PRE}(?:your|his|her|its)#{MK_POST} foot sharply, the (?:ground|floor) shakes wildly!/,
              # mastodon variant (round-5 corpus)
              /(?<attacker>.+?) slams a gigantic foot down, sending tremors rippling outward/
            ].freeze)
          ].freeze

          # Third-person attack initiations: other players and creatures.
          # Catalogued from 2026-08-20 Duskruin arena spectator logs. The
          # same grammar covers both attacker classes - in the live stream
          # player attackers are <a exist> links (negative ids) and creature
          # attackers are pushBold-wrapped links, so the attacker capture
          # uses .+? to span the markup. These enable group-member
          # attribution and creature AS/DS collection (the roll line that
          # follows attaches to the event these lines open).
          THIRD_PERSON_ATTACKS = [
            # Creature spell initiations aimed at us, mined from orphaned
            # CS/TD rolls. Like the :natural additions these key on the
            # ACTION - one "points a clawed finger" pattern covers every
            # psionicist adjective the corpus contains.
            AttackDef.new(:creature_spell, [
              /(?<attacker>.+?) points a clawed finger toward (?<target>[^!]+)!/,
              /(?<attacker>.+?) points a single golden nail toward (?<target>[^!]+)!/,
              /(?<attacker>.+?) turns to look at (?<target>.+?), the empty pits where/,
              /(?<attacker>.+?) glares malevolently at (?<target>[^.!]+)[.!]/,
              /(?<attacker>.+?) flicks #{MK_PRE}(?:his|her|its)#{MK_POST} bulging eyes toward (?<target>[^!]+)!/,
              /(?<attacker>.+?) focuses a lambent beam of divine energy at (?<target>[^!]+)!/,
              /(?<attacker>.+?) levitates a sizeable stone at (?<target>[^!]+)!/,
              /(?<attacker>.+?) projects a thin spear of nacreous light at (?<target>[^!]+)!/,
              /A sudden burst of bright light emanates from (?<attacker>.+?) toward (?<target>[^!]+)!/,
              /(?<attacker>.+?) sends dripping tendrils of rust-colored ectoplasm (?:toward|at) (?<target>[^!]+)!/,
              /(?<attacker>.+?) artfully plays #{MK_PRE}(?:his|her|its)#{MK_POST} .+?, sending .+? toward (?<target>[^!]+)!/
            ].freeze),
            AttackDef.new(:attack, [
              # known flavor tails ("in a murderous arc") trimmed from the
              # target capture; post-capture normalization is the general
              # answer if more tails appear
              /(?<attacker>.+?) swings (?<weapon>.+?) at (?<target>.+?)(?: in a murderous arc)?!/,
              # UAC strike WITH a weapon = weapon attack, same rule as 2p
              /(?<attacker>.+?) (?:punches|jabs|kicks|grapples) with (?<weapon>.+?) at (?<target>[^!]+)!/,
              # dance-macabre chain swings (round-5: only the last plain
              # swing of a chain matched before these)
              /(?<attacker>.+?) charges, swinging (?<weapon>.+?) at (?<target>[^!]+)!/,
              /(?<attacker>.+?) whirls into a deadly form, swinging (?<weapon>.+?) at (?<target>[^!]+)!/,
              /With an .+? flourish of #{MK_PRE}(?:his|her|its)#{MK_POST} (?<weapon>.+?), (?<attacker>.+?) (?:charges forward, trying to skewer|lashes out at) (?<target>[^!]+)!/
            ].freeze),
            AttackDef.new(:thrust, [/(?<attacker>.+?) thrusts with (?<weapon>.+?) at (?<target>[^!]+)!/].freeze),
            # generic verb parallel to "thrusts with" (creature mstrike
            # swings, e.g. dance macabre, use it too)
            AttackDef.new(:slash, [/(?<attacker>.+?) slashes with (?<weapon>.+?) at (?<target>.+?)(?: in a murderous arc)?!/].freeze),
            AttackDef.new(:fire, [/(?<attacker>.+?) fires (?<weapon>.+?) at (?<target>.+?)(?: but the shot flies wide of the target)?!/].freeze),
            # warding/bolt cast initiations (the spell itself names no verb);
            # the creature telegraph and rapid-cast forms open their own
            # CS/TD rolls just like "gestures at"
            AttackDef.new(:cast, [
              /(?<attacker>.+?) gestures at (?<target>[^.]+)\./,
              # untargeted AoE cast (round-6: 8.4k "Nisugi gestures.");
              # per-target events unfold under it via the switch logic.
              # Collides with the bare GESTURE emote, but that event never
              # gains a target id, so event_savable? drops it silently
              /^(?<attacker>.+?) gestures\.\s*$/,
              /(?<attacker>.+?) brings a hand forward, pointing at (?<target>[^!]+)!/,
              /(?<attacker>.+?) makes a complex gesture at (?<target>[^.]+)\./,
              # generic creature warding grammar (round-5: ~5,600 + ~1,700
              # orphaned CS/TD rolls; the tendril/finger lead-ins that
              # precede the warp line are prefixes)
              /The force of (?<attacker>.+?)'s#{MK_POST} power warps the air as it surges toward (?<target>[^!]+)!/,
              /(?<attacker>.+?) points an? .+? finger at (?<target>[^!]+)!/,
              /(?<attacker>.+?) directs the force of #{MK_PRE}(?:his|her|its)#{MK_POST} voice at (?<target>[^!]+)!/
            ].freeze),
            AttackDef.new(:channel, [/(?<attacker>.+?) channels at (?<target>[^.]+)\./].freeze),
            # creature wand flourish - the erupt tail rides the same line
            AttackDef.new(:wand, [/(?<attacker>.+?) flourishes (?<weapon>.+?) at (?<target>[^.]+)\.\s+A .+? erupts toward/].freeze),
            # "hurls a/an <bolt>" - bolt spells from players AND creatures;
            # the reflexive form ("hurls himself") is the tackle maneuver
            AttackDef.new(:bolt, [
              /(?<attacker>.+?) hurls (?:a|an|some) (?<bolt>.+?) at (?<target>[^!]+)!/,
              /(?<attacker>.+?) throws (?:a|an) (?<bolt>.+?) at (?<target>[^!]+)!/,
              # haste-repeat rounds emit the vortex with no cast line; when a
              # cast line IS present it opened the event with the same target,
              # so the re-open is benign
              /(?<attacker>.+?) unleashes a compact swirling vortex at (?<target>[^!]+)!/
            ].freeze),
            # ".+?" not "[^!]+" for target: the cman form appends " and
            # connects!" which a greedy class would swallow into the target
            AttackDef.new(:tackle, [/(?<attacker>.+?) hurls #{MK_PRE}(?:himself|herself|itself)#{MK_POST} at (?<target>.+?)(?: and connects)?!/].freeze),
            # UAC - "attempts to" (3p) vs the 2p "attempt to" above. The
            # weapon-form ("punches with a katar at") lives under :attack:
            # a UAC strike WITH a weapon resolves as a weapon attack.
            AttackDef.new(:uac, [
              /(?<attacker>.+?) attempts to (?<strike>punch|jab|kick|grapple) (?<target>[^!]+)!/
            ].freeze),
            # creature natural weapons and maneuvers
            AttackDef.new(:natural, [
              /(?<attacker>.+?) claws at (?<target>[^!]+)!/,
              /(?<attacker>.+?) snaps at (?<target>.+?) with its (?<weapon>[^!]+)!/,
              /(?<attacker>.+?) pounds at (?<target>.+?) with #{MK_PRE}(?:his|her|its)#{MK_POST} .*?fists?!/,
              /(?<attacker>.+?) tries to bite (?<target>[^!]+)!/,
              /(?<attacker>.+?) tries to ensnare (?<target>[^!]+)!/,
              /(?<attacker>.+?) charges at (?<target>[^!]+)!/,
              /(?<attacker>.+?) crouches and sweeps a leg at (?<target>[^!]+)!/,
              # generic verb cores (round-5; the hyper-bespoke forms go to
              # the orphan-fallback catalog instead)
              /(?<attacker>.+?) flails with #{MK_PRE}(?:his|her|its)#{MK_POST} .+? at (?<target>[^!]+)!/,
              /(?<attacker>.+?) thrusts down at (?<target>.+?) with #{MK_PRE}(?:his|her|its)#{MK_POST} .+?!/,
              /(?<attacker>.+?) barrels into a merciless charge at (?<target>[^!]+)!/,
              /(?<attacker>.+?) attempts to crush (?<target>.+?) with a vicious stomp!/,
              /(?<attacker>.+?) tries to strangle (?<target>.+?) with/,
              # Inbound forms mined from orphaned AS/DS rolls - each of these
              # left its roll, damage and crits with no event to attach to
              # (1-3% of all AS-roll chunks; see mining_results/inbound_attacks.txt).
              # Keyed on the ACTION, not the creature: "points a clawed finger"
              # arrives under five psionicist adjectives but is one shape.
              /(?<attacker>.+?) rakes at (?<target>.+?) with #{MK_PRE}(?:his|her|its)#{MK_POST} .+?!/,
              /(?<attacker>.+?) pecks viciously at (?<target>.+?) with #{MK_PRE}(?:his|her|its)#{MK_POST} .+?!/,
              /(?<attacker>.+?) lunges at (?<target>.+?), maw slathering as #{MK_PRE}(?:he|she|it)#{MK_POST} tries to take/,
              /(?<attacker>.+?) bounds forward and slashes at (?<target>.+?) with /,
              /(?<attacker>.+?) slices at (?<target>.+?) with an elongated talon!/,
              /(?<attacker>.+?) undulates forward and tries to close #{MK_PRE}(?:his|her|its)#{MK_POST} vast jaws on (?<target>[^!]+)!/,
              /(?<attacker>.+?) tries to stomp on (?<target>[^!]+)!/,
              /(?<attacker>.+?) lowers one shoulder and barrels toward (?<target>[^!]+)!/,
              /Misshapen arms erupt from (?<attacker>.+?) to flail at (?<target>[^!]+)!/,
              /(?<attacker>.+?) whirls on (?<target>[^!]+)!/,
              # Round-7 inbound forms, verified against logs/examples XML.
              # Each left its AS roll, damage and crits unbound.
              /(?<attacker>.+?) slashes relentlessly at (?<target>.+?) with /,
              /(?<attacker>.+?) raises #{MK_PRE}(?:his|her|its)#{MK_POST} fists overhead and flails violently at (?<target>[^!]+)!/,
              /(?<attacker>.+?) opens its stony jaws and tries to savage (?<target>.+?) with /,
              /(?<attacker>.+?) rears up onto its ossified hind legs and kicks at (?<target>.+?) with /,
              # Mounted charge: the rider clause comes FIRST and carries its
              # own link to the mount, so the attacker capture must start at
              # the comma - otherwise "Urged on by the knight riding it"
              # becomes the attacker and the real one is lost.
              /Urged on by .+?, (?<attacker>.+?) gallops into a deadly charge at (?<target>[^!]+)!/,
              # Ward-probe opener (CS/TD follows). "sneaking in an attack on
              # the magical wards" is the creature form of spell_thieve.
              /(?<attacker>.+?) hangs back for a moment and concentrates intently on (?<target>[^,]+), before sneaking in an attack/,
              /(?<attacker>.+?) lifts a slender hand and points unerringly at (?<target>[^!]+)!/
            ].freeze),
            # ambush - "waylay" IS its own attack line (it names a target).
            # The bare "leaps from hiding" form is NOT here: it is a
            # MODIFIER, see AMBUSH_PREFIXES below.
            AttackDef.new(:ambush, [
              /(?<attacker>.+?) steps out of hiding to waylay (?<target>[^!]+)!/,
              # cannibal grapple/lunge forms (round-5)
              /(?<attacker>.+?) leaps from the shadows and (?:throws #{MK_PRE}(?:his|her|its)#{MK_POST} .+? around|hurtles at) (?<target>[^,!]+)/
            ].freeze),
            # PSM maneuvers, third person
            AttackDef.new(:hamstring, [/(?<attacker>.+?) lunges forward and tries to hamstring (?<target>.+?) with #{MK_PRE}(?:his|her|its)#{MK_POST} .+?!/].freeze),
            AttackDef.new(:shield_bash, [
              /(?<attacker>.+?) lunges forward at (?<target>.+?) with #{MK_PRE}(?:his|her|its)#{MK_POST} .+? and attempts a shield bash!/,
              /(?<attacker>.+?) launches a quick bash with (?<weapon>.+?) at (?<target>[^!]+)!/,
              /(?<attacker>.+?) dips #{MK_PRE}(?:his|her|its)#{MK_POST} shoulder and rushes towards (?<target>[^!]+)!/
            ].freeze),
            AttackDef.new(:shield_charge, [
              /(?<attacker>.+?) raises #{MK_PRE}(?:his|her|its)#{MK_POST} (?<weapon>.+?) and charges headlong towards (?<target>[^!]+)!/,
              /(?<attacker>.+?) charges forward at (?<target>.+?) with #{MK_PRE}(?:his|her|its)#{MK_POST} (?<weapon>.+?) and attempts a shield charge!/
            ].freeze),
            AttackDef.new(:shield_throw, [/(?<attacker>.+?) snaps #{MK_PRE}(?:his|her|its)#{MK_POST} arm forward, hurling (?<weapon>.+?) at (?<target>.+?) with all #{MK_PRE}(?:his|her|its)#{MK_POST} might!/].freeze),
            AttackDef.new(:swiftkick, [/(?<attacker>.+?) spins around behind (?<target>[^,]+), attempting a swiftkick!/].freeze),
            AttackDef.new(:leg_sweep, [/(?<attacker>.+?) upends #{MK_PRE}(?:himself|herself)#{MK_POST} into a cartwheel and then, twisting #{MK_PRE}(?:his|her)#{MK_POST} lateral momentum into a spin, drops low and lashes out with one leg at (?<target>[^!]+)!/].freeze),
            AttackDef.new(:smite, [/(?<attacker>.+?) levels #{MK_PRE}(?:his|her)#{MK_POST} .+? at (?<target>.+?) and calls down excoriating power to smite/].freeze),
            AttackDef.new(:thrash, [/(?<attacker>.+?) rushes (?<target>.+?), raising #{MK_PRE}(?:his|her)#{MK_POST} .+? high to deliver a sound thrashing!/].freeze),
            # collateral pin when a mount goes down (rollless; damage follows)
            AttackDef.new(:mount_collapse, [/(?<target>.+?) (?:is|are) pinned beneath (?<mount>.+?) as #{MK_PRE}(?:it|he|she)#{MK_POST} falls!/].freeze)
          ].freeze

          # 2p shield throw: each flash/ricochet line opens its own SMR +
          # damage, one event per bounce target. Ricochet pattern MUST come
          # first or the plain flash pattern swallows it. The wind-up line
          # ("You snap your arm forward, hurling...") is a PREFIX - no def.
          SHIELD_ATTACKS = [
            AttackDef.new(:shield_throw, [
              /Your (?<weapon>.+?) ricochets off .+? and flashes toward (?<target>[^!]+)!/,
              /Your (?<weapon>.+?) flashes toward (?<target>[^!]+)!/
            ].freeze)
          ].freeze

          # Companion/pet attacks
          COMPANION_ATTACKS = [
            AttackDef.new(:companion, [
              /(?<companion>.+?) pounces on (?<target>[^,]+), knocking the .+? painfully to the ground!/,
              %r{The (?<companion>.+?) takes the opportunity to slash .+? claws at (?:<pushBold/>)?the (?<target>.+?) \w+!},
              /(?<companion>.+?) charges forward and slashes .+? claws at (?<target>.+?) faster than .+? can react!/,
              /(?<companion>.+?) charges forward and bites down on (?<target>.+?) faster than .+? can react!/,
              /(?<companion>.+?) rushes forward, sinking #{MK_PRE}(?:his|her|its)#{MK_POST} teeth into (?<target>.+?) neck!/,
              /(?<companion>.+?) rushes forward, slashing viciously at the back of (?<target>.+?) (?:right|left) leg with #{MK_PRE}(?:his|her|its)#{MK_POST} teeth and claws!/
            ].freeze)
          ].freeze

          # Environmental attacks
          ENVIRONMENTAL_ATTACKS = [].freeze

          # AMBUSH PREFIXES - modifiers, not attacks.
          #
          # Attacking from hiding is still just an attack; the hiding line
          # only marks that it carries the ambush bonuses (DS pushdown plus
          # crit weighting - or, for waylay, damage weighting instead). The
          # real attack line follows and carries the target and the roll:
          #
          #     Butch leaps from hiding to strike!      <- prefix, no target
          #     Butch attempts to punch <creature>!     <- the actual attack
          #       UAF: 681 vs UDF: 575 ... = 130        <- its roll
          #
          # Archive evidence (11k+ logs): the follower is always an attack
          # or UAC maneuver (swings/claws/thrusts/attempts to jab|punch|kick)
          # - or, when the ambush is wholly negated, an OUTCOME with no
          # attack line at all ("The thorny barrier ... blocks the attack!",
          # "You outmaneuver the attack!"). Never a non-combat action.
          #
          # Treated as a def these opened a second, fact-less event per
          # ambush (35,549 occurrences). Treated as a prefix they set
          # `ambush: true` on the attack that follows, so the attack keeps
          # its own name (:attack, :uac...) and gains the modifier - and a
          # negated ambush still records as a missed attack via its outcome.
          AMBUSH_PREFIXES = [
            # 2p. cman_garrote.txt proved these prefixes: the SMR that
            # follows belongs to the maneuver line, not to this.
            /\AYou leap from hiding to (?:attack|strike)!/,
            /\AYou quickly leap from hiding to deliver your attack!/,
            /\AYou step from hiding and attack!/,
            # 3p, same grammar with an attacker
            /\A(?<attacker>.+?) leaps from hiding to (?:attack|strike)!/
          ].freeze

          AMBUSH_GATE, AMBUSH_ALWAYS_SCAN = PatternGate.build(AMBUSH_PREFIXES)

          # True when the line is an ambush prefix; returns the attacker
          # capture when the 3p form carries one.
          def self.ambush_prefix(line)
            return nil if PatternGate.rejects?(AMBUSH_GATE, AMBUSH_ALWAYS_SCAN, line)

            AMBUSH_PREFIXES.each do |pattern|
              next unless (m = pattern.match(line))

              return { attacker: m.names.include?('attacker') ? m[:attacker] : nil }
            end
            nil
          end

          # All attack definitions combined
          # Ordering is load-bearing: PRIORITY defs pre-empt the generic
          # swing patterns; second-person defs come before third-person so
          # "You swing" never falls through; the generic 2p bolt sits last
          # inside WIKI_SPELL_ATTACKS so named bolts keep their names.
          ALL_ATTACKS = (PRIORITY_ATTACKS + BASIC_ATTACKS + SPELL_ATTACKS + WIKI_SPELL_ATTACKS +
                        MANEUVER_ATTACKS + WEAPON_ATTACKS +
                        RANGED_ATTACKS + SHIELD_ATTACKS + COMPANION_ATTACKS + ENVIRONMENTAL_ATTACKS +
                        THIRD_PERSON_ATTACKS).freeze

          # Create lookup table for fast pattern matching
          ATTACK_LOOKUP = ALL_ATTACKS.flat_map do |attack_def|
            attack_def.patterns.compact.map { |pattern| [pattern, attack_def.name] }
          end.freeze

          # Compiled regex for fast detection. NOTE: costs ~0.5ms per
          # non-matching line (unanchored `.+?` alternatives); kept for
          # compatibility but the literal gate below is what the parser uses.
          ATTACK_DETECTOR = Regexp.union(ATTACK_LOOKUP.map(&:first)).freeze

          # Literal-substring gate (~7us/line): a line can only match an
          # attack pattern if it contains that pattern's longest literal.
          ATTACK_GATE, ATTACK_ALWAYS_SCAN = PatternGate.build(ATTACK_LOOKUP.map(&:first))

          # True when the line cannot match any attack pattern
          def self.rejects?(line)
            PatternGate.rejects?(ATTACK_GATE, ATTACK_ALWAYS_SCAN, line)
          end
        end
      end
    end
  end
end
