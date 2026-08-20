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
              /A clean miss\./,
              /A close miss\./,
              /Nowhere close!/
            ].freeze),
            OutcomeDef.new(:warded, [/^\s*Warded off!/].freeze),
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
              /(?<target>.+?) stumbles dazedly, somehow managing to evade the .+?!/
            ].freeze),
            OutcomeDef.new(:block, [
              /A heavy barrier of stone momentarily forms around (?<target>.+?) and blocks the attack!/,
              /Amazingly, (?<target>.+?) manages to block the .+? with .+?!/,
              /At the last moment, (?<target>.+?) blocks the .+? with .+?!/,
              /Fumbling aimlessly, (?<target>.+?) manages to deflect the .+? with .+?!/,
              /In the nick of time, (?<target>.+?) interposes .+? between .+? and the .+?!/,
              /Lying flat on .+? back, (?<target>.+?) barely deflects the .+? with .+?!/,
              /Nearly insensible, (?<target>.+?) desperately blocks the .+? with .+?!/,
              /Nearly insensible, (?<target>.+?) wildly blocks the .+? with .+?!/,
              /Reeling and staggering, (?<target>.+?) barely blocks the .+? with .+?!/,
              /Stupefied, (?<target>.+?) blocks the .+? by blind luck!/,
              /The thorny barrier surrounding (?<target>.+?) blocks your .+?!/,
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
              /(?<target>.+?) stumbles dazedly, but manages to block the .+? with .+?!/,
              /(?<target>.+?) stumbles dazedly, somehow managing to block the .+? with .+?!/,
              /(?<target>.+?) tumbles to the side and deflects the .+? with .+?!/
            ].freeze),
            OutcomeDef.new(:parry, [
              /Amazingly, (?<target>.+?) manages to parry the .+? with .+?!/,
              /At the last moment, (?<target>.+?) parries the .+? with .+?!/,
              /Using the bone plates surrounding .+? forearms, (?<target>.+?) parries your .+?!/,
              /With extreme effort, (?<target>.+?) beats back the .+? with .+?!/,
              /With no room to spare, (?<target>.+?) manages to parry the .+? with .+?!/,
              /(?<target>.+?) barely manages to fend off the .+? with .+?!/,
              /(?<target>.+?) flails on the ground but manages to parry the .+? with .+?!/,
              /(?<target>.+?) rolls to one side and parries the .+? with .+?!/
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
              /AS: (?<as>[+\-\d]+) vs DS: (?<ds>[+\-\d]+) with AvD: (?<avd>[+\-\d]+) \+ d\d+ roll: (?<roll>[+\-\d]+) = (?<result>[+\-\d]+)/
            ].freeze),
            ResolutionDef.new(:cs_td, [
              /CS: (?<cs>[+\-\d]+) - TD: (?<td>[+\-\d]+) \+ CvA: (?<cva>[+\-\d]+) \+ d\d+: (?<roll>[+\-\d]+) \+ Bonus: (?<bonus>[+\-\d]+) == (?<result>[+\-\d]+)/,
              /CS: (?<cs>[+\-\d]+) - TD: (?<td>[+\-\d]+) \+ CvA: (?<cva>[+\-\d]+) \+ d\d+: (?<roll>[+\-\d]+) == (?<result>[+\-\d]+)/
            ].freeze),
            ResolutionDef.new(:uaf_udf, [
              /UAF: (?<uaf>\d+) vs UDF: (?<udf>\d+) = (?<total>[.\d]+) \* MM: (?<mm>\d+) \+ d\d+: (?<roll>\d+) = (?<result>\d+)/
            ].freeze),
            ResolutionDef.new(:smr, [
              /\[SMR result: (?<result>\d+) \(Open d100: (?<roll>[+\-\d]+), Bonus: (?<bonus>[+\-\d]+)\)\]/,
              /\[SMR result: (?<result>\d+) \(Open d100: (?<roll>[+\-\d]+)\)\]/
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
