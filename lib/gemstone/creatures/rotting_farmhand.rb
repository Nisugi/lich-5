{
  schema_version: 3,
  name: "rotting farmhand",
  noun: "",
  url: "https://gswiki.play.net/rotting_farmhand",
  picture: "",
  level: 32,
  family: "Humanoid",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Abandoned Farm",
      uids: [4124114..4124124]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Rusted pitchfork",
        as: 243
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
    asg: "5",
    immunities: [],
    melee: (237..369),
    ranged: nil,
    bolt: 210,
    udf: 246,
    bar_td: 105,
    cle_td: 103,
    emp_td: (105..113),
    pal_td: nil,
    ran_td: nil,
    sor_td: (109..112),
    wiz_td: nil,
    mje_td: 115,
    mne_td: 114,
    mjs_td: nil,
    mns_td: 104,
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
    other: "Glimmering blue essence dust"
  },
  messaging: {
    description: [
      "At one time the rotting farmhand would have chosen to be left alone. Now she seeks the company of the living, if only for the short time it takes for her to kill them. Her clothes hang in tatters, waving gently in the breeze as she stumbles about on decaying legs, her putrid flesh barely adhering to her bones. In life the rotting farmhand raised fields of living things. Now her mission seems to be one of filling fields with dead things."
    ],
    arrival: [
      "A rotting farmhand shambles in!"
    ],
    flee: [],
    death: [
      "The rotting farmhand twitches violently, then dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A rotting farmhand swings {weapon} at you!"
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
