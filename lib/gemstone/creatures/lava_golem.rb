{
  schema_version: 3,
  name: "lava golem",
  noun: "",
  url: "https://gswiki.play.net/lava_golem",
  picture: "",
  level: 56,
  family: "Golem",
  type: "Biped",
  undead: false,
  blood: false,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Magical",
    "Element-based"
  ],
  bcs: true,
  max_hp: 527,
  speed: nil,
  height: 13,
  size: "huge",
  areas: [
    {
      name: "Eye of V'Tull",
      uids: [3060002..3060018, 3061001..3061028]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound (attack)",
        as: 325
      },
      {
        name: "Stomp (attack)",
        as: 320
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
    melee: (205..470),
    ranged: nil,
    bolt: nil,
    udf: 276,
    bar_td: nil,
    cle_td: nil,
    emp_td: 248,
    pal_td: nil,
    ran_td: nil,
    sor_td: (221..233),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: 208,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Immune to Unbalance (110)"
    ]
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: true,
    boxes: nil,
    skin: nil,
    other: "Essence of fire, Crystal core"
  },
  messaging: {
    description: [
      "The lava golem is a mammoth construct of molten red hot rock and white hot eyes. Towering over twelve feet in height, it surely weighs several tons."
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
