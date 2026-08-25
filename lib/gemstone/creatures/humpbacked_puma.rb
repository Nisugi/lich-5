{
  schema_version: 3,
  name: "humpbacked puma",
  noun: "",
  url: "https://gswiki.play.net/humpbacked_puma",
  picture: "",
  level: 15,
  family: "Feline",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
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
      name: "Liath Bheinn and Aillidh Brae",
      uids: [4250062..4250067]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite (attack)",
        as: 168
      },
      {
        name: "Claw (attack)",
        as: 168
      },
      {
        name: "Bite",
        as: 148
      },
      {
        name: "Claw",
        as: 142
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Leap"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "1N",
    immunities: [],
    melee: (153..166),
    ranged: 119,
    bolt: 119,
    udf: 197,
    bar_td: nil,
    cle_td: nil,
    emp_td: (25..33),
    pal_td: nil,
    ran_td: nil,
    sor_td: 45,
    wiz_td: nil,
    mje_td: 45,
    mne_td: 45,
    mjs_td: nil,
    mns_td: 45,
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
    skin: "a puma paw",
    other: nil
  },
  messaging: {
    description: [
      "The humpbacked puma is a muscular and athletic animal. Covered with a uniform coat of greyish-brown fur, his long, lithe body is equipped with powerful legs, displaying a proportionately greater difference in the length of the forelegs compared to the extenuated hind legs. The feline's head is topped with rounded ears, and a very long, balancing tail completes the puma's physique."
    ],
    arrival: [
      "A humpbacked puma scampers in!"
    ],
    flee: [
      "A humpbacked puma scampers {direction}."
    ],
    death: [
      "The humpbacked puma lets out a final caterwaul and dies.",
      "The humpbacked puma crumples to the ground and dies.",
      "A humpbacked puma goes limp as he is rendered unconscious!"
    ],
    decay: [
      "A humpbacked puma decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A humpbacked puma tries to bite you!"
    ],
    claw: [
      "A humpbacked puma claws at you!"
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
