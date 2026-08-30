{
  schema_version: 3,
  name: "ashen patrician vampire",
  noun: "",
  url: "https://gswiki.play.net/ashen_patrician_vampire",
  picture: "",
  level: 107,
  family: "Humanoid",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: false,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 375,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Moonsedge",
      uids: [4577106..4577123, 4577201..4577214, 4577216..4577249]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Rapier",
        as: "566 to"
      },
      {
        name: "Charge",
        as: 530
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Blind",
        cs: 455
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Disarm Weapon"
      },
      {
        name: "Feint"
      },
      {
        name: "Pounce"
      }
    ],
    special_abilities: [
      {
        name: "Mstrike"
      },
      {
        name: "Cripple"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (427..567),
    ranged: (446..704),
    bolt: (446..704),
    udf: 530,
    bar_td: (503..507),
    cle_td: (486..492),
    emp_td: 488,
    pal_td: (470..476),
    ran_td: 521,
    sor_td: "503 to 527",
    wiz_td: nil,
    mje_td: (419..544),
    mne_td: (419..544),
    mjs_td: nil,
    mns_td: 492,
    mnm_td: nil,
    defensive_spells: [
      "Mindward (1208)",
      "Blink (1215)"
    ],
    defensive_abilities: [],
    special_defenses: [
      "Health regeneration"
    ]
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a swept-hilt veil iron rapier adorned with jewels"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      ""
    ],
    arrival: [
      "An ashen patrician vampire prowls in, deadly grace in every fluid step.  With a smirk that twists her exquisite features, she bares her shining white fangs.",
      "An ashen patrician vampire strides in, moving like flowing water."
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
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
