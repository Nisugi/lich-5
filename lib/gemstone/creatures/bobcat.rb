{
  schema_version: 3,
  name: "bobcat",
  noun: "",
  url: "https://gswiki.play.net/bobcat",
  picture: "",
  level: 5,
  family: "Feline",
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
  max_hp: 60,
  speed: nil,
  height: 2,
  size: "small",
  areas: [
    {
      name: "The Toadwort",
      uids: [14007024..14007041]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite (attack)",
        as: 80
      },
      {
        name: "Claw (attack)",
        as: 90
      },
      {
        name: "Charge (attack)",
        as: 90
      },
      {
        name: "Bite",
        as: 72
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Leap"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: (29..65),
    ranged: 27,
    bolt: 27,
    udf: 93,
    bar_td: nil,
    cle_td: 15,
    emp_td: 15,
    pal_td: nil,
    ran_td: nil,
    sor_td: 15,
    wiz_td: nil,
    mje_td: 15,
    mne_td: 15,
    mjs_td: nil,
    mns_td: 15,
    mnm_td: 15,
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
    skin: "a bobcat claw",
    other: nil
  },
  messaging: {
    description: [
      "Twice the size of a domestic cat, the bobcat is covered in dense, thick fur varying from soft greys to light reddish brown. The fur along the middle back is darker, while her underparts are snowy white. Deep brown spots mark the bobcat's pelt but a predominent white spot on the back of her dark triangular ears make her easily recognizable when gathered with other wild cats. Whisking back and forth with her short banded tail, the bobcat seems anxious to pounce on her next prey."
    ],
    arrival: [
      "A bobcat scampers in!"
    ],
    flee: [
      "A bobcat scampers {direction}.",
      "A bobcat scampers {direction}, mewling in pain."
    ],
    death: [
      "The bobcat crumples to the ground and dies.",
      "The bobcat lets out a final caterwaul and dies.",
      "The bobcat mewls in pain as she slumps to the ground and licks her wounded right foreleg.",
      "The bobcat mewls in pain as he slumps to the ground and licks his wounded left foreleg.",
      "The bobcat mewls in pain as she slumps to the ground and licks her wounded left paw.",
      "The bobcat mewls in pain as he slumps to the ground and licks his wounded right foreleg.",
      "The bobcat mewls in pain as she slumps to the ground and licks her wounded left foreleg.",
      "The bobcat mewls in pain as he slumps to the ground and licks his wounded left paw."
    ],
    decay: [
      "A bobcat decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A bobcat tries to bite you!"
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
