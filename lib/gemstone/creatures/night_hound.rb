{
  schema_version: 3,
  name: "night hound",
  noun: "",
  url: "https://gswiki.play.net/night_hound",
  picture: "",
  level: 24,
  family: "Canine",
  type: "Quadruped",
  undead: true,
  blood: false,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 210,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "The Graveyard",
      uids: [2150002..2150007, 2150010..2150014]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 192
      },
      {
        name: "Claw",
        as: (182..202)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Breath attack"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (137..149),
    ranged: nil,
    bolt: 143,
    udf: 141,
    bar_td: 97,
    cle_td: 99,
    emp_td: (90..101),
    pal_td: nil,
    ran_td: nil,
    sor_td: 104,
    wiz_td: nil,
    mje_td: 106,
    mne_td: (101..107),
    mjs_td: nil,
    mns_td: nil,
    mnm_td: 97,
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
    skin: "a night hound hide",
    other: "No"
  },
  messaging: {
    description: [
      "You have never seen anything quite like a night hound, so you are not really sure what to make of it or how dangerous it might be."
    ],
    arrival: [],
    flee: [],
    death: [
      "The night hound lets out one last whimpering sigh of dark and shadowy whirlwinds and dies."
    ],
    decay: [
      "A night hound decays into a compost of fur and fangs."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A night hound tries to bite you!"
    ],
    claw: [
      "A night hound claws at you!"
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
