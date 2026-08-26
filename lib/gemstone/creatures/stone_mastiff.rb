{
  schema_version: 3,
  name: "stone mastiff",
  noun: "",
  url: "https://gswiki.play.net/stone_mastiff",
  picture: "",
  level: 62,
  family: "Canine",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: nil,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Magical"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 4,
  size: "large",
  areas: [
    {
      name: "Stone Valley",
      uids: [4292001..4292060]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (229..268)
      },
      {
        name: "Claw",
        as: 337
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Charge"
      },
      {
        name: "Leap"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "20N",
    immunities: [],
    melee: (232..294),
    ranged: 221,
    bolt: 221,
    udf: 456,
    bar_td: (206..227),
    cle_td: (236..245),
    emp_td: (236..245),
    pal_td: (198..207),
    ran_td: (201..210),
    sor_td: (247..259),
    wiz_td: nil,
    mje_td: 265,
    mne_td: 260,
    mjs_td: nil,
    mns_td: (233..242),
    mnm_td: 186,
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
    skin: "a stone heart",
    other: nil
  },
  messaging: {
    description: [
      "The stone mastiff is a huge grey dog that seems to be formed of living stone. The mastiff is rectangular in shape, and the length of the mastiff from forechest to rear is around five feet. Massive and heavy boned, with a powerful muscle structure, this stone mastiff presents a formidable foe."
    ],
    arrival: [],
    flee: [
      "A stone mastiff barrels {direction}."
    ],
    death: [
      "The stone mastiff falls to the ground and dies.",
      "The stone mastiff rolls over and dies.",
      "The stone mastiff yelps loudly as she slumps to the ground and licks her wounded right foreleg.",
      "The stone mastiff yelps loudly as he slumps to the ground and licks his wounded left foreleg.",
      "The stone mastiff yelps loudly as he slumps to the ground and licks his wounded right foreleg.",
      "The stone mastiff yelps loudly as she slumps to the ground and licks her wounded left foreleg.",
      "The stone mastiff yelps loudly as he slumps to the ground and licks his wounded left paw.",
      "The stone mastiff yelps loudly as she slumps to the ground and licks her wounded right paw.",
      "The stone mastiff yelps loudly as she slumps to the ground and licks her wounded left paw.",
      "The stone mastiff yelps loudly as he slumps to the ground and licks his wounded right paw."
    ],
    decay: [
      "A stone mastiff crumbles into a pile of rubble."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A stone mastiff tries to bite you!"
    ],
    claw: [
      "A stone mastiff claws at you!"
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
