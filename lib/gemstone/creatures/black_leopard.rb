{
  schema_version: 3,
  name: "black leopard",
  noun: "",
  url: "https://gswiki.play.net/black_leopard",
  picture: "",
  level: 15,
  family: "Feline",
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
  max_hp: 140,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Grasslands",
      uids: [14012050..14012070, 14012150..14012165]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (134..168)
      },
      {
        name: "Bite",
        as: (128..168)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Pounce"
      },
      {
        name: "Leap"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: (128..151),
    ranged: 85,
    bolt: 85,
    udf: 146,
    bar_td: 45,
    cle_td: (42..51),
    emp_td: (25..33),
    pal_td: nil,
    ran_td: nil,
    sor_td: (42..51),
    wiz_td: nil,
    mje_td: (39..45),
    mne_td: 45,
    mjs_td: 45,
    mns_td: 45,
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
    skin: "a black leopard paw",
    other: nil
  },
  messaging: {
    description: [
      "At first glance, the black leopard has pure black fur but upon the shifting of light, faint auburn rosette patterns fade in and out of sight against the sleek darkness. The only visible part of the leopard when she's stealthily hidden in the wilds is her deeply-toned amber eyes, which are always gazing warily at her surroundings. With the ability to retract her claws into her large padded paws, the black leopard is able to conceal her movement and stalk silently behind her prey with great success."
    ],
    arrival: [
      "A black leopard scampers in!",
      "A black leopard scampers in, mewling in pain!",
      "An Agresh bear lumbers in, flecks of drool flinging with each of its strides."
    ],
    flee: [
      "A black leopard scampers {direction}.",
      "A black leopard scampers {direction}, mewling in pain."
    ],
    death: [
      "The black leopard lets out a final caterwaul and dies.",
      "The black leopard crumples to the ground and dies."
    ],
    decay: [
      "A black leopard decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A black leopard tries to bite you!"
    ],
    claw: [
      "A black leopard claws at you!"
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
