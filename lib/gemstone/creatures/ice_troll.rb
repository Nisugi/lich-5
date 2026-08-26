{
  schema_version: 3,
  name: "ice troll",
  noun: "",
  url: "https://gswiki.play.net/ice_troll",
  picture: "",
  level: 29,
  family: "Troll",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Element-based",
    "Boss"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Glatoph",
      uids: [35005..35009, 35026..35040, 35068..35072]
    },
    {
      name: "Ice Plains",
      uids: [7502001..7502010, 7502016..7502021]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Sword",
        as: 228
      },
      {
        name: "Battle-axe",
        as: 205
      },
      {
        name: "Enruned ice-covered battle axe",
        as: 200
      },
      {
        name: "Freezing ball of pure cold",
        as: (179..185)
      }
    ],
    bolt_spells: [
      {
        name: "Major Cold (907)",
        as: 158
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16",
    immunities: [],
    melee: (201..280),
    ranged: nil,
    bolt: 150,
    udf: 191,
    bar_td: (86..91),
    cle_td: nil,
    emp_td: (94..104),
    pal_td: nil,
    ran_td: (81..84),
    sor_td: (101..112),
    wiz_td: nil,
    mje_td: 109,
    mne_td: 104,
    mjs_td: nil,
    mns_td: (94..97),
    mnm_td: (87..90),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a badly torn rusted chain hauberk",
    "a massive icicle",
    "an enruned ice-covered battle axe",
    "an ice club",
    "an ice spear",
    "an ice-covered two-handed sword",
    "an ice-crusted steel chain hauberk"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "an ice troll scalp",
    other: "essence of water, small troll tooth"
  },
  messaging: {
    description: [
      "Glistening in the light, the troll's ice white skin is covered in slush and snow. Seemingly carved from living ice, the ice troll is a stark, imposing creature. Instead of hair, the ice troll has a field of icicles growing from its head and face."
    ],
    arrival: [],
    flee: [],
    death: [
      "The ice troll cries out in cold agony one last time and dies.",
      "An ice troll goes limp as she is rendered unconscious!",
      "The ice troll falls to the ground motionless."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "An ice troll hurls {weapon} at you!",
      "An ice troll swings {weapon} at you!"
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
