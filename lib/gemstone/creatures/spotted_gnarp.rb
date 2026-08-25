{
  schema_version: 3,
  name: "spotted gnarp",
  noun: "",
  url: "https://gswiki.play.net/spotted_gnarp",
  picture: "",
  level: 1,
  family: "Caprine",
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
  max_hp: 60,
  speed: nil,
  height: 2,
  size: "large",
  areas: [
    {
      name: "Yander's Farm",
      uids: [14005002..14005019]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Impale",
        as: 32
      },
      {
        name: "Tusk",
        as: 23
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
    asg: "10N",
    immunities: [],
    melee: (14..37),
    ranged: 14,
    bolt: 14,
    udf: 61,
    bar_td: 3,
    cle_td: 3,
    emp_td: (-31..3),
    pal_td: 3,
    ran_td: 3,
    sor_td: 3,
    wiz_td: 3,
    mje_td: 3,
    mne_td: 3,
    mjs_td: 3,
    mns_td: 3,
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
    skin: "a spotted gnarp horn",
    other: "No"
  },
  messaging: {
    description: [
      "Oh, what a thing of horror is the curl-horned spotted gnarp! Huge floppy ears stand out from her long snout like horizontal bunny ears, and her eyes are deep, liquid pools of irascibility and indecision. The creature's ponderous spotted belly hangs from a ridge-like backbone, which tapers in a long tail with a curly tip. Swishing her tail viciously, the gnarp minces about on cloven hooves, her massive curled horns overbalancing her head as she tears at the scattered herbage with her large, formidable teeth."
    ],
    arrival: [],
    flee: [],
    death: [
      "The spotted gnarp collapses to the ground, emits a final cry, and dies.",
      "The spotted gnarp lets out a final agonized cry and dies.",
      "The spotted gnarp collapses to the ground, emits a final silent cry, and dies."
    ],
    decay: [
      "A spotted gnarp decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A spotted gnarp charges at you with {pronoun} tusk!"
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
