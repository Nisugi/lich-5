{
  schema_version: 3,
  name: "ridge orc",
  noun: "",
  url: "https://gswiki.play.net/ridge_orc",
  picture: "",
  level: 4,
  family: "Orc",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: true,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 80,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Locksmehr Trail",
      uids: [13000063..13000085]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Handaxe",
        as: (74..84)
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
    asg: "5",
    immunities: [],
    melee: (65..70),
    ranged: 21,
    bolt: (21..23),
    udf: (90..106),
    bar_td: 12,
    cle_td: 12,
    emp_td: 12,
    pal_td: (9..12),
    ran_td: 12,
    sor_td: 12,
    wiz_td: nil,
    mje_td: 12,
    mne_td: 12,
    mjs_td: 12,
    mns_td: 12,
    mnm_td: 12,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a handaxe",
    "some light leather"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "an orc ear",
    other: nil
  },
  messaging: {
    description: [
      "Massive and sullen looking, the ridge orc glares and grimaces at all who dare to approach. Unknown power resides in this horrific-appearing monster."
    ],
    arrival: [],
    flee: [
      "A ridge orc flees {direction}."
    ],
    death: [
      "A ridge orc gives a last gasp and dies."
    ],
    decay: [
      "A ridge orc decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A ridge orc swings {weapon} at you!"
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
