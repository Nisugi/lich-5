{
  schema_version: 3,
  name: "deathsworn fanatic",
  noun: "",
  url: "https://gswiki.play.net/deathsworn_fanatic",
  picture: "",
  level: 98,
  family: "Humanoid",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 270,
  speed: 8,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Shadow of the Sanctum",
      uids: [4216001..4216049]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Major Fire",
        as: 462
      },
      {
        name: "Bronze cutlass",
        as: 549
      },
      {
        name: "Ensnare",
        as: 413
      },
      {
        name: "Heel of his hand",
        as: 420
      },
      {
        name: "Strike",
        as: 459
      }
    ],
    warding_spells: [
      {
        name: "Finger (Pestilence?)",
        cs: 431
      },
      {
        name: "Corrupt Essence (703)"
      },
      {
        name: "Dark Catalyst (719)"
      },
      {
        name: "Ensnare",
        cs: 443
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Disarm"
      },
      {
        name: "Strike"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "1",
    immunities: [],
    melee: (402..612),
    ranged: (371..446),
    bolt: (371..446),
    udf: (447..618),
    bar_td: 405,
    cle_td: 451,
    emp_td: (440..443),
    pal_td: 392,
    ran_td: (352..377),
    sor_td: (452..455),
    wiz_td: nil,
    mje_td: (466..476),
    mne_td: (466..476),
    mjs_td: 453,
    mns_td: 453,
    mnm_td: 364,
    defensive_spells: [
      "Cloak of Shadows",
      "Elemental Defense I",
      "Elemental Defense II",
      "Elemental Defense III",
      "Spirit Shield",
      "Spirit Warding I",
      "Spirit Warding II",
      "Elemental Targeting",
      "Elemental Barrier"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: "Summon shambling lurks",
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a copper serpent necklace",
    "some stained emerald robes"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "Clad in emerald robes of lush velvet that are stitched with tiny scales of clacking bronze, the fanatic is nearly fleshless, his reserves of fat and muscle burned away by a long war with madness. He has, judging from the stink of body odor and filth about him, not washed in weeks, and his gaze is as inconstant as the quickfire succession of random emotions that play across his tanned face."
    ],
    arrival: [
      "A deathsworn fanatic just arrived."
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A deathsworn fanatic jabs a trembling finger at you!",
      "A deathsworn fanatic tries to ensnare you!",
      "Deathsworn fanatic face twisting with mad rage, a deathsworn fanatic swings at you!",
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
