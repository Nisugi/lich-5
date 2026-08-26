{
  schema_version: 3,
  name: "big ugly kobold",
  noun: "",
  url: "https://gswiki.play.net/big_ugly_kobold",
  picture: "",
  level: 2,
  family: "Kobold",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 50,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Lower Dragonsclaw",
      uids: [373005..373016]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Short sword",
        as: 55
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
    asg: "1N",
    immunities: [],
    melee: (34..66),
    ranged: nil,
    bolt: 23,
    udf: 96,
    bar_td: nil,
    cle_td: 6,
    emp_td: 6,
    pal_td: (3..6),
    ran_td: 6,
    sor_td: 6,
    wiz_td: nil,
    mje_td: 6,
    mne_td: 6,
    mjs_td: 6,
    mns_td: 6,
    mnm_td: 6,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a short sword",
    "a wooden shield"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a kobold skin",
    other: nil
  },
  messaging: {
    description: [
      "This big ugly kobold is large for a kobold and ugly, even by kobold beauty standards. Smaller than a dwarf and even many halflings, she has ruddy skin and a hairless pate topped with small horns. Long-limbed for her size, the big ugly kobold eschews any display of brute strength and relies on what agility she pretends to have. The big ugly kobold stares back at you with beady little black eyes, sizing you up as a foe."
    ],
    arrival: [],
    flee: [
      "A big ugly kobold limps {direction}.",
      "A big ugly kobold heads {direction}."
    ],
    death: [],
    decay: [
      "A small, green cloud of smelly gas rises from the body of a big ugly kobold as she decays into compost.",
      "A small, green cloud of smelly gas rises from the body of a big ugly kobold as he decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A big ugly kobold swings {weapon} at you!"
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
