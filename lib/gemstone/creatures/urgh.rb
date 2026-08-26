{
  schema_version: 3,
  name: "urgh",
  noun: "",
  url: "https://gswiki.play.net/urgh",
  picture: "",
  level: 4,
  family: "Suine",
  type: "Quadruped",
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
  max_hp: 51,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Foothills of Zeltoph",
      uids: [2131013..2131024]
    },
    {
      name: "Plains of Vornavis",
      uids: [4212101..4212130, 4213101..4213130]
    },
    {
      name: "Noman's Land",
      uids: [4600001..4600009]
    },
    {
      name: "Locksmehr Trail",
      uids: [13001001..13001038]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Impale",
        as: 84
      },
      {
        name: "Tusk",
        as: 74
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
    melee: (21..51),
    ranged: 19,
    bolt: 19,
    udf: (49..72),
    bar_td: 12,
    cle_td: 12,
    emp_td: 12,
    pal_td: (9..12),
    ran_td: 12,
    sor_td: 12,
    wiz_td: nil,
    mje_td: 12,
    mne_td: 12,
    mjs_td: nil,
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
  equipment: [],
  treasure: {
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "urgh hide",
    other: nil
  },
  messaging: {
    description: [
      "The herbivorous urgh resembles, if anything, an overgrown, hairy pig. He stands on four feet and has a dark brown coat and curled, hairless tail. Instead of the usual upper and lower jaw in the front of his head, though, the urgh has an extremely long upper lip, which he can extend a good two feet to drag vegetation back into his mouth. Under the mouth reside two long, sharp tusks, used for digging up peat and other grasses upon which the urgh feeds, and for defense."
    ],
    arrival: [],
    flee: [
      "An urgh trots {direction}."
    ],
    death: [
      "The urgh collapses to the ground, emits a final squeal, and dies.",
      "The urgh lets out a final agonized squeal and dies.",
      "The urgh squeals loudly as she slumps to the ground and cradles her wounded left foreleg.",
      "The urgh squeals loudly as he slumps to the ground and cradles his wounded left foreleg.",
      "The urgh squeals loudly as she slumps to the ground and cradles her wounded right foreleg.",
      "The urgh squeals loudly as he slumps to the ground and cradles his wounded right foreleg."
    ],
    decay: [
      "An urgh decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An urgh charges at you with {pronoun} tusk!"
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
