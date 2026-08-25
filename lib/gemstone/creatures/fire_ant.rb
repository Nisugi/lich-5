{
  schema_version: 3,
  name: "fire ant",
  noun: "",
  url: "https://gswiki.play.net/fire_ant",
  picture: "",
  level: 1,
  family: "Ant",
  type: "Insect",
  undead: false,
  blood: true,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 28,
  speed: nil,
  height: 1,
  size: "small",
  areas: [
    {
      name: "unmapped",
      uids: [14010001..14010032]
    },
    {
      name: "Barefoot Hill",
      uids: [14010101..14010118]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 41
      },
      {
        name: "Charge",
        as: 51
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
    asg: "6N",
    immunities: [],
    melee: (25..27),
    ranged: 25,
    bolt: 25,
    udf: 33,
    bar_td: 3,
    cle_td: 3,
    emp_td: 3,
    pal_td: 3,
    ran_td: 3,
    sor_td: 3,
    wiz_td: 3,
    mje_td: 3,
    mne_td: 3,
    mjs_td: 3,
    mns_td: 3,
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "a fire ant pincer",
    other: nil
  },
  messaging: {
    description: [
      "The fire ant looks like a giant armored version of a common ordinary ant except for the faint wisps of smoke floating off its feelers. Its faceted eyes stare back at you with apparent disinterest."
    ],
    arrival: [
      "A fire ant just arrived.",
      "A fire ant crawls in, feelers twitching."
    ],
    flee: [],
    death: [
      "The fire ant falls to the ground and dies, its feelers twitching."
    ],
    decay: [
      "A fire ant decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A fire ant tries to bite you!"
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
