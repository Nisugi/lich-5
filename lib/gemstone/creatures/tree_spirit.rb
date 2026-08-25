{
  schema_version: 3,
  name: "tree spirit",
  noun: "",
  url: "https://gswiki.play.net/tree_spirit",
  picture: "",
  level: 26,
  family: "Tree",
  type: "Plantlife",
  undead: true,
  blood: false,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: nil,
  max_hp: 310,
  speed: nil,
  height: 10,
  size: "large",
  areas: [
    {
      name: "Lunule Weald",
      uids: [14016039..14016057, 14016059..14016082]
    },
    {
      name: "Upper Trollfang",
      uids: [2123001..2123010]
    },
    {
      name: "Abandoned Farm",
      uids: [4124001..4124006]
    },
    {
      name: "Vornavian Coast",
      uids: [4214303..4214323]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Ensnare",
        as: 190
      }
    ],
    bolt_spells: [
      {
        name: "Major Shock (910)",
        as: 194
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Call Lightning (125)"
      },
      {
        name: "Call Wind (912)"
      },
      {
        name: "Earthen Fury (917)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (112..226),
    ranged: (105..126),
    bolt: (105..126),
    udf: 230,
    bar_td: 78,
    cle_td: 82,
    emp_td: (81..90),
    pal_td: nil,
    ran_td: nil,
    sor_td: (88..91),
    wiz_td: nil,
    mje_td: (91..97),
    mne_td: 91,
    mjs_td: nil,
    mns_td: 84,
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
    skin: nil,
    other: "Glimmering blue essence shard"
  },
  messaging: {
    description: [
      "The undead tree spirit resides among its living brethren, barely distinguishable from them until it is awakened from its slumber. It resembles many different types of towering trees, for a tree spirit is able to take on the shape and appearance of the forest around it. Being spirit, though, it is not quite solid, not quite sharply defined, and its appearance shifts slightly as it moves. Many are fooled by a tree spirit's soft, soothing whispering, only to realize with horror that it is the preparation of a lethal spell."
    ],
    arrival: [
      "A tree spirit just arrived."
    ],
    flee: [],
    death: [
      "The tree spirit slowly settles to the ground and begins to dissipate."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A tree spirit gestures at you!"
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
