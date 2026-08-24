{
  schema_version: 3,
  name: "mammoth arachnid",
  noun: "",
  url: "https://gswiki.play.net/mammoth_arachnid",
  picture: "",
  level: 30,
  family: "Arachnid",
  type: "Arachnid",
  undead: false,
  blood: true,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 350,
  speed: nil,
  height: 5,
  size: "large",
  areas: [
    {
      name: "Sorcerer's Isle",
      uids: [14202001..14202023]
    },
    {
      name: "Spider Temple",
      uids: [13020..13036]
    },
    {
      name: "unmapped",
      uids: [4217102..4217132]
    },
    {
      name: "Vornavian Coast",
      uids: [4218301..4218325]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 212
      },
      {
        name: "Ensnare",
        as: 222
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Web"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (167..289),
    ranged: 120,
    bolt: nil,
    udf: 317,
    bar_td: (90..96),
    cle_td: nil,
    emp_td: (88..97),
    pal_td: nil,
    ran_td: nil,
    sor_td: (89..101),
    wiz_td: nil,
    mje_td: 100,
    mne_td: 100,
    mjs_td: nil,
    mns_td: 91,
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
    skin: "a mammoth arachnid mandible",
    other: nil
  },
  messaging: {
    description: [
      "The mammoth arachnid towers over its prey, fangs dripping poison mixed with fresh blood from its last kill shortly ago. Its entire body is draped with long, coal black hair, with the exception of a small patch on the very rear tip of its bulbous abdomen. This contains the spinnerets it uses to effectively web its prey before injecting the victim with a caustic poison, resulting in slow disintegration from the inside. The arachnid's eight crimson eyes dart about, making certain no prey, no matter how small, escapes."
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
