{
  schema_version: 3,
  name: "shan wizard",
  noun: "",
  url: "https://gswiki.play.net/shan_wizard",
  picture: "",
  level: 42,
  family: "Shan",
  type: "Biped",
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
  max_hp: 210,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4218301..4218325]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Dagger",
        as: 254
      }
    ],
    bolt_spells: [
      {
        name: "Minor Acid (904)",
        as: 228
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Earthen Fury (917)"
      },
      {
        name: "Elemental Focus (513)"
      },
      {
        name: "Elemental Targeting (425)"
      }
    ],
    maneuvers: [
      {
        name: "Web"
      },
      {
        name: "Point"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (238..348),
    ranged: 241,
    bolt: 241,
    udf: 323,
    bar_td: (138..157),
    cle_td: (156..165),
    emp_td: (161..170),
    pal_td: (135..145),
    ran_td: (138..144),
    sor_td: (170..187),
    wiz_td: nil,
    mje_td: 168,
    mne_td: 168,
    mjs_td: (164..173),
    mns_td: (164..173),
    mnm_td: (128..134),
    defensive_spells: [
      "Elemental Defense II",
      "Elemental Defense III"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a flowing grey robe",
    "a long dagger",
    "a spiked tower shield"
  ],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The shan wizard stands in a half-crouch, his long, knotty legs giving him that lanky, dangerous look of a wolf. Walking upright, the body covered with mottled grey fur and his long arms conclude in large, clawed hands with semi-opposable thumbs. The shan wizard's dog-like visage is fierce, with slavering jaws and eyes that glow like something out of a bad dream."
    ],
    arrival: [],
    flee: [],
    death: [
      "The shan wizard twitches violently, then dies.",
      "The shan wizard yips in pain as he falls to the ground motionless.",
      "The shan wizard yips in pain as she falls to the ground motionless.",
      "The shan wizard howls out one last time and dies.",
      "A shan wizard's body shimmers slightly.  Suddenly, her features cave in, falling grotesquely into a haunting visage of decay, before abruptly fraying to a pile of fur and fangs that marks the spot of her death like a silhouette.",
      "A shan wizard's body shimmers slightly.  Suddenly, his features cave in, falling grotesquely into a haunting visage of decay, before abruptly fraying to a pile of fur and fangs that marks the spot of his death like a silhouette.",
    ],
    decay: [
      "The shan wizard's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A shan wizard points both hands at you!"
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
