{
  schema_version: 3,
  name: "blood eagle",
  noun: "",
  url: "https://gswiki.play.net/blood_eagle",
  picture: "",
  level: 7,
  family: "Bird",
  type: "Avian",
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
  max_hp: 120,
  speed: nil,
  height: 2,
  size: "large",
  areas: [
    {
      name: "The Citadel",
      uids: [2102022..2102049]
    },
    {
      name: "South River Road",
      uids: [2104010..2104016]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: 100
      },
      {
        name: "Bite"
      },
      {
        name: "Pound"
      },
      {
        name: "Ensnare",
        as: 96
      },
      {
        name: "Black fists",
        as: 86
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Carry and drop prey while in flight"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "1N",
    immunities: [],
    melee: 38,
    ranged: 17,
    bolt: 24,
    udf: 71,
    bar_td: nil,
    cle_td: 21,
    emp_td: 21,
    pal_td: (18..21),
    ran_td: nil,
    sor_td: 21,
    wiz_td: nil,
    mje_td: 21,
    mne_td: 21,
    mjs_td: nil,
    mns_td: 21,
    mnm_td: 21,
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
    boxes: nil,
    skin: "a blood red eagle feather",
    other: nil
  },
  messaging: {
    description: [
      "With a body length of nearly 3 feet and a wingspan of 8 feet, the blood eagle is without a doubt the largest eagle you've ever seen. The body is covered with brown and black feathers and its powerful wings raise dust whenever the eagle nears ground. Large black eyes gleam with intelligence and claws sharp enough to rip apart a bear give this creature a distinctively threatening appearance."
    ],
    arrival: [],
    flee: [],
    death: [
      "The blood eagle squawks as it falls back into a heap and dies.",
      "The blood eagle flutters its wings one last time and dies."
    ],
    decay: [
      "A blood eagle decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A night golem tries to ensnare you in blood eagle black arms!",
      "A night golem pounds at you with blood eagle black fists!"
    ],
    bite: [],
    claw: [
      "A blood eagle claws at you!"
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
