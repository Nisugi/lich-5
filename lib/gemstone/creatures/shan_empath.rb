{
  schema_version: 3,
  name: "shan empath",
  noun: "",
  url: "https://gswiki.play.net/shan_empath",
  picture: "",
  level: 60,
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
  max_hp: 228,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Forgotten Vineyard",
      uids: [4225003..4225016]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Spirit Strike"
      },
      {
        name: "Modwir-hafted mace",
        as: (260..378)
      }
    ],
    maneuvers: [
      {
        name: "Gesture"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (205..446),
    ranged: (184..295),
    bolt: (184..295),
    udf: (269..445),
    bar_td: nil,
    cle_td: (277..283),
    emp_td: (271..286),
    pal_td: (240..249),
    ran_td: (216..221),
    sor_td: (254..276),
    wiz_td: nil,
    mje_td: (270..279),
    mne_td: (270..279),
    mjs_td: 295,
    mns_td: 295,
    mnm_td: (206..215),
    defensive_spells: [
      "Troll's Blood"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a modwir-hafted mace",
    "an engraved parma",
    "some torn leathers"
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
      ""
    ],
    arrival: [
      "A shan empath just arrived."
    ],
    flee: [
      "A shan empath pads {direction}.",
      "A shan empath limps {direction}."
    ],
    death: [
      "The shan empath howls out one last time and dies.",
      "The shan empath yips in pain as he falls to the ground motionless.",
      "The shan empath yips in pain as she falls to the ground motionless.",
      "A shan empath's body shimmers slightly.  Suddenly, her features cave in, falling grotesquely into a haunting visage of decay, before abruptly fraying to a pile of fur and fangs that marks the spot of her death like a silhouette.",
      "A shan empath's body shimmers slightly.  Suddenly, his features cave in, falling grotesquely into a haunting visage of decay, before abruptly fraying to a pile of fur and fangs that marks the spot of his death like a silhouette.",
      "Beautiful shot pierces both lungs, the shan empath makes a wheezing noise, and drops dead!"
    ],
    decay: [
      "The shan empath's left leg crumbles briefly and explodes in a shower of gore.",
      "The shan empath's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A shan empath snarls and gestures sharply at you!",
      "A shan empath swings {weapon} at you!"
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
