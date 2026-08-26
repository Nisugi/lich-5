{
  schema_version: 3,
  name: "treekin warrior",
  noun: "",
  url: "https://gswiki.play.net/treekin_warrior",
  picture: "",
  level: 80,
  family: "Tree",
  type: "Plantlife",
  undead: false,
  blood: true,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Magical"
  ],
  bcs: true,
  max_hp: 408,
  speed: nil,
  height: 16,
  size: "large",
  areas: [
    {
      name: "Red Forest",
      uids: [480246..480248, 480250..480260, 17006246..17006248, 17006250..17006260]
    },
    {
      name: "unmapped",
      uids: [480249..480249, 17006249..17006249]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound",
        as: 390
      },
      {
        name: "Root lash",
        as: 390
      },
      {
        name: "Root slam",
        as: 390
      },
      {
        name: "Leafy fist",
        as: 355
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Twin Hammerfists"
      },
      {
        name: "Caber toss"
      },
      {
        name: "Grab"
      },
      {
        name: "Sap Spit"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "17",
    immunities: [
      "Stun"
    ],
    melee: (176..283),
    ranged: nil,
    bolt: nil,
    udf: 556,
    bar_td: 312,
    cle_td: 334,
    emp_td: (317..326),
    pal_td: (268..277),
    ran_td: nil,
    sor_td: (337..343),
    wiz_td: nil,
    mje_td: (349..408),
    mne_td: nil,
    mjs_td: nil,
    mns_td: (317..323),
    mnm_td: 252,
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
    skin: "blood-stained bark",
    other: nil
  },
  messaging: {
    description: [
      "Standing approximately twelve feet tall, the treekin warrior towers menacingly before you. Lambent yellow eyes and thick leg-shaped roots make it clear that this is no ordinary tree. Leaves cover the warrior from head to trunk, with two arm-shaped branches protruding from the canopy. Numerous gashes and chips indicate that this particular specimen has seen much combat in the past."
    ],
    arrival: [
      "With a rustle of leaves, a treekin warrior lumbers in!",
      "A treekin warrior lumbers in!",
      "A treekin warrior shudders as it lumbers in, leaving a path of sap and leaves behind it!",
      "A treekin warrior lumbers in, leaving a path of leaves behind it!"
    ],
    flee: [
      "A treekin warrior shudders and lumbers {direction}, leaving a trail of sap and leaves of behind it.",
      "A treekin warrior lumbers {direction}.",
      "A treekin warrior lumbers {direction}, leaving a trail of leaves of behind it."
    ],
    death: [],
    decay: [
      "A treekin warrior decays into compost.",
      "The layer of bark on a treekin warrior hardens and absorbs the attack!  The bark crackles as it crumbles to dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A treekin warrior lashes {weapon} at you!",
      "A treekin warrior pounds at you with a leafy fist!",
      "A treekin warrior raises a large root and slams it down at you!",
      "A treekin warrior strikes out at you with all of treekin warrior might!"
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
