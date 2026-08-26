{
  schema_version: 3,
  name: "ilvari pixie",
  noun: "",
  url: "https://gswiki.play.net/ilvari_pixie",
  picture: "",
  level: 74,
  family: "Fey",
  type: "Biped",
  undead: false,
  blood: false,
  bones: nil,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Magical"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 3,
  size: "small",
  areas: [
    {
      name: "Red Forest",
      uids: [480231..480245, 17006231..17006245]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Giant bee stinger",
        as: 348
      }
    ],
    bolt_spells: [
      {
        name: "Major Acid (1710)",
        as: 352
      }
    ],
    warding_spells: [
      {
        name: "Pain (711)",
        cs: 339
      }
    ],
    offensive_spells: [
      {
        name: "Elemental Dispel (417)"
      },
      {
        name: "Major Elemental Wave (435)"
      }
    ],
    maneuvers: [
      {
        name: "Point"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "5N",
    immunities: [],
    melee: nil,
    ranged: nil,
    bolt: nil,
    udf: 477,
    bar_td: nil,
    cle_td: (300..307),
    emp_td: (302..308),
    pal_td: (260..268),
    ran_td: nil,
    sor_td: (311..333),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (302..311),
    mnm_td: 236,
    defensive_spells: [
      "Arcane Barrier (1720)",
      "Elemental Defense I (401)",
      "Elemental Defense II (406)",
      "Elemental Defense III (414)",
      "Invisibility (916)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a giant bee stinger",
    "a leafy green tunic"
  ],
  treasure: {
    coins: true,
    magic_items: nil,
    gems: true,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "This smallish humanoid sports a pair of expressive sparkling eyes, lightly tanned skin, and a wide grin from ear to ear. Cute is too kind of a word for this caricature of elven descent. A faintly shimmering golden aura surrounds him."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [
      "The layer of bark on an Ilvari pixie hardens and absorbs the attack!  The bark crackles as it crumbles to dust.",
      "Acid dissolves connecting cartilage, freeing the Ilvari pixie's ribs to move independently.",
      "The layer of bark on an Ilvari pixie hardens and absorbs the magical energy!  The bark crackles as it crumbles to dust.",
      "The Ilvari pixie's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An Ilvari pixie points precisely at you!",
      "An Ilvari pixie thrusts with a giant bee stinger at you!"
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
