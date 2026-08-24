{
  schema_version: 3,
  name: "great stag",
  noun: "",
  url: "https://gswiki.play.net/great_stag",
  picture: "",
  level: 13,
  family: "Deer",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 121,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Yander's Farm",
      uids: [14005067..14005080]
    },
    {
      name: "Yegharren Plains",
      uids: [13034101..13034118, 13034201..13034221]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge (attack)",
        as: 165
      },
      {
        name: "Impale (attack)",
        as: 165
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
    immunities: [],
    melee: (93..142),
    ranged: 84,
    bolt: 84,
    udf: 141,
    bar_td: 39,
    cle_td: nil,
    emp_td: (17..25),
    pal_td: nil,
    ran_td: 39,
    sor_td: (36..45),
    wiz_td: nil,
    mje_td: 39,
    mne_td: (33..39),
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Hides when attacked"
    ]
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  treasure: {
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "antlers (special)",
    other: "No"
  },
  messaging: {
    description: [
      "Standing almost a foot taller than an average human, the great stag is the preeminent example of majesty in the wilds. Its soft brown coat and strong muscled legs offer the duality of nature incarnate, calm and peaceful but powerful. The antlers atop the stag's head reach towards the sky in regal beauty."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
