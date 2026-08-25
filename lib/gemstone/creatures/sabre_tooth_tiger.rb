{
  schema_version: 3,
  name: "sabre-tooth tiger",
  noun: "",
  url: "https://gswiki.play.net/sabre-tooth_tiger",
  picture: "",
  level: 53,
  family: "Feline",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 4,
  size: "large",
  areas: [
    {
      name: "Great Mountain Aenatumgana",
      uids: [4561010..4561020, 4561102..4561140, 4561201..4561208]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 313
      },
      {
        name: "Charge",
        as: (297..315)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Leap"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (196..467),
    ranged: nil,
    bolt: (225..243),
    udf: 374,
    bar_td: nil,
    cle_td: nil,
    emp_td: (186..195),
    pal_td: nil,
    ran_td: nil,
    sor_td: (197..206),
    wiz_td: nil,
    mje_td: (209..218),
    mne_td: nil,
    mjs_td: nil,
    mns_td: 186,
    mnm_td: (150..159),
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
    skin: "a tiger incisor",
    other: nil
  },
  messaging: {
    description: [
      "The huge sabre-tooth tiger is obviously a formidable predator, measuring more than 15 feet from the nose to the tip of her tail. Flexing massive shoulders above powerful forelegs, the tiger growls and snarls, exposing the elongated canines that give her her name. The tiger's magnificent striped pelt gradates from a soft tan undertone along the spine to a powder white on belly and legs."
    ],
    arrival: [
      "A sabre-tooth tiger prowls in!"
    ],
    flee: [],
    death: [
      "The sabre-tooth tiger crumples to the ground and dies.",
      "The sabre-tooth tiger lets out a final caterwaul and dies.",
      "A sabre-tooth tiger goes limp as she is rendered unconscious!"
    ],
    decay: [
      "A sabre-tooth tiger decays into a compost of fangs, fur and claws.",
      "A dazzling sabre-tooth tiger decays into a compost of fangs, fur and claws.",
      "A steadfast sabre-tooth tiger decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A sabre-tooth tiger charges at you!"
    ],
    bite: [
      "A sabre-tooth tiger tries to bite you!"
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
