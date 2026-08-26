{
  schema_version: 3,
  name: "red bear",
  noun: "",
  url: "https://gswiki.play.net/red_bear",
  picture: "",
  level: 16,
  family: "Bear",
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
  max_hp: 210,
  speed: nil,
  height: 4,
  size: "large",
  areas: [
    {
      name: "Stone Valley",
      uids: [4291001..4291025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (160..174)
      },
      {
        name: "Bite",
        as: 174
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
    melee: (121..194),
    ranged: nil,
    bolt: 100,
    udf: nil,
    bar_td: nil,
    cle_td: (45..48),
    emp_td: (48..52),
    pal_td: (45..54),
    ran_td: (45..51),
    sor_td: 48,
    wiz_td: nil,
    mje_td: (42..54),
    mne_td: (42..54),
    mjs_td: nil,
    mns_td: (45..48),
    mnm_td: (45..54),
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
    skin: "a bear paw",
    other: nil
  },
  messaging: {
    description: [
      "The red bear weighs around 600 pounds and is about seven feet long. This bear is a dark reddish-brown color and has a characteristic muscle hump over the shoulders, and has long vicious looking claws on his front paws.K"
    ],
    arrival: [
      "A red bear lumbers in!",
      "A red bear slowly lumbers in, growling in pain!"
    ],
    flee: [
      "A red bear lumbers {direction}.",
      "A red bear slowly lumbers {direction}, growling in pain."
    ],
    death: [
      "The red bear collapses heavily into a heap on the ground and dies.",
      "The red bear lets out a blood-curdling roar and dies.",
      "The red bear roars loudly as she slumps to the ground and licks her wounded right foreleg.",
      "The red bear roars loudly as he slumps to the ground and licks his wounded left foreleg.",
      "The red bear roars loudly as she slumps to the ground and licks her wounded left foreleg.",
      "The red bear roars loudly as she slumps to the ground and licks her wounded left paw.",
      "The red bear roars loudly as he slumps to the ground and licks his wounded right foreleg."
    ],
    decay: [
      "A red bear decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A red bear tries to bite you!"
    ],
    claw: [
      "A red bear claws at you!"
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
