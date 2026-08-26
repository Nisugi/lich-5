{
  schema_version: 3,
  name: "sheruvian monk",
  noun: "",
  url: "https://gswiki.play.net/sheruvian_monk",
  picture: "",
  level: 41,
  family: "Humanoid",
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
  max_hp: 311,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "The Broken Lands",
      uids: [487020..487025, 487030..487032, 487034..487041, 487043..487043, 487058..487075]
    },
    {
      name: "unmapped",
      uids: [487042..487042]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Jeddart-axe",
        as: 314
      },
      {
        name: "Lunge",
        as: 269
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Healing"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: 340,
    ranged: nil,
    bolt: 260,
    udf: nil,
    bar_td: 143,
    cle_td: nil,
    emp_td: 231,
    pal_td: nil,
    ran_td: nil,
    sor_td: (164..231),
    wiz_td: nil,
    mje_td: 172,
    mne_td: 172,
    mjs_td: nil,
    mns_td: 231,
    mnm_td: 123,
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
    other: "Glowing violet essence dust"
  },
  messaging: {
    description: [
      "It is hard to tell if the Sheruvian monk is human, or some foul spawn of inhuman parents. The head of the warrior-monk has been shaved smooth and is covered in dark, mystic runes tattooed on its scalp. A heavy brow hangs low over its cold, calculating eyes."
    ],
    arrival: [
      "A Sheruvian monk just arrived."
    ],
    flee: [],
    death: [
      "A Sheruvian monk goes limp as it is rendered unconscious!",
      "The Sheruvian monk screams emotionlessly one last time and lies still.",
      "The Sheruvian monk falls to the ground and lies still."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A Sheruvian monk lunges at you!  As you shift to block the blow, the monk reverses {pronoun} swing, coming in low to your left side!",
      "A Sheruvian monk snarls as it launches itself at you!",
      "A Sheruvian monk swings {weapon} at you!"
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
