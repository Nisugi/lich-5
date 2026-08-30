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
  muggable: true,
  sleepable: true,
  boss: true,
  boss_type: "pack",
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 275,
  speed: 7,
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
    melee: (138..219),
    ranged: (133..172),
    bolt: (133..172),
    udf: (140..220),
    bar_td: 72,
    cle_td: (68..74),
    emp_td: (73..76),
    pal_td: (66..75),
    ran_td: (66..72),
    sor_td: (79..85),
    wiz_td: nil,
    mje_td: (78..82),
    mne_td: (78..82),
    mjs_td: (76..99),
    mns_td: (76..99),
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
    arrival: [],
    flee: [
      "A giant albino scorpion skitters {direction}."
    ],
    death: [
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
