{
  schema_version: 3,
  name: "hunch-backed dogmatist",
  noun: "",
  url: "https://gswiki.play.net/hunch-backed_dogmatist",
  picture: "",
  level: 70,
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
  max_hp: 364,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Temple Wyneb",
      uids: [13300001..13300076, 13300080..13300080]
    },
    {
      name: "unmapped",
      uids: [13300077..13300079]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Kaskara",
        as: 350
      }
    ],
    bolt_spells: [
      {
        name: "Fire Spirit (111)",
        as: 356
      }
    ],
    warding_spells: [
      {
        name: "Mass Interference (217)",
        cs: 320
      },
      {
        name: "Fervent Reproach (312)",
        cs: 320
      },
      {
        name: "Censure (316)",
        cs: 320
      },
      {
        name: "Interdiction",
        cs: 320
      }
    ],
    offensive_spells: [
      {
        name: "Spirit Dispel (119)"
      }
    ],
    maneuvers: [],
    special_abilities: [
      {
        name: "Gaze"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "5N",
    immunities: [],
    melee: (338..378),
    ranged: nil,
    bolt: nil,
    udf: (354..463),
    bar_td: "268 to 277",
    cle_td: "281 to 397",
    emp_td: (283..293),
    pal_td: (247..257),
    ran_td: nil,
    sor_td: "315 to 322",
    wiz_td: "315 to 322",
    mje_td: "315 to 322",
    mne_td: "315 to 322",
    mjs_td: "277 to 293",
    mns_td: "277 to 293",
    mnm_td: (271..280),
    defensive_spells: [
      "Wall of Force (140)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: "Resurrect",
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a silver-edged black silk sack",
    "a tarnished invar kaskara"
  ],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: true,
    skin: nil,
    other: "Farlook vitreous humor"
  },
  messaging: {
    description: [
      "A hunch-backed dogmatist's frail frame has seen many years of toil and abuse. Evidence of such hardship appears in the stooped posture of the dogmatist. A defined hump protrudes from behind the dogmatist's head, easily discerned through layers of clothing and leather armor. The hunch-backed dogmatist's eyes glance frequently from side-to-side, as if constantly waiting for something to appear."
    ],
    arrival: [],
    flee: [],
    death: [
      "A hunch-backed dogmatist goes limp as he is rendered unconscious!",
      "A hunch-backed dogmatist goes limp as she is rendered unconscious!",
      "The hunch-backed dogmatist slumps to the ground."
    ],
    decay: [
      "A hunch-backed dogmatist crumbles in upon herself, her skin flaking away as if it only served as an outer shell.",
      "A hunch-backed dogmatist crumbles in upon himself, his skin flaking away as if it only served as an outer shell."
    ],
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
