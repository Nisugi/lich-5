{
  schema_version: 3,
  name: "wood wight",
  noun: "",
  url: "https://gswiki.play.net/wood_wight",
  picture: "",
  level: 20,
  family: "Wight",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 170,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Plains of Vornavis",
      uids: [4212201..4212222]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: 156
      },
      {
        name: "Closed fist",
        as: 166
      },
      {
        name: "Pound",
        as: 146
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Mind Jolt (706)",
        cs: 123
      }
    ],
    offensive_spells: [
      {
        name: "Earthen Fury (917)"
      }
    ],
    maneuvers: [
      {
        name: "Gas cloud"
      },
      {
        name: "Gesture"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "1N",
    immunities: [],
    melee: (139..160),
    ranged: (69..109),
    bolt: (69..109),
    udf: 180,
    bar_td: 66,
    cle_td: nil,
    emp_td: (52..60),
    pal_td: nil,
    ran_td: nil,
    sor_td: (61..67),
    wiz_td: nil,
    mje_td: 62,
    mne_td: 63,
    mjs_td: nil,
    mns_td: 60,
    mnm_td: nil,
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
    skin: "a wight scalp",
    other: nil
  },
  messaging: {
    description: [
      "The wood wight stalks the forest, searching for decaying and not-so-decaying flesh. Perhaps once a powerful human ranger, the wood wight is still powerful, but its tattered clothing is covered with mold, fungus and moss. The wood wight shambles about, mercilessly attacking anything living. Its cold, grey eyes and clammy fingers wield magic and weaponry with equal skill."
    ],
    arrival: [
      "A wood wight just arrived.",
      "A wood wight just arrived, limping badly."
    ],
    flee: [],
    death: [
      "The wood wight screams evilly one last time and goes still."
    ],
    decay: [
      "A wood wight crumbles to dust."
    ],
    search: [],
    spell_prep: [],
    attack: [],
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
