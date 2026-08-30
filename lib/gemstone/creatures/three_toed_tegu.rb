{
  schema_version: 3,
  name: "three-toed tegu",
  noun: "",
  url: "https://gswiki.play.net/three-toed_tegu",
  picture: "",
  level: 33,
  family: "Reptilian",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 380,
  speed: nil,
  height: 2,
  size: "large",
  areas: [
    {
      name: "Teorainn Dale",
      uids: [13024010..13024027]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Impale",
        as: 237
      },
      {
        name: "Bite",
        as: (227..237)
      },
      {
        name: "Claw",
        as: 237
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Tail Sweep"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (166..247),
    ranged: (156..183),
    bolt: (156..183),
    udf: (198..250),
    bar_td: (96..99),
    cle_td: (96..105),
    emp_td: (97..106),
    pal_td: (99..108),
    ran_td: (99..108),
    sor_td: (103..120),
    wiz_td: nil,
    mje_td: (111..114),
    mne_td: (111..114),
    mjs_td: (97..106),
    mns_td: (97..106),
    mnm_td: 99,
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
    skin: "a tailspike",
    other: nil
  },
  messaging: {
    description: [
      "Despite its lumbering appearance, this heavily plated creature can show surprising bursts of speed. Each of the three toes on the tegu's forelegs are incredibly sharp, capable of slicing through the toughest hide. The armored tail of this male tegu is tipped with pointy spikes."
    ],
    arrival: [
      "A three-toed tegu slithers in."
    ],
    flee: [
      "A three-toed tegu slithers {direction}."
    ],
    death: [
      "The three-toed tegu arches its back in a tortured spasm and dies.",
      "The three-toed tegu stumbles and falls to the ground, twitches and dies."
    ],
    decay: [
      "A three-toed tegu's leathered hide and scaly armor collapses into dust."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A three-toed tegu tries to bite you!"
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
