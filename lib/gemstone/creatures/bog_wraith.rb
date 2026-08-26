{
  schema_version: 3,
  name: "bog wraith",
  noun: "",
  url: "https://gswiki.play.net/bog_wraith",
  picture: "",
  level: 41,
  family: "Wraith",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Miasmal Forest",
      uids: [5003021..5003027, 5003030..5003030, 5003032..5003032, 5003036..5003050]
    },
    {
      name: "unmapped",
      uids: [5003028..5003029, 5003031..5003031, 5003033..5003035]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: 216
      },
      {
        name: "Ensnare",
        as: 239
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Lash"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (190..270),
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: nil,
    cle_td: (160..170),
    emp_td: (166..176),
    pal_td: (140..150),
    ran_td: nil,
    sor_td: (173..183),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (166..176),
    mnm_td: (176..185),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a bruised left eye"
  ],
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
      "A haze of cloaked blackness and violet vapors, the bog wraith floats in the air just above the ground. Its violet eyes illuminate between a soft glow and an angry blazoned appearance. A pair of clawed hands extend from the middle of its being, abnormally tiny in comparison to the rest of its body."
    ],
    arrival: [
      "A bog troll lumbers in, her face set in an angry scowl!",
      "A bog troll lumbers in, his face set in an angry scowl!"
    ],
    flee: [],
    death: [
      "A bog wraith's form dissipates into a purple haze."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A bog wraith tries to ensnare you!"
    ],
    bite: [],
    claw: [
      "A bog wraith claws at you!"
    ],
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
