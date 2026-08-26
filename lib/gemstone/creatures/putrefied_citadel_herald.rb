{
  schema_version: 3,
  name: "putrefied citadel herald",
  noun: "",
  url: "https://gswiki.play.net/putrefied_citadel_herald",
  picture: "",
  level: 60,
  family: "Humanoid",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "corporeal undead"
  ],
  bcs: true,
  max_hp: 241,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "The Citadel",
      uids: [377013..377015, 377027..377030, 377301..377314, 377320..377344]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Runestaff",
        as: (277..302)
      }
    ],
    bolt_spells: [
      {
        name: "Fire Spirit (111)",
        as: (298..318)
      },
      {
        name: "Web Bolt (118)",
        as: 290
      }
    ],
    warding_spells: [
      {
        name: "Bind (214)",
        cs: (273..279)
      },
      {
        name: "Interference (212)"
      },
      {
        name: "Searing Light (135)",
        cs: 270
      },
      {
        name: "Silence (210)",
        cs: 273
      },
      {
        name: "Unbalance (110)"
      },
      {
        name: "Wither (1115)",
        cs: 285
      },
      {
        name: "Divine Wrath (335)",
        cs: 273
      }
    ],
    offensive_spells: [
      {
        name: "Spirit Strike (117)"
      },
      {
        name: "Web (118)"
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
    asg: "2",
    immunities: [],
    melee: (279..472),
    ranged: 279,
    bolt: 239,
    udf: 486,
    bar_td: 232,
    cle_td: (279..288),
    emp_td: (268..276),
    pal_td: (231..236),
    ran_td: nil,
    sor_td: (268..280),
    wiz_td: nil,
    mje_td: 296,
    mne_td: 283,
    mjs_td: nil,
    mns_td: (267..276),
    mnm_td: 212,
    defensive_spells: [
      "Fasthr's Reward (115)",
      "Lesser Shroud (120)",
      "Prayer of Protection (303)",
      "Spirit Shield (202)"
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "Maggots crawl and writhe in the eye sockets of a putrefied Citadel herald. Replete in immaculate costume, the herald stands stiffly with an expression of disdain on her withered face of grey putrified skin. A large signet ring graces one of her two large wrinkled hands patiently folded one over the other. A polished, leather scroll case hangs at the herald's side, embossed with a large letter \"E.\""
    ],
    arrival: [
      "A putrefied Citadel herald strides in confidently.",
      "A rotting Citadel arbalester strides into the room, her crossbow cradled in the crook of an arm.",
      "A rotting Citadel arbalester strides into the room, his crossbow cradled in the crook of an arm.",
      "A rotting Citadel arbalester strides into the area, his crossbow cradled in the crook of an arm.",
      "A rotting Citadel arbalester strides into the area, her crossbow cradled in the crook of an arm."
    ],
    flee: [],
    death: [
      "A putrefied Citadel herald collapses in upon herself, leaving behind a pile of dust.",
      "A putrefied Citadel herald collapses in upon himself, leaving behind a pile of dust."
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the Citadel herald's ribs to move independently.",
      "The Citadel herald's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A putrefied Citadel herald decisively points at you!",
      "A putrefied Citadel herald swings {weapon} at you!"
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
