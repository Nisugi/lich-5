{
  schema_version: 3,
  name: "illoke mystic",
  noun: "",
  url: "https://gswiki.play.net/illoke_mystic",
  picture: "",
  level: 62,
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
    "Living"
  ],
  bcs: true,
  max_hp: 600,
  speed: nil,
  height: 22,
  size: "huge",
  areas: [
    {
      name: "Stone Valley",
      uids: [4292001..4292050]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Giant stone hammer",
        as: 341
      },
      {
        name: "Heavy stone hammer",
        as: 255
      },
      {
        name: "Large rock",
        as: 356
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Divine Wrath"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (294..345),
    ranged: nil,
    bolt: nil,
    udf: 392,
    bar_td: (229..234),
    cle_td: (244..251),
    emp_td: (238..246),
    pal_td: (220..225),
    ran_td: (204..211),
    sor_td: (259..269),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (241..252),
    mnm_td: (200..210),
    defensive_spells: [
      "Elemental Defense I (401)",
      "Elemental Defense II (406)",
      "Elemental Defense III (414)",
      "Elemental Targeting (425)",
      "Natural Colors (601)",
      "Resist Elements (602)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a giant stone hammer",
    "a grey stone crescent symbol",
    "a heavy stone hammer",
    "a massive iron shield"
  ],
  treasure: {
    coins: true,
    magic_items: nil,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Glowing violet essence dust"
  },
  messaging: {
    description: [
      "Massive and imposing, the Illoke mystic towers over adventurers. It is more than three times the size of the largest giantman, with smooth grey skin and deep black eyes that glare out from under a heavy brow. The eyes regard potential victims with disdain, as if they were nothing more than an offering to be sacrificed. Chiseled deep into the forehead of the shaman, the symbol of Illoke glows red with power."
    ],
    arrival: [],
    flee: [],
    death: [
      "An Illoke mystic goes limp as he is rendered unconscious!",
      "The Illoke mystic grumbles in pain one last time before lying still.",
      "The Illoke mystic slumps to the ground.",
      "The Illoke mystic shudders one last time before lying still."
    ],
    decay: [
      "An Illoke mystic crumbles into a mound of sand that quickly blows away.",
      "The Illoke mystic's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An Illoke mystic swings {weapon} at you!",
      "An Illoke mystic throws {weapon} at you!"
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
