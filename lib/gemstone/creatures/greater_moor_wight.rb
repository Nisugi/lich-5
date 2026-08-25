{
  schema_version: 3,
  name: "greater moor wight",
  noun: "",
  url: "https://gswiki.play.net/greater_moor_wight",
  picture: "",
  level: 39,
  family: "Wight",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 284,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Miasmal Forest",
      uids: [5003039..5003050, 5004035..5004044, 5004049..5004053]
    },
    {
      name: "unmapped",
      uids: [5004045..5004048, 5004054..5004054]
    },
    {
      name: "Yegharren Plains",
      uids: [13036201..13036217, 13036401..13036414, 13036501..13036514]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Broadsword"
      },
      {
        name: "Handaxe",
        as: (226..252)
      },
      {
        name: "Rusty steel flyssa",
        as: 246
      },
      {
        name: "Wickedly curved scimitar",
        as: 226
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Cold Snap (512)",
        cs: 203
      }
    ],
    offensive_spells: [
      {
        name: "Elemental Dispel (417)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (182..315),
    ranged: (195..250),
    bolt: (195..250),
    udf: 372,
    bar_td: 133,
    cle_td: (152..155),
    emp_td: (155..164),
    pal_td: nil,
    ran_td: nil,
    sor_td: (162..171),
    wiz_td: nil,
    mje_td: (158..167),
    mne_td: 160,
    mjs_td: nil,
    mns_td: 145,
    mnm_td: nil,
    defensive_spells: [
      "Haste (506)",
      "Mass Blur (911)",
      "Prismatic Guard (905)",
      "Spirit Defense (103)",
      "Spirit Warding I (101)"
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
    skin: "a wight mane",
    other: "Glowing violet essence dust"
  },
  messaging: {
    description: [
      "Once beautiful beyond comprehension, the moor wight before you is now as disgusting as it was once charming. The wight has a slender, decaying body hidden by tattered and fading robes. Plainly written across the moor wight's face is an expression of eternal anguish and pain, silently speaking of the horrific events which unfolded during its life to bring it to this sad state."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A greater moor wight swings {weapon} at you!"
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
