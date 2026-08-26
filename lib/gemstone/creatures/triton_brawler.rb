{
  schema_version: 3,
  name: "triton brawler",
  noun: "",
  url: "https://gswiki.play.net/triton_brawler",
  picture: "",
  level: 98,
  family: "Triton",
  type: "Biped",
  undead: false,
  blood: true,
  bones: nil,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 337,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Atoll",
      uids: [7138101..7138119]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "UCS",
        as: "414 UAF"
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Crowd Press"
      },
      {
        name: "Haymaker"
      },
      {
        name: "Headbutt"
      },
      {
        name: "Sucker Punch"
      },
      {
        name: "Twin Hammerfists"
      },
      {
        name: "Charge"
      },
      {
        name: "Fist"
      },
      {
        name: "Grapple"
      },
      {
        name: "Jab"
      },
      {
        name: "Kick"
      },
      {
        name: "Punch"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "11N",
    immunities: [],
    melee: (321..413),
    ranged: nil,
    bolt: nil,
    udf: 759,
    bar_td: 385,
    cle_td: nil,
    emp_td: (412..422),
    pal_td: nil,
    ran_td: nil,
    sor_td: (410..437),
    wiz_td: nil,
    mje_td: (458..460),
    mne_td: 435,
    mjs_td: nil,
    mns_td: (403..413),
    mnm_td: 419,
    defensive_spells: [
      "Iron Skin (1202)",
      "Mindward (1208)",
      "Brace (1214)",
      "Premonition (1220)"
    ],
    defensive_abilities: [],
    special_defenses: [
      "Slippery Mind"
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
    skin: "darkened triton hide",
    other: nil
  },
  messaging: {
    description: [
      "Wearing only a linen and leather pteruges, a triton brawler is covered in roughly inked black tattoos, a cavalcade of runes, sigils, and symbols twining about one another and obscuring his grey-blue flesh. Across his amphibian-like head is a tattoo of a powerful tentacle crushing a trident in its suckered grip. The brawler's eyes dart warily this way and that, and his tongue flicks in and out with deceptive laziness."
    ],
    arrival: [
      "A triton brawler just arrived.",
      "A triton brawler just arrived, limping badly.",
      "A tough triton brawler just arrived, limping badly.",
      "A triton brawler just arrived, limping."
    ],
    flee: [
      "A triton brawler heads {direction}."
    ],
    death: [
      "The triton brawler gurgles once and goes still, a wrathful look on her face."
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the triton brawler's ribs to move independently."
    ],
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
