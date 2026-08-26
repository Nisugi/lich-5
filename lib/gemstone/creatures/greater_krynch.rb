{
  schema_version: 3,
  name: "greater krynch",
  noun: "",
  url: "https://gswiki.play.net/greater_krynch",
  picture: "",
  level: 84,
  family: "Krynch",
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
  max_hp: 300,
  speed: nil,
  height: 7,
  size: "medium",
  areas: [
    {
      name: "Bowels of Thanatoph",
      uids: [4293001..4293052]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound (attack)",
        as: 427
      },
      {
        name: "Fist",
        as: 427
      },
      {
        name: "Heavy earthen fists",
        as: 417
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Ethereal Wave"
      }
    ],
    special_abilities: [
      {
        name: "Krynch boulder"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "20N",
    immunities: [],
    melee: (222..438),
    ranged: 240,
    bolt: 240,
    udf: (464..653),
    bar_td: (306..315),
    cle_td: 341,
    emp_td: (323..332),
    pal_td: (279..282),
    ran_td: (288..294),
    sor_td: 345,
    wiz_td: nil,
    mje_td: 364,
    mne_td: nil,
    mjs_td: nil,
    mns_td: 354,
    mnm_td: (258..264),
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "luminescent silvery boulder opal",
    other: nil
  },
  messaging: {
    description: [
      "Veins of mica and quartz crystal run along and through the towering krynch's barrel chest and thick, powerful limbs, causing it to shimmer in even the dimmest light. A crown of rough rock and crystal spikes protrude from the top of its otherwise perfectly spherical head, adding to the creature's powerful stature. Its mouth is fixed in a perpetual scowl, and glossy black eyes glare at you with malevolent intensity."
    ],
    arrival: [
      "A massive boulder comes barrelling into view, abruptly rolls to a stop, and rises into the form of a greater krynch!",
      "The boulder comes to a sudden stop and rises into the form of a greater krynch!"
    ],
    flee: [],
    death: [
      "The greater krynch shudders, then topples to the ground.",
      "The greater krynch shudders violently for a moment, then goes still."
    ],
    decay: [
      "Tiny fissures quickly spread over a dead greater krynch, and it crumbles into rubble."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A greater earth elemental pounds at you with greater krynch heavy earthen fists!",
      "A greater krynch pounds at you with {pronoun} fist!"
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
