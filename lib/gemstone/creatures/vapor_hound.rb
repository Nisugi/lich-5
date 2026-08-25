{
  schema_version: 3,
  name: "vapor hound",
  noun: "",
  url: "https://gswiki.play.net/vapor_hound",
  picture: "",
  level: 24,
  family: "Canine",
  type: "Quadruped",
  undead: true,
  blood: false,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 211,
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
        as: 192
      },
      {
        name: "Claw",
        as: 202
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Breath attack"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: nil,
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: nil,
    cle_td: 99,
    emp_td: (90..101),
    pal_td: nil,
    ran_td: nil,
    sor_td: 104,
    wiz_td: nil,
    mje_td: 106,
    mne_td: 107,
    mjs_td: 101,
    mns_td: 101,
    mnm_td: nil,
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
    skin: "vapor hound tail",
    other: "Essence of air"
  },
  messaging: {
    description: [
      "You have never seen anything quite like a vapor hound, so you are not really sure what to make of it or how dangerous it might be.\n\n;Assess\nThe vapor hound is medium in size and about three feet high in its current state."
    ],
    arrival: [],
    flee: [],
    death: [
      "The vapor hound lets out one last whimpering sigh of chartreuse vapors and dies."
    ],
    decay: [
      "A vapor hound decays into a compost of fur and fangs."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A vapor hound tries to bite you!"
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
