{
  schema_version: 3,
  name: "spectre",
  noun: "",
  url: "https://gswiki.play.net/spectre",
  picture: "",
  level: 14,
  family: "Ghost",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: nil,
  max_hp: 127,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4202161..4202180]
    },
    {
      name: "Wolves' Den",
      uids: [390002..390022, 390025..390048]
    },
    {
      name: "Plains of Bone",
      uids: [14011042..14011054]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Halberd",
        as: 102
      },
      {
        name: "Battle axe",
        as: 102
      },
      {
        name: "Fist",
        as: 102
      }
    ],
    bolt_spells: [
      {
        name: "Minor Shock (901)",
        as: 137
      },
      {
        name: "Major Cold (907)",
        as: 137
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Call Wind (912)"
      }
    ],
    maneuvers: [
      {
        name: "Gas cloud"
      },
      {
        name: "Mystic Gesture"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "17",
    immunities: [],
    melee: (49..156),
    ranged: (49..52),
    bolt: (49..52),
    udf: (72..167),
    bar_td: nil,
    cle_td: 42,
    emp_td: 42,
    pal_td: (39..42),
    ran_td: 42,
    sor_td: 42,
    wiz_td: nil,
    mje_td: 42,
    mne_td: 42,
    mjs_td: nil,
    mns_td: 42,
    mnm_td: 42,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a pitted battle axe",
    "a rusty metal breastplate"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a spectre skin",
    other: "Alchemy (common)"
  },
  messaging: {
    description: [
      "You have never seen anything quite like a spectre, so you are not really sure what to make of it or how dangerous it might be."
    ],
    arrival: [
      "A gnoll ranger wanders in, alertly surveying its surroundings.",
      "A spectre just arrived.",
      "A shadowy spectre just arrived."
    ],
    flee: [
      "A luminous spectre floats {direction}."
    ],
    death: [
      "The spectre falls to the ground motionless.",
      "The shadowy spectre falls to the ground motionless.",
      "The shadowy spectre goes still for a moment while its head reshapes.",
      "The spectre goes still for a moment while its head reshapes."
    ],
    decay: [
      "A spectre turns to dust.",
      "A shadowy spectre turns to dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A spectre gestures at you!",
      "A spectre nods at you!",
      "A spectre pounds at you with {pronoun} fist!",
      "A spectre swings {weapon} at you!"
    ],
    bite: [],
    claw: [],
    info: {
      general: [
        "Also encountered as an unarmed (\"monk\") variant at Plains of Bone, using natural attacks instead of weapons."
      ],
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
