{
  schema_version: 3,
  name: "elder tree spirit",
  noun: "",
  url: "https://gswiki.play.net/elder_tree_spirit",
  picture: "",
  level: 30,
  family: "Tree",
  type: "Plantlife",
  undead: true,
  blood: nil,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: nil,
  max_hp: 350,
  speed: nil,
  height: 12,
  size: "huge",
  areas: [
    {
      name: "Abandoned Farm",
      uids: [4124101..4124112, 4124114..4124124]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Ensnare (attack)"
      },
      {
        name: "Ensnare",
        as: 182
      }
    ],
    bolt_spells: [
      {
        name: "Major Shock (910)",
        as: (208..220)
      }
    ],
    warding_spells: [
      {
        name: "Unbalance (110)",
        cs: (157..169)
      }
    ],
    offensive_spells: [
      {
        name: "Earthen Fury (917)"
      },
      {
        name: "Call Lightning (125)"
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
    asg: "11N",
    immunities: [],
    melee: (71..162),
    ranged: nil,
    bolt: nil,
    udf: 97,
    bar_td: 99,
    cle_td: (109..115),
    emp_td: (108..117),
    pal_td: (90..99),
    ran_td: nil,
    sor_td: (109..115),
    wiz_td: nil,
    mje_td: nil,
    mne_td: 120,
    mjs_td: nil,
    mns_td: (105..114),
    mnm_td: (84..90),
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
    other: "Glimmering blue essence dust"
  },
  messaging: {
    description: [
      "The undead tree spirit resides among its living brethren, barely distinguishable from them until it is awakened from its slumber. It resembles many different types of towering trees, for a tree spirit is able to take on the shape and appearance of the forest around it. Being spirit, though, it is not quite solid, not quite sharply defined, and its appearance shifts slightly as it moves. Many are fooled by a tree spirit's soft, soothing whispering, only to realize with horror that it is the preparation of a lethal spell."
    ],
    arrival: [
      "An elder tree spirit just arrived."
    ],
    flee: [
      "An elder tree spirit heads {direction}."
    ],
    death: [
      "The tree spirit slowly settles to the ground and begins to dissipate."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "An elder tree spirit gestures at you!",
      "An elder tree spirit tries to ensnare you!"
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
