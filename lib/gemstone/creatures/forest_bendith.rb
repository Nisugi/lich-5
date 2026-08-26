{
  schema_version: 3,
  name: "forest bendith",
  noun: "",
  url: "https://gswiki.play.net/forest_bendith",
  picture: "",
  level: 40,
  family: "Fey",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 3,
  size: "small",
  areas: [
    {
      name: "Gyldemar Forest",
      uids: [13031001..13031056]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Scimitar",
        as: (230..256)
      },
      {
        name: "Morning star",
        as: (235..256)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Cheapshots#Eyepoke"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (268..290),
    ranged: nil,
    bolt: nil,
    udf: 330,
    bar_td: (136..148),
    cle_td: (149..152),
    emp_td: (152..161),
    pal_td: (127..136),
    ran_td: 130,
    sor_td: (160..166),
    wiz_td: nil,
    mje_td: (168..171),
    mne_td: 167,
    mjs_td: nil,
    mns_td: (152..161),
    mnm_td: (120..129),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Hides when attacked"
    ]
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a braided vine necklace",
    "a morning star",
    "a rusted metal helm",
    "a scimitar",
    "a small cracked wooden shield",
    "a stained leather helm",
    "a warped wooden shield"
  ],
  treasure: {
    coins: true,
    magic_items: nil,
    gems: true,
    boxes: nil,
    skin: nil,
    other: "Glowing violet essence shard"
  },
  messaging: {
    description: [
      "Short and stumpy with pale yellowish skin, the forest bendith is hunched and her body is covered with greenish mosses of varying thickness. Imbedded into the soft flesh of her bulbous head are a pair of watery purple eyes which peer forth with a sense of malignant inquisitiveness. An odor of damp mold and rotting vegetation seems to hang about the diminutive being."
    ],
    arrival: [],
    flee: [],
    death: [
      "A forest bendith goes limp as she is rendered unconscious!",
      "The forest bendith's eyes grow dim as her lifeforce fades away.",
      "Just as you move to cast, the forest bendith grins slightly, and then fades into the thick undergrowth to avoid your spell.",
      "The forest bendith slumps to the ground."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A forest bendith swings {weapon} at you!"
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
