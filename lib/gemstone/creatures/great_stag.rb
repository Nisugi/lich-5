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
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 123,
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
      },
      {
        name: "Antlers",
        as: 148
      },
      {
        name: "Charge",
        as: 148
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
    melee: (71..142),
    ranged: (67..93),
    bolt: (67..93),
    udf: (106..141),
    bar_td: 39,
    cle_td: (33..42),
    emp_td: (39..47),
    pal_td: (36..45),
    ran_td: (33..39),
    sor_td: (36..45),
    wiz_td: nil,
    mje_td: (33..39),
    mne_td: (33..39),
    mjs_td: (36..39),
    mns_td: (36..39),
    mnm_td: (39..45),
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
  equipment: [],
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
    flee: [
      "A great stag trots {direction}."
    ],
    death: [
      "The great stag collapses to the ground, emits a final sigh, and dies.",
      "The great stag lets out a final agonized sigh and dies.",
      "The great stag collapses to the ground, emits a final silent sigh, and dies.",
      "The great stag silently lets out a final agonized sigh and dies.",
      "Beautiful shot pierces both lungs, the great stag makes a wheezing noise, and drops dead!"
    ],
    decay: [
      "A great stag decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A great stag charges at you!",
      "A great stag tries to impale you with {pronoun} antlers!",
      "A great stag tries to impale you with {pronoun} antlers!"
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
