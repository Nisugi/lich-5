{
  schema_version: 3,
  name: "lesser faeroth",
  noun: "",
  url: "https://gswiki.play.net/lesser_faeroth",
  picture: "",
  level: 46,
  family: "Faeroth",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 6,
  size: "large",
  areas: [
    {
      name: "Gyldemar Forest",
      uids: [13030041..13030076]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (271..281)
      },
      {
        name: "Claw",
        as: (281..291)
      },
      {
        name: "Pound",
        as: (271..281)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: 472,
    ranged: (205..216),
    bolt: 229,
    udf: (254..421),
    bar_td: (143..153),
    cle_td: (158..167),
    emp_td: (154..160),
    pal_td: (129..138),
    ran_td: 138,
    sor_td: (166..187),
    wiz_td: nil,
    mje_td: nil,
    mne_td: 175,
    mjs_td: (157..166),
    mns_td: (157..166),
    mnm_td: (129..138),
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: nil,
    other: "a mottled faeroth crest"
  },
  messaging: {
    description: [
      "The lesser faeroth looks as though she is a near relative to a monkey. Standing on powerful forelimbs, her body is lifted entirely off the ground. Two atrophied legs with filthy claws dangle loosely below the body and look to be double-jointed. A spark of malevolent intelligence burns in her eyes."
    ],
    arrival: [
      "A lesser faeroth strides in.",
      "A lesser faeroth just arrived!",
      "A stalwart lesser faeroth strides in.",
      "A robust lesser faeroth strides in."
    ],
    flee: [],
    death: [
      "A lesser faeroth goes limp as she is rendered unconscious!",
      "A lesser faeroth goes limp as he is rendered unconscious!",
      "A lesser faeroth emits a shriek as he goes still.",
      "A lesser faeroth emits a shriek as she goes still.",
      "A lesser faeroth releases a shriek as she falls to the ground and goes still.",
      "A lesser faeroth releases a shriek as he falls to the ground and goes still.",
      "A lesser faeroth's face contorts in horror as he goes still.",
      "A robust lesser faeroth releases a shriek as she falls to the ground and goes still.",
      "A stalwart lesser faeroth emits a shriek as she goes still.",
      "A robust lesser faeroth releases a shriek as he falls to the ground and goes still.",
      "A stalwart lesser faeroth releases a shriek as he falls to the ground and goes still.",
      "A lesser faeroth releases a shriek as she falls to the floor and goes still.",
      "A robust lesser faeroth emits a shriek as she goes still.",
      "A stalwart lesser faeroth releases a shriek as she falls to the ground and goes still."
    ],
    decay: [
      "A lesser faeroth decays into a pile of foul-smelling compost.",
      "A robust lesser faeroth decays into a pile of foul-smelling compost.",
      "A stalwart lesser faeroth decays into a pile of foul-smelling compost."
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
