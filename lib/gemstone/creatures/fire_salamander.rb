{
  schema_version: 3,
  name: "fire salamander",
  noun: "",
  url: "https://gswiki.play.net/fire_salamander",
  picture: "",
  level: 3,
  family: "Amphibian",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Element-based"
  ],
  bcs: true,
  max_hp: 44,
  speed: nil,
  height: 1,
  size: "medium",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4202301..4202320]
    },
    {
      name: "Catacombs",
      uids: [46019..46025, 46028..46032]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 42
      },
      {
        name: "Charge",
        as: 52
      },
      {
        name: "Claw",
        as: 42
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
    melee: (38..59),
    ranged: 55,
    bolt: 35,
    udf: 49,
    bar_td: nil,
    cle_td: 9,
    emp_td: (-23..9),
    pal_td: nil,
    ran_td: nil,
    sor_td: 9,
    wiz_td: nil,
    mje_td: 9,
    mne_td: 9,
    mjs_td: 9,
    mns_td: 9,
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
    gems: nil,
    boxes: nil,
    skin: "a salamander skin",
    other: nil
  },
  messaging: {
    description: [
      "The fire salamander is pale white, with bright red eyes, sharp claws, feathery gill slits and a flickering tongue."
    ],
    arrival: [
      "A fire salamander slithers in!"
    ],
    flee: [],
    death: [
      "The fire salamander hisses one last time and dies."
    ],
    decay: [
      "A fire salamander decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A fire salamander charges at you!"
    ],
    bite: [
      "A fire salamander tries to bite you!"
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
