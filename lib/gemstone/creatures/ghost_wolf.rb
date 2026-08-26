{
  schema_version: 3,
  name: "ghost wolf",
  noun: "",
  url: "https://gswiki.play.net/ghost_wolf",
  picture: "",
  level: 16,
  family: "Canine",
  type: "Quadruped",
  undead: true,
  blood: false,
  bones: nil,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: nil,
  max_hp: 150,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Plains of Bone",
      uids: [14011023..14011041]
    },
    {
      name: "Upper Trollfang",
      uids: [14070..14079]
    },
    {
      name: "Icemule Trail",
      uids: [4044200..4044218]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 143
      },
      {
        name: "Claw",
        as: 143
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
    asg: "1N",
    immunities: [],
    melee: (76..101),
    ranged: 84,
    bolt: 84,
    udf: (107..117),
    bar_td: 48,
    cle_td: 48,
    emp_td: 48,
    pal_td: (45..48),
    ran_td: 48,
    sor_td: 48,
    wiz_td: 48,
    mje_td: 48,
    mne_td: 48,
    mjs_td: 48,
    mns_td: 48,
    mnm_td: 48,
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
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "A transparent, flickering, light-grey canine, the ghost wolf is the captured spirit of a member of the wolf packs that used to roam the lands. The ghost wolf uses its snapping jaws and rending claws to best advantage. As it did in life, the ghost wolf prefers to hunt with other members of its species, carefully watching its prey through bright yellow eyes, darting in to bite, then rushing away while another ghost wolf attacks from the rear."
    ],
    arrival: [
      "A ghost wolf scampers in."
    ],
    flee: [
      "The wolf scampers {direction}."
    ],
    death: [
      "The ghost wolf falls back into a heap and dies.",
      "The ghost wolf hisses one last time and dies.",
      "The ghost wolf goes still for a moment while its head reshapes."
    ],
    decay: [
      "A ghost wolf decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A ghost wolf tries to bite you!"
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
