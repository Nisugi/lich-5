{
  schema_version: 3,
  name: "snow leopard",
  noun: "",
  url: "https://gswiki.play.net/snow_leopard",
  picture: "",
  level: 27,
  family: "Feline",
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
  max_hp: 240,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Sleeping Lady Mountains",
      uids: [4565009..4565014]
    },
    {
      name: "Emerald Forest",
      uids: [13301170..13301191, 13301201..13301232]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (182..203)
      },
      {
        name: "Charge",
        as: 213
      },
      {
        name: "Claw",
        as: (187..213)
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
    melee: 152,
    ranged: nil,
    bolt: nil,
    udf: 236,
    bar_td: 81,
    cle_td: 84,
    emp_td: (81..89),
    pal_td: nil,
    ran_td: nil,
    sor_td: (76..88),
    wiz_td: nil,
    mje_td: 86,
    mne_td: 86,
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
    skin: "a leopard skin",
    other: nil
  },
  messaging: {
    description: [
      "With her distinctive markings, the reclusive snow leopard is endowed with an almost uncanny ability to blend into the rocky vastness she inhabits. Adapted to living in the rugged mountains, she has large forepaws, short forelimbs, well-developed chest muscles and a long, elegant tail. The leopard's fur is a beautiful combination of dark spots set against a field of tan that fades from a dorsal stripe to luminous white on the leopard's belly. Small ears crown the animal's head."
    ],
    arrival: [
      "A snow leopard just arrived."
    ],
    flee: [],
    death: [
      "The snow leopard lets out a final caterwaul and dies.",
      "The snow leopard crumples to the ground and dies.",
      "A snow leopard goes limp as he is rendered unconscious!",
      "A snow leopard goes limp as she is rendered unconscious!"
    ],
    decay: [
      "A snow leopard decays into a compost of fangs, fur and claws.",
      "Acid dissolves connecting cartilage, freeing the snow leopard's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A snow leopard tries to bite you!"
    ],
    claw: [
      "A snow leopard claws at you!"
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
