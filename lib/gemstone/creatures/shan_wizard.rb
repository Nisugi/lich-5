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
    melee: (306..324),
    ranged: nil,
    bolt: nil,
    udf: 323,
    bar_td: (138..157),
    cle_td: (162..165),
    emp_td: (161..170),
    pal_td: nil,
    ran_td: nil,
    sor_td: (170..187),
    wiz_td: nil,
    mje_td: 168,
    mne_td: 168,
    mjs_td: nil,
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
  equipment: [],
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
      "A shan wizard's body shimmers slightly.  Suddenly, his features cave in, falling grotesquely into a haunting visage of decay, before abruptly fraying to a pile of fur and fangs that marks the spot of his death like a silhouette."
    ],
    decay: [],
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
