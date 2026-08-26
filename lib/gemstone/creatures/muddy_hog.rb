{
  schema_version: 3,
  name: "muddy hog",
  noun: "",
  url: "https://gswiki.play.net/muddy_hog",
  picture: "",
  level: nil,
  family: "Suine",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 124,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Black Weald",
      uids: [7130001..7130018]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 161
      },
      {
        name: "Charge",
        as: 171
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
    asg: nil,
    immunities: [],
    melee: (65..67),
    ranged: (65..67),
    bolt: (65..67),
    udf: (110..128),
    bar_td: nil,
    cle_td: (42..48),
    emp_td: (21..51),
    pal_td: (36..42),
    ran_td: nil,
    sor_td: (39..48),
    wiz_td: nil,
    mje_td: 42,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (36..45),
    mnm_td: (42..48),
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "brown boar hide",
    other: nil
  },
  messaging: {
    description: [
      ""
    ],
    arrival: [],
    flee: [
      "A muddy hog trots {direction}."
    ],
    death: [
      "The muddy hog collapses to the ground, emits a final squeal, and dies.",
      "The muddy hog lets out a final agonized squeal and dies.",
      "The muddy hog collapses to the ground, emits a final silent squeal, and dies.",
      "A muddy hog goes limp as she is rendered unconscious!",
      "The muddy hog squeals loudly as she slumps to the ground and cradles her wounded right foreleg.",
      "The muddy hog squeals loudly as she slumps to the ground and cradles her wounded left hoof.",
      "The muddy hog squeals loudly as he slumps to the ground and cradles his wounded left hoof.",
      "The muddy hog squeals loudly as he slumps to the ground and cradles his wounded right foreleg.",
      "The muddy hog squeals loudly as he slumps to the ground and cradles his wounded left foreleg.",
      "The muddy hog squeals loudly as he slumps to the ground and cradles his wounded right hoof.",
      "The muddy hog squeals loudly as she slumps to the ground and cradles her wounded left foreleg.",
      "The muddy hog squeals loudly as she slumps to the ground and cradles her wounded right hoof."
    ],
    decay: [
      "A muddy hog decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A muddy hog charges at you!"
    ],
    bite: [
      "A muddy hog tries to bite you!"
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
