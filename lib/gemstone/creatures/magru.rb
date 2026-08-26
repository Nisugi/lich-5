{
  schema_version: 3,
  name: "magru",
  noun: "",
  url: "https://gswiki.play.net/magru",
  picture: "",
  level: 37,
  family: "Globoid",
  type: "Globoid",
  undead: false,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: nil,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "The Broken Lands",
      uids: [94002..94019]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound",
        as: 210
      },
      {
        name: "Fist",
        as: 260
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Stream of Fluid"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [
      "Fire"
    ],
    melee: nil,
    ranged: (107..119),
    bolt: (107..119),
    udf: nil,
    bar_td: nil,
    cle_td: nil,
    emp_td: 130,
    pal_td: nil,
    ran_td: nil,
    sor_td: 136,
    wiz_td: nil,
    mje_td: 143,
    mne_td: nil,
    mjs_td: nil,
    mns_td: 130,
    mnm_td: 111,
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
    coins: nil,
    magic_items: nil,
    gems: true,
    boxes: nil,
    skin: "No",
    other: nil
  },
  messaging: {
    description: [
      "The magru appears to be a huge, gelatinous red lump that pulses, swelling and shrinking slightly with a hypnotic rhythm. Its skin glistens with a dark, disgusting ooze."
    ],
    arrival: [
      "A magru just arrived."
    ],
    flee: [],
    death: [],
    decay: [
      "The magru collapses into a heap of quivering jelly."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A magru pounds at you with {pronoun} fist!"
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
