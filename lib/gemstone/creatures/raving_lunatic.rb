{
  schema_version: 3,
  name: "raving lunatic",
  noun: "",
  url: "https://gswiki.play.net/raving_lunatic",
  picture: "",
  level: 77,
  family: "Humanoid",
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
    "Extraplanar",
    "Boss"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "The Rift",
      uids: [4566001..4566055, 4567001..4567055]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Short sword",
        as: 371
      },
      {
        name: "Bite",
        as: 367
      },
      {
        name: "Claw",
        as: 398
      },
      {
        name: "Midnight black spiked whip",
        as: 415
      },
      {
        name: "Twisted kris",
        as: 401
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
    asg: "8N",
    immunities: [],
    melee: (379..499),
    ranged: (276..346),
    bolt: (339..359),
    udf: 579,
    bar_td: 278,
    cle_td: (300..306),
    emp_td: (294..300),
    pal_td: nil,
    ran_td: nil,
    sor_td: (315..326),
    wiz_td: 330,
    mje_td: (330..331),
    mne_td: 330,
    mjs_td: nil,
    mns_td: 317,
    mnm_td: (242..251),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a twisted kris",
    "some tattered rags"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Tiny golden seed"
  },
  messaging: {
    description: [
      "Perhaps driven mad by the shifting world around her, the raving lunatic babbles and chatters to herself, sometimes gleefully, sometimes angrily. A disgustingly corpulent humanoid, her rolls of pink flesh bounce and quiver as the raving lunatic staggers from area to area, not comprehending her surroundings. Clear spittle drools from her open mouth, and her unblinking eyes dart wildly about in unfocused confusion. She is a totally unpredictable foe."
    ],
    arrival: [],
    flee: [],
    death: [
      "A raving lunatic goes limp as he is rendered unconscious!",
      "The raving lunatic twitches violently, then dies."
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the raving lunatic's ribs to move independently.",
      "The raving lunatic's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A raving lunatic swings {weapon} at you!",
      "An raving lunatic swings {weapon} at you!",
      "An raving lunatic throws {weapon} at you!",
      "A raving lunatic throws {weapon} at you!"
    ],
    bite: [
      "A raving lunatic tries to bite you!",
      "An raving lunatic tries to bite you!"
    ],
    claw: [
      "A raving lunatic claws at you!",
      "An raving lunatic claws at you!"
    ],
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
