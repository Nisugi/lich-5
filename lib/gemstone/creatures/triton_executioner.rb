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
        as: (433..439)
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
    cle_td: 358,
    emp_td: (359..368),
    pal_td: nil,
    ran_td: nil,
    sor_td: (381..396),
    wiz_td: nil,
    mje_td: (393..408),
    mne_td: nil,
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
  equipment: [],
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
      "A triton executioner strides in, a wary look on his face."
    ],
    flee: [],
    death: [],
    decay: [],
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
