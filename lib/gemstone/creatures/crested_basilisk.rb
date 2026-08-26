{
  schema_version: 3,
  name: "crested basilisk",
  noun: "",
  url: "https://gswiki.play.net/crested_basilisk",
  picture: "",
  level: 22,
  family: "Basilisk",
  type: "Hybrid",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 200,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Outlands",
      uids: [2152013..2152030]
    },
    {
      name: "Rambling Meadows",
      uids: [14006041..14006046, 14006048..14006060]
    },
    {
      name: "Yegharren Plains",
      uids: [13034401..13034416]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (206..220)
      },
      {
        name: "Claw",
        as: 221
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Paralyzing Gaze"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (126..198),
    ranged: (129..145),
    bolt: 129,
    udf: 193,
    bar_td: (66..72),
    cle_td: (72..78),
    emp_td: (68..76),
    pal_td: (63..66),
    ran_td: nil,
    sor_td: (64..73),
    wiz_td: 72,
    mje_td: (72..78),
    mne_td: (72..78),
    mjs_td: 68,
    mns_td: (65..74),
    mnm_td: (66..72),
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
    gems: true,
    boxes: nil,
    skin: "a basilisk crest",
    other: nil
  },
  messaging: {
    description: [
      "The crested basilisk is the size of a large dog, but its vicious-looking talons and sharp, hooked beak are fearsome weapons indeed. Looking like a cross between a huge fighting rooster and a serpentine lizard, the crested basilisk gazes around with its hypnotic, paralyzing eyes as its scaled reptilian tail whips back and forth. A bright red crest, more reminiscent of a lizard than of a chicken, adorns its feathered head and neck."
    ],
    arrival: [
      "A crested basilisk stomps in and glares about.",
      "A combative crested basilisk stomps in and glares about.",
      "A belligerent crested basilisk stomps in and glares about.",
      "A canny crested basilisk stomps in and glares about."
    ],
    flee: [
      "A crested basilisk hisses and stomps {direction}.",
      "A combative crested basilisk hisses and stomps {direction}.",
      "A belligerent crested basilisk hisses and stomps {direction}."
    ],
    death: [
      "The crested basilisk rolls over on its back, emits a final hiss and dies.",
      "The crested basilisk emits a final hiss and dies.",
      "The crested basilisk emits a final silent hiss and dies.",
      "A crested basilisk goes limp as it is rendered unconscious!",
      "The crested basilisk rolls over on its back, emits a final silent hiss and dies.",
      "The crested basilisk slumps to the ground."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A crested basilisk tries to bite you!"
    ],
    claw: [
      "A crested basilisk claws at you!"
    ],
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
