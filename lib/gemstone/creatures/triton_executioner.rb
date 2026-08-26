{
  schema_version: 3,
  name: "triton executioner",
  noun: "",
  url: "https://gswiki.play.net/triton_executioner",
  picture: "",
  level: 96,
  family: "Triton",
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
  max_hp: nil,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Ruined Temple",
      uids: [3031025..3031042, 3031045..3031080]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Handaxe",
        as: (433..445)
      },
      {
        name: "Heavy crossbow"
      },
      {
        name: "longsword",
        as: (433..441)
      },
      {
        name: "Streaked pale driftwood bolt",
        as: 453
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Coup de Grace"
      },
      {
        name: "Cutthroat"
      },
      {
        name: "Drown"
      },
      {
        name: "Sweep"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (342..528),
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: 340,
    cle_td: 379,
    emp_td: (359..368),
    pal_td: (312..321),
    ran_td: nil,
    sor_td: (381..396),
    wiz_td: nil,
    mje_td: (393..408),
    mne_td: nil,
    mjs_td: nil,
    mns_td: 371,
    mnm_td: (294..303),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a coral-hilted sharply tapered longsword",
    "a crested thick leather harness",
    "a navy-banded slate grey targe",
    "a rough ashen heavy crossbow",
    "a sharply curved black handaxe",
    "a short-prodded heavy arbalest",
    "a silver-rimmed black steel buckler",
    "a teardrop-clasped dark leather harness"
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
      "The triton executioner scans his surroundings with merciless eyes as if seeking his next client. Heavy, leathery lips are pulled into a perpetually disgusted sneer, pinching the creature's nostrils into narrow slits. Animal muscles, powerfully knotted beneath his moist blue-green skin, seem ready to spring in any direction. The executioner wears a dark blue tabard emblazoned with a silver wave upon the chest."
    ],
    arrival: [
      "A triton executioner stalks in silently, her cold eyes gleaming with hatred.",
      "A triton executioner strides in, a wary look on her face.",
      "A triton dissembler arrives, striding forth with his robes trailing behind him.",
      "A triton radical strides in, gliding swiftly through the water with a wary look on his face.",
      "A triton executioner stalks in silently, his cold eyes gleaming with hatred.",
      "A triton dissembler arrives, striding forth with her robes trailing behind her.",
      "A triton executioner strides in, a wary look on his face.",
      "A triton executioner strides in, gliding swiftly through the water with a wary look on his face.",
      "A triton executioner just arrived."
    ],
    flee: [],
    death: [
      "The triton executioner gurgles once and goes still, a wrathful look on his face.",
      "The triton executioner gurgles once and goes still, a wrathful look on her face."
    ],
    decay: [
      "The triton executioner's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A triton executioner fires {weapon} at you!",
      "A triton executioner swings {weapon} at you!"
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
