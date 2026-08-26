{
  schema_version: 3,
  name: "spotted gak",
  noun: "",
  url: "https://gswiki.play.net/spotted_gak",
  picture: "",
  level: 2,
  family: "Bovine",
  type: "Quadruped",
  undead: false,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 70,
  speed: nil,
  height: 4,
  size: "large",
  areas: [
    {
      name: "Graendlor Pasture",
      uids: [4301001..4301025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Impale",
        as: 48
      },
      {
        name: "Tusk",
        as: 48
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
    asg: "6N",
    immunities: [],
    melee: (11..36),
    ranged: 11,
    bolt: 18,
    udf: 60,
    bar_td: nil,
    cle_td: 6,
    emp_td: 6,
    pal_td: (3..6),
    ran_td: 6,
    sor_td: 6,
    wiz_td: nil,
    mje_td: 6,
    mne_td: 6,
    mjs_td: nil,
    mns_td: 6,
    mnm_td: 6,
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
    skin: "a gak hide",
    other: "No"
  },
  messaging: {
    description: [
      "The spotted gak is a big, ugly beast with a heavy spotted brown pelt. A marked odor of dung and musty wool surrounds him in a noxious cloud. The gak chomps vicious-looking teeth, a mix of distrust and hatred in his large doe-like eyes. A pair of sharp horns curves up above his short, broad head in a shape that resembles a lyre. The animal looks ungainly with his tall shoulders and shorter hindquarters, which give his a jerky, uneven gait. Suddenly, he bares his bovine ivories and brays loudly!"
    ],
    arrival: [],
    flee: [],
    death: [
      "The spotted gak collapses to the ground, emits a final bellow, and dies.",
      "The spotted gak lets out a final agonized bellow and dies.",
      "The spotted gak brays loudly as she slumps to the ground and cradles her wounded right foreleg.",
      "The spotted gak brays loudly as she slumps to the ground and cradles her wounded left foreleg.",
      "The spotted gak brays loudly as he slumps to the ground and cradles his wounded left foreleg."
    ],
    decay: [
      "A spotted gak decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A spotted gak charges at you with {pronoun} tusk!"
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
