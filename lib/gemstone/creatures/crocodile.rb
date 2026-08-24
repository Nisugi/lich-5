{
  schema_version: 3,
  name: "crocodile",
  noun: "",
  url: "https://gswiki.play.net/crocodile",
  picture: "",
  level: 9,
  family: "Reptilian",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 129,
  speed: nil,
  height: 1,
  size: "medium",
  areas: [
    {
      name: "The Citadel",
      uids: [377051..377066, 377077..377081, 377083..377084]
    },
    {
      name: "unmapped",
      uids: [377067..377076, 377082..377082]
    },
    {
      name: "Plains of Vornavis",
      uids: [4212301..4212324]
    },
    {
      name: "Thurfel's Island",
      uids: [7530006..7530029]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge (attack)",
        as: 137
      },
      {
        name: "Bite",
        as: 127
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Disease (on hit)"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (47..81),
    ranged: (31..50),
    bolt: (31..50),
    udf: 96,
    bar_td: 33,
    cle_td: nil,
    emp_td: "-11-27",
    pal_td: nil,
    ran_td: nil,
    sor_td: (18..27),
    wiz_td: nil,
    mje_td: (18..27),
    mne_td: 27,
    mjs_td: 27,
    mns_td: 27,
    mnm_td: 27,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  treasure: {
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a crocodile snout",
    other: nil
  },
  messaging: {
    description: [
      "A large scaled lizard, with a wide gaping mouth full of sharp teeth, it has short powerful legs barely long enough to lift the beast off the ground. The crocodile also has a long powerful tail that looks rather dangerous."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
