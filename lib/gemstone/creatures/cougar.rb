{
  schema_version: 3,
  name: "cougar",
  noun: "",
  url: "https://gswiki.play.net/cougar",
  picture: "",
  level: 22,
  family: "Feline",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 195,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4218101..4218121]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (196..203)
      },
      {
        name: "Claw",
        as: 208
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Charge"
      },
      {
        name: "Kick"
      },
      {
        name: "Leap"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (148..219),
    ranged: nil,
    bolt: nil,
    udf: 190,
    bar_td: 66,
    cle_td: nil,
    emp_td: (53..76),
    pal_td: nil,
    ran_td: nil,
    sor_td: (63..72),
    wiz_td: nil,
    mje_td: (60..66),
    mne_td: 66,
    mjs_td: nil,
    mns_td: 66,
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
    skin: "a cougar tail",
    other: nil
  },
  messaging: {
    description: [
      "The cougar is a large, tawny brown animal of the cat family with a slender body and long tail. Her sleek build disguises her power. Both claws and jaws are to be feared, as the cougar strikes quickly with each. Prized for her soft pelt, this cat's hunting grounds have been severely diminished in recent years due to overhunting, though many of her breed can still be found in more remote areas and backwaters."
    ],
    arrival: [
      "A cougar scampers in, mewling in pain!",
      "A cougar scampers in!",
      "A deft cougar scampers in!",
      "An adroit cougar scampers in!",
      "A canny cougar scampers in!",
      "A keen cougar scampers in!",
      "A belligerent cougar scampers in!",
      "A luminous cougar scampers in!"
    ],
    flee: [
      "A cougar scampers {direction}.",
      "A cougar scampers {direction}, mewling in pain.",
      "A barbed cougar scampers {direction}.",
      "A deft cougar scampers {direction}.",
      "A robust cougar scampers {direction}.",
      "A keen cougar scampers {direction}.",
      "A combative cougar scampers {direction}."
    ],
    death: [
      "The cougar lets out a final caterwaul and dies.",
      "The cougar crumples to the ground and dies.",
      "A cougar goes limp as she is rendered unconscious!",
      "A cougar goes limp as he is rendered unconscious!",
      "The cougar twitches violently, then dies."
    ],
    decay: [
      "A cougar decays into a compost of fangs, fur and claws.",
      "A barbed cougar decays into a compost of fangs, fur and claws.",
      "A spiny cougar decays into a compost of fangs, fur and claws.",
      "An adroit cougar decays into a compost of fangs, fur and claws.",
      "A deft cougar decays into a compost of fangs, fur and claws.",
      "A stalwart cougar decays into a compost of fangs, fur and claws.",
      "A robust cougar decays into a compost of fangs, fur and claws.",
      "A shimmering cougar decays into a compost of fangs, fur and claws.",
      "A gleaming cougar decays into a compost of fangs, fur and claws.",
      "A keen cougar decays into a compost of fangs, fur and claws.",
      "A canny cougar decays into a compost of fangs, fur and claws.",
      "A belligerent cougar decays into a compost of fangs, fur and claws.",
      "A combative cougar decays into a compost of fangs, fur and claws.",
      "A lustrous cougar decays into a compost of fangs, fur and claws.",
      "A luminous cougar decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A cougar tries to bite you!"
    ],
    claw: [
      "A cougar claws at you!"
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
