{
  schema_version: 3,
  name: "ethereal triton psionicist",
  noun: "",
  url: "https://gswiki.play.net/ethereal_triton_psionicist",
  picture: "",
  level: 103,
  family: "Triton",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: false,
  boss: true,
  boss_type: "miniboss",
  otherclass: [
    "non-corporeal undead",
    "Boss"
  ],
  bcs: true,
  max_hp: 257,
  speed: 8,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Atoll",
      uids: [7138201..7138218]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Unarmed combat",
        as: "390 UAF"
      }
    ],
    bolt_spells: [
      {
        name: "Telekinesis (1206)",
        as: 365
      },
      {
        name: "Astral Spear (1408)",
        as: 365
      }
    ],
    warding_spells: [
      {
        name: "Thought Lash (1210)",
        cs: 448
      },
      {
        name: "Vertigo (1219)",
        cs: 448
      },
      {
        name: "Mindwipe (1225)",
        cs: 448
      },
      {
        name: "Mana Burst (1414)",
        cs: 457
      },
      {
        name: "Jab",
        cs: 448
      },
      {
        name: "Lash",
        cs: 448
      },
      {
        name: "Claw Curse",
        cs: 460
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Claw Curse"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "11N",
    immunities: [],
    melee: (204..501),
    ranged: (240..363),
    bolt: (240..363),
    udf: 472,
    bar_td: nil,
    cle_td: 463,
    emp_td: (440..447),
    pal_td: "~380",
    ran_td: 415,
    sor_td: "447 to 480",
    wiz_td: nil,
    mje_td: 404,
    mne_td: "485 to 498",
    mjs_td: (348..355),
    mns_td: "435 to 457",
    mnm_td: nil,
    defensive_spells: [
      "Empathic Focus (1109)",
      "Strength of Will (1119)",
      "Intensity (1130)",
      "Iron Skin (1202)",
      "Foresight (1204)",
      "Mindward (1208)",
      "Blink (1215)",
      "Premonition (1220)"
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
      "An ethereal triton psionicist scowls about the area, her unsubstantial bluish skin rippling like waves across the ocean. Her tongue flickers out, pierced by a tiny atoll crab, and barnacles encircle each muscular arm. Sigil-carved shell rings adorn each finger, and a broken ivory trident dangles from an intangible coral belt."
    ],
    arrival: [
      "An ethereal triton psionicist just arrived."
    ],
    flee: [
      "An ethereal triton psionicist heads {direction}."
    ],
    death: [
      "The triton psionicist fades into transparency, her remnants rapidly dissolving into the air."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "An triton psionicist points a clawed finger toward you!",
      "An ethereal triton psionicist points a clawed finger toward you!"
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
