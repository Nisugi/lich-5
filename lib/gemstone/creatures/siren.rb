{
  schema_version: 3,
  name: "siren",
  noun: "",
  url: "https://gswiki.play.net/siren",
  picture: "",
  level: 96,
  family: "Fey",
  type: "Hybrid",
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
  max_hp: 205,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Ruined Temple",
      uids: [3031025..3031042, 3031045..3031080]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Ensnare",
        as: 449
      },
      {
        name: "Coral-hilted sharply tapered longsword",
        as: 428
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Corrupt Essence (703)",
        cs: 402
      },
      {
        name: "Holding Song (1001)",
        cs: 402
      },
      {
        name: "Lullabye (1005)",
        cs: 402
      },
      {
        name: "Song of Depression (1015)",
        cs: 402
      },
      {
        name: "Song of Unravelling (1013)",
        cs: 402
      },
      {
        name: "Coral-hilted sharply tapered longsword",
        cs: 410
      },
      {
        name: "Ensnare",
        cs: 416
      }
    ],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "1",
    immunities: [],
    melee: (413..577),
    ranged: nil,
    bolt: (336..453),
    udf: 613,
    bar_td: 363,
    cle_td: 389,
    emp_td: (417..424),
    pal_td: 329,
    ran_td: nil,
    sor_td: (398..407),
    wiz_td: nil,
    mje_td: (403..435),
    mne_td: (411..423),
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Elemental Defense I",
      "Elemental Defense II",
      "Elemental Defense III",
      "Song of Mirrors",
      "Song of Tonis"
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
    other: "pristine siren's hair"
  },
  messaging: {
    description: [
      "The siren is a peculiar vision of beauty from the sea. Though her lower body is that of an iridescently scaled fish, it takes away nothing from the rest of her ravishingly feminine figure draped in long, golden blonde hair and surrounded by a mystical aura. Discretely hidden webbing beneath her arms that aids in navigating deep waters has given rise to the erroneous legend that the siren can also fly. The soothing song from these strangely beautiful creatures has pulled many sailors to their deaths, and every moment that the siren gazes at you with her captivating brilliant blue eyes and serenades you with liquid notes from her glistening full lips is a moment that you plunge deeper into danger yourself."
    ],
    arrival: [
      "A siren arrives, warbling softly.",
      "A siren just arrived."
    ],
    flee: [],
    death: [
      "The siren gives a plaintive wail before she slumps to her side and dies."
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the siren's ribs to move independently.",
      "A siren decays into compost.",
      "The siren's soft aura fades and her flesh crumbles to reveal the corpse of a hideous scaled creature, which then quickly decays away.",
      "A deft siren decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A siren swings {weapon} at you!",
      "A siren tries to ensnare you!"
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
