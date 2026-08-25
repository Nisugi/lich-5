{
  schema_version: 3,
  name: "glacial morph",
  noun: "",
  url: "https://gswiki.play.net/glacial_morph",
  picture: "",
  level: 56,
  family: "Elemental",
  type: "Elemental",
  undead: false,
  blood: nil,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Magical"
  ],
  bcs: true,
  max_hp: 260,
  speed: nil,
  height: 8,
  size: "large",
  areas: [
    {
      name: "Gossamer Valley",
      uids: [13023013..13023054]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound"
      },
      {
        name: "Ensnare"
      },
      {
        name: "Elongated block of ice",
        as: 310
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
    melee: 472,
    ranged: (224..290),
    bolt: (224..290),
    udf: (289..466),
    bar_td: (188..194),
    cle_td: (204..222),
    emp_td: (205..208),
    pal_td: nil,
    ran_td: 221,
    sor_td: 221,
    wiz_td: nil,
    mje_td: (242..245),
    mne_td: 232,
    mjs_td: 178,
    mns_td: 208,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Hides when attacked"
    ]
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: false,
    boxes: nil,
    skin: nil,
    other: "Gold Dust"
  },
  messaging: {
    description: [
      "Chunks of ice appear to be held together by strands of organic material to form the rough outline of a bipedal creature. The chunks have no specific shape, and some are larger than others without direct relation to placement on glacial morph. Often the glacial morph draws in on itself, the chunks rearranging and reattaching to form a considerably different shape, and it seems to be able to change color at will to match its surroundings. The glacial morph peers out from two malevolent eyes set deeply in a 'head' of ice. Strangely, the head does not always appear to be on top of the torso."
    ],
    arrival: [
      "An animated slush ripples in, its mass wobbling slightly as it arrives."
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A glacial morph swings {weapon} at you!"
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
