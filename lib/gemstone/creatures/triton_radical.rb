{
  schema_version: 3,
  name: "triton radical",
  noun: "",
  url: "https://gswiki.play.net/triton_radical",
  picture: "",
  level: 100,
  family: "Triton",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 205,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Ruined Temple",
      uids: [3031036..3031042, 3031056..3031106]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Scaling fork",
        as: (430..505)
      },
      {
        name: "Trident",
        as: 430
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Censure (316)",
        cs: 415
      },
      {
        name: "Divine Strike (1615)",
        cs: 424
      },
      {
        name: "Divine Wrath (335)",
        cs: 403
      },
      {
        name: "Frenzy (216)",
        cs: 409
      },
      {
        name: "Judgment (1630)",
        cs: 409
      },
      {
        name: "Point",
        cs: 421
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
        name: "Bull Rush"
      },
      {
        name: "Charge"
      },
      {
        name: "Shield Charge"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12",
    immunities: [],
    melee: (308..567),
    ranged: nil,
    bolt: (275..326),
    udf: 649,
    bar_td: 375,
    cle_td: nil,
    emp_td: (369..372),
    pal_td: 345,
    ran_td: nil,
    sor_td: (416..420),
    wiz_td: nil,
    mje_td: (428..453),
    mne_td: (414..438),
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Divine Shield",
      "Fasthr's Reward",
      "Lesser Shroud",
      "Mantle of Faith",
      "Warding Sphere"
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
    skin: "an elongated triton spine",
    other: nil
  },
  messaging: {
    description: [
      "Glaring angrily and gnashing his sharp yellowed teeth, the triton radical stalks along muttering to himself as if involved in angry debate with a phantasmal antagonist. Pale, red-rimmed eyes sit deep in a heavy-boned skull, which perches upon a long, slender neck. The radical's body pitches forward alarmingly, so only the weight of his tail prevents a return to a four-legged posture. Upon his tapered brow is set a golden crown bearing a large, wave-etched crystal drop."
    ],
    arrival: [
      "A triton radical strides in, a wary look on her face.",
      "A triton executioner stalks in silently, his cold eyes gleaming with hatred.",
      "A triton radical strides in, a wary look on his face.",
      "A triton executioner strides in, a wary look on her face.",
      "A triton executioner stalks in silently, her cold eyes gleaming with hatred."
    ],
    flee: [],
    death: [
      "The siren gives a plaintive wail before she slumps to her side and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A triton radical thrusts with a corroded bronze scaling fork at you!",
      "A triton radical thrusts with a wide silvery green trident at you!"
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
