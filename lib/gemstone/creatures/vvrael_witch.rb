{
  schema_version: 3,
  name: "vvrael witch",
  noun: "",
  url: "https://gswiki.play.net/vvrael_witch",
  picture: "",
  level: 80,
  family: "Vvrael",
  type: "Biped",
  undead: false,
  blood: false,
  bones: false,
  muggable: nil,
  boss: true,
  otherclass: [
    "Extraplanar",
    "Anti-mana",
    "Boss"
  ],
  bcs: true,
  max_hp: 234,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "The Rift",
      uids: [4566001..4566055]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Minor Acid (904)"
      },
      {
        name: "Chunk of ice",
        as: 349
      },
      {
        name: "Large boulder",
        as: 349
      },
      {
        name: "Midnight black morning star",
        as: 323
      },
      {
        name: "Powerful lightning bolt",
        as: 360
      },
      {
        name: "Stream of fire",
        as: 349
      }
    ],
    warding_spells: [
      {
        name: "Earthen Fury (917)"
      },
      {
        name: "Elemental Dispel (417)"
      },
      {
        name: "Midnight black morning star",
        cs: 352
      }
    ],
    maneuvers: [
      {
        name: "Anti-mana Wave"
      },
      {
        name: "Lash"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "1N",
    immunities: ["magic"],
    melee: (405..602),
    ranged: nil,
    bolt: nil,
    udf: 581,
    bar_td: nil,
    cle_td: nil,
    emp_td: nil,
    pal_td: nil,
    ran_td: nil,
    sor_td: nil,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Elemental Defense I (401)",
      "Elemental Defense II (406)",
      "Elemental Defense III (414)",
      "Elemental Targeting (425)",
      "Elemental Barrier (430)",
      "Elemental Bias (508)",
      "Elemental Focus (513)",
      "Mass Blur (911)"
    ],
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
    gems: nil,
    boxes: nil,
    skin: nil,
    other: "Radiant crimson essence shardTiny golden seed"
  },
  messaging: {
    description: [
      "The Vvrael witch rises from the ground in a pillar of shadow, tall and slim, the outline of her perfect form frayed by a strange atmospheric disturbance. Her face is a vision of beauty. However, darkness fills her features like a secret biding in her glance, lending her visage an indistinct appearance. Her eyes are dark and wide, framed with fringes of long lashes, and in the depths of those expressive wells there flickers highlights of energy. Or perhaps they are coals of hatred waiting to be unearthed. The witch's hands move constantly, her long fingers and elegant nails making constant motions as if they have manic agendas of their own."
    ],
    arrival: [],
    flee: [],
    death: [
      "The Vvrael witch writhes in black agony and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A Vvrael witch gestures gracefully, hurling ebon motes of anti-mana at you!",
      "A Vvrael witch hurls {weapon} at you!",
      "A Vvrael witch swings {weapon} at you!"
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
