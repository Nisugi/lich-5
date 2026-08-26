{
  schema_version: 3,
  name: "fire ogre",
  noun: "",
  url: "https://gswiki.play.net/fire_ogre",
  picture: "",
  level: 28,
  family: "Ogre",
  type: "Biped",
  undead: false,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Element-based"
  ],
  bcs: true,
  max_hp: 225,
  speed: nil,
  height: 10,
  size: "huge",
  areas: [
    {
      name: "Volcanic Flats",
      uids: [3023001..3023028]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Flail",
        as: 245
      }
    ],
    bolt_spells: [
      {
        name: "Major Fire (908)",
        as: 167
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "17N",
    immunities: [],
    melee: (104..203),
    ranged: (92..123),
    bolt: 111,
    udf: 281,
    bar_td: (101..115),
    cle_td: nil,
    emp_td: (101..109),
    pal_td: nil,
    ran_td: nil,
    sor_td: (104..111),
    wiz_td: nil,
    mje_td: 113,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (106..114),
    mnm_td: (86..95),
    defensive_spells: [
      "Elemental Defense I",
      "Elemental Defense II"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a deep black spiked flail",
    "a scorched black oak-hafted flail"
  ],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "ogre tooth",
    other: "shimmering blue essence shardessence of fire"
  },
  messaging: {
    description: [
      "Easily three times as large as the largest giantman, this brutish creature glares about with fire red eyes. The fire ogre has black, soot-covered skin and fiery orange hair. Steam pours from her nose as she flexes her massive claws."
    ],
    arrival: [
      "A fire ogre stomps in, covered in black soot!"
    ],
    flee: [],
    death: [
      "A fire ogre goes limp as she is rendered unconscious!"
    ],
    decay: [
      "A fire ogre burns down to a husk, that crumbles to ash."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A fire ogre blows fire ogre fiery breath at you!"
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
