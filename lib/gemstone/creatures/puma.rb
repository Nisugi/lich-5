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
        as: 171
      },
      {
        name: "Claw",
        as: 163
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
    udf: 146,
    bar_td: 51,
    cle_td: nil,
    emp_td: (25..33),
    pal_td: 48,
    ran_td: nil,
    sor_td: (39..51),
    wiz_td: nil,
    mje_td: 45,
    mne_td: 45,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
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
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
