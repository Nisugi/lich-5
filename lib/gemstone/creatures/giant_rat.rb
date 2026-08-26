{
  schema_version: 3,
  name: "giant rat",
  noun: "",
  url: "https://gswiki.play.net/giant_rat",
  picture: "",
  level: 1,
  family: "Rodent",
  type: "Quadruped",
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
  max_hp: 28,
  speed: nil,
  height: 1,
  size: "small",
  areas: [
    {
      name: "Catacombs",
      uids: [46001..46003, 46007..46007, 46039..46041, 46052..46058, 2133100..2133109, 2133200..2133206, 2134100..2134108, 2134200..2134207, 2135100..2135107, 2135200..2135209, 2136100..2136108, 2136200..2136208, 4126004..4126023]
    },
    {
      name: "Lower Dragonsclaw",
      uids: [372005..372014, 372020..372026, 372030..372039]
    },
    {
      name: "The Citadel",
      uids: [2103007..2103013, 2103015..2103023]
    },
    {
      name: "Subterranean Tunnels",
      uids: [4045150..4045158, 4045160..4045168, 4045200..4045210]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 34
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
    asg: "1N",
    immunities: [],
    melee: (24..34),
    ranged: 2,
    bolt: 2,
    udf: 32,
    bar_td: 3,
    cle_td: 3,
    emp_td: 3,
    pal_td: 3,
    ran_td: nil,
    sor_td: 3,
    wiz_td: 3,
    mje_td: 3,
    mne_td: 3,
    mjs_td: 3,
    mns_td: 3,
    mnm_td: 3,
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
    skin: "rat pelt",
    other: nil
  },
  messaging: {
    description: [
      "Larger than a domestic cat, the giant rat stands over a foot high. Dark brown in color, shading off to white on the belly, with naked pink ears and narrow glinting eyes, the rat glares with unrestrained bloodlust. Known to exist in great packs, the rat has brought more than one over-eager adventurer to an early grave."
    ],
    arrival: [
      "A giant rat scampers in!"
    ],
    flee: [
      "A giant rat scampers {direction}."
    ],
    death: [
      "The giant rat collapses to the ground, emits a final squeal, and dies.",
      "The giant rat twitches and dies.",
      "The giant rat shrieks as it slumps to the ground and licks at its wounded left foreleg."
    ],
    decay: [
      "A giant rat decays into a pile of mangy hair and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [],
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
