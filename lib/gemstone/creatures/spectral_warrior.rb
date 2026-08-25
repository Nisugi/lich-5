{
  schema_version: 3,
  name: "spectral warrior",
  noun: "",
  url: "https://gswiki.play.net/spectral_warrior",
  picture: "",
  level: 34,
  family: "Ghost",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: nil,
  max_hp: 322,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "The Citadel",
      uids: [2100002..2100056]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: 230
      },
      {
        name: "Flail",
        as: (230..250)
      },
      {
        name: "Broadsword",
        as: 250
      },
      {
        name: "Halberd",
        as: (250..288)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Disarm"
      },
      {
        name: "Halberd Sweep"
      }
    ],
    special_abilities: [
      {
        name: "Attack strength boost"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "various",
    immunities: [],
    melee: (147..212),
    ranged: (149..167),
    bolt: 169,
    udf: 191,
    bar_td: nil,
    cle_td: nil,
    emp_td: (102..105),
    pal_td: nil,
    ran_td: nil,
    sor_td: (93..102),
    wiz_td: nil,
    mje_td: (94..109),
    mne_td: (94..109),
    mjs_td: nil,
    mns_td: 102,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Immune to Unbalance"
    ]
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
    other: nil
  },
  messaging: {
    description: [
      "The spectral warrior shimmers for an instant, seemingly half real and half phantom, his semi-ethereal armor faintly gleaming as it moves. A gaunt face stares out from beneath the ghostly helm, his eyes swirling pits of blackness that seek out living foes, hatefully wishing to resign others to his own horrible fate."
    ],
    arrival: [
      "A spectral warrior strides in!"
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A spectral warrior swings {weapon} at you!"
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
