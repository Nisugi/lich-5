{
  schema_version: 3,
  name: "greater bog troll",
  noun: "",
  url: "https://gswiki.play.net/greater_bog_troll",
  picture: "",
  level: 39,
  family: "Troll",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 11,
  size: "large",
  areas: [
    {
      name: "Miasmal Forest",
      uids: [5003039..5003050, 5004035..5004044, 5004049..5004053]
    },
    {
      name: "unmapped",
      uids: [5004045..5004048, 5004054..5004054]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Axe",
        as: 262
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Call Swarm (615)"
      },
      {
        name: "Sounds (607)"
      },
      {
        name: "Tangleweed (610)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: 163,
    ranged: 97,
    bolt: (150..163),
    udf: 269,
    bar_td: nil,
    cle_td: nil,
    emp_td: 121,
    pal_td: nil,
    ran_td: 102,
    sor_td: 130,
    wiz_td: nil,
    mje_td: 136,
    mne_td: 135,
    mjs_td: 121,
    mns_td: 121,
    mnm_td: nil,
    defensive_spells: [
      "Mobility (618)",
      "Natural Colors (601)",
      "Self Control (613)",
      "Spirit Defense (103)",
      "Spirit Warding I (101)",
      "Spirit Warding II (107)"
    ],
    defensive_abilities: [],
    special_defenses: [
      "Hides when attacked"
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
    skin: "a cracked troll jawbone",
    other: nil
  },
  messaging: {
    description: [
      "Similar to its smaller cousin, the bog troll, the greater bog troll's skin is a dark yellow mottled with patches of brownish green. However, where the bog troll is hairless, the greater bog troll displays a thick mane of oily, dark brown hair that flows both down the center of its back and across its shoulders. Its head is barren, and bulbous green eyes sit nearly atop the flat cranium. Sharp claws extend from its oversized, webbed hands and feet, and long, jagged teeth glint menacingly within its wide mouth."
    ],
    arrival: [
      "A greater bog troll just arrived!",
      "A belligerent greater bog troll just arrived!"
    ],
    flee: [],
    death: [
      "The greater bog troll's body goes rigid and her eyes roll back into her head as she dies.",
      "The greater bog troll's body goes rigid and his eyes roll back into his head as he dies.",
      "A greater bog troll goes limp as he is rendered unconscious!",
      "A greater bog troll goes limp as she is rendered unconscious!"
    ],
    decay: [
      "A greater bog troll decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A greater bog troll swings {weapon} at you!"
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
