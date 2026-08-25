{
  schema_version: 3,
  name: "storm hound",
  noun: "",
  url: "https://gswiki.play.net/storm_hound",
  picture: "",
  level: 24,
  family: "Canine",
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
  max_hp: 210,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Stormpeak",
      uids: [13150101..13150120]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 192
      },
      {
        name: "Claw",
        as: 202
      },
      {
        name: "Powerful lightning bolt",
        as: 202
      }
    ],
    bolt_spells: [
      {
        name: "Major Shock (910)",
        as: 171
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: nil,
    ranged: 206,
    bolt: 206,
    udf: nil,
    bar_td: nil,
    cle_td: 74,
    emp_td: (65..76),
    pal_td: nil,
    ran_td: nil,
    sor_td: 79,
    wiz_td: nil,
    mje_td: nil,
    mne_td: 82,
    mjs_td: 76,
    mns_td: 76,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Shakes off stuns"
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
    skin: "storm hound paw",
    other: "Essence of air"
  },
  messaging: {
    description: [
      "You have never seen anything quite like a storm hound, so you are not really sure what to make of it or how dangerous it might be.\n\n;Assess\nThe vapor hound is medium in size and about three feet high in its current state."
    ],
    arrival: [],
    flee: [],
    death: [
      "The storm hound lets out one last whimpering sigh of sparks and blue mist and dies.",
      "A storm hound goes limp as it is rendered unconscious!"
    ],
    decay: [
      "A storm hound decays into a compost of fur and fangs."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A storm hound hurls {weapon} at you!"
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
