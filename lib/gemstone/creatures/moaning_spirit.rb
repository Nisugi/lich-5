{
  schema_version: 3,
  name: "moaning spirit",
  noun: "",
  url: "https://gswiki.play.net/moaning_spirit",
  picture: "",
  level: 28,
  family: "Ghost",
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
  bcs: nil,
  max_hp: 225,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Castle Anwyn",
      uids: [4285004..4285008, 4285013..4285013, 4285024..4285025]
    },
    {
      name: "The Graveyard",
      uids: [2150002..2150007]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: 235
      },
      {
        name: "Closed fist",
        as: 245
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Mystic Gesture"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (150..188),
    ranged: (138..148),
    bolt: (138..148),
    udf: (155..165),
    bar_td: nil,
    cle_td: 91,
    emp_td: 93,
    pal_td: nil,
    ran_td: 84,
    sor_td: 97,
    wiz_td: nil,
    mje_td: 100,
    mne_td: nil,
    mjs_td: nil,
    mns_td: 93,
    mnm_td: nil,
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "Intense hatred for those living drives the moaning spirit to traverse the bounds of space to attack its enemies. Crying out in constant pain, it marshals magic, claw and fist against its foes, destroying relentlessly to sate the desires of the forces that bind it, then returning whence it came to await the intrusion of another living creature. Its semi-transparent countenance is passably humanoid, save for the eagle-like claws replacing what would normally be the human's feet."
    ],
    arrival: [
      "A moaning spirit just arrived."
    ],
    flee: [],
    death: [
      "The moaning spirit falls to the ground motionless.",
      "The moaning spirit goes still for a moment while its head reshapes."
    ],
    decay: [
      "A moaning spirit collapses into a puddle of jelly, falling silent at last."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A moaning spirit gestures at you!",
      "A moaning spirit swings {weapon} at you!"
    ],
    bite: [],
    claw: [
      "A moaning spirit claws at you!"
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
