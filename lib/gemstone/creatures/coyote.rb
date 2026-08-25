{
  schema_version: 3,
  name: "coyote",
  noun: "",
  url: "https://gswiki.play.net/coyote",
  picture: "",
  level: 5,
  family: "Canine",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 60,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Upper Trollfang",
      uids: [16001..16005, 16011..16013]
    },
    {
      name: "Vornavian Coast",
      uids: [4214101..4214115]
    },
    {
      name: "Lower Dragonsclaw",
      uids: [9042..9047, 9058..9058]
    },
    {
      name: "Plains of Vornavis",
      uids: [4212101..4212130, 4213101..4213130]
    },
    {
      name: "Liath Bheinn and Aillidh Brae",
      uids: [4250022..4250026]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (76..95)
      },
      {
        name: "Charge",
        as: (85..95)
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
    asg: "8N",
    immunities: [],
    melee: (17..54),
    ranged: nil,
    bolt: nil,
    udf: 83,
    bar_td: 15,
    cle_td: nil,
    emp_td: 15,
    pal_td: nil,
    ran_td: nil,
    sor_td: 15,
    wiz_td: nil,
    mje_td: 15,
    mne_td: 15,
    mjs_td: nil,
    mns_td: 15,
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
    skin: "a coyote tail",
    other: "No"
  },
  messaging: {
    description: [
      "The coyote, a quick, buff-colored creature, is a smaller cousin of the wolf. However, the coyote lacks the wolf's braver tendencies, preferring to slash and run rather than risk a frontal assault in an attempt to go for the throat. The coyote must be approached with care, as the coyote has been known to take an adventurer's hand off with one quick snap of the jaws."
    ],
    arrival: [],
    flee: [],
    death: [
      "The coyote falls to the ground and dies.",
      "The coyote rolls over and dies.",
      "A greater orc breathes his last gasp and dies.",
      "A greater orc breathes her last gasp and dies."
    ],
    decay: [
      "A coyote decays into a compost of fangs and fur."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A coyote charges at you!"
    ],
    bite: [
      "A coyote tries to bite you!"
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
