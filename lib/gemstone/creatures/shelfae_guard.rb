{
  schema_version: 3,
  name: "shelfae guard",
  noun: "",
  url: "https://gswiki.play.net/shelfae_guard",
  picture: "",
  level: 7,
  family: "Shelfae",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 94,
  speed: nil,
  height: 5,
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
        as: 82
      },
      {
        name: "Claw",
        as: 82
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: 15,
    ranged: 10,
    bolt: 10,
    udf: 55,
    bar_td: nil,
    cle_td: 21,
    emp_td: 21,
    pal_td: (18..21),
    ran_td: nil,
    sor_td: 21,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: 21,
    mnm_td: 21,
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "scale",
    other: nil
  },
  messaging: {
    description: [
      ""
    ],
    arrival: [
      "A shelfae guard just arrived."
    ],
    flee: [],
    death: [
      "The shelfae guard falls to the ground and dies.",
      "A shelfae guard goes limp as it is rendered unconscious!",
      "The shelfae guard screams one last time and dies."
    ],
    decay: [
      "A guard crumbles into dust."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A shelfae guard tries to bite you!"
    ],
    claw: [
      "A shelfae guard claws at you!"
    ],
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
