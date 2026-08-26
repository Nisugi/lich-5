{
  schema_version: 3,
  name: "greater construct",
  noun: "",
  url: "https://gswiki.play.net/greater_construct",
  picture: "",
  level: 96,
  family: "Golem",
  type: "Biped",
  undead: false,
  blood: false,
  bones: false,
  witherable: false,
  sympathy: false,
  muggable: nil,
  boss: true,
  otherclass: [
    "Magical",
    "Boss"
  ],
  bcs: true,
  max_hp: 500,
  speed: nil,
  height: 18,
  size: "huge",
  areas: [
    {
      name: "Old Ta'Faendryl",
      uids: [17004001..17004028, 17004030..17004120]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Stomp"
      },
      {
        name: "Arm",
        as: (449..460)
      },
      {
        name: "Smash",
        as: 468
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Crush"
      },
      {
        name: "Tandem Dispel"
      },
      {
        name: "Team Swat"
      },
      {
        name: "Ground Slam"
      },
      {
        name: "Slam"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "20N",
    immunities: ["magic"],
    melee: (260..499),
    ranged: (299..344),
    bolt: nil,
    udf: 487,
    bar_td: nil,
    cle_td: (366..387),
    emp_td: (358..379),
    pal_td: nil,
    ran_td: nil,
    sor_td: 398,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Antimagic aura"
    ]
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [],
  treasure: {
    coins: true,
    magic_items: nil,
    gems: true,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The white granite-like features of the greater construct hold no hints of the giant creature's intentions or motivations. Its alabaster skin made more of the hardest rock than any living tissue makes the construct a formidable opponent for any who dare to trifle with it. Massing more than ten giantmen, it is a mountain of rock when in motion and very little, man or animal can oppose its desired path of travel once it is in motion."
    ],
    arrival: [
      "A greater construct stomps in.",
      "A glorious greater construct stomps in.",
      "A hoarse rumbling heralds the arrival of a greater construct!",
      "A deep humming sound comes from a greater construct as it lumbers in.",
      "An Ithzir initiate strides in, her hands clasped before her."
    ],
    flee: [],
    death: [],
    decay: [
      "A greater construct's body crumbles until only a pile of rubble marks its remains."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A glorious greater construct raises greater construct massive foot and attempts to smash you!",
      "A greater construct raises greater construct massive foot and attempts to smash you!",
      "A greater construct swings {weapon} at you!",
      "An Ithzir initiate places one palm on greater construct chest, and raises the other toward you!",
      "An Ithzir seer suddenly opens greater construct eyes and stares directly at you!"
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
