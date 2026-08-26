{
  schema_version: 3,
  name: "lesser ice giant",
  noun: "",
  url: "https://gswiki.play.net/lesser_ice_giant",
  picture: "",
  level: 41,
  family: "Giant",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Element-based"
  ],
  bcs: true,
  max_hp: 391,
  speed: nil,
  height: 15,
  size: "huge",
  areas: [
    {
      name: "Sleeping Lady Mountains",
      uids: [4560011..4560036]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Massive Icicle",
        as: 299
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "AS Booster"
      },
      {
        name: "Ground Slam"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (259..322),
    ranged: (226..244),
    bolt: (226..244),
    udf: 354,
    bar_td: (133..136),
    cle_td: (146..152),
    emp_td: (146..152),
    pal_td: (120..129),
    ran_td: nil,
    sor_td: (154..160),
    wiz_td: nil,
    mje_td: 162,
    mne_td: (162..165),
    mjs_td: nil,
    mns_td: (137..146),
    mnm_td: (114..123),
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
    skin: "a giant scalp",
    other: nil
  },
  messaging: {
    description: [
      "Standing twice as tall as the tallest giantman, the ice giant trails frost and snow in her wake. Seemingly carved from living ice and snow, icy blue eyes set beneath a heavily furrowed brow and a tangled mop of icy blue hair provide a splash of color against the ice giant's dull white frost-covered skin."
    ],
    arrival: [
      "A lesser ice giant lumbers in, followed by a hailing icestorm!"
    ],
    flee: [
      "A lesser ice giant lumbers {direction}, followed by a hailing icestorm."
    ],
    death: [
      "The ice giant cries out in cold agony one last time and dies.",
      "The ice giant falls to the ground motionless."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A lesser ice giant swings {weapon} at you!"
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
