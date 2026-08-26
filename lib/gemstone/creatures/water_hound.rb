{
  schema_version: 3,
  name: "water hound",
  noun: "",
  url: "https://gswiki.play.net/water_hound",
  picture: "",
  level: 24,
  family: "Canine",
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
  max_hp: 210,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Stormpeak",
      uids: [13150101..13150120]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (182..192)
      },
      {
        name: "Claw",
        as: 202
      },
      {
        name: "Stream of water",
        as: 202
      }
    ],
    bolt_spells: [
      {
        name: "Minor Water (903)",
        as: 171
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: nil,
    ranged: nil,
    bolt: nil,
    udf: 145,
    bar_td: nil,
    cle_td: 74,
    emp_td: 76,
    pal_td: (69..72),
    ran_td: nil,
    sor_td: 79,
    wiz_td: nil,
    mje_td: 81,
    mne_td: 82,
    mjs_td: 76,
    mns_td: 76,
    mnm_td: 72,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Shakes off stuns"
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
    skin: "water hound pelt",
    other: "Essence of water"
  },
  messaging: {
    description: [
      "You have never seen anything quite like a water hound, so you are not really sure what to make of it or how dangerous it might be.\n\n;Assess\nThe water hound is medium in size and about three feet high in its current state."
    ],
    arrival: [
      "A water hound arrives, shaking droplets of water from its slick, blue fur ruff!"
    ],
    flee: [],
    death: [
      "The water hound lets out one last whimpering sigh of water droplets and dies.",
      "A water hound goes limp as it is rendered unconscious!",
      "The water hound yelps loudly as it slumps to the ground and licks its wounded right foreleg.",
      "The water hound yelps loudly as it slumps to the ground and licks its wounded left foreleg.",
      "The water hound yelps loudly as it slumps to the ground and licks its wounded right paw.",
      "The water hound yelps loudly as it slumps to the ground and licks its wounded left paw.",
      "The water hound slumps to the ground."
    ],
    decay: [
      "A water hound decays into a compost of fur and fangs."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A water hound hurls {weapon} at you!"
    ],
    bite: [
      "A water hound tries to bite you!"
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
