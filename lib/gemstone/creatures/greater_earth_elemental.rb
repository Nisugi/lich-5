{
  schema_version: 3,
  name: "greater earth elemental",
  noun: "",
  url: "https://gswiki.play.net/greater_earth_elemental",
  picture: "",
  level: 88,
  family: "Elemental",
  type: "Elemental",
  undead: false,
  blood: nil,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Extraplanar",
    "Magical"
  ],
  bcs: true,
  max_hp: 510,
  speed: nil,
  height: 12,
  size: "huge",
  areas: [
    {
      name: "Bowels of Thanatoph",
      uids: [4293015..4293057]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound (attack)",
        as: (419..422)
      },
      {
        name: "Thrown Rock",
        as: 419
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
    melee: (166..314),
    ranged: nil,
    bolt: nil,
    udf: 657,
    bar_td: (326..332),
    cle_td: nil,
    emp_td: 343,
    pal_td: nil,
    ran_td: nil,
    sor_td: 372,
    wiz_td: nil,
    mje_td: (402..405),
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "30% damage factor reduction"
    ]
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: true,
    boxes: nil,
    skin: nil,
    other: "radiant crimson essence shard"
  },
  messaging: {
    description: [
      "Massive and thick, with broad shoulders but no apparent head, the earth elemental appears to be a composite of the earth itself. A large, craggy maw in the middle of the elemental's chest appears to be the creature's mouth, and the earth elemental's huge feet and giant-sized fists look like they would pulverize flesh without much effort at all.\n\nGreater earth elementals have DFRedux which will reduce the damage factors of weapons, including bolt spells, by 30% for AS-based attacks. This is in addition to their natural full plate equivalent armor."
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
