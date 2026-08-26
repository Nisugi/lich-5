{
  schema_version: 3,
  name: "forest trali shaman",
  noun: "",
  url: "https://gswiki.play.net/forest_trali_shaman",
  picture: "",
  level: 46,
  family: "Trali",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 268,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Gyldemar Forest",
      uids: [13028038..13028080]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Mace",
        as: 271
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Bind (214)",
        cs: 224
      },
      {
        name: "Calm (201)"
      },
      {
        name: "Silence (210)"
      },
      {
        name: "Unbalance (110)"
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
      }
    ],
    maneuvers: [
      {
        name: "Gesture"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "9",
    immunities: [],
    melee: (261..318),
    ranged: 273,
    bolt: 273,
    udf: 330,
    bar_td: (149..172),
    cle_td: (162..171),
    emp_td: (167..170),
    pal_td: (145..155),
    ran_td: nil,
    sor_td: (171..193),
    wiz_td: nil,
    mje_td: 200,
    mne_td: 198,
    mjs_td: nil,
    mns_td: (170..183),
    mnm_td: (163..166),
    defensive_spells: [
      "Natural Colors (601)",
      "Spirit Defense (103)",
      "Spirit Shield (202)",
      "Spell Shield (219)",
      "Spirit Warding I (101)"
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
    skin: "a trali scalp",
    other: "Glowing violet essence dust,"
  },
  messaging: {
    description: [
      "Standing nearly six feet tall, the man-like trali shaman watches adventurers' every move with piercing grey eyes. A short matted, reddish grey mane covers his head and his skin has a greenish grey hue. There is little doubt that the stealthy trali shaman can be a formidable opponent when need arises, or when he is hard pressed."
    ],
    arrival: [
      "A forest trali shaman arrives, sniffing the air for prey!",
      "A forest trali shaman stalks in."
    ],
    flee: [],
    death: [],
    decay: [
      "A forest trali shaman's body crumbles into dust and is scattered by a stiff breeze.",
      "Acid dissolves connecting cartilage, freeing the trali shaman's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A forest trali shaman swings {weapon} at you!"
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
