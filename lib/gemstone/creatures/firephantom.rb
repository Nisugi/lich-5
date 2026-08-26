{
  schema_version: 3,
  name: "firephantom",
  noun: "",
  url: "https://gswiki.play.net/firephantom",
  picture: "",
  level: 6,
  family: "Elemental",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead",
    "Element-based"
  ],
  bcs: nil,
  max_hp: 70,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Glatoph",
      uids: [35010..35024]
    },
    {
      name: "Vornavian Coast",
      uids: [4202301..4202320]
    },
    {
      name: "The Citadel",
      uids: [2102001..2102006, 2102059..2102069]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Closed fist",
        as: 77
      }
    ],
    bolt_spells: [
      {
        name: "Minor Fire (906)",
        as: 69
      },
      {
        name: "Major Fire (908)",
        as: 69
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "1N",
    immunities: [],
    melee: "-64",
    ranged: -61,
    bolt: "-61",
    udf: 13,
    bar_td: 18,
    cle_td: 18,
    emp_td: 18,
    pal_td: nil,
    ran_td: nil,
    sor_td: 18,
    wiz_td: nil,
    mje_td: 18,
    mne_td: 18,
    mjs_td: nil,
    mns_td: 18,
    mnm_td: 18,
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
    other: nil
  },
  messaging: {
    description: [
      "A billowing pillar of searing fire, the firephantom darts about quickly to set aflame any that would stand in its way. Although it has a vaguely humanoid appearance, its form is entirely composed of fire, with the legs a dark red. The darker red slowly gives way to blazing red in the torso and bright yellow in the cranial area. Where the eyes and mouth should be only empty holes exist, floating eerily in the head of this mobile conflagration."
    ],
    arrival: [
      "A firephantom just arrived."
    ],
    flee: [],
    death: [
      "The firephantom slowly settles to the ground and begins to dissipate."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A firephantom swings {weapon} at you!"
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
