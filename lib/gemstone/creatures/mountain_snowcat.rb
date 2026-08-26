{
  schema_version: 3,
  name: "mountain snowcat",
  noun: "",
  url: "https://gswiki.play.net/mountain_snowcat",
  picture: "",
  level: 3,
  family: "Feline",
  type: "Quadruped",
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
  max_hp: 44,
  speed: nil,
  height: 2,
  size: "small",
  areas: [
    {
      name: "Upper Dragonsclaw",
      uids: [2121006..2121013]
    },
    {
      name: "Southern Snowfields",
      uids: [4128024..4128030]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 59
      },
      {
        name: "Claw",
        as: (49..59)
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
    melee: (32..59),
    ranged: 34,
    bolt: 34,
    udf: 67,
    bar_td: nil,
    cle_td: 9,
    emp_td: 9,
    pal_td: (6..9),
    ran_td: 9,
    sor_td: 9,
    wiz_td: nil,
    mje_td: 9,
    mne_td: 9,
    mjs_td: nil,
    mns_td: 9,
    mnm_td: 9,
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
    skin: "a snowcat pelt",
    other: nil
  },
  messaging: {
    description: [
      "With its distinctive markings, the reclusive mountain snowcat is endowed with an almost uncanny ability to blend into the rocky vastness she inhabits. Adapted to living in the rugged mountains, she has large forepaws, short forelimbs, well-developed chest muscles and a long, elegant tail. Smaller than her cousin the snow leopard, the snowcat's fur shows many of the same beautiful combinations of dark spots that mark the snow leopards. Small ears crown the snowcat's head."
    ],
    arrival: [
      "A mountain snowcat scampers in!"
    ],
    flee: [
      "A mountain snowcat scampers {direction}."
    ],
    death: [
      "The mountain snowcat crumples to the ground and dies.",
      "The mountain snowcat lets out a final caterwaul and dies.",
      "The mountain snowcat mewls in pain as he slumps to the ground and licks his wounded left paw.",
      "The mountain snowcat mewls in pain as he slumps to the ground and licks his wounded left foreleg.",
      "The mountain snowcat mewls in pain as she slumps to the ground and licks her wounded left foreleg."
    ],
    decay: [
      "A mountain snowcat decays into a compost of fangs, fur and claws.",
      "The mountain snowcat's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [],
    claw: [
      "A mountain snowcat claws at you!"
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
