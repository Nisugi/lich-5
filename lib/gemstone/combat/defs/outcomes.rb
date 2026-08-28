# frozen_string_literal: true

#
# Outcome & Resolution Pattern Definitions
# Converted from ctparser/OUTCOME_DEFS + RESOLUTION_DEFS to
# Lich::Gemstone::Combat namespace
#
# Outcomes are the WHY of a swing that produced no damage: evaded,
# blocked, parried, warded, clean miss. Resolutions are the roll lines
# (AS/DS, CS/TD, UAF/UDF, SMR) - the numbers a subscriber needs to judge
# whether an engagement is worth continuing.
#
# :warded / :ward_failed are not in ctparser; catalogued from session
# logs (8357 "Warding failed!" / 537 "Warded off!" in one month).
#

require_relative 'pattern_gate'

module Lich
  module Gemstone
    module Combat
      module Definitions
        module Outcomes
          OutcomeDef = Struct.new(:type, :patterns)

          OUTCOME_DEFS = [
            OutcomeDef.new(:miss, [
              # [.!] - the UAC forms end with a bang
              /A clean miss[.!]/,
              /A close miss[.!]/,
              /Nowhere close!/,
              # third person (spectator/group members)
              /(?<attacker>.+?)'s#{MK_POST} swing goes wide!/,
              /The (?:arrow|bolt) streaks off into the distance!/,
              # ambush/maneuver misses ("thwarted" is just a fancy miss)
              /Though (?<target>.+?) is caught unaware, you manage to completely miss your strike/,
              /You make a grab for (?<target>.+?) but miss, leaving yourself open/,
              /You stumble slightly as you leap from hiding, revealing yourself in the process\./,
              /You move towards (?<target>.+?) to finish your kill, but .+? thwarts your attempt\./,
              /The shadowy barb strikes harmlessly at the ground near (?<target>[^.]+)\./,
              # volley per-target misses (each follows its own low SMR).
              # ground|floor: both surfaces are live and the floor variant
              # was missing entirely (1,070 occurrences in archive replay).
              /A falling arrow flashes past (?<target>.+?) and shatters against the (?:ground|floor)!/,
              /An incoming arrow just misses (?<target>[^!]+)!/,
              /An arrow falls to the (?:ground|floor), narrowly missing (?<target>[^!]+)!/,
              # target dodges the incoming shot - names the target, so it
              # binds the event that the miss belongs to
              /(?<target>.+?) moves at the last moment to avoid an incoming arrow!/,
              # volley/pindown whiff against one target in the spray
              /The spray of arrows leaves (?<target>.+?) unscathed and undeterred!/,
              # tangleweed whiff (targeted form; the targetless idle whiff
              # fires after the target died - no event - and stays un-def'd)
              /The .+? vine#{MK_POST} (?:lashes out at|grabs at) (?<target>.+?),? (?:but is unable to grasp|unable to find a purchase)/,
              /Your strike misses its mark!/,
              /(?<attacker>.+?) whacks your legs to no effect!/,
              # 2p sweep whiff (logs/examples/cman_sweep.txt)
              /You whack (?<target>.+?'s)#{MK_POST} legs futilely!/,
              # groin-kick whiff; "slighty" is the game's own typo, slightl?y
              # tolerates it being fixed someday
              /You end up missing entirely, leaving you slightl?y off balance\./,
              # round-5 maneuver/SMR closers (each follows its own roll)
              /(?<target>.+?) avoids your bash!/,
              /(?<target>.+?) is unaffected by your futile bash!/,
              /Your (?<weapon>.+?) flies wide, narrowly missing (?<target>[^!]+)!/,
              /The net flies past you and collapses into a useless heap!/,
              /(?<attacker>.+?) stumbles behind you like a top out of control!/,
              /The enormous hand attempts to grab you, but you manage to avoid it at the last moment\./
            ].freeze),
            # Spectator-level hit confirm (round-6: 109k "A hit!", 5.8k
            # "Good hit!") - another player's swing connecting, rendered
            # without the roll/damage detail
            OutcomeDef.new(:hit, [/^#{MK_POST}\s*(?:A|Good) hit!\s*$/].freeze),
            OutcomeDef.new(:warded, [/^#{MK_POST}\s*Warded off!/].freeze),
            OutcomeDef.new(:ward_failed, [/^#{MK_POST}\s*Warding failed!/].freeze),
            # INTERCEPTS - the attack is nullified BEFORE it resolves, by a
            # barrier/shield/ward standing between attacker and defender.
            # Categorically NOT :block or :evade: nothing was blocked or
            # dodged, and no defensive skill was exercised - it is as if the
            # attack never happened. Kept separate so hit-rate and
            # block-rate statistics stay honest (an intercept must not count
            # against a creature's evasion or a character's block rate).
            #
            # Ordered BEFORE :evade/:block so these claim their lines first
            # (parse is first-match-wins).
            OutcomeDef.new(:intercept, [
              # 250 Thorn Barrier / thorny barrier
              /The thorny barrier surrounding (?<target>.+?) blocks your .+?!/,
              /The thorny barrier surrounding you blocks the attack from (?<attacker>[^!]+)!/,
              /The thorny barrier surrounding (?<target>.+?) blocks the attack from .+?!/,
              # 430 Evanescent Shield
              /The evanescent shield shrouding (?<target>.+?) flares to life and absorbs the (?:oncoming blow|essence of the spell, dissipating it harmlessly)\./,
              /The evanescent shield shrouding you flares to life and absorbs the (?:oncoming blow|essence of the spell, dissipating it harmlessly)\./,
              # 606 Bark Skin
              /The layer of bark on you hardens and absorbs the attack!/,
              /The layer of bark on (?<target>.+?) hardens and absorbs the attack!/,
              # stone barrier
              /A heavy barrier of stone momentarily forms around (?<target>.+?) and blocks the attack!/,
              # full spell-deflect barrier - replaces the roll line entirely
              /A complex pattern of .+? energy flashes briefly into existence between .+? and (?<target>.+?), deflecting the assault entirely\./,
              /(?<attacker>.+?)'s#{MK_POST} spell is deflected by your barrier in a flash of \w+ light!/,
              %r{Your spell is deflected by (?:<pushBold/>)?the (?<target>.+?)'s#{MK_POST} barrier in a flash of \w+ light!},
              # mirror image - the image takes the hit, not the character
              /A mirror image of (?:you|.+?) shimmers into view, gaining substance just long enough to intercept the attack!/,
              # outmaneuver: the attack is avoided outright, no roll involved
              /(?<target>.+?) outmaneuvers the attack and completely avoids it!/,
              /You outmaneuver the attack and completely avoid it!/
            ].freeze),
            OutcomeDef.new(:evade, [
              /By amazing chance, (?<target>.+?) evades the .+?!/,
              /Lying flat on .+? back, (?<target>.+?) leans to one side and dodges the .+?!/,
              /Nearly insensible, (?<target>.+?) desperately evades the .+?!/,
              /Rolling hurriedly, (?<target>.+?) blocks the .+? with .+?!/,
              /Stupefied, (?<target>.+?) evades the .+? by blind luck!/,
              /Unable to focus clearly, (?<target>.+?) blindly evades the .+?!/,
              /(?<target>.+?) barely dodges the .+?!/,
              /(?<target>.+?) dodges just in the nick of time!/,
              /(?<target>.+?) dodges out of the way!/,
              /(?<target>.+?) evades the .+? by a hair!/,
              /(?<target>.+?) evades the .+? by inches!/,
              /(?<target>.+?) evades the .+? with ease!/,
              /(?<target>.+?) flails on the ground but manages to barely dodge the .+?!/,
              /(?<target>.+?) gracefully avoids the .+?!/,
              /(?<target>.+?) moves at the last moment to evade the .+?!/,
              /(?<target>.+?) rolls to one side and evades the .+?!/,
              /(?<target>.+?) skillfully dodges the .+?!/,
              /(?<target>.+?) stumbles dazedly, somehow managing to evade the .+?!/,
              # NOTE: "outmaneuvers the attack and completely avoids it" moved
              # to :intercept - it nullifies the attack rather than dodging it.
              /(?<target>.+?) dodges an incoming arrow!/,
              # mstrike per-target pre-empt (logs/examples/mstrike.txt):
              # the swing never happens, so this IS that strike's outcome
              /Sensing your attack coming, (?<target>.+?) leaps to safety as you move to attack (?:him|her|it), leaving you out of position!/,
              /Unable to focus clearly, you blindly evade the attack!/,
              # second person - we are the one evading
              /You barely dodge the attack!/,
              /Unfortunately, your aim is off and your attack goes wide!/,
              /You evade the (?:attack|missile|bolt) by inches!/,
              /You evade the (?:attack|missile|bolt) by a hair!/,
              /You evade the (?:attack|missile|bolt) with ease!/,
              /You evade the attack with incredible finesse!/,
              /You dodge just in the nick of time!/,
              /You dodge out of the way!/,
              /By amazing chance, you evade the .+?!/,
              /You move at the last moment to evade the .+?!/,
              /You gracefully avoid the .+?!/,
              /You skillfully dodge the .+?!/,
              /With blinding speed, (?:you|(?<target>.+?)) dodges? the .+?!/,
              /You move slightly, letting the attack pass harmlessly by!/,
              /You move quickly avoiding the magic!/,
              /You manage to jump out of the way!/,
              /Staggering like a punch-drunk brawler, you dodge the .+?!/,
              /Sensing an impending attack, you manage to roll hard to the side/,
              /Stupefied, you evade the .+? by blind luck!/,
              # NOTE: "You outmaneuver the attack..." moved to :intercept.
              # round-5: haymaker dodge + maneuver/SMR closers
              /You manage to dodge (?<attacker>.+?)'s#{MK_POST} blow!/,
              /(?<attacker>.+?) attempts to bearhug (?<target>.+?), but .+? to evade #{MK_PRE}(?:his|her|its)#{MK_POST} grasp!/,
              /You dodge the .+? with barely a hair's breadth to spare!/,
              /You manage to dodge .+?(?:, and it passes harmlessly by| in the nick of time)!/,
              /You dodge the .+? by a hair!/,
              /Bobbing and weaving, you dodge the .+?!/,
              # trip whiff (logs/examples/cman_trip.txt; leading article is
              # lowercase live)
              /(?<target>.+?) deftly avoids the stroke\./
            ].freeze),
            # NOTE: barrier/shield/bark/deflect patterns live in :intercept
            # above - they nullify the attack rather than blocking it.
            OutcomeDef.new(:block, [
              /Amazingly, (?<target>.+?) manages to block the .+? with .+?!/,
              /At the last moment, (?<target>.+?) blocks the .+? with .+?!/,
              /Fumbling aimlessly, (?<target>.+?) manages to deflect the .+? with .+?!/,
              /In the nick of time, (?<target>.+?) interposes .+? between .+? and the .+?!/,
              /Lying flat on .+? back, (?<target>.+?) barely deflects the .+? with .+?!/,
              /Nearly insensible, (?<target>.+?) desperately blocks the .+? with .+?!/,
              /Nearly insensible, (?<target>.+?) wildly blocks the .+? with .+?!/,
              /Reeling and staggering, (?<target>.+?) barely blocks the .+? with .+?!/,
              /Stupefied, (?<target>.+?) blocks the .+? by blind luck!/,
              # full spell-deflect barrier - replaces the roll line entirely;
              # color varies ("ghostly blue", "pale") and either party can be
              # the first operand
              /You harmlessly deflect the charge!/,
              /Unable to focus clearly, (?<target>.+?) blindly blocks the .+?!/,
              /With extreme effort, (?<target>.+?) blocks the .+? with .+?!/,
              /With no room to spare, (?<target>.+?) blocks the .+? with .+?!/,
              /(?<target>.+?) awkwardly scrambles along the ground to avoid the .+?!/,
              /(?<target>.+?) awkwardly scrambles to the right and blocks the .+?!/,
              /(?<target>.+?) barely manages to block the .+? with .+?!/,
              /(?<target>.+?) easily blocks the .+? with .+?!/,
              /(?<target>.+?) flails on the ground but manages to block the .+? with .+?!/,
              /(?<target>.+?) interposes .+? between .+? and the .+?!/,
              /(?<target>.+?) manages to block the .+? with .+?!/,
              /(?<target>.+?) rolls to one side and deflects the .+? with .+?!/,
              /(?<target>.+?) skillfully blocks the .+? with .+?!/,
              /(?<target>.+?) skillfully interposes .+? between .+? and the .+?!/,
              # "manages to" optional: "stumbles dazedly, but blocks the
              # missile with her mattock!" is live (round-5)
              /(?<target>.+?) stumbles dazedly, but (?:manages to )?blocks? the .+? with .+?!/,
              /(?<target>.+?) deflects your (?<weapon>.+?) with #{MK_PRE}(?:his|her|its)#{MK_POST} .+?!/,
              /(?<target>.+?) stumbles dazedly, somehow managing to block the .+? with .+?!/,
              /(?<target>.+?) tumbles to the side and deflects the .+? with .+?!/,
              /(?<target>.+?) harmlessly deflects the charge!/,
              # second person - we are the one blocking
              /You gauge the attack and expertly deflect it with your .+?!/,
              /At the last moment, you block the missile with your .+?!/,
              /In the nick of time, you interpose your .+? between yourself and the (?:missile|blow)!/,
              /Though dazed, you easily deflect the .+? with your .+?!/,
              /Although completely oblivious, you instinctively block the .+? with your .+?!/,
              /You skillfully block the missile with your .+?!/,
              # round-5: 2p block family (~1,350 - the largest outcome hole).
              # Ordered specific-first; the bare last pattern catches the
              # plain wording.
              /(?:With no room to spare|With blinding speed|With extreme effort|Amazingly), you(?: manage to)? block the .+? with your .+?!/,
              /At the last moment, you block the (?:attack|missile|bolt|blow) with your .+?!/,
              /You (?:easily|skillfully) block the (?:attack|missile|bolt|blow) with your .+?!/,
              /You barely manage to block the .+? with your .+?!/,
              /With incredible finesse, you deflect the .+? with your .+?!/,
              /You block the (?:attack|missile|bolt|blow) with your .+?!/,
              # haymaker deflect (2p)
              /You manage to deflect (?<attacker>.+?)'s#{MK_POST} blow in the nick of time!/,
              # maneuver/SMR closers (each directly follows its own roll)
              /(?<attacker>.+?)'s#{MK_POST} spell is deflected by your barrier in a flash of \w+ light!/,
              # 2p attacker - our spell eaten by the target's barrier
              %r{Your spell is deflected by (?:<pushBold/>)?the (?<target>.+?)'s#{MK_POST} barrier in a flash of \w+ light!}
            ].freeze),
            OutcomeDef.new(:parry, [
              /Amazingly, (?<target>.+?) manages to parry the .+? with .+?!/,
              /At the last moment, (?<target>.+?) parries the .+? with .+?!/,
              /Using the bone plates surrounding .+? forearms, (?<target>.+?) parries your .+?!/,
              /With extreme effort, (?<target>.+?) beats back the .+? with .+?!/,
              /With no room to spare, (?<target>.+?) manages to parry the .+? with .+?!/,
              /(?<target>.+?) barely manages to fend off the .+? with .+?!/,
              /(?<target>.+?) flails on the ground but manages to parry the .+? with .+?!/,
              /(?<target>.+?) rolls to one side and parries the .+? with .+?!/,
              # second person - we are the one parrying
              /With no room to spare, you manage to parry the blow with your .+?!/,
              /Using the bone plates surrounding your forearms, you parry the attack!/,
              /(?<target>.+?) manages to fend off (?:your|(?<attacker>.+?)'s#{MK_POST}) attack!/,
              /At the last moment, you parry the .+? with your .+?!/,
              /Amazingly, you manage to parry the .+? with your .+?!/,
              /You barely manage to fend off the .+? with your .+?!/,
              /With extreme effort, you beat back the .+? with your .+?!/,
              /You gauge the attack and expertly parry it with your .+?!/
            ].freeze),
            # Hit landed (or attack resolved) but the effect was reduced or
            # negated by a defense that is not evade/block/parry/ward
            OutcomeDef.new(:resisted, [
              /(?<target>.+?) shrugs off some of the damage!/,
              /(?<target>.+?)'s#{MK_POST} exterior hardens for a moment and softens the attack!/,
              /A dull grey beam snakes out toward you, but dissipates upon impact\./,
              /The web turns away harmlessly from (?<target>[^.]+)\./,
              /The wisps dissipate harmlessly into the air\./,
              /Your attack whistles right through (?<target>[^.]+)\./,
              /(?<target>.+?) wavers as your attack passes right through #{MK_PRE}(?:it|him|her)#{MK_POST}!/,
              # partial mitigation - precedes a visibly reduced damage line
              /(?<target>.+?) aura absorbs some of the damage!/,
              /(?<target>.+?) manages to block some of the (?:elemental )?damage with #{MK_PRE}(?:his|her|its)#{MK_POST} .+?!/,
              /(?<armor>.+?) partially deflects the onslaught of the \w+ attack\./,
              # fear-save resists (follow the SSR roll)
              /Your heart leaps for an instant, but you control the urge to run\./,
              /(?<target>.+?) remains resolute in the face of the tremendous sound!/,
              # round-5 maneuver/SMR closers
              /(?<attacker>.+?) attempts to jab (?<weapon>.+?) into your .+?, but it doesn't faze you\./,
              /Your body resists the \w+ damage and lessens the severity of the attack!/
            ].freeze),
            OutcomeDef.new(:fumble, [/d100 == 1 FUMBLE!/].freeze),
            OutcomeDef.new(:hindrance, [/\[Spell Hindrance for (?<armor>.+?) is (?<hindrance_amount>\d+)% with current Armor Use skill, d100= (?<roll>\d+)\]/].freeze),
            OutcomeDef.new(:confused, [/Something confusing enters your mind at the worst possible moment, and the distraction disrupts your .+?!/].freeze)
          ].freeze

          OUTCOME_LOOKUP = OUTCOME_DEFS.flat_map { |d| d.patterns.map { |rx| [rx, d.type] } }.freeze
          GATE, ALWAYS_SCAN = PatternGate.build(OUTCOME_LOOKUP.map(&:first))

          # @return [Symbol, nil] outcome type
          def self.parse(line)
            return nil unless GATE.match?(line) || ALWAYS_SCAN.any? { |rx| rx.match?(line) }

            OUTCOME_LOOKUP.each { |rx, type| return type if rx.match?(line) }
            nil
          end
        end

        module Resolutions
          ResolutionDef = Struct.new(:type, :patterns)

          RESOLUTION_DEFS = [
            ResolutionDef.new(:as_ds, [
              # optional "+ N +" term = True Strike bonus; the die is not
              # always d100 there either (d80, d40 at higher tiers)
              /AS: (?<as>[+\-\d]+) vs DS: (?<ds>[+\-\d]+) with AvD: (?<avd>[+\-\d]+) \+ (?:(?<bonus>\d+) \+ )?d\d+ roll: (?<roll>[+\-\d]+) = (?<result>[+\-\d]+)/
            ].freeze),
            ResolutionDef.new(:cs_td, [
              /CS: (?<cs>[+\-\d]+) - TD: (?<td>[+\-\d]+) \+ CvA: (?<cva>[+\-\d]+) \+ d\d+: (?<roll>[+\-\d]+) \+ Bonus: (?<bonus>[+\-\d]+) == (?<result>[+\-\d]+)/,
              # trailing "- N" modifier (Torment 718, Untrammel 209, Vertigo 1219)
              /CS: (?<cs>[+\-\d]+) - TD: (?<td>[+\-\d]+) \+ CvA: (?<cva>[+\-\d]+) \+ d\d+: (?<roll>[+\-\d]+)(?: - (?<penalty>[+\-\d]+))? == (?<result>[+\-\d]+)/
            ].freeze),
            ResolutionDef.new(:uaf_udf, [
              /UAF: (?<uaf>\d+) vs UDF: (?<udf>\d+) = (?<total>[.\d]+) \* MM: (?<mm>\d+) \+ d\d+: (?<roll>\d+) = (?<result>\d+)/
            ].freeze),
            ResolutionDef.new(:smr, [
              # Penalty term and negative results are both live (Rysk logs)
              /\[SMR result: (?<result>-?\d+) \(Open d100: (?<roll>[+\-\d]+)(?:, Bonus: (?<bonus>[+\-\d]+))?(?:, Penalt(?:y|ies): (?<penalty>[+\-\d]+))?\)\]/
            ].freeze),
            # Standard Save Roll - follows intimidation/terrorize checks
            ResolutionDef.new(:ssr, [
              /\[SSR result: (?<result>-?\d+) \(Open d100: (?<roll>[+\-\d]+)\)\]/
            ].freeze),
            # Imbed/crystal activation roll - sits between a wand wave and
            # its spell cast ("1d100: 30 + Modifiers: 375 == 405"); gives
            # the otherwise fact-less :wand event its roll (round-6, from
            # the fury/divine_fury real-feed capture)
            ResolutionDef.new(:activation, [
              /1d100: (?<roll>[+\-\d]+) \+ Modifiers: (?<mods>[+\-\d]+) == (?<result>[+\-\d]+)/
            ].freeze),
            # Legacy maneuver roll (lowercase "open", no SMR prefix). Most
            # cmans were converted to SMR but the old format is kept as a
            # fallback - it costs one gate literal and catches stragglers.
            ResolutionDef.new(:maneuver_roll, [
              /\[Roll result: (?<result>-?\d+) \(open d100: (?<roll>-?\d+)\)(?:,? (?:Bonus: (?<bonus>-?\d+)|Penalt(?:y|ies): (?<penalty>-?\d+)))?\]/
            ].freeze),
            # Fear resolution (Sheer fear) - its own roll grammar entirely
            ResolutionDef.new(:fear, [
              /FS: (?<fs>[+\-\d]+) - FD: (?<fd>[+\-\d]+) \+ FvP: (?<fvp>[+\-\d]+) \+ d100\(L\): (?<roll>[+\-\d]+) = (?<result>[+\-\d]+)/
            ].freeze)
          ].freeze

          RESOLUTION_LOOKUP = RESOLUTION_DEFS.flat_map { |d| d.patterns.map { |rx| [rx, d.type] } }.freeze
          GATE, ALWAYS_SCAN = PatternGate.build(RESOLUTION_LOOKUP.map(&:first))

          # @return [Hash, nil] { type: :as_ds, as: 739, ds: 376, ..., result: 469 }
          #   with every named capture converted to Integer (total, which can
          #   be fractional in UCS, converts to Float when it contains a dot).
          def self.parse(line)
            return nil unless GATE.match?(line) || ALWAYS_SCAN.any? { |rx| rx.match?(line) }

            RESOLUTION_LOOKUP.each do |rx, type|
              next unless (match = rx.match(line))

              result = { type: type }
              match.names.each do |cap|
                next unless match[cap]

                result[cap.to_sym] = match[cap].include?('.') ? match[cap].to_f : match[cap].to_i
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
