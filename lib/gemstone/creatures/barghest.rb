{
  schema_version: 3,
  name: "barghest",
  noun: "",
  url: "https://gswiki.play.net/barghest",
  picture: "",
  level: 35,
  family: "Canine",
  type: "Quadruped",
  undead: true,
  blood: nil,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: true,
  max_hp: 316,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Yegharren Plains",
      uids: [13036201..13036217, 13036301..13036310, 13036401..13036414]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge (attack)",
        as: 229
      },
      {
        name: "Bite",
        as: (206..234)
      },
      {
        name: "Charge",
        as: 214
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
    melee: (145..250),
    ranged: (163..176),
    bolt: (163..176),
    udf: 272,
    bar_td: 109,
    cle_td: nil,
    emp_td: (121..130),
    pal_td: nil,
    ran_td: nil,
    sor_td: (122..128),
    wiz_td: nil,
    mje_td: (125..134),
    mne_td: 134,
    mjs_td: nil,
    mns_td: 115,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The ghostly counterpart of her living canine brothers, the barghest shimmers like a growling mass of mist as she raises her spectral head in a piercing, mournful howl. The undead beast appears to be nearly transparent, but the blood and shreds of flesh on her slavering jaws suggest that she is capable of considerable corpoeral harm."
    ],
    arrival: [],
    flee: [],
    death: [
      "The barghest falls to the ground and dies.",
      "The barghest rolls over and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A barghest charges at you!"
    ],
    bite: [
      "A barghest tries to bite you!"
    ],
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
