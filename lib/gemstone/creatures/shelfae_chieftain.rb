{
  schema_version: 3,
  name: "shelfae chieftain",
  noun: "",
  url: "https://gswiki.play.net/shelfae_chieftain",
  picture: "",
  level: 11,
  family: "Shelfae",
  type: "Hybrid",
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
  max_hp: 140,
  speed: nil,
  height: 7,
  size: "medium",
  areas: [
    {
      name: "Coastal Cliffs",
      uids: [84408..84413, 84416..84419]
    },
    {
      name: "Plains of Vornavis",
      uids: [4212301..4212324]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Halberd",
        as: 130
      },
      {
        name: "Morning star",
        as: 130
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Tail strike"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "11",
    immunities: [],
    melee: (39..42),
    ranged: 6,
    bolt: 6,
    udf: nil,
    bar_td: 33,
    cle_td: 33,
    emp_td: 33,
    pal_td: (30..33),
    ran_td: nil,
    sor_td: 33,
    wiz_td: nil,
    mje_td: 33,
    mne_td: 33,
    mjs_td: 33,
    mns_td: 33,
    mnm_td: 33,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a halberd"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a shelfae crest",
    other: "No"
  },
  messaging: {
    description: [
      "Similar to the shelfae soldier but taller by nearly two feet, the shelfae chieftain guides the legions of shelfae in combat. Its taller stature, significantly brighter orange coloration, and protruding crest mark it as an officer. Although formidably armed, the shelfae chieftain prefers to bring its opponents down first by sweeping its tail to produce a quake effect."
    ],
    arrival: [
      "A shelfae chieftain just arrived."
    ],
    flee: [],
    death: [
      "The shelfae chieftain falls to the ground and dies.",
      "The shelfae chieftain screams one last time and dies.",
      "The shelfae chieftain twitches violently, then dies."
    ],
    decay: [
      "A chieftain crumbles into dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A shelfae chieftain swings {weapon} at you!"
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
