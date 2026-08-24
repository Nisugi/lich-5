{
  schema_version: 3,
  name: "forest trali",
  noun: "",
  url: "https://gswiki.play.net/forest_trali",
  picture: "",
  level: 44,
  family: "Trali",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Gyldemar Forest",
      uids: [13028038..13028080]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Broadsword",
        as: 274
      },
      {
        name: "Dart",
        as: 298
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
    asg: "9",
    immunities: [],
    melee: (220..337),
    ranged: 265,
    bolt: 265,
    udf: 381,
    bar_td: (132..141),
    cle_td: nil,
    emp_td: (144..150),
    pal_td: nil,
    ran_td: nil,
    sor_td: (153..159),
    wiz_td: nil,
    mje_td: nil,
    mne_td: 168,
    mjs_td: nil,
    mns_td: 144,
    mnm_td: nil,
    defensive_spells: [],
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
    skin: "a trali hide",
    other: "Glowing violet essence shard"
  },
  messaging: {
    description: [
      "Standing nearly six feet tall, the man-like forest trali watches adventurers' every move with piercing grey eyes. A short matted, reddish grey mane covers her head and her skin has a greenish grey hue. There is little doubt that the stealthy forest trali can be a formidable opponent when need arises, or when she is hard pressed."
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
