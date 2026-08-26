{
  schema_version: 3,
  name: "giant ant",
  noun: "",
  url: "https://gswiki.play.net/giant_ant",
  picture: "",
  level: 1,
  family: "Ant",
  type: "Insect",
  undead: false,
  blood: nil,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 29,
  speed: nil,
  height: 1,
  size: "small",
  areas: [
    {
      name: "Dark Caverns",
      uids: [47001..47024, 47026..47033]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (36..41)
      },
      {
        name: "Charge (attack)",
        as: 46
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
    asg: "5N",
    immunities: [],
    melee: (25..47),
    ranged: (25..33),
    bolt: (25..33),
    udf: 33,
    bar_td: nil,
    cle_td: (3..6),
    emp_td: (3..6),
    pal_td: (3..6),
    ran_td: 3,
    sor_td: (3..6),
    wiz_td: nil,
    mje_td: 3,
    mne_td: 3,
    mjs_td: 3,
    mns_td: (3..6),
    mnm_td: 3,
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
    skin: "an ant pincer",
    other: "ant larva"
  },
  messaging: {
    description: [
      "The giant ant looks like a giant armored version of a common ordinary ant. Its faceted eyes stare out into air with constant disinterest."
    ],
    arrival: [
      "A giant ant just arrived."
    ],
    flee: [],
    death: [
      "The giant ant falls to the ground and dies, its feelers twitching.",
      "The giant ant feebly twitches a feeler one last time and dies.",
      "Beautiful shot pierces both lungs, the giant ant makes a wheezing noise, and drops dead!"
    ],
    decay: [
      "A giant ant decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A giant ant tries to bite you!"
    ],
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
