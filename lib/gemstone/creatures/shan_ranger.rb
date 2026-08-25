{
  schema_version: 3,
  name: "shan ranger",
  noun: "",
  url: "https://gswiki.play.net/shan_ranger",
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
  max_hp: 240,
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
        name: "Longsword",
        as: (276..294)
      }
    ],
    bolt_spells: [
      {
        name: "Web (118)",
        as: 276
      }
    ],
    warding_spells: [
      {
        name: "Wild Entropy (603)",
        cs: 188
      },
      {
        name: "Web (118)",
        cs: 194
      }
    ],
    offensive_spells: [
      {
        name: "Phoen's Strength (606)"
      },
      {
        name: "Spirit Strike (117)"
      },
      {
        name: "Spike Thorn (616)"
      },
      {
        name: "Tangleweed (610)"
      },
      {
        name: "Sounds (607)"
      },
      {
        name: "Call Swarm (615)"
      }
    ],
    maneuvers: [
      {
        name: "Disarm"
      },
      {
        name: "Lash"
      },
      {
        name: "Web"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "11",
    immunities: [],
    melee: (279..377),
    ranged: nil,
    bolt: nil,
    udf: 373,
    bar_td: 135,
    cle_td: nil,
    emp_td: (142..152),
    pal_td: nil,
    ran_td: (135..138),
    sor_td: (160..166),
    wiz_td: nil,
    mje_td: 159,
    mne_td: 165,
    mjs_td: nil,
    mns_td: 146,
    mnm_td: nil,
    defensive_spells: [
      "Mobility (618)",
      "Natural Colors (601)",
      "Self Control (613)",
      "Spirit Warding I (101)",
      "Spirit Defense (103)",
      "Spirit Warding II (107)"
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
    skin: nil,
    other: "Tiny golden seed"
  },
  messaging: {
    description: [
      "The shan ranger stands in a half-crouch, his long, knotty legs giving him that lanky, dangerous look of a wolf. Walking upright, the body covered with mottled grey fur and his long arms conclude in large, clawed hands with semi-opposable thumbs. The shan ranger's dog-like visage is fierce, with slavering jaws and eyes that glow like something out of a bad dream."
    ],
    arrival: [],
    flee: [],
    death: [
      "The shan ranger howls out one last time and dies.",
      "The shan ranger yips in pain as he falls to the ground motionless.",
      "The shan ranger yips in pain as she falls to the ground motionless."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A shan ranger swings {weapon} at you!"
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
