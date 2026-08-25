{
  schema_version: 3,
  name: "storm giant",
  noun: "",
  url: "https://gswiki.play.net/storm_giant",
  picture: "",
  level: 39,
  family: "Giant",
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
    "Element-based"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 12,
  size: "huge",
  areas: [
    {
      name: "Stormpeak",
      uids: [13150201..13150220]
    },
    {
      name: "Upper Trollfang",
      uids: [16065..16071]
    },
    {
      name: "Ice Plains",
      uids: [4127035..4127045]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Morning star",
        as: 247
      },
      {
        name: "Spear",
        as: (197..247)
      },
      {
        name: "Weathered huge zorchar maul",
        as: 252
      }
    ],
    bolt_spells: [
      {
        name: "Major Shock (910)",
        as: 195
      },
      {
        name: "Minor Water (903)",
        as: 195
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Call Wind (912)"
      },
      {
        name: "Gas cloud"
      }
    ],
    maneuvers: [
      {
        name: "Ground stomp"
      },
      {
        name: "Wind blast"
      },
      {
        name: "Ground Slam"
      },
      {
        name: "Thunderclap"
      },
      {
        name: "Wind Rush"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: 176,
    ranged: nil,
    bolt: 161,
    udf: 194,
    bar_td: nil,
    cle_td: nil,
    emp_td: (145..155),
    pal_td: nil,
    ran_td: nil,
    sor_td: (155..163),
    wiz_td: nil,
    mje_td: 167,
    mne_td: 166,
    mjs_td: nil,
    mns_td: 155,
    mnm_td: nil,
    defensive_spells: [
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
    skin: "a giant skin",
    other: "essence of air"
  },
  messaging: {
    description: [
      "The storm giant's regal bearing and calm demeanor stand in sharp contrast to the raging tempest surrounding it. Standing taller than the tallest giantman, the storm giant stares at others with dull grey eyes that refuse to reflect the sparks of electricity that crackle out from them."
    ],
    arrival: [
      "A storm giant lumbers in, surrounded by a raging storm!"
    ],
    flee: [],
    death: [
      "The storm giant howls in agony one last time and dies.",
      "The storm giant twitches violently, then dies.",
      "A storm giant goes limp as it is rendered unconscious!"
    ],
    decay: [
      "Acid dissolves the knee ligaments.  The storm giant's tibia passes its femur in a very unpleasant manner!",
      "The storm giant's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A storm giant claps {pronoun} hands together in front of you!",
      "A storm giant swings {weapon} at you!",
      "A storm giant thrusts with a spear at you!"
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
