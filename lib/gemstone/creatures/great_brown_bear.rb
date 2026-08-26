{
  schema_version: 3,
  name: "great brown bear",
  noun: "",
  url: "https://gswiki.play.net/great_brown_bear",
  picture: "",
  level: 14,
  family: "Bear",
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
  max_hp: 190,
  speed: nil,
  height: 4,
  size: "large",
  areas: [
    {
      name: "Upper Trollfang",
      uids: [14001..14023, 17020..17025, 17101..17118, 17127..17127]
    },
    {
      name: "unmapped",
      uids: [17119..17126]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (189..191)
      },
      {
        name: "Bite",
        as: (182..184)
      },
      {
        name: "Charge (attack)",
        as: 194
      },
      {
        name: "Charge",
        as: 179
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
    asg: "8N",
    immunities: [],
    melee: (91..140),
    ranged: nil,
    bolt: nil,
    udf: 155,
    bar_td: nil,
    cle_td: (39..45),
    emp_td: (42..50),
    pal_td: (39..42),
    ran_td: (39..48),
    sor_td: (39..48),
    wiz_td: nil,
    mje_td: 42,
    mne_td: 42,
    mjs_td: nil,
    mns_td: (39..48),
    mnm_td: 42,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Hides when attacked"
    ]
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
    skin: "a brown bear skin",
    other: nil
  },
  messaging: {
    description: [
      "The great brown bear weighs around 500 pounds and is about eight feet long. This bear is dark brown in color and has a characteristic muscle hump over the shoulders and longer claws on her front paws than on her rear paws."
    ],
    arrival: [
      "A great brown bear lumbers in!"
    ],
    flee: [
      "A great brown bear slowly lumbers {direction}, growling in pain.",
      "A great brown bear lumbers {direction}."
    ],
    death: [
      "The great brown bear collapses heavily into a heap on the ground and dies.",
      "The great brown bear lets out a blood-curdling roar and dies.",
      "A great brown bear goes limp as she is rendered unconscious!",
      "A great brown bear goes limp as he is rendered unconscious!",
      "The great brown bear roars loudly as she slumps to the ground and licks her wounded left foreleg.",
      "The great brown bear roars loudly as he slumps to the ground and licks his wounded right foreleg.",
      "The great brown bear roars loudly as she slumps to the ground and licks her wounded right foreleg.",
      "The great brown bear roars loudly as he slumps to the ground and licks his wounded left foreleg.",
      "The great brown bear roars loudly as he slumps to the ground and licks his wounded right paw.",
      "The great brown bear roars loudly as he slumps to the ground and licks his wounded left paw."
    ],
    decay: [
      "A great brown bear decays into a compost of fangs, fur and claws.",
      "Acid dissolves the knee ligaments.  The great brown bear's tibia passes his femur in a very unpleasant manner!"
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A great brown bear charges at you!"
    ],
    bite: [
      "A great brown bear tries to bite you!"
    ],
    claw: [
      "A great brown bear claws at you!"
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
