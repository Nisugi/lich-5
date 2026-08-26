{
  schema_version: 3,
  name: "lava troll",
  noun: "",
  url: "https://gswiki.play.net/lava_troll",
  picture: "",
  level: 34,
  family: "Troll",
  type: "Biped",
  undead: false,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Element-based",
    "Boss"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 11,
  size: "huge",
  areas: [
    {
      name: "Volcanic Flats",
      uids: [3023001..3023017]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Maul",
        as: 215
      },
      {
        name: "Warsword",
        as: 215
      },
      {
        name: "Leather-wound ruddy steel sledgehammer",
        as: 215
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
    asg: "6N",
    immunities: [],
    melee: 118,
    ranged: 148,
    bolt: 136,
    udf: 260,
    bar_td: (105..111),
    cle_td: nil,
    emp_td: (111..120),
    pal_td: nil,
    ran_td: nil,
    sor_td: (123..132),
    wiz_td: nil,
    mje_td: 129,
    mne_td: 129,
    mjs_td: nil,
    mns_td: (117..126),
    mnm_td: (102..111),
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
    skin: "a troll eye",
    other: nil
  },
  messaging: {
    description: [
      "Easily twice as large as the largest giantman, this brutish creature glares with coal black eyes. The lava troll has reddened, blistered skin and soot-black hair. Steam pours from her ears when she bares her blackened fangs."
    ],
    arrival: [],
    flee: [
      "A lava troll crawls {direction}."
    ],
    death: [
      "A lava troll goes limp as she is rendered unconscious!"
    ],
    decay: [
      "A lava troll burns down to a husk, that crumbles to ash."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A lava troll swings {weapon} at you!"
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
