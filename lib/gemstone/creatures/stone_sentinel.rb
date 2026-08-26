{
  schema_version: 3,
  name: "stone sentinel",
  noun: "",
  url: "https://gswiki.play.net/stone_sentinel",
  picture: "",
  level: 53,
  family: "Golem",
  type: "Biped",
  undead: false,
  blood: false,
  bones: false,
  witherable: false,
  sympathy: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Magical"
  ],
  bcs: true,
  max_hp: nil,
  speed: nil,
  height: 8,
  size: "large",
  areas: [
    {
      name: "Darkstone Castle",
      uids: [42001..42016, 42024..42026]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound",
        as: 380
      },
      {
        name: "Fist",
        as: 350
      }
    ],
    bolt_spells: [
      {
        name: "Fireball",
        as: 373
      }
    ],
    warding_spells: [
      {
        name: "Mind Jolt",
        cs: (231..241)
      },
      {
        name: "Silence",
        cs: (231..241)
      }
    ],
    offensive_spells: [
      {
        name: "Elemental Wave (410)"
      },
      {
        name: "Earthen Fury (917)"
      }
    ],
    maneuvers: [],
    special_abilities: [
      {
        name: "Stone-spitting"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "20",
    immunities: [
      "Stun"
    ],
    melee: 59,
    ranged: (63..103),
    bolt: nil,
    udf: (294..446),
    bar_td: nil,
    cle_td: nil,
    emp_td: 203,
    pal_td: nil,
    ran_td: nil,
    sor_td: (216..226),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (203..213),
    mnm_td: (180..190),
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
    skin: "No",
    other: nil
  },
  messaging: {
    description: [
      "Comprised of solid blocks of granite, the immense stone sentinel stands and moves very stiffly. Each portion of its anatomy is chiseled in rectangular pieces with sharp right angles. It is not apparent how this animated construct moves, or how it even stays together, but somehow it does both effectively. The attacks of a stone sentinel carry the weight of tons of rock behind them. Being in the path of one is not an experience to be recommended."
    ],
    arrival: [
      "A stone sentinel just arrived."
    ],
    flee: [],
    death: [],
    decay: [
      "A stone sentinel crumbles to dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A stone sentinel pounds at you with {pronoun} fist!"
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
