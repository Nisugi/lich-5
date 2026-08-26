{
  schema_version: 3,
  name: "flesh golem",
  noun: "",
  url: "https://gswiki.play.net/flesh_golem",
  picture: "",
  level: 50,
  family: "golem",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Corporeal undead",
    "Magical",
    "Boss"
  ],
  bcs: true,
  max_hp: 448,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Marsh Keep",
      uids: [376051..376054, 376057..376088]
    },
    {
      name: "unmapped",
      uids: [376055..376056]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound (double attack)",
        as: 300
      },
      {
        name: "Stomp",
        as: 300
      },
      {
        name: "Fist",
        as: (230..304)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Noxious Cloud"
      },
      {
        name: "Twin Hammerfists"
      },
      {
        name: "Ground Slam"
      },
      {
        name: "Miasma"
      },
      {
        name: "Shield Bash"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (106..341),
    ranged: (174..201),
    bolt: (174..201),
    udf: 398,
    bar_td: 169,
    cle_td: (185..194),
    emp_td: 213,
    pal_td: (156..165),
    ran_td: nil,
    sor_td: (194..203),
    wiz_td: nil,
    mje_td: 211,
    mne_td: 183,
    mjs_td: 183,
    mns_td: (183..189),
    mnm_td: (150..159),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a pitted wooden shield covered in rusty black iron spikes"
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
      "Overlapping layers of skin are stitched together in a patchwork pattern over a frame of bone to resemble the form of a man. Dark creases in the flesh offer the only indication of features in the golem's face, while the rest of its body is composed of blubbery mass and the occasional portion of some humanoid race, from kobold to krolvin. Two lengthy, thick arms that end in huge swollen fists distract from the great height of the golem."
    ],
    arrival: [
      "A flesh golem arrives with a trail of rotting skin behind it."
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A flesh golem lifts flesh golem fat fleshy foot and tries to stomp on you!",
      "A flesh golem pounds at you with flesh golem huge swollen right fist!",
      "A flesh golem pounds at you with {pronoun} fist!",
      "A slimy flesh golem lifts flesh golem fat fleshy foot and tries to stomp on you!",
      "A slimy flesh golem pounds at you with flesh golem huge swollen right fist!"
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
