{
  schema_version: 3,
  name: "n'ecare",
  noun: "",
  url: "https://gswiki.play.net/n'ecare",
  picture: "",
  level: 87,
  family: "N'ecare",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead",
    "Extraplanar"
  ],
  bcs: true,
  max_hp: 349,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "The Rift",
      uids: [4568001..4568055, 4570001..4570014]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Falchion",
        as: (386..503)
      },
      {
        name: "Mace",
        as: (386..396)
      },
      {
        name: "Long blackened jeddart-axe",
        as: 520
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Tackle"
      },
      {
        name: "Trip"
      },
      {
        name: "Polearm Plant"
      },
      {
        name: "Pounce"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "(see other info)",
    immunities: [],
    melee: (236..412),
    ranged: nil,
    bolt: nil,
    udf: 613,
    bar_td: 308,
    cle_td: 326,
    emp_td: (326..332),
    pal_td: 277,
    ran_td: nil,
    sor_td: (333..342),
    wiz_td: nil,
    mje_td: (362..371),
    mne_td: nil,
    mjs_td: 320,
    mns_td: (320..359),
    mnm_td: (252..261),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a dark steel shield",
    "a heavy flanged mace",
    "a long blackened jeddart-axe",
    "a spiked leather collar",
    "a splintered wooden buckler",
    "a studded leather scabbard",
    "a tattered black cloak",
    "a wickedly curved falchion",
    "some deep black reinforced leather",
    "some knee-high black boots",
    "some rotting black leather gloves",
    "some rusted chain mail"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Inky necrotic coreRadiant crimson mote of essence"
  },
  messaging: {
    description: [
      "Shadows suddenly converge, revealing the skulking form of a creature with horribly elongated extremities and twisted anatomy. The n'ecare's movements are as fleet as a hare, rendering him difficult to see clearly, and his spidery fingers skitter constantly, as if the n'ecare was using them to taste the air around him. From the dark pools of gloom beneath his cracked brows, the n'ecare's eyes glitter in fanatical mirth, made all the more terrible by the rotting maw of his grin."
    ],
    arrival: [],
    flee: [],
    death: [
      "The n'ecare falls to the ground motionless.",
      "The n'ecare wails in terrifying pain one last time and lies still."
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the n'ecare's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A n'ecare swings {weapon} at you!"
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
