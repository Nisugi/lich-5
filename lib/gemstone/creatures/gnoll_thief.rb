{
  schema_version: 3,
  name: "gnoll thief",
  noun: "",
  url: "https://gswiki.play.net/gnoll_thief",
  picture: "",
  level: 13,
  family: "Gnoll",
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
  max_hp: 160,
  speed: nil,
  height: 3,
  size: "small",
  areas: [
    {
      name: "Foothills of Zeltoph",
      uids: [10001..10020, 10201..10206]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Short sword",
        as: 162
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Hurl"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "6",
    immunities: [],
    melee: 176,
    ranged: nil,
    bolt: (72..109),
    udf: nil,
    bar_td: nil,
    cle_td: (39..45),
    emp_td: (31..39),
    pal_td: (36..45),
    ran_td: nil,
    sor_td: 45,
    wiz_td: nil,
    mje_td: (33..45),
    mne_td: (33..45),
    mjs_td: nil,
    mns_td: (33..39),
    mnm_td: (36..45),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Hides when attacked"
    ]
  },
  special_other: "Stealing",
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Yes"
  },
  messaging: {
    description: [
      "Light fingered and agile, the gnoll thief is easily at home in both the dark stone corridors of his lair and anywhere that loot may be gained. Wiry and lithe, with pale skin and large, colorless eyes, the thief stands around three feet tall as it regards you uneasily."
    ],
    arrival: [
      "A gnoll ranger wanders in, alertly surveying its surroundings."
    ],
    flee: [],
    death: [
      "The gnoll thief rolls over and dies.",
      "The gnoll thief falls to the ground and dies.",
      "A gnoll thief goes limp as she is rendered unconscious!"
    ],
    decay: [
      "Acid dissolves the knee ligaments.  The gnoll thief's tibia passes her femur in a very unpleasant manner!"
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
