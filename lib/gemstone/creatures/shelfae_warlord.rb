{
  schema_version: 3,
  name: "shelfae warlord",
  noun: "",
  url: "https://gswiki.play.net/shelfae_warlord",
  picture: "",
  level: 18,
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
  max_hp: 160,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Plains of Vornavis",
      uids: [4212301..4212324]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Falchion",
        as: 170
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Tremors (909)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (49..65),
    ranged: nil,
    bolt: 50,
    udf: nil,
    bar_td: 54,
    cle_td: (53..54),
    emp_td: 54,
    pal_td: nil,
    ran_td: nil,
    sor_td: 54,
    wiz_td: nil,
    mje_td: 54,
    mne_td: 54,
    mjs_td: nil,
    mns_td: 54,
    mnm_td: (53..54),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a falchion",
    "a wooden shield"
  ],
  treasure: {
    coins: true,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "an orange shelfae scale",
    other: nil
  },
  messaging: {
    description: [
      "The shelfae warlord is the noble class of the shelfae reptilian society and is highly trained in the art of physical warfare. Its scaly skin carries the bright orange color of the shelfae officers, but it also contains an odd bluish design, which some say is merely a genetic discoloration, and others maintain is a likeness of Charl holding aloft his trident. Either way, the shelfae warlord is a quick, powerful opponent."
    ],
    arrival: [
      "A shelfae warlord just arrived."
    ],
    flee: [],
    death: [
      "The shelfae warlord falls to the ground and dies.",
      "The shelfae warlord screams one last time and dies."
    ],
    decay: [
      "A warlord crumbles into dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A shelfae warlord swings {weapon} at you!"
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
