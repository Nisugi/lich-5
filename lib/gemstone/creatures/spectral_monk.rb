{
  schema_version: 3,
  name: "spectral monk",
  noun: "",
  url: "https://gswiki.play.net/spectral_monk",
  picture: "",
  level: 25,
  family: "Humanoid",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: false,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: nil,
  max_hp: 264,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Lysierian Hills",
      uids: [95156..95179]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Quarterstaff",
        as: 227
      },
      {
        name: "Scythe",
        as: 227
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Silence (210)",
        cs: 136
      },
      {
        name: "Frenzy (216)",
        cs: 136
      },
      {
        name: "Blind (311)",
        cs: 142
      },
      {
        name: "Mind Jolt (706)",
        cs: 146
      }
    ],
    offensive_spells: [
      {
        name: "Bravery (211)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8",
    immunities: [],
    melee: (98..219),
    ranged: (98..131),
    bolt: (98..131),
    udf: (144..239),
    bar_td: nil,
    cle_td: (76..101),
    emp_td: (90..100),
    pal_td: (74..84),
    ran_td: (74..84),
    sor_td: (100..109),
    wiz_td: nil,
    mje_td: (98..103),
    mne_td: (98..103),
    mjs_td: (96..106),
    mns_td: (96..106),
    mnm_td: (75..80),
    defensive_spells: [
      "Spirit Warding I (101)",
      "Spirit Shield (202)",
      "Prismatic Guard (905)",
      "Prayer of Protection (303)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a black skull-cap",
    "a long blackened scythe",
    "a rusty claidhmore",
    "some black coiled prayer beads",
    "some burnished black leathers"
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
      "A tattered black cowl obscures the spectral monk's face. Given the burning green eyes and foul stench he exudes, perhaps that is for the best. Tattered rags cloak his shimmering pellucid form. Its ghostly body flickers in and out of existance, as if only his desire to destroy keeps him bound to this plane."
    ],
    arrival: [],
    flee: [],
    death: [
      "A spectral monk fades into oblivion.",
      "The spectral monk goes still for a moment while its head reshapes."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
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
