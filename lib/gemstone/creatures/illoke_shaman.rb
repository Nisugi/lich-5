{
  schema_version: 3,
  name: "illoke shaman",
  noun: "",
  url: "https://gswiki.play.net/illoke_shaman",
  picture: "",
  level: 67,
  family: "Giant",
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
  max_hp: 600,
  speed: nil,
  height: 22,
  size: "huge",
  areas: [
    {
      name: "Stone Valley",
      uids: [4292017..4292060]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "War mattock"
      },
      {
        name: "Fist",
        as: 337
      },
      {
        name: "Foot",
        as: 303
      },
      {
        name: "Huge stone maul",
        as: 316
      },
      {
        name: "Massive granite hammer",
        as: 325
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Interdiction",
        cs: 282
      },
      {
        name: "Interference (212)",
        cs: 282
      },
      {
        name: "Huge stone maul",
        cs: 291
      }
    ],
    offensive_spells: [
      {
        name: "Earthen Fury"
      }
    ],
    maneuvers: [
      {
        name: "Divine Wrath"
      },
      {
        name: "Ground Slam"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (301..385),
    ranged: nil,
    bolt: nil,
    udf: 462,
    bar_td: (244..259),
    cle_td: (263..272),
    emp_td: (266..274),
    pal_td: (231..240),
    ran_td: nil,
    sor_td: (285..291),
    wiz_td: nil,
    mje_td: 301,
    mne_td: nil,
    mjs_td: 268,
    mns_td: (261..271),
    mnm_td: (218..227),
    defensive_spells: [
      "Benediction (307)",
      "Elemental Defense I (401)",
      "Elemental Defense II (406)",
      "Elemental Defense III (414)",
      "Elemental Targeting (425)",
      "Resist Elements (602)"
    ],
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
    magic_items: nil,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Glowing violet mote of essence"
  },
  messaging: {
    description: [
      "Massive and imposing, the Illoke shaman towers over adventurers. It is more than three times the size of the largest giantman, with smooth grey skin and deep black eyes that glare out from under a heavy brow. The eyes regard potential victims with disdain, as if they were nothing more than an offering to be sacrificed. Chiseled deep into the forehead of the shaman, the symbol of Illoke glows red with power."
    ],
    arrival: [],
    flee: [],
    death: [
      "An Illoke shaman goes limp as he is rendered unconscious!",
      "The Illoke shaman grumbles in pain one last time before lying still."
    ],
    decay: [
      "An Illoke shaman crumbles into a mass of shiny rocks, leaving nothing behind.",
      "The Illoke shaman's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An Illoke shaman pounds at you with {pronoun} fist!",
      "An Illoke shaman stomps at you with {pronoun} foot!",
      "An Illoke shaman swings {weapon} at you!"
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
