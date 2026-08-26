{
  schema_version: 3,
  name: "lesser moor wight",
  noun: "",
  url: "https://gswiki.play.net/lesser_moor_wight",
  picture: "",
  level: 37,
  family: "Wight",
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
    "Boss"
  ],
  bcs: true,
  max_hp: 274,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Miasmal Forest",
      uids: [5003021..5003027, 5003030..5003030, 5003032..5003032, 5003036..5003038, 5004001..5004034]
    },
    {
      name: "unmapped",
      uids: [5003028..5003029, 5003031..5003031, 5003033..5003035, 13035101..13035136, 13035201..13035219]
    },
    {
      name: "Yegharren Plains",
      uids: [13036201..13036217, 13036401..13036414, 13036501..13036514]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Broadsword",
        as: 250
      },
      {
        name: "Blackened twisted steel longsword",
        as: 250
      },
      {
        name: "Slender enruned steel longsword",
        as: 250
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Elemental Wave (410)"
      },
      {
        name: "Gas cloud"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12",
    immunities: [],
    melee: (148..268),
    ranged: 186,
    bolt: 133,
    udf: 339,
    bar_td: (110..115),
    cle_td: (100..119),
    emp_td: (110..120),
    pal_td: (108..118),
    ran_td: nil,
    sor_td: (119..128),
    wiz_td: nil,
    mje_td: (119..134),
    mne_td: 130,
    mjs_td: nil,
    mns_td: 129,
    mnm_td: (108..116),
    defensive_spells: [
      "Thurfel's Ward (503)"
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
    skin: "wight skull",
    other: nil
  },
  messaging: {
    description: [
      "Once beautiful beyond comprehension, the moor wight before you is now as disgusting as it was once charming. The wight has a slender, decaying body hidden by tattered and fading robes. Plainly written across the moor wight's face is an expression of eternal anguish and pain, silently speaking of the horrofic events which unfolded during its life to bring it to this sad state."
    ],
    arrival: [
      "A lesser moor wight arrives on a cold wind.",
      "A bog troll lumbers in, his face set in an angry scowl!"
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A lesser moor wight swings {weapon} at you!"
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
