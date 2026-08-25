{
  schema_version: 3,
  name: "cave worm",
  noun: "",
  url: "https://gswiki.play.net/cave_worm",
  picture: "",
  level: 10,
  family: "Worm",
  type: "Worm",
  undead: false,
  blood: true,
  bones: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 120,
  speed: nil,
  height: 3,
  size: "large",
  areas: [
    {
      name: "Crystal Caves",
      uids: [24001..24017, 24019..24057]
    },
    {
      name: "Sea Caverns",
      uids: [392001..392008]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Ensnare",
        as: 139
      },
      {
        name: "Bite",
        as: 129
      },
      {
        name: "Charge (attack)",
        as: 139
      },
      {
        name: "Charge",
        as: 119
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (63..146),
    ranged: (50..81),
    bolt: (50..81),
    udf: 137,
    bar_td: nil,
    cle_td: nil,
    emp_td: 30,
    pal_td: nil,
    ran_td: nil,
    sor_td: 30,
    wiz_td: nil,
    mje_td: 30,
    mne_td: 30,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The cave worm is a colorless and legless serpentine creature. Its bizarre head is encircled with six three-foot horns, which cut through obstacles as it moves through subterranean caverns. Over 20 feet in length, it feeds on both rock and flesh, and caustic acid oozes from its body and its 10-foot prehensile tongue. Six-inch fangs allow it to casually tear through any armor, and its pungent acid dissolves what it cannot consume."
    ],
    arrival: [
      "A cave worm crawls in, leaving a trail of slime in its wake."
    ],
    flee: [
      "A cave worm slithers {direction}."
    ],
    death: [
      "The worm rolls over and dies."
    ],
    decay: [
      "A cave worm decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A cave worm charges at you!",
      "A cave worm tries to ensnare you!"
    ],
    bite: [
      "A cave worm tries to bite you!"
    ],
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
