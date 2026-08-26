{
  schema_version: 3,
  name: "puma",
  noun: "",
  url: "https://gswiki.play.net/puma",
  picture: "",
  level: 15,
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
  max_hp: 140,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4202182..4202199]
    },
    {
      name: "Lysierian Hills",
      uids: [92079..92081, 92095..92099, 93045..93056]
    },
    {
      name: "Noralgar Forest",
      uids: [4286004..4286014, 4286019..4286023, 4286046..4286067]
    },
    {
      name: "Northern Slopes of Wehntoph",
      uids: [4302013..4302035]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (156..171)
      },
      {
        name: "Claw",
        as: (160..163)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Pounce"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: (148..151),
    ranged: (81..100),
    bolt: 85,
    udf: (112..146),
    bar_td: 51,
    cle_td: (42..51),
    emp_td: (45..53),
    pal_td: (39..48),
    ran_td: (45..51),
    sor_td: (39..51),
    wiz_td: nil,
    mje_td: 45,
    mne_td: 45,
    mjs_td: nil,
    mns_td: (39..48),
    mnm_td: (42..51),
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
    skin: "a puma hide",
    other: nil
  },
  messaging: {
    description: [
      "The puma is a muscular and athletic animal. Covered with a uniform coat of greyish-brown fur, her long, lithe body is equipped with powerful legs, displaying a proportionately greater difference in the length of the forelegs compared to the extenuated hind limbs. The feline's head is topped with rounded ears, and a very long, balancing tail completes the puma's physique."
    ],
    arrival: [
      "A puma scampers in!"
    ],
    flee: [
      "A puma scampers {direction}.",
      "A puma scampers {direction}, mewling in pain."
    ],
    death: [
      "The puma lets out a final caterwaul and dies.",
      "The puma crumples to the ground and dies.",
      "The puma mewls in pain as he slumps to the ground and licks his wounded left foreleg.",
      "The puma mewls in pain as she slumps to the ground and licks her wounded left foreleg.",
      "The puma mewls in pain as he slumps to the ground and licks his wounded right foreleg.",
      "The puma mewls in pain as she slumps to the ground and licks her wounded left paw.",
      "The puma mewls in pain as he slumps to the ground and licks his wounded right paw.",
      "The puma mewls in pain as she slumps to the ground and licks her wounded right foreleg.",
      "The puma mewls in pain as he slumps to the ground and licks his wounded left paw.",
      "The puma mewls in pain as she slumps to the ground and licks her wounded right paw."
    ],
    decay: [
      "A puma decays into a compost of fangs, fur and claws.",
      "The puma's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A puma tries to bite you!"
    ],
    claw: [
      "A puma claws at you!"
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
