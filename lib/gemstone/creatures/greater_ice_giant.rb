{
  schema_version: 3,
  name: "greater ice giant",
  noun: "",
  url: "https://gswiki.play.net/greater_ice_giant",
  picture: "",
  level: 46,
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
  max_hp: 400,
  speed: nil,
  height: 20,
  size: "huge",
  areas: [
    {
      name: "Sleeping Lady Mountains",
      uids: [4560030..4560053]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Battle-axe",
        as: (236..306)
      }
    ],
    bolt_spells: [
      {
        name: "Major Cold (907)",
        as: 215
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Spirit Dispel"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (164..305),
    ranged: nil,
    bolt: 183,
    udf: 289,
    bar_td: (151..156),
    cle_td: nil,
    emp_td: (164..173),
    pal_td: nil,
    ran_td: nil,
    sor_td: (175..184),
    wiz_td: nil,
    mje_td: (184..189),
    mne_td: (180..183),
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
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
      "Standing nearly three times as tall as a giantman, the ice giant trails frost and snow in his wake. Seemingly carved from living ice and snow, icy blue eyes set beneath a heavily furrowed brow and a tangled mop of icy blue hair provide a splash of color against the ice giant's dull white frost-covered skin."
    ],
    arrival: [
      "A greater ice giant lumbers in, followed by a hailing icestorm!"
    ],
    flee: [],
    death: [
      "The ice giant cries out in cold agony one last time and dies.",
      "The ice giant falls to the ground motionless."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A greater ice giant points an icy finger at you!",
      "A greater ice giant swings {weapon} at you!"
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
