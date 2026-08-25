{
  schema_version: 3,
  name: "ebon swine",
  noun: "",
  url: "https://gswiki.play.net/ebon_swine",
  picture: "",
  level: nil,
  family: "Suine",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 131,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Black Weald",
      uids: [7130001..7130018]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 158
      },
      {
        name: "Charge",
        as: 181
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
    asg: nil,
    immunities: [],
    melee: 100,
    ranged: 67,
    bolt: 67,
    udf: nil,
    bar_td: nil,
    cle_td: nil,
    emp_td: (21..29),
    pal_td: nil,
    ran_td: nil,
    sor_td: (36..45),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      ""
    ],
    arrival: [],
    flee: [],
    death: [
      "The ebon swine lets out a final agonized squeal and dies.",
      "The ebon swine collapses to the ground, emits a final squeal, and dies.",
      "The ebon swine twitches violently, then dies.",
      "The ebon swine silently lets out a final agonized squeal and dies."
    ],
    decay: [
      "An ebon swine decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An ebon swine charges at you!"
    ],
    bite: [
      "An ebon swine tries to bite you!"
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
