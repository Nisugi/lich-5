{
  schema_version: 3,
  name: "arch wight",
  noun: "",
  url: "https://gswiki.play.net/arch_wight",
  picture: "",
  level: 20,
  family: "Wight",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 170,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Castle Anwyn",
      uids: [4285023..4285023, 4285030..4285030, 4285051..4285057, 4285100..4285103]
    },
    {
      name: "Plains of Bone",
      uids: [14011023..14011041]
    },
    {
      name: "The Graveyard",
      uids: [18101..18110, 18200..18209, 2162113..2162122]
    },
    {
      name: "Abbey",
      uids: [4132101..4132118]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Scimitar",
        as: (144..156)
      },
      {
        name: "Claw",
        as: 136
      },
      {
        name: "Twohanded sword",
        as: 150
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Mind Jolt (706)",
        cs: 123
      },
      {
        name: "Empathy (1108)"
      },
      {
        name: "Scimitar",
        cs: 129
      },
      {
        name: "Twohanded sword",
        cs: 117
      }
    ],
    offensive_spells: [
      {
        name: "Earthen Fury (917)"
      },
      {
        name: "Gas cloud"
      }
    ],
    maneuvers: [
      {
        name: "Gesture"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "10",
    immunities: [],
    melee: (62..165),
    ranged: nil,
    bolt: 55,
    udf: 152,
    bar_td: 66,
    cle_td: 60,
    emp_td: (60..68),
    pal_td: 60,
    ran_td: 60,
    sor_td: 60,
    wiz_td: 60,
    mje_td: 60,
    mne_td: 60,
    mjs_td: 60,
    mns_td: 60,
    mnm_td: 60,
    defensive_spells: [
      "Spirit Warding II (107)",
      "Spell Shield (219)"
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "a wight skin",
    other: nil
  },
  messaging: {
    description: [
      "The arch wight moves along ponderously, its gaunt humanoid frame often bent nearly double as it walks through the corridors of the deceased. Massive upper arms contrast with a thin torso and narrow hips. Its liquid golden eyes seem to be filled with tiny red sparks, and the lack of flesh on its face causes the arch wight to sport a horrific toothy grin. Very proficient in the ways of magic, the arch wight feasts upon the flesh of the deceased, but often cooks the living to death before indulging in its grisly meal."
    ],
    arrival: [
      "An arch wight just arrived."
    ],
    flee: [],
    death: [
      "The arch wight falls to the ground motionless.",
      "The arch wight screams evilly one last time and goes still."
    ],
    decay: [
      "An arch wight crumbles to dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An arch wight swings {weapon} at you!"
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
