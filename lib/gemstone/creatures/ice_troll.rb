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
    emp_td: (88..98),
    pal_td: nil,
    ran_td: nil,
    sor_td: (101..112),
    wiz_td: nil,
    mje_td: 109,
    mne_td: 104,
    mjs_td: nil,
    mns_td: 94,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
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
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
