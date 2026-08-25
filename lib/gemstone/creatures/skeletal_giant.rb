{
  schema_version: 3,
  name: "skeletal giant",
  noun: "",
  url: "https://gswiki.play.net/skeletal_giant",
  picture: "",
  level: 33,
  family: "Giant",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 380,
  speed: nil,
  height: 12,
  size: "large",
  areas: [
    {
      name: "Upper Trollfang",
      uids: [16065..16071]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound",
        as: 227
      },
      {
        name: "Fist",
        as: 227
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
    asg: nil,
    immunities: [],
    melee: 197,
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: nil,
    cle_td: 105,
    emp_td: 106,
    pal_td: nil,
    ran_td: nil,
    sor_td: 112,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a skeletal giant bone",
    other: nil
  },
  messaging: {
    description: [
      "Once haughtily roaming the land of the living, this fearsome giant now mindlessly and unceasingly moves from place to place. The skeletal giant glares straight ahead, eyes like smoldering coals contrasting with the bleached white bone of its thick skull. Although its flesh is mostly a memory, the strong, heavy bones are still intact, and an unseen force keeps them connected, driven toward the destruction of all things living."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [
      "A skeletal giant turns to dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A skeletal giant pounds at you with {pronoun} fist!"
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
