{
  schema_version: 3,
  name: "colossus vulture",
  noun: "",
  url: "https://gswiki.play.net/colossus_vulture",
  picture: "",
  level: 34,
  family: "Bird",
  type: "Avian",
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
  max_hp: 390,
  speed: nil,
  height: nil,
  size: "large",
  areas: [
    {
      name: "Yegharren Plains",
      uids: [13036111..13036118, 13036201..13036217]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 235
      },
      {
        name: "Claw",
        as: 245
      },
      {
        name: "Impale",
        as: 235
      },
      {
        name: "Swoop",
        as: 245
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Wing buffet"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (192..207),
    ranged: 165,
    bolt: 150,
    udf: 200,
    bar_td: (93..102),
    cle_td: (100..106),
    emp_td: (107..114),
    pal_td: (102..111),
    ran_td: 102,
    sor_td: (113..122),
    wiz_td: nil,
    mje_td: 119,
    mne_td: 119,
    mjs_td: nil,
    mns_td: (146..155),
    mnm_td: (93..102),
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
    skin: "a ruff of vulture feathers",
    other: nil
  },
  messaging: {
    description: [
      "The colossus vulture is a large, distinctly marked bird, with a wingspan twice the height of a giantman. Glossy black feathers and white markings on its broad wings and rounded tail give the vulture an ominous appearance, and feathers cover its legs to its feet. A dark ruff borders the colossus vulture's bald red head and neck. Its hooked bill and powerful talons are well suited for hunting."
    ],
    arrival: [],
    flee: [
      "A colossus vulture flies {direction}."
    ],
    death: [
      "The colossus vulture writhes in agony, its wings flapping fruitlessly as it dies.",
      "A colossus vulture goes limp as it is rendered unconscious!",
      "The colossus vulture crashes to the ground, motionless."
    ],
    decay: [
      "The colossus vulture decays into a pile of feathers."
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
