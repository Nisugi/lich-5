{
  schema_version: 3,
  name: "roa'ter",
  noun: "",
  url: "https://gswiki.play.net/roa'ter",
  picture: "",
  level: 41,
  family: "Worm",
  type: "Worm",
  undead: false,
  blood: true,
  bones: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 260,
  speed: nil,
  height: 3,
  size: "huge",
  areas: [
    {
      name: "Castle Varunar",
      uids: [4750006..4750029]
    },
    {
      name: "Darkstone Castle",
      uids: [42500..42521]
    },
    {
      name: "Vornavian Coast",
      uids: [4218101..4218121]
    },
    {
      name: "Czeroth Caverns",
      uids: [13007201..13007228]
    },
    {
      name: "The Hive",
      uids: [13041001..13041026]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge",
        as: 244
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Burrow"
      },
      {
        name: "Tail Slam"
      },
      {
        name: "Tail Swipe"
      },
      {
        name: "Charge"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (142..332),
    ranged: (134..169),
    bolt: (134..169),
    udf: 323,
    bar_td: nil,
    cle_td: 142,
    emp_td: (146..149),
    pal_td: nil,
    ran_td: nil,
    sor_td: (151..154),
    wiz_td: nil,
    mje_td: 165,
    mne_td: nil,
    mjs_td: 146,
    mns_td: 146,
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
    coins: nil,
    magic_items: nil,
    gems: true,
    boxes: true,
    skin: "roa'ter skin",
    other: nil
  },
  messaging: {
    description: [
      "This massive worm is probably over twenty to thirty feet long, making it an easy target to hit, but having incomparable force and strength. Dark red in color, it seems to have no eyes, but its keen sense of smell quickly finds targets."
    ],
    arrival: [],
    flee: [
      "A roa'ter slithers {direction}."
    ],
    death: [
      "The roa'ter rolls over and dies."
    ],
    decay: [
      "A roa'ter decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A roa'ter charges at you!"
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
