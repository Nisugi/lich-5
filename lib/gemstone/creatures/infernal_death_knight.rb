{
  schema_version: 3,
  name: "infernal death knight",
  noun: "",
  url: "https://gswiki.play.net/infernal_death_knight",
  picture: "",
  level: 104,
  family: "Humanoid",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: false,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 500,
  speed: nil,
  height: 7,
  size: "medium",
  areas: [
    {
      name: "Moonsedge",
      uids: [4577001..4577028, 4577051..4577058, 4577106..4577123, 4577201..4577214, 4577216..4577249]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Trio of blue-black diamonds",
        as: (610..645)
      },
      {
        name: "Bite",
        as: 520
      },
      {
        name: "Charge",
        as: 565
      },
      {
        name: "Kick",
        as: 520
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Corrupt Essence",
        cs: 452
      },
      {
        name: "Disarm",
        cs: 459
      },
      {
        name: "Massive black ora sword adorned with a trio of blue-black diamonds",
        cs: 456
      }
    ],
    offensive_spells: [
      {
        name: "Elemental Wave"
      }
    ],
    maneuvers: [
      {
        name: "Spell Cleave"
      },
      {
        name: "Disarm"
      },
      {
        name: "Pounce"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "19",
    immunities: [],
    melee: (369..632),
    ranged: (353..463),
    bolt: (353..463),
    udf: (409..715),
    bar_td: 426,
    cle_td: (417..426),
    emp_td: 411,
    pal_td: (365..408),
    ran_td: (503..506),
    sor_td: 425,
    wiz_td: nil,
    mje_td: (342..350),
    mne_td: (342..350),
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a massive black ora sword adorned with a trio of blue-black diamonds",
    "some darkly blued steel half-plate"
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
      "Judging from her height, the death knight is a mummified remnant of a powerful warrior, though the flesh has mostly come free from her animated bones. Now, her heavy armor is all that holds her skeletal form together. Her neck ends in a jagged ruin, but over the shattered fragments of her spine hovers a bleached skull that is wreathed in azure flames. Fires burn malevolently in the skull's empty sockets.\n\nAppraisal:\nThe death knight is medium in size and about seven feet high in her current state."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [
      "Groans and cracks emanate from an infernal death knight's armor as it suddenly succumbs to metal fatigue.  Within seconds, his skeletal form collapses into blanched powder and blows away.",
      "Groans and cracks emanate from an infernal death knight's armor as it suddenly succumbs to metal fatigue.  Within seconds, her skeletal form collapses into blanched powder and blows away.",
      "Maggots and buzzing flies burst from a cadaverous tatterdemalion ghast's flesh as her skin peels and crumbles.  The scavenging insects rapidly consume the remains, leaving little but brittle bones.",
      "Maggots and buzzing flies burst from a cadaverous tatterdemalion ghast's flesh as his skin peels and crumbles.  The scavenging insects rapidly consume the remains, leaving little but brittle bones."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "Tightening {pronoun} grip on {pronoun} black ora sword, an infernal death knight strikes out at you with all of infernal death knight might!",
      "With effortless ease born of martial training, an infernal death knight swings {weapon} at you!",
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
