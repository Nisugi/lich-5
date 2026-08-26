{
  schema_version: 3,
  name: "zombie rolton",
  noun: "",
  url: "https://gswiki.play.net/zombie_rolton",
  picture: "",
  level: 1,
  family: "Caprine",
  type: "Quadruped",
  undead: true,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 28,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "The Citadel",
      uids: [2102008..2102020, 2103001..2103007]
    },
    {
      name: "Cairnfang",
      uids: [630100..630105]
    },
    {
      name: "Southern Snowfields",
      uids: [4128056..4128059]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 32
      },
      {
        name: "Claw",
        as: 32
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
    asg: "1N",
    immunities: [],
    melee: 7,
    ranged: 5,
    bolt: 5,
    udf: 42,
    bar_td: nil,
    cle_td: 3,
    emp_td: 3,
    pal_td: 3,
    ran_td: 3,
    sor_td: 3,
    wiz_td: nil,
    mje_td: 3,
    mne_td: 3,
    mjs_td: 3,
    mns_td: 3,
    mnm_td: 3,
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
    skin: "a rotting rolton pelt",
    other: nil
  },
  messaging: {
    description: [
      "An undead version of the domesticated breed, these were one of the earlier attempts by the Council of Twelve to create undead. They litter the countryside, viciously attacking any living thing they see."
    ],
    arrival: [
      "A zombie rolton scampers in."
    ],
    flee: [
      "The rolton scampers {direction}."
    ],
    death: [
      "The zombie rolton falls back into a heap and dies.",
      "The zombie rolton hisses one last time and dies."
    ],
    decay: [
      "A zombie rolton decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [],
    claw: [
      "A zombie rolton claws at you!"
    ],
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
