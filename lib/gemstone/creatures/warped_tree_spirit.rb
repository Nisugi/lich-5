{
  schema_version: 3,
  name: "warped tree spirit",
  noun: "",
  url: "https://gswiki.play.net/warped_tree_spirit",
  picture: "",
  level: 68,
  family: "Tree",
  type: "Plantlife",
  undead: true,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: true,
  max_hp: 383,
  speed: nil,
  height: 10,
  size: "large",
  areas: [
    {
      name: "Red Forest",
      uids: [480216..480230, 17006216..17006230]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Fear"
      },
      {
        name: "Pain (711)"
      },
      {
        name: "Ensnare",
        as: 301
      }
    ],
    offensive_spells: [
      {
        name: "Earthen Fury (917)"
      },
      {
        name: "Powersink (1203)"
      }
    ],
    maneuvers: [
      {
        name: "Vine fling"
      },
      {
        name: "Gesture"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (177..326),
    ranged: (181..214),
    bolt: (181..214),
    udf: 333,
    bar_td: (230..242),
    cle_td: (252..261),
    emp_td: 269,
    pal_td: (214..223),
    ran_td: nil,
    sor_td: (249..261),
    wiz_td: nil,
    mje_td: 290,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: (198..204),
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
    magic_items: nil,
    gems: nil,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The undead tree spirit resides among its living brethren, barely distinguishable from them until it is awakened from its slumber. Once awakened, terrible gashes and scars appear across its trunk, many of which would have been entirely fatal in life. Its outline is not quite defined and its appearance shifts noticeably as it moves. The occasional flicker reveals a horrifically malformed visage, before fading back to its normal tree-like state."
    ],
    arrival: [
      "A warped tree spirit just arrived."
    ],
    flee: [],
    death: [
      "The tree spirit slowly settles to the ground and begins to dissipate."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A warped tree spirit tries to ensnare you!"
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
