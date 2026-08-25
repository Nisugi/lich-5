{
  schema_version: 3,
  name: "steam dervish",
  noun: "",
  url: "https://gswiki.play.net/steam_dervish",
  picture: "",
  level: 84,
  family: "Humanoid",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Element-based",
    "Magical"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "McKyren's End",
      uids: [3063001..3063013]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Longsword",
        as: (402..452)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Hamstring"
      },
      {
        name: "Steam Blast"
      }
    ],
    special_abilities: [
      {
        name: "Steam blast"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "16",
    immunities: [],
    melee: (308..487),
    ranged: nil,
    bolt: 290,
    udf: 561,
    bar_td: "325 to 349",
    cle_td: nil,
    emp_td: (318..321),
    pal_td: nil,
    ran_td: nil,
    sor_td: (329..343),
    wiz_td: nil,
    mje_td: 367,
    mne_td: 370,
    mjs_td: nil,
    mns_td: 322,
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
    other: "Essence of water"
  },
  messaging: {
    description: [
      "This wiry humanoid resembles a gaunt human with badly blistered and burnt skin. In the place of eyes, two steaming holes glower with malevolent intent. A persistent cloud of steam emanates from the steam dervish, extending an aura of oppressive humidity around her."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A steam dervish swings {weapon} at you!"
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
