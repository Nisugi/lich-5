{
  schema_version: 3,
  name: "shelfae assailant",
  noun: "",
  url: "https://gswiki.play.net/shelfae_assailant",
  picture: "",
  level: nil,
  family: "Shelfae",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 135,
  speed: nil,
  height: 7,
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
        as: 110
      },
      {
        name: "Claw",
        as: 120
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
    melee: 25,
    ranged: 6,
    bolt: 6,
    udf: 73,
    bar_td: nil,
    cle_td: nil,
    emp_td: (9..37),
    pal_td: nil,
    ran_td: nil,
    sor_td: 33,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
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
    coins: nil,
    magic_items: nil,
    gems: true,
    boxes: nil,
    skin: "crest",
    other: nil
  },
  messaging: {
    description: [
      ""
    ],
    arrival: [
      "A shelfae assailant just arrived."
    ],
    flee: [],
    death: [
      "The shelfae assailant falls to the ground and dies.",
      "The shelfae assailant screams one last time and dies.",
      "A shelfae assailant goes limp as it is rendered unconscious!"
    ],
    decay: [
      "A assailant crumbles into dust."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A shelfae assailant tries to bite you!"
    ],
    claw: [
      "A shelfae assailant claws at you!"
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
