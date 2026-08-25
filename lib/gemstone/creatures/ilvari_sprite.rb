{
  schema_version: 3,
  name: "ilvari sprite",
  noun: "",
  url: "https://gswiki.play.net/ilvari_sprite",
  picture: "",
  level: 72,
  family: "Fey",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: nil,
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
    physical_attacks: [],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Bone Shatter (1106)",
        cs: (306..315)
      },
      {
        name: "Repel (Fear)",
        cs: (306..315)
      },
      {
        name: "Wither (1115)",
        cs: (306..315)
      },
      {
        name: "Sympathy (1120)"
      }
    ],
    offensive_spells: [
      {
        name: "Spirit Dispel (119)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "5N",
    immunities: [],
    melee: (401..440),
    ranged: 360,
    bolt: 340,
    udf: 462,
    bar_td: nil,
    cle_td: nil,
    emp_td: (294..303),
    pal_td: nil,
    ran_td: nil,
    sor_td: (300..315),
    wiz_td: nil,
    mje_td: 328,
    mne_td: (326..338),
    mjs_td: nil,
    mns_td: 306,
    mnm_td: nil,
    defensive_spells: [
      "Lesser Shroud (120)",
      "Spirit Warding I (101)",
      "Spirit Warding II (107)",
      "Wall of Force (140)"
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The subtle hourglass figure of this tiny offshoot of an elven female is all you can see due to a strange silvery aura covering her. Her face is the exception, for it shows through as a near picture perfect model of beauty. The only spoiler in the package is the strange look of madness in her shimmering silver eyes."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [
      "The layer of bark on an Ilvari sprite hardens and absorbs the attack!  The bark crackles as it crumbles to dust.",
      "The layer of bark on an Ilvari sprite hardens and absorbs the magical energy!  The bark crackles as it crumbles to dust.",
      "The Ilvari sprite's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [],
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
