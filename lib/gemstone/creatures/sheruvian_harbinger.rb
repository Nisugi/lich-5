{
  schema_version: 3,
  name: "sheruvian harbinger",
  noun: "",
  url: "https://gswiki.play.net/sheruvian_harbinger",
  picture: "",
  level: 63,
  family: "Humanoid",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Darkstone Castle",
      uids: [388012..388019, 388030..388035]
    },
    {
      name: "The Broken Lands",
      uids: [487019..487041, 487043..487052, 487054..487054, 487056..487075]
    },
    {
      name: "unmapped",
      uids: [487042..487042, 487053..487053, 487055..487055]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Broadsword",
        as: 404
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Bind (214)",
        cs: 284
      },
      {
        name: "Frenzy (216)",
        cs: 284
      },
      {
        name: "Mind Jolt (706)",
        cs: 291
      },
      {
        name: "Silence (210)",
        cs: 284
      },
      {
        name: "Black steel broadsword",
        cs: 284
      }
    ],
    offensive_spells: [
      {
        name: "Heroism (215)"
      },
      {
        name: "Spirit Strike (117)"
      }
    ],
    maneuvers: [
      {
        name: "Pale Arm"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (217..276),
    ranged: nil,
    bolt: nil,
    udf: 439,
    bar_td: 210,
    cle_td: nil,
    emp_td: (219..229),
    pal_td: 196,
    ran_td: nil,
    sor_td: (236..244),
    wiz_td: nil,
    mje_td: (248..254),
    mne_td: nil,
    mjs_td: nil,
    mns_td: 214,
    mnm_td: 206,
    defensive_spells: [
      "Lesser Shroud (120)",
      "Spirit Shield (202)",
      "Spirit Warding I (101)",
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
    skin: "No",
    other: "Glowing violet essence dust"
  },
  messaging: {
    description: [
      "The Sheruvian harbinger is a handsome woman with hypnotic eyes and fair skin. Her demeanor appears emotionless, but you can see some sort of evil fire burning within those dark pupils. A sleek, black breastplate covers most of her torso, and you can see it is made of fine quality. The mere look of the harbinger reminds most people of the tales of the Harbinger of Chaos, spawned forth to do great evil."
    ],
    arrival: [
      "A Sheruvian harbinger just arrived, limping badly.",
      "A Sheruvian harbinger just arrived."
    ],
    flee: [],
    death: [
      "The Sheruvian harbinger collapses on the ground and lies still.",
      "The Sheruvian harbinger releases a horrible wail then lies still."
    ],
    decay: [
      "The Sheruvian harbinger's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A Sheruvian harbinger swings {weapon} at you!"
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
