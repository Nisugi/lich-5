{
  schema_version: 3,
  name: "roa'ter wormling",
  noun: "",
  url: "https://gswiki.play.net/roa'ter_wormling",
  picture: "",
  level: 24,
  family: "Worm",
  type: "Worm",
  undead: false,
  blood: true,
  bones: nil,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 222,
  speed: nil,
  height: 2,
  size: "medium",
  areas: [
    {
      name: "Zaerthu Tunnels",
      uids: [13009001..13009040]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge (attack)",
        as: 197
      },
      {
        name: "Charge",
        as: 191
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Burrow"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (136..273),
    ranged: (140..179),
    bolt: (140..179),
    udf: 267,
    bar_td: 78,
    cle_td: (68..77),
    emp_td: (73..82),
    pal_td: (66..72),
    ran_td: nil,
    sor_td: (76..82),
    wiz_td: nil,
    mje_td: 81,
    mne_td: 82,
    mjs_td: 73,
    mns_td: (73..76),
    mnm_td: (72..78),
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The roa'ter wormling is large worm that seems not quite fully grown, and yet it is still a massive creature around fifteen feet long. Though young, it possesses great strength and moves quickly about. Light red in color, it seems to have no eyes, but its keen tremor sense quickly finds targets."
    ],
    arrival: [],
    flee: [
      "A roa'ter wormling slithers {direction}."
    ],
    death: [
      "The wormling rolls over and dies.",
      "A roa'ter wormling goes limp as it is rendered unconscious!"
    ],
    decay: [
      "A roa'ter wormling decays into compost.",
      "A combative roa'ter wormling decays into compost.",
      "A belligerent roa'ter wormling decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A roa'ter wormling charges at you!"
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
