{
  schema_version: 3,
  name: "baesrukha",
  noun: "",
  url: "https://gswiki.play.net/baesrukha",
  picture: "",
  level: 42,
  family: "Humanoid",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Yegharren Plains",
      uids: [13036401..13036414, 13036501..13036514]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (247..273)
      },
      {
        name: "Bite",
        as: (187..262)
      },
      {
        name: "Roaring ball of fire",
        as: 220
      }
    ],
    bolt_spells: [
      {
        name: "Major Fire (908)",
        as: 220
      }
    ],
    warding_spells: [
      {
        name: "Cold Snap (512)"
      },
      {
        name: "Elemental Blast (409)",
        cs: 212
      }
    ],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (187..303),
    ranged: (187..195),
    bolt: (187..195),
    udf: (251..330),
    bar_td: "140 to 153",
    cle_td: (158..165),
    emp_td: (164..167),
    pal_td: (135..144),
    ran_td: nil,
    sor_td: (162..179),
    wiz_td: nil,
    mje_td: 173,
    mne_td: 188,
    mjs_td: nil,
    mns_td: (161..168),
    mnm_td: (143..152),
    defensive_spells: [
      "Elemental Defense I",
      "Elemental Defense II",
      "Elemental Defense III",
      "Thurfel's Ward",
      "Elemental Bias"
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
    skin: nil,
    other: "Glowing violet essence dust,"
  },
  messaging: {
    description: [
      "Her emaciated form roughly humanoid, the baesrukha glides along the ground, clawing at the air with bloodied talons. Her burning red eyes stare malevolently at any intruder, gazing out from a nearly featureless face above a fanged, lipless mouth. Whitish tendrils of ectoplasm coil and whip around her tattered robes, writhing in the miasma that surrounds the ancient wraithlike creature like hungry snakes."
    ],
    arrival: [],
    flee: [],
    death: [
      "The baesrukha collapses to the ground in a motionless heap, sending a plume of dust up from his unwashed body.",
      "The baesrukha collapses to the ground in a motionless heap, sending a plume of dust up from her unwashed body.",
      "The baesrukha slumps to the ground."
    ],
    decay: [
      "The baesrukha's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A baesrukha hurls {weapon} at you!"
    ],
    bite: [
      "A baesrukha tries to bite you!"
    ],
    claw: [
      "A baesrukha claws at you!"
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
