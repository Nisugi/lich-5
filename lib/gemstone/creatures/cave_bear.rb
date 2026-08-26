{
  schema_version: 3,
  name: "cave bear",
  noun: "",
  url: "https://gswiki.play.net/cave_bear",
  picture: "",
  level: 21,
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
  max_hp: 260,
  speed: nil,
  height: 4,
  size: "large",
  areas: [
    {
      name: "Hidden Vale",
      uids: [40001..40013, 40020..40020]
    },
    {
      name: "unmapped",
      uids: [40014..40019]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (217..227)
      },
      {
        name: "Bite",
        as: (202..225)
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
    melee: (101..158),
    ranged: nil,
    bolt: 96,
    udf: 174,
    bar_td: nil,
    cle_td: (60..69),
    emp_td: (55..63),
    pal_td: nil,
    ran_td: nil,
    sor_td: (63..69),
    wiz_td: nil,
    mje_td: 63,
    mne_td: 63,
    mjs_td: nil,
    mns_td: (57..63),
    mnm_td: 63,
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
    skin: "bear claw",
    other: nil
  },
  messaging: {
    description: [
      "The cave bear is one of the smaller breeds of bear, her dark coloration enabling her to conceal herself well in the shadows of cave depths. She is also one of the fiercest bears, readily defending her chosen territory against all comers. The cave bear has especially large paws, well-padded to handle the sharp outcroppings and stalagmites of the cave surfaces, but with extremely sharp claws honed on the rough surfaces. Keen eyesight in low light conditions gives the cave bear an advantage over her intended prey in the caves."
    ],
    arrival: [
      "A cave bear lumbers in!",
      "A cave bear just arrived."
    ],
    flee: [
      "A cave bear lumbers {direction}.",
      "A cave bear slowly lumbers {direction}, growling in pain.",
      "A cave bear shudders and lumbers {direction}, snarling in agony."
    ],
    death: [
      "The cave bear collapses heavily into a heap on the ground and dies.",
      "The cave bear lets out a blood-curdling roar and dies.",
      "The cave bear roars loudly as he slumps to the ground and licks his wounded right foreleg.",
      "The cave bear roars loudly as she slumps to the ground and licks her wounded left foreleg.",
      "The cave bear roars loudly as he slumps to the ground and licks his wounded right paw.",
      "The cave bear roars loudly as she slumps to the ground and licks her wounded right paw.",
      "The cave bear roars loudly as he slumps to the ground and licks his wounded left foreleg.",
      "The cave bear roars loudly as he slumps to the ground and licks his wounded left paw."
    ],
    decay: [
      "A cave bear decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A cave bear tries to bite you!"
    ],
    claw: [
      "A cave bear claws at you!"
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
