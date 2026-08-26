{
  schema_version: 3,
  name: "lich qyn'arj",
  noun: "",
  url: "https://gswiki.play.net/lich_qyn'arj",
  picture: "",
  level: 84,
  family: "Reptilian",
  type: "Hybrid",
  undead: true,
  blood: false,
  bones: nil,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead",
    "Magical"
  ],
  bcs: true,
  max_hp: 245,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Old Ta'Faendryl",
      uids: [17002201..17002247, 17002301..17002325]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 382
      },
      {
        name: "Smash",
        as: 363
      }
    ],
    bolt_spells: [
      {
        name: "Minor Cold (1709)",
        as: 370
      },
      {
        name: "Web (118)",
        as: 351
      }
    ],
    warding_spells: [
      {
        name: "Unbalance (110)",
        cs: 341
      },
      {
        name: "Web (118)",
        cs: 341
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Gesture"
      },
      {
        name: "Ground Slam"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "6",
    immunities: [],
    melee: (312..447),
    ranged: nil,
    bolt: nil,
    udf: 564,
    bar_td: (333..336),
    cle_td: nil,
    emp_td: nil,
    pal_td: nil,
    ran_td: nil,
    sor_td: (368..377),
    wiz_td: nil,
    mje_td: nil,
    mne_td: 391,
    mjs_td: nil,
    mns_td: (353..359),
    mnm_td: (305..311),
    defensive_spells: [
      "Lesser Shroud",
      "Spirit Shield",
      "Spirit Warding II"
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The qyn'arj is a creature of legend, a massive serpent held aloft on brightly colored wings. But the lich qyn'arj before you has been animated by some means. The qyn'arj's body seems to hover there without the need to beat its rotting and mottled wings. Decaying flesh covers its body, but the head is completely skeletal and polished to the fine white of bleached bone. Swirling red pinpoints float where eyes used to be, and dagger sharp teeth can be seen inside its maw."
    ],
    arrival: [
      "A lich qyn'arj arrives on powerful strokes of its rotting wings."
    ],
    flee: [],
    death: [
      "The lich qyn'arj spasms violently and suddenly goes still, its body turning to stone."
    ],
    decay: [
      "The stone form of a lich qyn'arj crumbles away to dust.",
      "Acid dissolves connecting cartilage, freeing the lich qyn'arj's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A lich qyn'arj gestures with rotting mottled wings at you!",
      "A lesser construct raises lich qyn'arj massive foot and attempts to smash you!"
    ],
    bite: [
      "A lich qyn'arj tries to bite you!"
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
