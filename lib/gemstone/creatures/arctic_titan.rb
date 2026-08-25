{
  schema_version: 3,
  name: "arctic titan",
  noun: "",
  url: "https://gswiki.play.net/arctic_titan",
  picture: "",
  level: 36,
  family: "Giant",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: true,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Elemental family"
  ],
  bcs: true,
  max_hp: 397,
  speed: nil,
  height: 18,
  size: "huge",
  areas: [
    {
      name: "Glatoph",
      uids: [2153002..2153031]
    },
    {
      name: "Icemule Trail",
      uids: [4044134..4044139]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Handaxe",
        as: 262
      },
      {
        name: "Closed fist",
        as: 242
      },
      {
        name: "Stomp (attack)",
        as: 232
      }
    ],
    bolt_spells: [
      {
        name: "Major Shock (910)",
        as: 185
      }
    ],
    warding_spells: [
      {
        name: "Weapon Fire (915)",
        cs: 184
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Stomp"
      },
      {
        name: "Ground Slam"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "10",
    immunities: [],
    melee: 177,
    ranged: 195,
    bolt: 165,
    udf: nil,
    bar_td: nil,
    cle_td: 110,
    emp_td: 111,
    pal_td: nil,
    ran_td: nil,
    sor_td: 117,
    wiz_td: nil,
    mje_td: 124,
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "an arctic titan toe",
    other: "Yes"
  },
  messaging: {
    description: [
      "Commanding the elements of cold and ice, the arctic titan pounds through the snowy countryside, looking to destroy those that would invade its domain. The arctic titan stands tall amidst the howling winds and pounding sleet, its muscular torso and thick legs carrying it effortlessly through the elements to unleash savage attacks against its enemies. Its deep blue skin coloration is not a result of exposure to the icy wind but rather from the blue lichen that supplements its diet of meat."
    ],
    arrival: [
      "An arctic titan lumbers into view."
    ],
    flee: [],
    death: [
      "An arctic titan goes limp as it is rendered unconscious!",
      "The arctic titan screams evilly one last time and goes still.",
      "The arctic titan falls to the ground motionless."
    ],
    decay: [
      "An arctic titan turns to dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An arctic titan gestures at you!",
      "An arctic titan swings {weapon} at you!"
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
