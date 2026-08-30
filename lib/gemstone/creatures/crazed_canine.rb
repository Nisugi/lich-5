{
  schema_version: 3,
  name: "crazed canine",
  noun: "",
  url: "https://gswiki.play.net/crazed_canine",
  picture: "",
  level: 10,
  family: "Canine",
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
  max_hp: 100,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Cliffwalk",
      uids: [7129001..7129017]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (94..118)
      },
      {
        name: "Charge (attack)",
        as: 128
      },
      {
        name: "Charge",
        as: 128
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Leap maneuver"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: (52..87),
    ranged: (41..49),
    bolt: (41..49),
    udf: (62..97),
    bar_td: nil,
    cle_td: 30,
    emp_td: 30,
    pal_td: (27..30),
    ran_td: 30,
    sor_td: 30,
    wiz_td: nil,
    mje_td: 30,
    mne_td: 30,
    mjs_td: (30..33),
    mns_td: (30..33),
    mnm_td: 30,
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
    skin: "a rotted canine",
    other: nil
  },
  messaging: {
    description: [
      ""
    ],
    arrival: [],
    flee: [
      "A crazed canine rushes {direction}!"
    ],
    death: [
      "The crazed canine falls to the ground and dies.",
      "The crazed canine rolls over and dies."
    ],
    decay: [
      "A crazed canine decays into a compost of fangs and fur."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A crazed canine charges at you!"
    ],
    bite: [
      "A crazed canine tries to bite you!"
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
