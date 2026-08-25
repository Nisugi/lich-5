{
  schema_version: 3,
  name: "tree viper",
  noun: "",
  url: "https://gswiki.play.net/tree_viper",
  picture: "",
  level: 24,
  family: "Reptilian",
  type: "Ophidian",
  undead: false,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 230,
  speed: nil,
  height: 1,
  size: "medium",
  areas: [
    {
      name: "Karazja Jungle",
      uids: [5006004..5006009, 5006040..5006040]
    },
    {
      name: "Vipershroud",
      uids: [2190001..2190035]
    },
    {
      name: "unmapped",
      uids: [5006010..5006039]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (195..218)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Poisonous spit"
      },
      {
        name: "Spit"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (192..207),
    ranged: nil,
    bolt: 208,
    udf: 196,
    bar_td: nil,
    cle_td: nil,
    emp_td: (57..61),
    pal_td: nil,
    ran_td: nil,
    sor_td: 72,
    wiz_td: nil,
    mje_td: 75,
    mne_td: 72,
    mjs_td: nil,
    mns_td: 72,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "tree viper fang",
    other: nil
  },
  messaging: {
    description: [
      "The tree viper is a striking, brilliant green, complemented by its pale yellow underbelly that is usually only seen when the viper drapes over a tree branch. Much larger than a typical snake, the viper is nearly ten feet long, and it is quite capable of slaying foes as large as a human. The snake's lazy movement belies its ability to strike rapidly when threatened."
    ],
    arrival: [
      "A tree viper slithers in, hissing in warning!",
      "A tree viper slithers in."
    ],
    flee: [
      "A tree viper slithers {direction}.",
      "A tree viper drops from overhead and slithers {direction}."
    ],
    death: [],
    decay: [
      "A tree viper decays into a pile of scales and flesh."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A tree viper fangs glisten as it tries to bite you!"
    ],
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
