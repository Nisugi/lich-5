{
  schema_version: 3,
  name: "dreadnought raptor",
  noun: "",
  url: "https://gswiki.play.net/dreadnought_raptor",
  picture: "",
  level: 43,
  family: "Bird",
  type: "Avian",
  undead: false,
  blood: true,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: true,
  boss_type: "pack",
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 260,
  speed: 8,
  height: nil,
  size: "large",
  areas: [
    {
      name: "Gyldemar Forest",
      uids: [13028001..13028034]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Impale",
        as: (271..274)
      },
      {
        name: "Bite"
      },
      {
        name: "Claw",
        as: (275..281)
      },
      {
        name: "Swoop",
        as: (252..281)
      },
      {
        name: "Beak",
        as: 234
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Wing Buffet"
      }
    ],
    special_abilities: [
      {
        name: "Buffet"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (194..229),
    ranged: 214,
    bolt: 214,
    udf: (240..272),
    bar_td: (122..131),
    cle_td: (142..151),
    emp_td: (138..147),
    pal_td: (129..138),
    ran_td: (129..135),
    sor_td: (144..153),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: 144,
    mns_td: nil,
    mnm_td: (126..132),
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
    skin: "raptor feathers",
    other: nil
  },
  messaging: {
    description: [
      "The dreadnought raptor is a large, distinctly marked bird, with a wingspan twice the height of a giantman. Glossy black feathers and white markings on its broad wings and rounded tail give the raptor an ominous appearance, and feathers cover its legs to its feet. A dark ruff borders the dreadnought raptor's bald red head and neck. Its hooked bill and powerful talons are well suited for hunting."
    ],
    arrival: [],
    flee: [
      "A dreadnought raptor flies {direction}."
    ],
    death: [
      "The dreadnought raptor writhes in agony, its wings flapping fruitlessly as it dies.",
      "The dreadnought raptor crashes to the ground, motionless.",
      "Beautiful shot pierces both lungs, the dreadnought raptor makes a wheezing noise, and drops dead!"
    ],
    decay: [
      "The dreadnought raptor decays into a pile of feathers."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A dazzling dreadnought raptor tries to impale you on {pronoun} beak!",
      "A dreadnought raptor rakes at you with a razor-sharp claw!",
      "A dreadnought raptor tries to impale you on dreadnought raptor beak!",
      "A dreadnought raptor tries to spear you with dreadnought raptor beak!"
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
