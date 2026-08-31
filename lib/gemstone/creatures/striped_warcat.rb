{
  schema_version: 3,
  name: "striped warcat",
  noun: "",
  url: "https://gswiki.play.net/striped_warcat",
  picture: "",
  level: 20,
  family: "Feline",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 180,
  speed: 9,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Lysierian Hills",
      uids: [92120..92129]
    },
    {
      name: "Dubh Brugh",
      uids: [4003010..4003025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (185..195)
      },
      {
        name: "Bite",
        as: (166..193)
      },
      {
        name: "Unknown",
        as: 185
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Leap (knock down)"
      },
      {
        name: "Leap"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "10N",
    immunities: [],
    melee: (80..160),
    ranged: (68..111),
    bolt: (68..111),
    udf: (120..176),
    bar_td: 60,
    cle_td: 60,
    emp_td: (60..68),
    pal_td: (57..63),
    ran_td: (54..60),
    sor_td: (58..61),
    wiz_td: 63,
    mje_td: 63,
    mne_td: 63,
    mjs_td: (60..66),
    mns_td: (60..66),
    mnm_td: 60,
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
    skin: "a warcat whisker",
    other: "no"
  },
  messaging: {
    description: [
      "The striped warcat is a large ornery cat. It is fairly large, standing roughly a head over a halfling. Wide, tapering grey stripes run down the side of its black fur. Its amber eyes gleam hypnotically as it stares back in your direction."
    ],
    arrival: [
      "A striped warcat stalks in!"
    ],
    flee: [
      "A striped warcat stalks {direction}.",
      "A striped warcat roars loudly as he stands {direction}!"
    ],
    death: [
      "The striped warcat lets out a final caterwaul and dies.",
      "The striped warcat crumples to the ground and dies.",
      "Beautiful shot pierces both lungs, the striped warcat makes a wheezing noise, and drops dead!"
    ],
    decay: [
      "A striped warcat decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A striped warcat tries to bite you!"
    ],
    claw: [
      "A striped warcat claws at you!"
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
