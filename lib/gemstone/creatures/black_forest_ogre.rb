{
  schema_version: 3,
  name: "black forest ogre",
  noun: "",
  url: "https://gswiki.play.net/black_forest_ogre",
  picture: "",
  level: 60,
  family: "ogre",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 10,
  size: "large",
  areas: [
    {
      name: "Blighted Forest",
      uids: [13020001..13020051, 13020100..13020114]
    },
    {
      name: "Aradhul Road",
      uids: [17005003..17005006, 17005015..17005023, 17005027..17005035]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "DharaDhara (Rogues)",
        as: 340
      },
      {
        name: "Closed fistClosed fist (Wizards)",
        as: 294
      },
      {
        name: "Closed fist",
        as: 273
      },
      {
        name: "Rust-covered dhara",
        as: 336
      }
    ],
    bolt_spells: [
      {
        name: "Hand of Tonis (505)",
        as: 379
      },
      {
        name: "Minor Acid (904)",
        as: 379
      },
      {
        name: "Minor Fire (906)",
        as: 379
      },
      {
        name: "Major Cold (907)",
        as: 379
      }
    ],
    warding_spells: [
      {
        name: "Cold Snap (512)",
        cs: 222
      }
    ],
    offensive_spells: [
      {
        name: "Elemental Dispel (417)"
      },
      {
        name: "Tremors (909)"
      },
      {
        name: "Call Wind (912)"
      },
      {
        name: "Elemental Focus (513)"
      },
      {
        name: "Elemental Targeting (425)"
      }
    ],
    maneuvers: [
      {
        name: "Cheapshots"
      },
      {
        name: "Swiftkick"
      },
      {
        name: "Stomp"
      }
    ],
    special_abilities: [
      {
        name: "Familiar Gate (930)"
      },
      {
        name: "Foam"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (230..382),
    ranged: nil,
    bolt: 229,
    udf: 322,
    bar_td: 205,
    cle_td: 219,
    emp_td: 231,
    pal_td: nil,
    ran_td: (179..193),
    sor_td: "231 to 234",
    wiz_td: 246,
    mje_td: 247,
    mne_td: 246,
    mjs_td: 219,
    mns_td: 219,
    mnm_td: nil,
    defensive_spells: [
      "Elemental Defense I",
      "Elemental Defense II",
      "Elemental Defense III",
      "Elemental Barrier",
      "Thurfel's Ward",
      "Prismatic Guard",
      "Mass Blur",
      "Wizard's Shield"
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
    skin: "no",
    other: "Glowing violet essence shard"
  },
  messaging: {
    description: [
      "A black forest ogre plods through the countryside, her immense arm and leg muscles rippling with each wide step. An oversized, slavering lower jaw and two long, pointed, lower teeth give the ogre a constant toothy sneer. The thick bones of her protruding forehead shade beady black eyes, and if there is any intelligence in those eyes, it is completely obscured by the black forest ogre's vicious malevolence. Short, coal black hair covers the creature's body and appendages, though in many places the hair is broken by long, deep scars."
    ],
    arrival: [
      "A rippling in the shadows heralds the arrival of a black forest ogre!",
      "A black forest ogre lumbers in, growling.",
      "A black forest ogre lumbers in, muttering to herself.",
      "A ghastly black forest ogre lumbers in, growling."
    ],
    flee: [
      "A black forest ogre lumbers {direction}, growling.",
      "A black forest ogre lumbers {direction}, a grimace on her face.",
      "A black forest ogre lumbers {direction}, a grimace on his face.",
      "A black forest ogre lumbers {direction}, muttering to himself.",
      "A ghastly black forest ogre lumbers {direction}, muttering to himself."
    ],
    death: [
      "A black forest ogre twitches one last time and dies.",
      "A black forest ogre falls prone to the ground, twitches one last time and dies.",
      "The light in a black forest ogre's eyes goes out as she collapses and finally dies.",
      "The light in a black forest ogre's eyes goes out and she finally dies.",
      "The light in a black forest ogre's eyes goes out as he collapses and finally dies.",
      "The light in a black forest ogre's eyes goes out and he finally dies.",
      "A ghastly black forest ogre twitches one last time and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A black forest ogre swings {weapon} at you!",
      "A black forest ogre throws {weapon} at you!",
      "A black forest ogre waves {pronoun} elongated, clawed hands at you!"
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
