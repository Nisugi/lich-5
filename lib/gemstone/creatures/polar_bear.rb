{
  schema_version: 3,
  name: "polar bear",
  noun: "",
  url: "https://gswiki.play.net/polar_bear",
  picture: "",
  level: 44,
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
  max_hp: 400,
  speed: nil,
  height: 5,
  size: "huge",
  areas: [
    {
      name: "Great Mountain Aenatumgana",
      uids: [4561001..4561020, 4561201..4561208]
    },
    {
      name: "Pinefar Forests",
      uids: [4563043..4563055]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (278..319)
      },
      {
        name: "Charge",
        as: 315
      },
      {
        name: "Claw",
        as: 319
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
    asg: nil,
    immunities: [],
    melee: (219..289),
    ranged: 238,
    bolt: 226,
    udf: 315,
    bar_td: 135,
    cle_td: nil,
    emp_td: (148..157),
    pal_td: nil,
    ran_td: nil,
    sor_td: (157..166),
    wiz_td: nil,
    mje_td: 167,
    mne_td: 166,
    mjs_td: 154,
    mns_td: 154,
    mnm_td: 138,
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
    skin: "a polar bear skin",
    other: nil
  },
  messaging: {
    description: [
      "The polar bear is the largest of all bears, weighing in at close to 2000 pounds with an overall body length of around nine feet long. The bear has a distinctive all white coat, triangular profile, long neck, and small ears. The polar bear's nose, lips and all skin under his fur are black. This bear's front paws are very wide for paddling through arctic waters. Heavy fur, dense underfur, and thick layer of insulating fat allow the bear to maintain a normal body temperature when the outside temperature drops far below freezing."
    ],
    arrival: [],
    flee: [],
    death: [
      "The polar bear collapses heavily into a heap on the ground and dies.",
      "The polar bear lets out a blood-curdling roar and dies."
    ],
    decay: [
      "A polar bear decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A polar bear tries to bite you!"
    ],
    claw: [
      "A polar bear claws at you!"
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
