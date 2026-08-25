{
  schema_version: 3,
  name: "muscular supplicant",
  noun: "",
  url: "https://gswiki.play.net/muscular_supplicant",
  picture: "",
  level: 67,
  family: "Humanoid",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Temple Wyneb",
      uids: [13300001..13300076, 13300080..13300080]
    },
    {
      name: "unmapped",
      uids: [13300077..13300079]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Flamberge",
        as: (273..342)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "MSTRIKE"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: 246,
    ranged: nil,
    bolt: nil,
    udf: 489,
    bar_td: 238,
    cle_td: 259,
    emp_td: (244..259),
    pal_td: nil,
    ran_td: nil,
    sor_td: (269..272),
    wiz_td: nil,
    mje_td: 285,
    mne_td: 283,
    mjs_td: 259,
    mns_td: 259,
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
    skin: "No",
    other: "Glowing violet essence dust,"
  },
  messaging: {
    description: [
      "Standing somewhere near average height for a human, the muscular supplicant is a lean frame of wiry muscle covered by scarred and dry skin. A great mop of greasy hair covers her eyes, twisted up in long braids. Intricate tattoos cover the exposed flesh, drawing unrecognizable patterns."
    ],
    arrival: [
      "A muscular supplicant just arrived."
    ],
    flee: [],
    death: [
      "A muscular supplicant spasms one last time and then dies.",
      "A muscular supplicant thrashes violently and then dies.",
      "A muscular supplicant goes limp as he is rendered unconscious!",
      "A muscular supplicant dies and collapses to the floor.",
      "A muscular supplicant staggers, then falls to the floor and dies."
    ],
    decay: [
      "A muscular supplicant crumbles to dust and blows away on the wind.",
      "A muscular supplicant suddenly dissolves into a puddle of viscous ooze."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A muscular supplicant swings {weapon} at you!"
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
