{
  schema_version: 3,
  name: "silverback orc",
  noun: "",
  url: "https://gswiki.play.net/silverback_orc",
  picture: "",
  level: 14,
  family: "Orc",
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
  max_hp: 170,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "High Plains",
      uids: [4129002..4129021]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Falchion",
        as: (158..163)
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
    asg: "9",
    immunities: [],
    melee: (152..192),
    ranged: nil,
    bolt: nil,
    udf: (108..189),
    bar_td: 48,
    cle_td: (39..42),
    emp_td: (34..42),
    pal_td: (36..39),
    ran_td: nil,
    sor_td: 42,
    wiz_td: nil,
    mje_td: 42,
    mne_td: (42..48),
    mjs_td: nil,
    mns_td: (42..45),
    mnm_td: (36..42),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a falchion",
    "a leather breastplate",
    "a silver falchion"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a silverback orc knuckle",
    other: "Alchemy common"
  },
  messaging: {
    description: [
      "Silver-flecked eyes match the garish silver stripe down the silverback orc's back. It stands a hearty six feet tall, with pale white skin. Were it not for the flecks of blood and bits of tattered flesh sticking to its skin, it mayhaps be attractive. Or perhaps not."
    ],
    arrival: [],
    flee: [
      "A silverback orc runs {direction}."
    ],
    death: [
      "A silverback orc curls up in the snow and dies.",
      "A silverback orc goes limp as he is rendered unconscious!",
      "A silverback orc curls up and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A silverback orc swings {weapon} at you!"
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
