{
  schema_version: 3,
  name: "spectral lord",
  noun: "",
  url: "https://gswiki.play.net/spectral_lord",
  picture: "",
  level: 36,
  family: "Ghost",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Wraithenmist",
      uids: [13027044..13027086]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Ball and chain",
        as: 250
      },
      {
        name: "Morning star",
        as: (222..250)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Disarm Weapon"
      },
      {
        name: "Disarm"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (165..193),
    ranged: nil,
    bolt: nil,
    udf: 255,
    bar_td: 108,
    cle_td: nil,
    emp_td: (108..117),
    pal_td: 108,
    ran_td: nil,
    sor_td: (108..114),
    wiz_td: 114,
    mje_td: nil,
    mne_td: (113..119),
    mjs_td: nil,
    mns_td: 110,
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
    skin: nil,
    other: "Glowing violet essence shard"
  },
  messaging: {
    description: [
      "But a shade of its original self, the spectral lord is a dim and flickering image of a noble. Sharp, hawk-like features, and narrowed brilliant eyes give the appearance of a keen intellect. Worn and rotting gear hangs from its body, deteriorating from centuries of disuse."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A spectral lord swings a black steel ball &amp; chain at you!",
      "A spectral lord swings {weapon} at you!"
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
