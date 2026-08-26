{
  schema_version: 3,
  name: "shadow steed",
  noun: "",
  url: "https://gswiki.play.net/shadow_steed",
  picture: "",
  level: 38,
  family: "Equine",
  type: "Quadruped",
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
  max_hp: 400,
  speed: nil,
  height: 6,
  size: "large",
  areas: [
    {
      name: "Shadow Valley",
      uids: [389030..389035, 2160001..2160035, 2161001..2161022]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge",
        as: 254
      },
      {
        name: "Foot",
        as: 228
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
    asg: nil,
    immunities: [],
    melee: (140..293),
    ranged: (148..211),
    bolt: (148..211),
    udf: 290,
    bar_td: nil,
    cle_td: (127..137),
    emp_td: (131..141),
    pal_td: nil,
    ran_td: nil,
    sor_td: (144..151),
    wiz_td: nil,
    mje_td: (154..157),
    mne_td: nil,
    mjs_td: nil,
    mns_td: (132..140),
    mnm_td: (115..125),
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
    gems: true,
    boxes: nil,
    skin: "a silvery tail",
    other: "Glowing violet essence dust"
  },
  messaging: {
    description: [
      "As magnificent as any living horse, this shadow steed stares beyond you with glowing red eyes. Its matte black coat provides a sharp contrast to its shining silvery tail and mane. The shadow steed paws the ground restlessly with its front hooves as it swishes its tail, flickering into and out of the shadows."
    ],
    arrival: [],
    flee: [],
    death: [
      "The shadow steed goes still for a moment while its head reshapes.",
      "A shadow steed fades into oblivion."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A shadow steed charges at you!",
      "A shadow steed stomps at you with {pronoun} foot!"
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
