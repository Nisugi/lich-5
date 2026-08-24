{
  schema_version: 3,
  name: "great boar",
  noun: "",
  url: "https://gswiki.play.net/great_boar",
  picture: "",
  level: 10,
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
  max_hp: 100,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4202182..4202199]
    },
    {
      name: "Yander's Farm",
      uids: [14005054..14005066]
    },
    {
      name: "Lysierian Hills",
      uids: [92002..92018]
    },
    {
      name: "Slope",
      uids: [395002..395015]
    },
    {
      name: "Locksmehr Trail",
      uids: [13000002..13000047]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge",
        as: 148
      },
      {
        name: "Bite",
        as: 138
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Charge"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "1N",
    immunities: [],
    melee: (41..79),
    ranged: (17..29),
    bolt: (17..29),
    udf: 113,
    bar_td: 30,
    cle_td: nil,
    emp_td: (5..30),
    pal_td: nil,
    ran_td: 30,
    sor_td: 30,
    wiz_td: nil,
    mje_td: 30,
    mne_td: 30,
    mjs_td: nil,
    mns_td: 30,
    mnm_td: nil,
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
  treasure: {
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a boar tusk",
    other: nil
  },
  messaging: {
    description: [
      "The great boar snorts loudly and scrapes at the ground, peering around with his close-set, bloodshot eyes in hopes of finding something he can gore into a bloody pulp or pound into the earth. His body is covered with coarse, mottled, grey-brown hair, and gleaming tusks protrude from each side of his gaping mouth. A good six feet long from dripping snout to curly tail and weighing more than a quarter ton, the great boar moves with surprising speed and dexterity as he bears down, squealing furiously, on his intended prey. This is one mean brute."
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
