{
  schema_version: 3,
  name: "writhing frost-glazed vine",
  noun: "",
  url: "https://gswiki.play.net/writhing_frost-glazed_vine",
  picture: "",
  level: 40,
  family: "Plant",
  type: "Plantlife",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 379,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Abandoned Farm",
      uids: [4124037..4124049]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Vine fling"
      },
      {
        name: "Stinger",
        as: 217
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (93..238),
    ranged: nil,
    bolt: nil,
    udf: (247..281),
    bar_td: nil,
    cle_td: (162..168),
    emp_td: (162..171),
    pal_td: (137..143),
    ran_td: nil,
    sor_td: (170..176),
    wiz_td: nil,
    mje_td: 172,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (162..171),
    mnm_td: (120..129),
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
    skin: "thorn-ridden appendage",
    other: nil
  },
  messaging: {
    description: [
      "This \"little\" vine seems to be a bit on the feeling poorly side but if it catches you, likely you'll feel pretty bad too."
    ],
    arrival: [
      "A writhing frost-glazed vine slithers in grasping and twisting as it arrives."
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A writhing frost-glazed vine stabs at you with {pronoun} stinger!"
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
