{
  schema_version: 3,
  name: "luminous worm",
  noun: "worm",
  url: "https://gswiki.play.net/luminous_worm",
  picture: "",
  level: 16,
  family: "Worm",
  type: "Worm",
  undead: false,
  blood: true,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 179,
  speed: nil,
  height: 1,
  size: "medium",
  areas: [
    {
      name: "Hornwort Cavern",
      uids: [7131001..7131018]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge (attack)",
        as: 156
      },
      {
        name: "Charge",
        as: (156..162)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (62..98),
    ranged: (62..73),
    bolt: (62..73),
    udf: 106,
    bar_td: nil,
    cle_td: (45..54),
    emp_td: (42..48),
    pal_td: (45..54),
    ran_td: (48..54),
    sor_td: (48..51),
    wiz_td: nil,
    mje_td: 51,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (48..54),
    mnm_td: (42..51),
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [],
    arrival: [
      "A luminous worm slithers into view, its glow illuminating the area."
    ],
    flee: [],
    death: [
      "A luminous worm goes limp as it is rendered unconscious!",
      "A luminous worm slumps to the ground, its glowing form now motionless and dull."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A worm charges at you!"
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
