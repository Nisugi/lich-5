{
  schema_version: 3,
  name: "necrotic snake",
  noun: "",
  url: "https://gswiki.play.net/necrotic_snake",
  picture: "",
  level: 48,
  family: "Reptilian",
  type: "Ophidian",
  undead: true,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 290,
  speed: nil,
  height: 1,
  size: "medium",
  areas: [
    {
      name: "Marsh Keep",
      uids: [376001..376001, 376003..376010, 376015..376018, 376020..376034, 376040..376044]
    },
    {
      name: "Fethayl Bog",
      uids: [13038001..13038031]
    },
    {
      name: "unmapped",
      uids: [376002..376002, 376019..376019, 376035..376039]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Strike",
        as: (277..291)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Constriction"
      },
      {
        name: "Poison Spit"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (255..488),
    ranged: nil,
    bolt: nil,
    udf: 475,
    bar_td: 161,
    cle_td: 176,
    emp_td: (175..184),
    pal_td: nil,
    ran_td: 119,
    sor_td: (176..194),
    wiz_td: nil,
    mje_td: (196..202),
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
  treasure: {
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a snake fang",
    other: nil
  },
  messaging: {
    description: [
      "The fearsome product of magical experimentation, the necrotic snake is larger than most men. Rotting scales cover the length of the undead reptile in a diamond pattern formed of various hues of brown, gold, and black. Large gashes in the snake's side reveal thin rib bones and the carcasses of previous meals, while leaking rancid fumes into the surrounding air."
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
