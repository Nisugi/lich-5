{
  schema_version: 3,
  name: "krynch",
  noun: "",
  url: "https://gswiki.play.net/krynch",
  picture: "",
  level: 31,
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
    "Living",
    "Magical"
  ],
  bcs: true,
  max_hp: 236,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Mraent Caverns",
      uids: [13008001..13008040]
    },
    {
      name: "unmapped",
      uids: [13008041..13008041]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound"
      },
      {
        name: "Fist",
        as: 250
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Tremors"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "20N",
    immunities: [],
    melee: (71..199),
    ranged: (71..98),
    bolt: (71..98),
    udf: 273,
    bar_td: (87..102),
    cle_td: (104..113),
    emp_td: (101..105),
    pal_td: (93..102),
    ran_td: nil,
    sor_td: (104..113),
    wiz_td: nil,
    mje_td: 115,
    mne_td: "106 124",
    mjs_td: 99,
    mns_td: (99..108),
    mnm_td: (93..99),
    defensive_spells: [
      "Natural Colors (601)"
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
    skin: "a krynch shinbone",
    other: nil
  },
  messaging: {
    description: [
      "Flecked with bits of mica and quartz crystal, the krynch shimmers in even the dimmest light. Moving with a fluid grace that belies the granite composition of its body, the creature has a barrel chest and thick, powerful limbs. The krynch has no visible ears or nose on its perfectly spherical head. Its mouth is fixed in a perpetual scowl and its glossy black eyes glare at you with malevolent intensity."
    ],
    arrival: [
      "A large boulder comes barrelling into view, abruptly rolls to a stop, and rises into the form of a krynch!",
      "The boulder comes to a sudden stop and rises into the form of a krynch!"
    ],
    flee: [],
    death: [
      "The krynch shudders, then topples to the ground.",
      "The krynch shudders violently for a moment, then goes still."
    ],
    decay: [
      "Tiny fissures quickly spread over a dead krynch, and it crumbles into rubble."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A krynch pounds at you with {pronoun} fist!"
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
