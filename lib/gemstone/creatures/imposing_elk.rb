{
  schema_version: 3,
  name: "imposing elk",
  noun: "",
  url: "https://gswiki.play.net/imposing_elk",
  picture: "",
  level: nil,
  family: "Deer",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 122,
  speed: nil,
  height: 6,
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
        name: "Antlers",
        as: 139
      },
      {
        name: "Charge",
        as: 148
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
    melee: (93..138),
    ranged: (90..93),
    bolt: (90..93),
    udf: 141,
    bar_td: nil,
    cle_td: nil,
    emp_td: (17..25),
    pal_td: nil,
    ran_td: nil,
    sor_td: (36..45),
    wiz_td: nil,
    mje_td: (33..39),
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
    skin: "antlers",
    other: nil
  },
  messaging: {
    description: [
      ""
    ],
    arrival: [],
    flee: [],
    death: [
      "The imposing elk collapses to the ground, emits a final sigh, and dies.",
      "An imposing elk goes limp as she is rendered unconscious!",
      "The imposing elk silently lets out a final agonized sigh and dies.",
      "The imposing elk lets out a final agonized sigh and dies.",
      "The imposing elk collapses to the ground, emits a final silent sigh, and dies.",
      "An imposing elk goes limp as he is rendered unconscious!"
    ],
    decay: [
      "An imposing elk decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An imposing elk charges at you!",
      "An imposing elk tries to impale you with {pronoun} antlers!"
    ],
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
