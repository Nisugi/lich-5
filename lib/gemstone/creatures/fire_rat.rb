{
  schema_version: 3,
  name: "fire rat",
  noun: "",
  url: "https://gswiki.play.net/fire_rat",
  picture: "",
  level: 16,
  family: "Rodent",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Element-based"
  ],
  bcs: true,
  max_hp: 148,
  speed: nil,
  height: 2,
  size: "small",
  areas: [
    {
      name: "Lysierian Hills",
      uids: [92032..92041]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (139..169)
      },
      {
        name: "Claw",
        as: 169
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
    asg: "8N",
    immunities: [
      "Fire"
    ],
    melee: (72..115),
    ranged: (72..101),
    bolt: (72..101),
    udf: (110..121),
    bar_td: 42,
    cle_td: (45..54),
    emp_td: (40..48),
    pal_td: (45..48),
    ran_td: (42..48),
    sor_td: (42..54),
    wiz_td: nil,
    mje_td: 48,
    mne_td: 42,
    mjs_td: nil,
    mns_td: (48..54),
    mnm_td: (48..54),
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
    skin: "a fire rat tail",
    other: nil
  },
  messaging: {
    description: [
      "The fire rat is a large animal, roughly the size of a small dog. Its fur is shaggy, and rusty red in color. It has a long hairless tail, and glinting red eyes. Most dangerous are its claws which spark flame when attacking its prey."
    ],
    arrival: [
      "A fire rat scampers in!"
    ],
    flee: [
      "A fire rat scampers {direction}.",
      "A fire rat crawls {direction}."
    ],
    death: [
      "The fire rat collapses to the ground, emits a final squeal, and dies.",
      "The fire rat twitches and dies.",
      "The fire rat collapses to the ground, emits a final silent squeal, and dies.",
      "The fire rat shrieks as it slumps to the ground and licks at its wounded right foreleg.",
      "The fire rat shrieks as it slumps to the ground and licks at its wounded left foreleg.",
      "The fire rat shrieks as it slumps to the ground and licks at its wounded left claw."
    ],
    decay: [
      "A fire rat crumbles into a pile of ash.",
      "Acid dissolves the knee ligaments.  The fire rat's tibia passes its femur in a very unpleasant manner!"
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A fire rat tries to bite you!"
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
