{
  schema_version: 3,
  name: "shan warrior",
  noun: "",
  url: "https://gswiki.play.net/shan_warrior",
  picture: "",
  level: 42,
  family: "Shan",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4218301..4218325]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Flamberge",
        as: (259..271)
      },
      {
        name: "Longsword",
        as: (231..259)
      },
      {
        name: "Jeddart-axe",
        as: (237..259)
      },
      {
        name: "Sharply-honed vultite handaxe",
        as: 375
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
    asg: "see other info",
    immunities: [],
    melee: (163..349),
    ranged: nil,
    bolt: nil,
    udf: 407,
    bar_td: (117..150),
    cle_td: nil,
    emp_td: (123..132),
    pal_td: 126,
    ran_td: nil,
    sor_td: (117..135),
    wiz_td: nil,
    mje_td: 132,
    mne_td: (129..132),
    mjs_td: nil,
    mns_td: 150,
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
    skin: nil,
    other: "Tiny golden seed"
  },
  messaging: {
    description: [
      "The shan warrior stands in a half-crouch, her long, knotty legs giving her that lanky, dangerous look of a wolf. Walking upright, the body covered with mottled grey fur and her long arms conclude in large, clawed hands with semi-opposable thumbs. The shan warrior's dog-like visage is fierce, with slavering jaws and eyes that glow like something out of a bad dream."
    ],
    arrival: [],
    flee: [],
    death: [
      "The shan warrior howls out one last time and dies.",
      "The shan warrior yips in pain as she falls to the ground motionless.",
      "The shan warrior yips in pain as he falls to the ground motionless."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A shan warrior swings {weapon} at you!"
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
