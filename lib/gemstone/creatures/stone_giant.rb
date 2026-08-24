{
  schema_version: 3,
  name: "stone giant",
  noun: "",
  url: "https://gswiki.play.net/stone_giant",
  picture: "",
  level: 58,
  family: "Giant",
  type: "Biped",
  undead: false,
  blood: true,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 611,
  speed: nil,
  height: 22,
  size: "huge",
  areas: [
    {
      name: "Stone Valley",
      uids: [4291027..4291043, 4291046..4291050, 4291053..4291058, 4292001..4292060]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound",
        as: (324..346)
      },
      {
        name: "Stomp",
        as: (324..346)
      },
      {
        name: "War mattock",
        as: (324..346)
      }
    ],
    bolt_spells: [
      {
        name: "Hurl Boulder (510)",
        as: 334
      }
    ],
    warding_spells: [
      {
        name: "Unbalance (110)",
        cs: (251..263)
      }
    ],
    offensive_spells: [
      {
        name: "Earthen Fury (917)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "20N",
    immunities: [],
    melee: (227..573),
    ranged: (149..222),
    bolt: (149..222),
    udf: 474,
    bar_td: 202,
    cle_td: 219,
    emp_td: 228,
    pal_td: 192,
    ran_td: nil,
    sor_td: (235..241),
    wiz_td: nil,
    mje_td: (240..243),
    mne_td: nil,
    mjs_td: nil,
    mns_td: 216,
    mnm_td: 186,
    defensive_spells: [
      "Natural Colors",
      "Resist Elements",
      "Self Control"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
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
      "Looming high above you, taller than three of the tallest giantmen, this stone giant dominates the surrounding area. The stone giant's skin is a smooth dull grey with mottled brown splotches and its eyes, concealed under a heavy brow, gleam black with hatred."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
