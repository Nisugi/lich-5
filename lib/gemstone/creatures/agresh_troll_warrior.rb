{
  schema_version: 3,
  name: "agresh troll warrior",
  noun: "",
  url: "https://gswiki.play.net/agresh_troll_warrior",
  picture: "",
  level: 16,
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
  max_hp: 210,
  speed: nil,
  height: 8,
  size: "large",
  areas: [
    {
      name: "Grasslands",
      uids: [14012010..14012022]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "War hammer",
        as: 165
      },
      {
        name: "Fist",
        as: 115
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
    asg: "16",
    immunities: [],
    melee: (51..156),
    ranged: (52..100),
    bolt: (52..100),
    udf: 114,
    bar_td: 55,
    cle_td: 63,
    emp_td: 63,
    pal_td: nil,
    ran_td: nil,
    sor_td: 59,
    wiz_td: 55,
    mje_td: 55,
    mne_td: (55..59),
    mjs_td: 63,
    mns_td: 63,
    mnm_td: 48,
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
      "The troll warrior stands silenty still. Disdain touches its face as it awaits any who would challenge its bulking muscles. Stripes of ash run down its cheeks in illegible runes as bits of its straggly hair blow in front of it. The eyes that stare out from under its low brow are those of a natural born killer awaiting its next victim."
    ],
    arrival: [
      "An Agresh troll warrior just arrived!"
    ],
    flee: [],
    death: [
      "An Agresh troll warrior goes limp as she is rendered unconscious!"
    ],
    decay: [
      "An Agresh troll warrior decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An Agresh troll warrior pounds at you with {pronoun} fist!",
      "An Agresh troll warrior swings {weapon} at you!"
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
