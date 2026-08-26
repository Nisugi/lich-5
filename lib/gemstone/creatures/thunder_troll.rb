{
  schema_version: 3,
  name: "thunder troll",
  noun: "",
  url: "https://gswiki.play.net/thunder_troll",
  picture: "",
  level: 18,
  family: "Troll",
  type: "Biped",
  undead: false,
  blood: true,
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
  max_hp: 160,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Stormpeak",
      uids: [13150001..13150016]
    },
    {
      name: "Vornavian Coast",
      uids: [4214201..4214218]
    },
    {
      name: "Northern Slopes of Wehntoph",
      uids: [4302001..4302025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "War mattock",
        as: 163
      },
      {
        name: "Flamberge",
        as: 163
      },
      {
        name: "Nut brown steel bastard sword",
        as: 163
      }
    ],
    bolt_spells: [
      {
        name: "Major Shock (910)",
        as: 117
      }
    ],
    warding_spells: [
      {
        name: "Pain (711)",
        cs: 98
      }
    ],
    offensive_spells: [
      {
        name: "Call Wind (912)"
      }
    ],
    maneuvers: [
      {
        name: "Gas cloud"
      },
      {
        name: "Wind Rush"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "10N",
    immunities: [],
    melee: (74..122),
    ranged: nil,
    bolt: (91..116),
    udf: 95,
    bar_td: (41..68),
    cle_td: (49..59),
    emp_td: (49..59),
    pal_td: (49..59),
    ran_td: nil,
    sor_td: (57..64),
    wiz_td: nil,
    mje_td: 53,
    mne_td: 53,
    mjs_td: nil,
    mns_td: (59..66),
    mnm_td: (61..66),
    defensive_spells: [
      "Elemental Defense I",
      "Elemental Defense II",
      "Spirit Defense",
      "Spirit Warding I",
      "Spirit Warding II"
    ],
    defensive_abilities: [],
    special_defenses: [
      "Shake off stuns"
    ]
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a crude steel maul with forking lightning etchings"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a troll scalp",
    other: nil
  },
  messaging: {
    description: [
      "Tall but sleek, the size of the thunder troll belies its quickness. The thunder troll moves about surrounded by a raging tempest. An upturned lip, protruding jaw and sunken, orange eyes impart an air of arrogance to this foul, rubbery creature. Given to sudden fits of uncontrollable rage, a thunder troll has been known to spring from the forest and tear a seasoned warrior in half before the warrior can even cry out, then, surprisingly, turn and dart away, distracted, leaving small children unharmed."
    ],
    arrival: [
      "A thunder troll just arrived!"
    ],
    flee: [],
    death: [
      "The thunder troll howls in agony one last time and dies.",
      "A thunder troll goes limp as it is rendered unconscious!",
      "A thunder troll dissipates into the air, leaving nothing behind.",
      "The thunder troll crumples to the ground motionless."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A thunder troll claps {pronoun} hands together in front of you!",
      "A thunder troll swings {weapon} at you!"
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
