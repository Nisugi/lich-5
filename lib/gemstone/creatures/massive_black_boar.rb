{
  schema_version: 3,
  name: "massive black boar",
  noun: "",
  url: "https://gswiki.play.net/massive_black_boar",
  picture: "",
  level: 59,
  family: "Suine",
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
  max_hp: 400,
  speed: nil,
  height: 4,
  size: "large",
  areas: [
    {
      name: "Blighted Forest",
      uids: [13020001..13020051]
    },
    {
      name: "Red Forest",
      uids: [480201..480215, 17006201..17006215]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge (attack)",
        as: 335
      },
      {
        name: "Impale (attack)",
        as: 292
      },
      {
        name: "Bite (attack)",
        as: 312
      },
      {
        name: "Bite",
        as: 325
      },
      {
        name: "Charge",
        as: 335
      },
      {
        name: "Tusk",
        as: 325
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Charge"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (202..438),
    ranged: nil,
    bolt: nil,
    udf: 320,
    bar_td: (194..215),
    cle_td: 223,
    emp_td: (208..229),
    pal_td: nil,
    ran_td: (190..202),
    sor_td: (234..246),
    wiz_td: nil,
    mje_td: (253..256),
    mne_td: 246,
    mjs_td: nil,
    mns_td: 220,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a heavy grey tusk",
    other: nil
  },
  messaging: {
    description: [
      "The black boar snorts loudly and scrapes at the ground, peering around with his close-set, bloodshot eyes in hopes of finding something he can gore into a bloody pulp or pound into the earth. His body is covered with coarse, black hair, and dull grey tusks protrude from each side of his gaping mouth. A good ten feet long from dripping snout to curly tail and weighing more than a ton, the black boar moves with surprising speed and dexterity as he bears down, squealing furiously, on his intended prey. The murderous glint in the boar's eyes betrays an intelligence much greater than his mundane kin."
    ],
    arrival: [],
    flee: [
      "A massive black boar crawls {direction}."
    ],
    death: [
      "The black boar lets out a final agonized squeal and dies.",
      "The black boar collapses to the ground, emits a final squeal, and dies."
    ],
    decay: [
      "A massive black boar decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A massive black boar charges at you with {pronoun} tusk!",
      "A massive black boar charges at you!"
    ],
    bite: [
      "A massive black boar tries to bite you!"
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
