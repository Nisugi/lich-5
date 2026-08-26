{
  schema_version: 3,
  name: "moor hound",
  noun: "",
  url: "https://gswiki.play.net/moor_hound",
  picture: "",
  level: 33,
  family: "Canine",
  type: "Quadruped",
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
  max_hp: 260,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Shattered Moors",
      uids: [420001..420037, 420040..420046]
    },
    {
      name: "unmapped",
      uids: [420038..420039]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 232
      },
      {
        name: "Charge",
        as: 242
      },
      {
        name: "Claw",
        as: (232..242)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Wing Buffet"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (207..222),
    ranged: nil,
    bolt: nil,
    udf: 238,
    bar_td: 101,
    cle_td: (109..115),
    emp_td: (113..121),
    pal_td: (96..99),
    ran_td: nil,
    sor_td: 119,
    wiz_td: nil,
    mje_td: nil,
    mne_td: 124,
    mjs_td: nil,
    mns_td: 113,
    mnm_td: (99..108),
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
    skin: "moor hound paw",
    other: nil
  },
  messaging: {
    description: [
      "The moor hound stands nearly as tall as a halfling, her broad shoulders easily support the weight of her frame. The jet-black fur is matted and frizzled, giving the hound an unkept appearance. Tiny droplets of perspiration drip from her blood-red eyes as misty vapor wafts out of the nostrils. A curl in her upper lip forms, revealing a massive canine tooth as she hungrily looks upon her pray."
    ],
    arrival: [
      "A moor hound stalks into the area with a sickly vapor pouring from his nostrils!",
      "A moor hound stalks into the room with a sickly vapor pouring from his nostrils!",
      "A moor hound stalks into the area with a sickly vapor pouring from her nostrils!",
      "A moor hound stalks into the room with a sickly vapor pouring from her nostrils!"
    ],
    flee: [
      "A moor hound plods {direction}."
    ],
    death: [
      "The moor hound falls to the ground and dies.",
      "The moor hound rolls over and dies.",
      "A moor hound goes limp as she is rendered unconscious!",
      "A moor hound goes limp as he is rendered unconscious!",
      "The moor hound yelps loudly as she slumps to the ground and licks her wounded left foreleg.",
      "The moor hound yelps loudly as he slumps to the ground and licks his wounded right foreleg.",
      "The moor hound yelps loudly as she slumps to the ground and licks her wounded right foreleg.",
      "The moor hound yelps loudly as he slumps to the ground and licks his wounded right paw.",
      "The moor hound yelps loudly as he slumps to the ground and licks his wounded left foreleg."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [],
    claw: [
      "A moor hound claws at you!"
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
