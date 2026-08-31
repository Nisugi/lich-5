{
  schema_version: 3,
  name: "frozen corpse",
  noun: "",
  url: "https://gswiki.play.net/frozen_corpse",
  picture: "",
  level: 42,
  family: "Zombie",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: false,
  boss: true,
  boss_type: "miniboss",
  otherclass: [
    "Corporeal undead",
    "Boss"
  ],
  bcs: true,
  max_hp: 299,
  speed: 12,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Sleeping Lady Mountains",
      uids: [4560030..4560053]
    },
    {
      name: "Pinefar Forests",
      uids: [4563030..4563051]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Ice Pick",
        as: (282..286)
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
    asg: nil,
    immunities: [],
    melee: (181..278),
    ranged: (221..254),
    bolt: (221..254),
    udf: (239..272),
    bar_td: 123,
    cle_td: (143..152),
    emp_td: (142..151),
    pal_td: (123..126),
    ran_td: (123..135),
    sor_td: (148..151),
    wiz_td: nil,
    mje_td: (153..168),
    mne_td: (153..168),
    mjs_td: 186,
    mns_td: 186,
    mnm_td: (123..129),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a large ice pick",
    "a mountaineer's pack",
    "some rotted leather"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "scalp",
    other: nil
  },
  messaging: {
    description: [
      "Unearthed from his place of resting by the avalanches, the frozen corpse stiffly roams the ice fields looking for rest again. Ranging from dwarf to giantman in size, the frozen corpse attacks ruthlessly any living thing in his path, perhaps blaming the living for his current predicament. His features are taut and drawn, but most of the flesh is still intact, preserved by the subzero cold. His movements are punctuated by the loud screeching of ice against ice in his joints and a continual crackling as his frozen appendages fracture."
    ],
    arrival: [
      "A frozen corpse shambles in!"
    ],
    flee: [
      "A frozen corpse shambles {direction}."
    ],
    death: [
      "The frozen corpse wails in terrifying pain one last time and lies still.",
      "Beautiful shot pierces both lungs, the frozen corpse makes a wheezing noise, and drops dead!",
      "The frozen corpse slumps to the ground."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A frozen corpse swings {weapon} at you!"
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
