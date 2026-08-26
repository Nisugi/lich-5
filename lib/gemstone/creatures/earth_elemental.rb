{
  schema_version: 3,
  name: "earth elemental",
  noun: "",
  url: "https://gswiki.play.net/earth_elemental",
  picture: "",
  level: 82,
  family: "Elemental",
  type: "Elemental",
  undead: false,
  blood: false,
  bones: nil,
  witherable: false,
  sympathy: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Extraplanar",
    "Magical"
  ],
  bcs: true,
  max_hp: 443,
  speed: nil,
  height: 10,
  size: "huge",
  areas: [
    {
      name: "Bowels of Thanatoph",
      uids: [4293001..4293032, 4293051..4293057]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound (attack)",
        as: 401
      },
      {
        name: "Foot",
        as: 422
      },
      {
        name: "Heavy earthen fists",
        as: 421
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
    asg: "20N",
    immunities: [],
    melee: (160..293),
    ranged: nil,
    bolt: nil,
    udf: 662,
    bar_td: nil,
    cle_td: 333,
    emp_td: 315,
    pal_td: (277..286),
    ran_td: nil,
    sor_td: (366..375),
    wiz_td: nil,
    mje_td: 369,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: (246..252),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "30% weapon damage factor reduction"
    ]
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a massive iron-banded greatshield"
  ],
  treasure: {
    coins: false,
    magic_items: false,
    gems: true,
    boxes: false,
    skin: "No",
    other: "Yes"
  },
  messaging: {
    description: [
      "Massive and thick, with broad shoulders but no apparent head, the earth elemental appears to be a composite of the earth itself. A large, craggy maw in the middle of the elemental's chest appears to be the creature's mouth, and the earth elemental's huge feet and giant-sized fists look like they would pulverize flesh without much effort at all."
    ],
    arrival: [
      "The boulder comes to a sudden stop and rises into the form of a greater krynch!",
      "An earth elemental lumbers in slowly."
    ],
    flee: [],
    death: [],
    decay: [
      "Tiny fissures quickly spread over the entire form of an earth elemental.  Within moments, it crumbles into a pile of dirt and rubble.",
      "The earth elemental's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An earth elemental pounds at you with earth elemental heavy earthen fists!",
      "An earth elemental stomps at you with {pronoun} foot!"
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
