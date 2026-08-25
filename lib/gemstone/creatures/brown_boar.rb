{
  schema_version: 3,
  name: "brown boar",
  noun: "",
  url: "https://gswiki.play.net/brown_boar",
  picture: "",
  level: 14,
  family: "Suine",
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
  max_hp: 130,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Neartofar Forest",
      uids: [14015101..14015118]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (121..171)
      },
      {
        name: "Charge (attack)",
        as: 187
      },
      {
        name: "Charge",
        as: 151
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Charge"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "1N",
    immunities: [],
    melee: (119..124),
    ranged: (55..67),
    bolt: (55..67),
    udf: 140,
    bar_td: 42,
    cle_td: nil,
    emp_td: (38..42),
    pal_td: nil,
    ran_td: 42,
    sor_td: (39..48),
    wiz_td: nil,
    mje_td: 42,
    mne_td: 42,
    mjs_td: 42,
    mns_td: 42,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a brown boar hide",
    other: nil
  },
  messaging: {
    description: [
      "The brown boar noses along the ground, peering at everything with his close-set, bloodshot eyes in hopes of finding something to satisfy his insatiable hunger. Any who get in his way will most likely rapidly regret having done so. His body is covered with stringy, brown hair, and mud-caked greyish tusks protrude from each side of his slit of a mouth. The largest can easily reach a good six feet long from dripping snout to curly tail and weigh more than a quarter ton. When in motion, the brown boar moves with a surprising speed and dexterity for a beast his size. It is not unusual to find oneself snacked on by this beast if not properly prepared."
    ],
    arrival: [],
    flee: [],
    death: [
      "The brown boar collapses to the ground, emits a final squeal, and dies.",
      "The brown boar lets out a final agonized squeal and dies.",
      "The brown boar silently lets out a final agonized squeal and dies.",
      "A brown boar goes limp as he is rendered unconscious!",
      "The brown boar collapses to the ground, emits a final silent squeal, and dies."
    ],
    decay: [
      "A brown boar decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A brown boar charges at you!"
    ],
    bite: [
      "A brown boar tries to bite you!"
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
