{
  schema_version: 3,
  name: "jungle troll",
  noun: "",
  url: "https://gswiki.play.net/jungle_troll",
  picture: "",
  level: 26,
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
  max_hp: 310,
  speed: nil,
  height: 9,
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
        name: "Falchion",
        as: 209
      },
      {
        name: "Claw (attack)",
        as: 199
      },
      {
        name: "Bamboo-hilted machete",
        as: 209
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Lash"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: 116,
    ranged: 91,
    bolt: 91,
    udf: 157,
    bar_td: nil,
    cle_td: 97,
    emp_td: 99,
    pal_td: (90..93),
    ran_td: nil,
    sor_td: 99,
    wiz_td: nil,
    mje_td: 98,
    mne_td: 98,
    mjs_td: nil,
    mns_td: 99,
    mnm_td: (78..85),
    defensive_spells: [
      "Spirit Warding II (107)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a bamboo-hilted machete"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a troll knuckle",
    other: nil
  },
  messaging: {
    description: [
      "A thin, tall creature, the jungle troll scampers over the terrain in quick bursts, its long legs and arms seemingly moving in different directions as it shifts course. The jungle troll's dark green, mottled skin displays an oily sheen, and hair is nowhere to be found on its body. The jungle troll's most striking feature, though, is its elongated face. An exaggerated chin extends a foot or more below a thin-lipped mouth, and tall, pointed ears stand up straight atop its head. Its eyes appear stretched, and the silver, slitted pupils could almost be called cat-like if they didn't run horizontally instead of vertically."
    ],
    arrival: [
      "A jungle troll lumbers in at a run!",
      "A jungle troll just arrived!"
    ],
    flee: [],
    death: [
      "A jungle troll goes limp as she is rendered unconscious!"
    ],
    decay: [
      "A jungle troll decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A jungle troll swings {weapon} at you!"
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
