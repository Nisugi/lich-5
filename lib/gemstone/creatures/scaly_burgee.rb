{
  schema_version: 3,
  name: "scaly burgee",
  noun: "",
  url: "https://gswiki.play.net/scaly_burgee",
  picture: "",
  level: 29,
  family: "Reptilian",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 340,
  speed: nil,
  height: 2,
  size: "large",
  areas: [
    {
      name: "Teorainn Dale",
      uids: [13024030..13024047, 13024051..13024064]
    },
    {
      name: "Greymist Woods",
      uids: [3022018..3022034]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge (attack)",
        as: 250
      },
      {
        name: "Claw",
        as: (225..247)
      },
      {
        name: "Charge",
        as: 221
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Spit"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (185..263),
    ranged: 140,
    bolt: 151,
    udf: 289,
    bar_td: 87,
    cle_td: nil,
    emp_td: (81..95),
    pal_td: nil,
    ran_td: 87,
    sor_td: (88..97),
    wiz_td: nil,
    mje_td: (95..98),
    mne_td: 95,
    mjs_td: nil,
    mns_td: 87,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a scaly burgee shell",
    other: nil
  },
  messaging: {
    description: [
      "The dark, beady eyes of the scaly burgee gleam with feral menace beneath two jutting ridges. Flexible diamond-shaped scales cover its carapace and its small, triangular head. Thinly coated around its surprisingly wide mouth is a greyish substance."
    ],
    arrival: [],
    flee: [],
    death: [
      "A scaly burgee goes limp as it is rendered unconscious!"
    ],
    decay: [
      "Acid dissolves the knee ligaments.  The scaly burgee's tibia passes its femur in a very unpleasant manner!"
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A scaly burgee charges at you!"
    ],
    bite: [],
    claw: [
      "A scaly burgee claws at you!"
    ],
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
