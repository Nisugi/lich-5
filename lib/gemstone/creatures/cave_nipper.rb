{
  schema_version: 3,
  name: "cave nipper",
  noun: "",
  url: "https://gswiki.play.net/cave_nipper",
  picture: "",
  level: 3,
  family: "Reptilian",
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
  size: "medium",
  areas: [
    {
      name: "Sea Caverns",
      uids: [391001..391022]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge",
        as: 43
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
    melee: 33,
    ranged: 30,
    bolt: 30,
    udf: nil,
    bar_td: nil,
    cle_td: nil,
    emp_td: 9,
    pal_td: nil,
    ran_td: nil,
    sor_td: 9,
    wiz_td: nil,
    mje_td: 9,
    mne_td: 9,
    mjs_td: nil,
    mns_td: nil,
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "a cave nipper skin",
    other: nil
  },
  messaging: {
    description: [
      "More serpent than lizard, the cave nipper is nearly as long as a human is tall, though less thick. It has a short and stubby tail, virtually no neck, and legs so stumpy that they are nearly nonexistent. A brown back shading off to a tannish underside allows this beast to blend in among the rocks and moss of its habitat. Moving swiftly and showing great strength for its size, the cave nipper will pursue and capture prey much larger than itself. This one is sizing up its next meal through cold, unblinking, reptilian eyes that stare out from its thick, blunt-nosed head. Its tongue flicks out quickly, as if gathering your scent."
    ],
    arrival: [
      "A cave nipper slithers in!"
    ],
    flee: [
      "A cave nipper slithers {direction}."
    ],
    death: [],
    decay: [
      "A cave nipper decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A cave nipper charges at you!"
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
