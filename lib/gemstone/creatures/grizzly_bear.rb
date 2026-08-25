{
  schema_version: 3,
  name: "grizzly bear",
  noun: "",
  url: "https://gswiki.play.net/grizzly_bear",
  picture: "",
  level: 38,
  family: "Bear",
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
  max_hp: 400,
  speed: nil,
  height: 4,
  size: "large",
  areas: [
    {
      name: "Pinefar Forests",
      uids: [4563014..4563026]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge",
        as: 286
      },
      {
        name: "Claw",
        as: 285
      },
      {
        name: "Bite",
        as: 269
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Charge"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (244..254),
    ranged: 184,
    bolt: 172,
    udf: 267,
    bar_td: 114,
    cle_td: nil,
    emp_td: (124..133),
    pal_td: nil,
    ran_td: nil,
    sor_td: (130..137),
    wiz_td: nil,
    mje_td: 138,
    mne_td: 138,
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
    skin: "a grizzly bear hide",
    other: nil
  },
  messaging: {
    description: [
      "One of the largest of the bears, the grizzly bear weighs around 860 pounds and has about ten feet of total body length. This bear is dark brown in color. The tips of her guard hairs are white, giving the bear a grizzled appearance. The grizzly bear has a characteristic muscle hump over the shoulders, and longer claws on her front paws than on her rear paws."
    ],
    arrival: [
      "A grizzly bear lumbers in!"
    ],
    flee: [
      "A grizzly bear lumbers {direction}."
    ],
    death: [
      "The grizzly bear lets out a blood-curdling roar and dies.",
      "The grizzly bear collapses heavily into a heap on the ground and dies.",
      "A grizzly bear goes limp as he is rendered unconscious!",
      "A grizzly bear goes limp as she is rendered unconscious!"
    ],
    decay: [
      "A grizzly bear decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A grizzly bear charges at you!"
    ],
    bite: [
      "A grizzly bear tries to bite you!"
    ],
    claw: [
      "A grizzly bear claws at you!"
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
