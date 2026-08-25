{
  schema_version: 3,
  name: "jungle troll chieftain",
  noun: "",
  url: "https://gswiki.play.net/jungle_troll_chieftain",
  picture: "",
  level: 30,
  family: "Troll",
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
  max_hp: 350,
  speed: nil,
  height: 10,
  size: "large",
  areas: [
    {
      name: "Karazja Jungle",
      uids: [5006001..5006009, 5006040..5006040]
    },
    {
      name: "Greymist Woods",
      uids: [3021001..3021016, 3022001..3022034]
    },
    {
      name: "unmapped",
      uids: [5006010..5006039]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bastard sword",
        as: 212
      },
      {
        name: "Claw (attack)",
        as: 227
      },
      {
        name: "Vine-wrapped rusting bastard sword",
        as: 272
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Call Swarm (615)"
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
    asg: "12N",
    immunities: [],
    melee: 109,
    ranged: 86,
    bolt: 102,
    udf: 236,
    bar_td: 89,
    cle_td: nil,
    emp_td: (98..108),
    pal_td: nil,
    ran_td: nil,
    sor_td: (105..112),
    wiz_td: nil,
    mje_td: (109..114),
    mne_td: 98,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Natural Colors (601)",
      "Self Control (613)",
      "Mobility (618)",
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
    skin: "a scrap of troll skin",
    other: "a glimmering blue essence shard"
  },
  messaging: {
    description: [
      "A thin, tall creature, the troll chieftain scampers over the terrain in quick bursts. The a jungle troll chieftain's dark green, mottled skin displays an oily sheen, and hair is nowhere to be found on its body. An elongated face, perhaps two feet from the end of the exaggerated chin to the tips of the pointed ears, sits atop a thin, rubbery neck. Deep orange, slitted pupils nest horizontally in the steel grey eyes, and clusters of sharp orange horns poke up from the troll chieftain's head to surround the extended ears."
    ],
    arrival: [
      "A jungle troll chieftain just arrived!"
    ],
    flee: [],
    death: [
      "A jungle troll chieftain goes limp as he is rendered unconscious!",
      "A jungle troll chieftain goes limp as she is rendered unconscious!"
    ],
    decay: [
      "A jungle troll chieftain decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A jungle troll chieftain swings {weapon} at you!"
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
