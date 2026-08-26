{
  schema_version: 3,
  name: "agresh troll scout",
  noun: "",
  url: "https://gswiki.play.net/agresh_troll_scout",
  picture: "",
  level: 14,
  family: "Troll",
  type: "Biped",
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
  max_hp: 170,
  speed: nil,
  height: 8,
  size: "large",
  areas: [
    {
      name: "Grasslands",
      uids: [14012030..14012042]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "War hammer",
        as: 171
      },
      {
        name: "Ensnare"
      },
      {
        name: "Pound"
      },
      {
        name: "Stomp"
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
    melee: 115,
    ranged: 115,
    bolt: 119,
    udf: 128,
    bar_td: 49,
    cle_td: 57,
    emp_td: 57,
    pal_td: nil,
    ran_td: nil,
    sor_td: 53,
    wiz_td: 49,
    mje_td: 49,
    mne_td: 49,
    mjs_td: nil,
    mns_td: 57,
    mnm_td: (42..49),
    defensive_spells: [
      "Spirit Warding II (107)"
    ],
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
      "The troll scout grimaces as it surveys its surroundings with suspicion. Crudely drawn runic symbols painted with ash cover its face. Tufts of straggly, yellow hair are spread over its otherwise barren body giving it a vaguely lionish appearance. Only occasionally can sparks of true intelligence be seen in its otherwise dull eyes."
    ],
    arrival: [
      "An Agresh troll scout just arrived!",
      "An Agresh troll scout stalks in, glancing warily side to each side!"
    ],
    flee: [
      "An Agresh troll scout runs {direction}."
    ],
    death: [
      "An Agresh troll scout goes limp as he is rendered unconscious!",
      "Intestines rupture from intense heat; an Agresh troll scout dies a slow, painful death."
    ],
    decay: [
      "An Agresh troll scout decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An Agresh troll scout swings {weapon} at you!"
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
