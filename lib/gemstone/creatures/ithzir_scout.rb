{
  schema_version: 3,
  name: "ithzir scout",
  noun: "",
  url: "https://gswiki.play.net/ithzir_scout",
  picture: "",
  level: 89,
  family: "Ithzir",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Extraplanar"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Old Ta'Faendryl",
      uids: [17004001..17004028, 17004031..17004079, 17004160..17004168, 17004180..17004187, 17004190..17004195]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Broadsword",
        as: (414..424)
      },
      {
        name: "Closed fist",
        as: 402
      },
      {
        name: "Smash",
        as: 443
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Cheapshots"
      },
      {
        name: "Sweep"
      },
      {
        name: "Stomp"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12",
    immunities: [],
    melee: (328..552),
    ranged: (323..343),
    bolt: (346..392),
    udf: 434,
    bar_td: nil,
    cle_td: (335..339),
    emp_td: (325..334),
    pal_td: nil,
    ran_td: nil,
    sor_td: (339..363),
    wiz_td: nil,
    mje_td: 380,
    mne_td: 368,
    mjs_td: nil,
    mns_td: 328,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "crystal-edged weapons"
  },
  messaging: {
    description: [
      "Wide, pupil-less green eyes peer about, quickly assessing both threats and terrain. The Ithzir scout stalks in a fluid, half-crouch that is as graceful as it is lightning fast, his whole demeanor underscoring his menace and obvious intelligence. The Ithzir scout is slightly taller than a human, and while his humanoid form is similar to scores of other races, the hairless, blue-skinned body is nonetheless alien in its appearance. The scout wears a charcoal grey tunic with no apparent identifiers of his station."
    ],
    arrival: [
      "An Ithzir initiate strides in, his hands clasped before him.",
      "An Ithzir initiate strides in, her hands clasped before her."
    ],
    flee: [],
    death: [
      "The Ithzir scout twitches violently, then dies."
    ],
    decay: [
      "Acid dissolves the knee ligaments.  The Ithzir scout's tibia passes her femur in a very unpleasant manner!"
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A greater construct raises ithzir scout massive foot and attempts to smash you!",
      "An Ithzir scout swings {weapon} at you!",
      "An Ithzir scout throws {weapon} at you!",
      "The Ithzir scout points at you for emphasis."
    ],
    bite: [],
    claw: [],
    info: {
      general: [],
      class_tips: {
        cleric: [],
        paladin: [],
        ranger: [],
        bard: [],
        wizard: [],
        empath: [],
        rogue: [],
        warrior: [],
        sorcerer: []
      },
      miscellany: []
    },
    triggers: {}
  }
}
