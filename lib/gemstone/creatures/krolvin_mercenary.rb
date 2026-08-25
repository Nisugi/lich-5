{
  schema_version: 3,
  name: "krolvin mercenary",
  noun: "",
  url: "https://gswiki.play.net/krolvin_mercenary",
  picture: "",
  level: 17,
  family: "Krolvin",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 200,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Sea Caves",
      uids: [26103..26120]
    },
    {
      name: "Lysierian Hills",
      uids: [93050..93070]
    },
    {
      name: "Liath Bheinn and Aillidh Brae",
      uids: [4250050..4250068]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Broadsword",
        as: 178
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Cheapshot"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "11",
    immunities: [],
    melee: (194..224),
    ranged: nil,
    bolt: nil,
    udf: 127,
    bar_td: 51,
    cle_td: nil,
    emp_td: (51..59),
    pal_td: nil,
    ran_td: nil,
    sor_td: (51..57),
    wiz_td: nil,
    mje_td: 51,
    mne_td: 51,
    mjs_td: nil,
    mns_td: 51,
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "As tall as the average human, the mercenary has the characteristic long-fingered hands and sturdy musculature that denote most of the krolvin race. The mercenary also sports the trademark grey-blue skin and thick, coarse, white hair covers his head and spreads across his shoulders and down his back."
    ],
    arrival: [
      "A krolvin mercenary just arrived."
    ],
    flee: [],
    death: [],
    decay: [
      "A krolvin mercenary collapses into a pile of dirty rags."
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
