{
  schema_version: 3,
  name: "giant albino scorpion",
  noun: "",
  url: "https://gswiki.play.net/giant_albino_scorpion",
  picture: "",
  level: 24,
  family: "Arachnid",
  type: "Arachnid",
  undead: false,
  blood: true,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 229,
  speed: nil,
  height: 1,
  size: "medium",
  areas: [
    {
      name: "Mraent Caverns",
      uids: [13008001..13008040]
    },
    {
      name: "unmapped",
      uids: [13008041..13008041]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pincer (attack)",
        as: 197
      },
      {
        name: "Stinger (attack)",
        as: 207
      },
      {
        name: "Pincer",
        as: 177
      },
      {
        name: "Stinger",
        as: 207
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
    asg: "12N",
    immunities: [],
    melee: (154..219),
    ranged: nil,
    bolt: 146,
    udf: 207,
    bar_td: 72,
    cle_td: (68..74),
    emp_td: (73..76),
    pal_td: nil,
    ran_td: nil,
    sor_td: (79..85),
    wiz_td: nil,
    mje_td: 81,
    mne_td: 82,
    mjs_td: 76,
    mns_td: (76..82),
    mnm_td: 72,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a scorpion stinger",
    other: "No"
  },
  messaging: {
    description: [
      "The scorpion is like any other scorpion in general body structure. This particular variety, however, is about seven feet in length, with potent venom brewing in its cauda. The huge insectoid creature is entirely white, except for its pincers and stinger, which are a light pink. The eyes of the albino scorpion are crimson -- not to mention entirely blind."
    ],
    arrival: [
      "The boulder comes to a sudden stop and rises into the form of a krynch!"
    ],
    flee: [],
    death: [
      "A giant albino scorpion goes limp as it is rendered unconscious!",
      "The albino scorpion twitches violently, then dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A giant albino scorpion snaps at you with {pronoun} pincer!",
      "A giant albino scorpion stabs at you with {pronoun} stinger!"
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
