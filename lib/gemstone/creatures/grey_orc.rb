{
  schema_version: 3,
  name: "grey orc",
  noun: "",
  url: "https://gswiki.play.net/grey_orc",
  picture: "",
  level: 14,
  family: "Orc",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: false,
  max_hp: 130,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Yander's Farm",
      uids: [14005067..14005080]
    },
    {
      name: "Upper Trollfang",
      uids: [14015..14023, 14025..14025, 16051..16057]
    },
    {
      name: "unmapped",
      uids: [14024..14024]
    },
    {
      name: "Liath Bheinn and Aillidh Brae",
      uids: [4250005..4250021]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Composite bow",
        as: 139
      }
    ],
    bolt_spells: [
      {
        name: "Minor Fire (906)",
        as: 130
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Gas cloud"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (106..123),
    ranged: (67..105),
    bolt: (67..105),
    udf: 118,
    bar_td: 42,
    cle_td: nil,
    emp_td: (42..46),
    pal_td: nil,
    ran_td: 39,
    sor_td: (42..45),
    wiz_td: 42,
    mje_td: 45,
    mne_td: 42,
    mjs_td: 42,
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "an orc beard",
    other: nil
  },
  messaging: {
    description: [
      "This orc, midway in size between a lesser and a greater orc, the grey orc has a greyish cast to its skin, lending an unhealthy pallor to an already hideous countenance. Dim intelligence flickers behind the narrow eyes and a mocking grin shows blackened and rotting teeth."
    ],
    arrival: [],
    flee: [],
    death: [
      "A grey orc gazes upward one last time and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
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
