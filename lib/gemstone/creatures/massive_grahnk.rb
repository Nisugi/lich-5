{
  schema_version: 3,
  name: "massive grahnk",
  noun: "",
  url: "https://gswiki.play.net/massive_grahnk",
  picture: "",
  level: 20,
  family: "Grahnk",
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
  max_hp: 321,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Thurfel's Island",
      uids: [7532001..7532033]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Cudgel"
      },
      {
        name: "Foot",
        as: 151
      },
      {
        name: "Heavy stone club",
        as: 192
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Tackle"
      },
      {
        name: "Pounce"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "17",
    immunities: [],
    melee: (64..124),
    ranged: (38..69),
    bolt: (38..69),
    udf: 168,
    bar_td: (54..60),
    cle_td: 60,
    emp_td: (60..68),
    pal_td: 60,
    ran_td: nil,
    sor_td: (54..63),
    wiz_td: nil,
    mje_td: 60,
    mne_td: 60,
    mjs_td: nil,
    mns_td: 60,
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
      "Taller than a giant, the massive grahnk bears similarities to both a troll and an ogre. The beast has rippling muscles easily capable of tearing an arm or leg from its socket."
    ],
    arrival: [
      "A massive grahnk lumbers in, malice in her eyes!"
    ],
    flee: [
      "A massive grahnk lumbers {direction}, malice in her eyes."
    ],
    death: [
      "A massive grahnk goes limp as she is rendered unconscious!"
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A massive grahnk stomps at you with {pronoun} foot!",
      "A massive grahnk swings {weapon} at you!"
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
