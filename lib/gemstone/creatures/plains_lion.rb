{
  schema_version: 3,
  name: "plains lion",
  noun: "",
  url: "https://gswiki.play.net/plains_lion",
  picture: "",
  level: 18,
  family: "Feline",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 160,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Grasslands",
      uids: [14012100..14012120, 14012150..14012165]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 165
      },
      {
        name: "Claw",
        as: 165
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Pounce"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: (107..149),
    ranged: (80..119),
    bolt: (80..119),
    udf: (167..191),
    bar_td: (54..60),
    cle_td: (54..60),
    emp_td: (46..60),
    pal_td: (48..57),
    ran_td: (48..54),
    sor_td: (51..60),
    wiz_td: nil,
    mje_td: 54,
    mne_td: 54,
    mjs_td: (48..57),
    mns_td: (48..57),
    mnm_td: (54..60),
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
    skin: "a plains lion skin",
    other: nil
  },
  messaging: {
    description: [
      "The plains lion is a muscular and athletic animal. Covered with a uniform coat of soft, golden-brown fur, her long, lithe body is equipped with powerful legs, displaying a proportionately greater difference in the length of the forelegs compared to the extenuated hind limbs. The feline's head is topped with white tufted ears, and a very long, balancing tail completes the lion's physique."
    ],
    arrival: [
      "A plains lion scampers in!",
      "A plains lion scampers in, mewling in pain!"
    ],
    flee: [
      "A plains lion scampers {direction}.",
      "A plains lion scampers {direction}, mewling in pain.",
      "A plains lion roars loudly as he stands {direction}!"
    ],
    death: [
      "The plains lion crumples to the ground and dies.",
      "The plains lion lets out a final caterwaul and dies.",
      "Beautiful shot pierces both lungs, the plains lion makes a wheezing noise, and drops dead!"
    ],
    decay: [
      "A plains lion decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
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
