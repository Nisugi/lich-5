{
  schema_version: 3,
  name: "sheruvian initiate",
  noun: "",
  url: "https://gswiki.play.net/sheruvian_initiate",
  picture: "",
  level: 37,
  family: "Humanoid",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 278,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "The Broken Lands",
      uids: [487010..487014, 487016..487016, 487018..487025, 487027..487031, 487034..487041, 487043..487052, 487054..487054, 487056..487058, 487067..487075]
    },
    {
      name: "unmapped",
      uids: [487015..487015, 487017..487017, 487042..487042, 487053..487053, 487055..487055, 487076..487076]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Jeddart-axe",
        as: 230
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Healing"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (242..319),
    ranged: nil,
    bolt: (188..234),
    udf: 259,
    bar_td: 127,
    cle_td: nil,
    emp_td: (140..190),
    pal_td: nil,
    ran_td: nil,
    sor_td: 146,
    wiz_td: nil,
    mje_td: 153,
    mne_td: nil,
    mjs_td: 155,
    mns_td: 140,
    mnm_td: 111,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "No",
    other: nil
  },
  messaging: {
    description: [
      "The Sheruvian initiate is much as a monk of the same order, a foul spawn of inhuman parents with a head shaved smooth and covered in dark, mystic runes though fewer and less elaborate. What they appear to lack in intelligence, they make up for in belligerence."
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
