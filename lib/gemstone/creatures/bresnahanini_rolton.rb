{
  schema_version: 3,
  name: "bresnahanini rolton",
  noun: "",
  url: "https://gswiki.play.net/bresnahanini_rolton",
  picture: "",
  level: 3,
  family: "Caprine",
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
  max_hp: 44,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Outlands",
      uids: [4215701..4215716]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite (attack)",
        as: 60
      },
      {
        name: "Charge (attack)",
        as: 70
      },
      {
        name: "Bite",
        as: 50
      },
      {
        name: "Charge",
        as: 63
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
    asg: "5N",
    immunities: [],
    melee: (19..45),
    ranged: 17,
    bolt: 17,
    udf: 74,
    bar_td: nil,
    cle_td: 9,
    emp_td: 9,
    pal_td: (6..9),
    ran_td: nil,
    sor_td: 9,
    wiz_td: nil,
    mje_td: 9,
    mne_td: 9,
    mjs_td: nil,
    mns_td: 9,
    mnm_td: 9,
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
    gems: nil,
    boxes: nil,
    skin: "a rolton horn",
    other: nil
  },
  messaging: {
    description: [
      "Nearly four feet at the shoulder, and graced with a pair of large, curled horns, the Bresnahanini rolton is a larger and meaner version of his standard cousin. Sometimes called the curly-horned rolton, this species is reputed to have even killed a lord or two."
    ],
    arrival: [],
    flee: [
      "A Bresnahanini rolton trots {direction}."
    ],
    death: [
      "The Bresnahanini rolton collapses to the ground, emits a final bleat, and dies.",
      "The Bresnahanini rolton lets out a final agonized bleat and dies.",
      "The Bresnahanini rolton bleats loudly as he slumps to the ground and cradles his wounded left hoof.",
      "The Bresnahanini rolton bleats loudly as he slumps to the ground and cradles his wounded right foreleg."
    ],
    decay: [
      "A Bresnahanini rolton decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A Bresnahanini rolton charges at you!"
    ],
    bite: [
      "A Bresnahanini rolton tries to bite you!"
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
