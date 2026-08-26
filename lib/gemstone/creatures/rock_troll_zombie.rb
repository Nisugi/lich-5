{
  schema_version: 3,
  name: "rock troll zombie",
  noun: "",
  url: "https://gswiki.play.net/rock_troll_zombie",
  picture: "",
  level: 34,
  family: "Troll",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Corporeal undead",
    "Boss"
  ],
  bcs: true,
  max_hp: nil,
  speed: nil,
  height: 11,
  size: "huge",
  areas: [
    {
      name: "Troll Burial Grounds",
      uids: [13011001..13011035]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (227..245)
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
        name: "Disarm Weapon"
      },
      {
        name: "Disarm"
      },
      {
        name: "Pounce"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (142..268),
    ranged: 140,
    bolt: 140,
    udf: 373,
    bar_td: nil,
    cle_td: (116..119),
    emp_td: (117..127),
    pal_td: (99..108),
    ran_td: nil,
    sor_td: (123..132),
    wiz_td: nil,
    mje_td: 129,
    mne_td: (123..138),
    mjs_td: nil,
    mns_td: (117..126),
    mnm_td: (96..105),
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
    skin: "a decaying troll eye",
    other: nil
  },
  messaging: {
    description: [
      "A rock troll zombie is a towering sight to behold. Standing well over the height of two giantkin combined, the troll zombie is clad in rock armor, composed entirely of granite. Golden embers burn with a hatred of life out from under the zombie's massive granite helm."
    ],
    arrival: [
      "A rock troll zombie lumbers in!",
      "A rock troll zombie lumbers in, limping slightly!"
    ],
    flee: [
      "A rock troll zombie lumbers {direction}.",
      "A rock troll zombie lumbers {direction} with a slight limp.",
      "A rock troll zombie grimaces and slowly limps {direction}."
    ],
    death: [
      "The troll zombie tears off a piece of her flesh, gnawing upon the decayed meat in a vain attempt to nourish her continued tormented existence.  With the attempt failing, the troll zombie slumps to the ground motionless.",
      "The troll zombie tears off a piece of his flesh, gnawing upon the decayed meat in a vain attempt to nourish his continued tormented existence.  With the attempt failing, the troll zombie slumps to the ground motionless.",
      "The troll zombie tears off a piece of his flesh, gnawing upon the decayed meat in a vain attempt to nourish his continued tormented existence.  With the attempt failing, the troll zombie topples to the ground motionless.",
      "The troll zombie tears off a piece of her flesh, gnawing upon the decayed meat in a vain attempt to nourish her continued tormented existence.  With the attempt failing, the troll zombie topples to the ground motionless."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [],
    claw: [
      "A rock troll zombie claws at you!"
    ],
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
