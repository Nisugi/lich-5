{
  schema_version: 3,
  name: "hunter troll",
  noun: "",
  url: "https://gswiki.play.net/hunter_troll",
  picture: "",
  level: 30,
  family: "troll",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Teorainn Dale",
      uids: [13024010..13024027, 13024030..13024079]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Jeddart-axe",
        as: 232
      },
      {
        name: "Bite",
        as: 222
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Trip"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16",
    immunities: [],
    melee: 115,
    ranged: 63,
    bolt: nil,
    udf: (171..190),
    bar_td: 90,
    cle_td: 90,
    emp_td: 90,
    pal_td: (87..90),
    ran_td: 90,
    sor_td: 90,
    wiz_td: 90,
    mje_td: 90,
    mne_td: 90,
    mjs_td: 90,
    mns_td: 90,
    mnm_td: (90..100),
    defensive_spells: [
      "Natural Colors",
      "Self Control"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a chain hauberk",
    "a jeddart-axe"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a troll tongue",
    other: "a small troll tooth"
  },
  messaging: {
    description: [
      "Though lankier than most of its brethren, the hunter troll still towers over the tallest of giantmen. Its skin is slightly paler than most trolls, but the intelligence which smolders in its dark eyes forces you to dismiss any thought of this being a weak or inferior breed."
    ],
    arrival: [
      "A hunter troll just arrived!"
    ],
    flee: [],
    death: [
      "A hunter troll goes limp as he is rendered unconscious!",
      "The hunter troll slumps to the ground with a final snarl.",
      "The hunter troll slumps to the ground."
    ],
    decay: [
      "A hunter troll decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A hunter troll swings {weapon} at you!"
    ],
    bite: [
      "A hunter troll tries to bite you!"
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
