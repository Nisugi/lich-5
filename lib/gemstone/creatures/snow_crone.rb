{
  schema_version: 3,
  name: "snow crone",
  noun: "",
  url: "https://gswiki.play.net/snow_crone",
  picture: "",
  level: 36,
  family: "Witch",
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
  max_hp: 240,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Glatoph",
      uids: [35028..35038, 35068..35072]
    },
    {
      name: "Sleeping Lady Mountains",
      uids: [4560001..4560053]
    }
  ],
  attack_attributes: {
    physical_attacks: [],
    bolt_spells: [
      {
        name: "Major Cold (907)",
        as: 227
      }
    ],
    warding_spells: [
      {
        name: "Mana Disruption (702)",
        cs: 201
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Stomp"
      }
    ],
    special_abilities: [
      {
        name: "Gas Cloud"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (273..278),
    ranged: (190..199),
    bolt: 203,
    udf: (225..299),
    bar_td: (113..118),
    cle_td: (130..134),
    emp_td: (129..138),
    pal_td: (103..113),
    ran_td: nil,
    sor_td: (136..146),
    wiz_td: nil,
    mje_td: 125,
    mne_td: 143,
    mjs_td: nil,
    mns_td: 138,
    mnm_td: (113..123),
    defensive_spells: [
      "Spirit Defense (103)",
      "Spirit Warding I (101)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a flowing white robe",
    "an ice-white palache",
    "an icy dagger",
    "some tattered white robes"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a crooked crone finger",
    other: nil
  },
  messaging: {
    description: [
      "Glistening in the light, the crone's snow white skin is covered with frost and snow. Seemingly formed of living snow, the crone is a cold, imposing creature. The snow crone has a mop of tangle ice blue hair sticking out wildly in all directions."
    ],
    arrival: [],
    flee: [],
    death: [
      "The snow crone cries out in cold agony one last time and dies.",
      "A snow crone goes limp as she is rendered unconscious!",
      "The snow crone falls to the ground motionless."
    ],
    decay: [
      "The snow crone's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A snow crone points a crooked icy finger at you!"
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
