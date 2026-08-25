{
  schema_version: 3,
  name: "wharf rat",
  noun: "",
  url: "https://gswiki.play.net/wharf_rat",
  picture: "",
  level: nil,
  family: "Rodent",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 24,
  speed: nil,
  height: 1,
  size: "small",
  areas: [
    {
      name: "Rocky Shoals",
      uids: [7127001..7127019]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 4
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
    melee: 14,
    ranged: 12,
    bolt: 12,
    udf: nil,
    bar_td: nil,
    cle_td: nil,
    emp_td: -31,
    pal_td: nil,
    ran_td: nil,
    sor_td: 3,
    wiz_td: nil,
    mje_td: 3,
    mne_td: 3,
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
    skin: "fang",
    other: nil
  },
  messaging: {
    description: [
      ""
    ],
    arrival: [
      "A choking fetid odor heralds the arrival of a wharf rat!",
      "A wharf rat scampers in!"
    ],
    flee: [
      "A wharf rat scampers {direction}."
    ],
    death: [
      "The wharf rat collapses to the ground, emits a final squeal, and dies.",
      "The wharf rat twitches and dies.",
      "The wharf rat collapses to the ground, emits a final silent squeal, and dies."
    ],
    decay: [
      "A wharf rat decays into a pile of mangy hair and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A wharf rat tries to bite you!"
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
