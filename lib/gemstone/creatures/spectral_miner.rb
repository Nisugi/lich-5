{
  schema_version: 3,
  name: "spectral miner",
  noun: "",
  url: "https://gswiki.play.net/spectral_miner",
  picture: "",
  level: 40,
  family: "Ghost",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Non-corporeal undead",
    "Boss"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Shadow Valley",
      uids: [389050..389057, 2158001..2158038]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Mining pick",
        as: 311
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
    asg: "7",
    immunities: [],
    melee: (219..225),
    ranged: nil,
    bolt: (152..187),
    udf: 271,
    bar_td: 158,
    cle_td: nil,
    emp_td: (142..151),
    pal_td: nil,
    ran_td: nil,
    sor_td: (143..166),
    wiz_td: 164,
    mje_td: 164,
    mne_td: 163,
    mjs_td: nil,
    mns_td: (142..152),
    mnm_td: (125..135),
    defensive_spells: [
      "Spirit Warding I (101)",
      "Spirit Warding II (107)",
      "Spirit Defense (103)",
      "Spirit Shield (202)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a mining pick",
    "some ragged leather work clothing"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "No"
  },
  messaging: {
    description: [
      "This somewhat orc-like looking humanoid creature is surrounded with an eerie white glow and appears to be transparent. An abundance of excessively wrinkled skin and long bushy grey eyebrows serve to make spectral miner appear ancient."
    ],
    arrival: [
      "A spectral miner just arrived.",
      "A ready spectral miner just arrived."
    ],
    flee: [],
    death: [
      "The spectral miner falls to the ground motionless.",
      "The spectral miner goes still for a moment while its head reshapes."
    ],
    decay: [
      "A spectral miner quickly crumbles into the ground in front of your eyes."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A spectral miner swings {weapon} at you!"
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
