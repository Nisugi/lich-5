{
  schema_version: 3,
  name: "red tsark",
  noun: "",
  url: "https://gswiki.play.net/red_tsark",
  picture: "",
  level: 66,
  family: "Reptilian",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Element-based",
    "Boss"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 4,
  size: "large",
  areas: [
    {
      name: "Eye of V'Tull",
      uids: [3051003..3051030, 3061001..3061038]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Leap"
      },
      {
        name: "Bite",
        as: 293
      },
      {
        name: "Claw",
        as: 347
      },
      {
        name: "Roaring ball of fire",
        as: 294
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: 328,
    ranged: (166..211),
    bolt: (166..211),
    udf: 443,
    bar_td: 254,
    cle_td: nil,
    emp_td: (272..281),
    pal_td: nil,
    ran_td: nil,
    sor_td: (285..294),
    wiz_td: nil,
    mje_td: 309,
    mne_td: 298,
    mjs_td: nil,
    mns_td: 269,
    mnm_td: nil,
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
    skin: "a tsark skin",
    other: nil
  },
  messaging: {
    description: [
      "Circling and pacing, the red tsark creeps closer, her eyes glowing red with fury. The scaled creature moves constantly, crouched on her powerful back legs like a tightly wound spring, ready to launch an attack at any opportunity. Small front legs are held poised in front of the reptile's chest, armed with formidable claws that could easily disembowel an unwary adversary. Smoke trails from the red tsark's nostrils, punctuated by flames each time she snorts a challenge."
    ],
    arrival: [],
    flee: [],
    death: [
      "The red tsark goes limp and she falls over as the fire slowly fades from her eyes.",
      "The red tsark goes limp and he falls over as the fire slowly fades from his eyes."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A red tsark hurls {weapon} at you!"
    ],
    bite: [
      "A red tsark tries to bite you!"
    ],
    claw: [
      "A red tsark claws at you!"
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
