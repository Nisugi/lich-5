{
  schema_version: 3,
  name: "lesser griffin",
  noun: "",
  url: "https://gswiki.play.net/lesser_griffin",
  picture: "",
  level: 69,
  family: "Griffin",
  type: "Hybrid",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: nil,
  size: "large",
  areas: [
    {
      name: "Griffin's Keen",
      uids: [13302101..13302169]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Impale",
        as: 341
      },
      {
        name: "Bite",
        as: (338..341)
      },
      {
        name: "Claw",
        as: (348..351)
      },
      {
        name: "Beak",
        as: 329
      },
      {
        name: "Swoop",
        as: 320
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Screech"
      },
      {
        name: "Wing Swat"
      },
      {
        name: "Dive"
      }
    ],
    special_abilities: [
      {
        name: "Buffet"
      },
      {
        name: "Screech"
      },
      {
        name: "Wing Swat"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: 252,
    ranged: nil,
    bolt: 244,
    udf: nil,
    bar_td: 246,
    cle_td: nil,
    emp_td: (267..273),
    pal_td: nil,
    ran_td: nil,
    sor_td: (278..290),
    wiz_td: nil,
    mje_td: 285,
    mne_td: (292..304),
    mjs_td: nil,
    mns_td: nil,
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
    gems: true,
    boxes: false,
    skin: "ruffed tawny griffin pelt",
    other: "Glowing violet essence dust"
  },
  messaging: {
    description: [
      "The lesser griffin is a magnificent beast, as if designed by the gods to embody fierce and graceful predation. Its front legs, forebody, wings, and head are those of a great eagle, complete with large white feathers and aquiline beak. The rear half of the creature's body is that of a powerful lion, with short tawny fur and a long feline tail. Emphasized by its size, which is larger than a warhorse, the griffin's renowned majestic presence and great bravery have earned the creature a place on many nobles' coats-of-arms."
    ],
    arrival: [
      "A grifflet surveys the area intently as it flies into sight!"
    ],
    flee: [
      "A lesser griffin flies {direction}."
    ],
    death: [
      "The lesser griffin writhes in agony, its wings flapping fruitlessly as it dies."
    ],
    decay: [
      "The lesser griffin decays into a pile of feathers and fur."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A lesser griffin rakes at you with a razor-sharp claw!",
      "A lesser griffin tries to spear you with lesser griffin beak!"
    ],
    bite: [
      "A lesser griffin tries to bite you!"
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
