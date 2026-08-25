{
  schema_version: 3,
  name: "panther",
  noun: "",
  url: "https://gswiki.play.net/panther",
  picture: "",
  level: 15,
  family: "Feline",
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
  max_hp: 140,
  speed: nil,
  height: 3,
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
        name: "Bite",
        as: (150..174)
      },
      {
        name: "Claw",
        as: (134..174)
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
    asg: "6N",
    immunities: [],
    melee: (97..151),
    ranged: nil,
    bolt: 85,
    udf: 146,
    bar_td: (33..51),
    cle_td: nil,
    emp_td: (45..53),
    pal_td: nil,
    ran_td: nil,
    sor_td: (42..51),
    wiz_td: nil,
    mje_td: (39..48),
    mne_td: (39..45),
    mjs_td: nil,
    mns_td: nil,
    mnm_td: 45,
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
    skin: "a panther pelt",
    other: nil
  },
  messaging: {
    description: [
      "The panther is a large, black cat with a slender body and long tail. Often approaching and striking silently, he affords his prey little warning. Powerful jaws bite and sharp claws rend as the panther attempts to secure enough food for another day. Even when satiated, though, the panther enjoys killing just for the pleasure of it."
    ],
    arrival: [
      "A panther scampers in!",
      "A panther scampers in, mewling in pain!"
    ],
    flee: [
      "A panther scampers {direction}.",
      "A panther scampers {direction}, mewling in pain."
    ],
    death: [
      "The panther lets out a final caterwaul and dies.",
      "The panther crumples to the ground and dies.",
      "A panther goes limp as she is rendered unconscious!"
    ],
    decay: [
      "A panther decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A panther tries to bite you!"
    ],
    claw: [
      "A panther claws at you!"
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
