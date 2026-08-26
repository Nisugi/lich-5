{
  schema_version: 3,
  name: "pra'eda",
  noun: "",
  url: "https://gswiki.play.net/pra'eda",
  picture: "",
  level: 29,
  family: "Canine",
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
  max_hp: 341,
  speed: nil,
  height: 6,
  size: "large",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4214303..4214323, 4218101..4218121]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Closed fist",
        as: 281
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Energy Maelstrom (710)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "18N",
    immunities: [],
    melee: (151..241),
    ranged: 132,
    bolt: nil,
    udf: 206,
    bar_td: 89,
    cle_td: (105..115),
    emp_td: (115..125),
    pal_td: nil,
    ran_td: nil,
    sor_td: (103..128),
    wiz_td: nil,
    mje_td: (113..130),
    mne_td: 109,
    mjs_td: nil,
    mns_td: (114..123),
    mnm_td: (107..117),
    defensive_spells: [
      "Elemental Defense III (414)",
      "Spirit Defense (103)",
      "Spirit Warding I (101)",
      "Spirit Warding II (107)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a bruised left eye",
    "a bruised right eye"
  ],
  treasure: {
    coins: true,
    magic_items: nil,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Glimmering blue essence shard"
  },
  messaging: {
    description: [
      "The pra'eda before you stands on two legs, but the golden eyes that glare from either side of its fanged, canine snout and its coat of grizzled fur make it difficult to determine whether it is more human or wolf in nature. A stench of blood and rotting flesh emanates from its fanged jaws, and its rough, tattered clothing is stained with dirt and gore."
    ],
    arrival: [],
    flee: [],
    death: [
      "The pra'eda falls to the ground motionless.",
      "A pra'eda goes limp as it is rendered unconscious!",
      "The pra'eda cries out one last time and lies still."
    ],
    decay: [
      "The pra'eda's left leg crumbles briefly and explodes in a shower of gore.",
      "The pra'eda's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A pra'eda swings {weapon} at you!"
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
