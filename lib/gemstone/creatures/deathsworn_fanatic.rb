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
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 270,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Shadow of the Sanctum",
      uids: [4216001..4216049]
    }
  ],
  attack_attributes: {
    physical_attacks: [],
    bolt_spells: [
      {
        name: "Major Fire",
        as: 462
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
      }
    ],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "1",
    immunities: [],
    melee: (414..612),
    ranged: (430..441),
    bolt: nil,
    udf: 618,
    bar_td: 405,
    cle_td: nil,
    emp_td: 440,
    pal_td: nil,
    ran_td: 377,
    sor_td: nil,
    wiz_td: nil,
    mje_td: 427,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
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
