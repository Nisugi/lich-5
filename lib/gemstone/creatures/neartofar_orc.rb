{
  schema_version: 3,
  name: "neartofar orc",
  noun: "",
  url: "https://gswiki.play.net/neartofar_orc",
  picture: "",
  level: 11,
  family: "Orc",
  type: "Biped",
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
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Neartofar Forest",
      uids: [14015001..14015020]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Morning star",
        as: (149..159)
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
    asg: "12",
    immunities: [],
    melee: (82..163),
    ranged: (55..74),
    bolt: (55..74),
    udf: 165,
    bar_td: (30..33),
    cle_td: (30..39),
    emp_td: (33..41),
    pal_td: nil,
    ran_td: 33,
    sor_td: (33..39),
    wiz_td: nil,
    mje_td: (33..36),
    mne_td: (30..33),
    mjs_td: nil,
    mns_td: (30..39),
    mnm_td: (27..36),
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "an orc knuckle",
    other: nil
  },
  messaging: {
    description: [
      "Taller than a common human and of a substantially heavier build, the Neartofar orc has a build of solid bone and gristle. Piercing, yellow eyes glare angrily out from under a thick ridge of bone on his forehead. Irregular clumps of rank hair litter his oddly striking brown and green hued-body from head to toe. His arms resemble thick and twisted tree trunks, ending in ragged claws crusted with dried gore."
    ],
    arrival: [
      "A Neartofar orc stalks in purposefully, her nose raised as she sniffs at the air.",
      "A Neartofar orc stalks in purposefully, his nose raised as he sniffs at the air.",
      "A Neartofar orc stalks in!"
    ],
    flee: [
      "A Neartofar orc stalks {direction}."
    ],
    death: [
      "A Neartofar orc breathes her last gasp and dies.",
      "A Neartofar orc breathes his last gasp and dies.",
      "A Neartofar orc goes limp as he is rendered unconscious!"
    ],
    decay: [
      "A Neartofar orc collapses into a pile of dust.",
      "Acid dissolves the knee ligaments.  The Neartofar orc's tibia passes her femur in a very unpleasant manner!"
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A Neartofar orc swings {weapon} at you!"
    ],
    bite: [],
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
