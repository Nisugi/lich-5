{
  schema_version: 3,
  name: "mountain lion",
  noun: "",
  url: "https://gswiki.play.net/mountain_lion",
  picture: "",
  level: 18,
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
  max_hp: 160,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Stone Valley",
      uids: [4291001..4291025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (159..165)
      },
      {
        name: "Bite",
        as: 168
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Pounce"
      },
      {
        name: "Leap"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: (122..189),
    ranged: nil,
    bolt: 95,
    udf: 184,
    bar_td: nil,
    cle_td: (54..60),
    emp_td: (54..62),
    pal_td: (48..57),
    ran_td: (51..57),
    sor_td: (48..57),
    wiz_td: nil,
    mje_td: 54,
    mne_td: 54,
    mjs_td: nil,
    mns_td: (54..60),
    mnm_td: (51..57),
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
    skin: "a mountain lion skin",
    other: nil
  },
  messaging: {
    description: [
      "The mountain lion is a muscular and athletic animal. Covered with a uniform coat of reddish-brown fur, her long, lithe body is equipped with powerful legs, displaying a proportionately greater difference in the length of the forelegs compared to the extenuated hind limbs. The feline's head is topped with rounded ears, and a very long, balancing tail completes the lion's physique."
    ],
    arrival: [
      "A mountain lion scampers in!",
      "A mountain lion scampers in, mewling in pain!"
    ],
    flee: [
      "A mountain lion scampers {direction}.",
      "A mountain lion scampers {direction}, mewling in pain."
    ],
    death: [
      "The mountain lion crumples to the ground and dies.",
      "The mountain lion lets out a final caterwaul and dies.",
      "The mountain lion mewls in pain as he slumps to the ground and licks his wounded right foreleg.",
      "The mountain lion mewls in pain as he slumps to the ground and licks his wounded left foreleg.",
      "The mountain lion mewls in pain as she slumps to the ground and licks her wounded left foreleg.",
      "The mountain lion mewls in pain as he slumps to the ground and licks his wounded right paw.",
      "The mountain lion mewls in pain as she slumps to the ground and licks her wounded right foreleg."
    ],
    decay: [
      "A mountain lion decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A mountain lion tries to bite you!"
    ],
    claw: [
      "A mountain lion claws at you!"
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
