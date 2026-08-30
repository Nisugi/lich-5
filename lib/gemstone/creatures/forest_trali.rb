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
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 349,
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
        as: (244..274)
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
    melee: (185..337),
    ranged: (187..286),
    bolt: (187..286),
    udf: (238..403),
    bar_td: (132..141),
    cle_td: (142..151),
    emp_td: (144..153),
    pal_td: (126..132),
    ran_td: (123..132),
    sor_td: (153..159),
    wiz_td: nil,
    mje_td: nil,
    mne_td: 168,
    mjs_td: 170,
    mns_td: 170,
    mnm_td: (123..132),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a battered breastplate",
    "a battered shield",
    "a stain-darkened broadsword"
  ],
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
    arrival: [
      "A forest trali arrives, sniffing the air for prey!",
      "A forest trali stalks in."
    ],
    flee: [
      "A forest trali tramps {direction}.",
      "A forest trali limps {direction}."
    ],
    death: [
      "The forest trali twitches violently, then dies."
    ],
    decay: [
      "The forest trali's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A forest trali swings {weapon} at you!"
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
