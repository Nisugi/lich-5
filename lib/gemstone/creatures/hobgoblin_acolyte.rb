{
  schema_version: 3,
  name: "hobgoblin acolyte",
  noun: "",
  url: "https://gswiki.play.net/hobgoblin_acolyte",
  picture: "",
  level: 7,
  family: "Goblin",
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
  max_hp: 104,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Muddy Village",
      uids: [7128001..7128015, 7128026..7128030]
    },
    {
      name: "unmapped",
      uids: [7128016..7128025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Leather whip"
      }
    ],
    bolt_spells: [
      {
        name: "Minor Shock (901)",
        as: 104
      },
      {
        name: "Minor Water (903)",
        as: 104
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "5",
    immunities: [],
    melee: (71..79),
    ranged: 36,
    bolt: "24 to 44",
    udf: 100,
    bar_td: nil,
    cle_td: nil,
    emp_td: 36,
    pal_td: nil,
    ran_td: nil,
    sor_td: "32 to 39",
    wiz_td: nil,
    mje_td: 28,
    mne_td: "28 to 33",
    mjs_td: nil,
    mns_td: "36 to 46",
    mnm_td: nil,
    defensive_spells: [
      "Spirit Warding I (101)",
      "Spirit Defense (103)",
      "Spirit Warding II (107)",
      "Spirit Shield (202)"
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
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "ear",
    other: nil
  },
  messaging: {
    description: [
      ""
    ],
    arrival: [],
    flee: [
      "A hobgoblin acolyte snarls as he retreats!"
    ],
    death: [
      "The hobgoblin acolyte screams up at the heavens, then collapses and dies.",
      "The hobgoblin acolyte crumples to the ground and dies."
    ],
    decay: [
      "A hobgoblin acolyte decays into a pile of compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A hobgoblin acolyte finishes chanting and thrusts {weapon} towards you!"
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
