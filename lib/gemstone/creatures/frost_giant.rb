{
  schema_version: 3,
  name: "frost giant",
  noun: "",
  url: "https://gswiki.play.net/frost_giant",
  picture: "",
  level: 38,
  family: "Giant",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Element-based"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 15,
  size: "huge",
  areas: [
    {
      name: "Glatoph",
      uids: [35026..35030, 35068..35072, 2153002..2153031]
    },
    {
      name: "Icemule Trail",
      uids: [4044001..4044019, 4044121..4044130]
    },
    {
      name: "Sleeping Lady Mountains",
      uids: [4560001..4560019]
    },
    {
      name: "Ice Plains",
      uids: [7502011..7502021]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "War hammer"
      },
      {
        name: "Battle axe",
        as: 251
      },
      {
        name: "Freezing ball of pure cold",
        as: 204
      },
      {
        name: "Frost-covered battle-axe",
        as: 244
      },
      {
        name: "Morning star",
        as: 216
      }
    ],
    bolt_spells: [
      {
        name: "Major Cold (907)",
        as: (177..222)
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Stomp"
      }
    ],
    special_abilities: [
      {
        name: "AS Boost"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (230..287),
    ranged: 187,
    bolt: 201,
    udf: 329,
    bar_td: 109,
    cle_td: (130..137),
    emp_td: (135..138),
    pal_td: (111..121),
    ran_td: (111..121),
    sor_td: (134..151),
    wiz_td: nil,
    mje_td: (145..151),
    mne_td: 145,
    mjs_td: nil,
    mns_td: (129..138),
    mnm_td: (117..126),
    defensive_spells: [
      "Spirit Defense (103)",
      "Spirit Warding I (101)",
      "Spirit Warding II (107)"
    ],
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
    skin: "a giant toe",
    other: nil
  },
  messaging: {
    description: [
      "Standing more than twice as tall as the tallest giantman, the frost giant trails frost and snow in his wake. Seemingly carved from living ice and snow, icy blue eyes set beneath a heavily furrowed brow and a tangled mop of icy blue hair provide a splash of color against the frost giant's dull white frost-covered skin."
    ],
    arrival: [
      "A frost giant lumbers in, followed by a swirling snowstorm!"
    ],
    flee: [
      "A frost giant lumbers {direction}, followed by a swirling snowstorm."
    ],
    death: [
      "The frost giant cries out in cold agony one last time and dies.",
      "A frost giant goes limp as he is rendered unconscious!",
      "The frost giant falls to the ground motionless.",
      "A frost giant goes limp as she is rendered unconscious!"
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A frost giant hurls {weapon} at you!",
      "A frost giant points an icy finger at you!",
      "A frost giant swings {weapon} at you!"
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
