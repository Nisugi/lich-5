{
  schema_version: 3,
  name: "rotting woodsman",
  noun: "",
  url: "https://gswiki.play.net/rotting_woodsman",
  picture: "",
  level: 23,
  family: "Humanoid",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Corporeal undead",
    "Boss"
  ],
  bcs: true,
  max_hp: 260,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Plains of Vornavis",
      uids: [4212201..4212222]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Battle axe",
        as: 202
      },
      {
        name: "Huge logging axe",
        as: 207
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
    melee: (165..181),
    ranged: (115..169),
    bolt: (115..169),
    udf: 265,
    bar_td: 69,
    cle_td: (64..70),
    emp_td: (68..76),
    pal_td: nil,
    ran_td: nil,
    sor_td: (74..80),
    wiz_td: nil,
    mje_td: 79,
    mne_td: 77,
    mjs_td: nil,
    mns_td: (72..78),
    mnm_td: (63..69),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a huge logging axe",
    "some tattered rags"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The rotting woodsman staggers about through the forests she once knew in life, now unable to obtain rest. Putrid flesh drips from her exposed bones, and only ragged patches of hair remain on her thick skull. Despite the lack of solid muscle, the rotting woodsman swings her axe with enormous power, felling the living as she once felled the immense trees of the forest."
    ],
    arrival: [
      "A robust rotting woodsman shambles in!",
      "A rotting woodsman shambles in!"
    ],
    flee: [
      "A rotting woodsman crawls {direction}."
    ],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A rotting woodsman swings {weapon} at you!",
      "A rotting woodsman waves {pronoun} arms around flinging bits of flesh towards you."
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
