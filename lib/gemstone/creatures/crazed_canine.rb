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
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
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
    melee: 87,
    ranged: nil,
    bolt: nil,
    udf: 97,
    bar_td: nil,
    cle_td: nil,
    emp_td: 30,
    pal_td: nil,
    ran_td: nil,
    sor_td: 30,
    wiz_td: nil,
    mje_td: 30,
    mne_td: 30,
    mjs_td: nil,
    mns_td: 30,
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
    flee: [],
    death: [
      "The crazed canine falls to the ground and dies.",
      "The crazed canine rolls over and dies.",
      "A crazed canine goes limp as he is rendered unconscious!"
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
