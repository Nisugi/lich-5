{
  schema_version: 3,
  name: "patchwork flesh monstrosity",
  noun: "",
  url: "https://gswiki.play.net/patchwork_flesh_monstrosity",
  picture: "",
  level: 98,
  family: "Chimeric",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: false,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 550,
  speed: 6,
  height: 15,
  size: "huge",
  areas: [
    {
      name: "Shadow of the Sanctum",
      uids: [4216001..4216049]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Ensnare (attack)Ensnare",
        as: 450
      },
      {
        name: "Stomp (attack)Stomp"
      },
      {
        name: "Bloated arms",
        as: (438..480)
      },
      {
        name: "Bronze cutlass",
        as: 543
      },
      {
        name: "Heel of his hand",
        as: 418
      },
      {
        name: "Kick",
        as: 390
      },
      {
        name: "Heel of her hand",
        as: 427
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Tackle"
      },
      {
        name: "Twin Hammerfists"
      },
      {
        name: "Charge"
      },
      {
        name: "Disarm"
      },
      {
        name: "Stomp"
      }
    ],
    special_abilities: [
      {
        name: "Tremors"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "5",
    immunities: [],
    melee: (81..562),
    ranged: (92..372),
    bolt: (92..372),
    udf: (291..646),
    bar_td: nil,
    cle_td: (409..418),
    emp_td: (401..407),
    pal_td: (353..362),
    ran_td: (347..361),
    sor_td: (421..430),
    wiz_td: nil,
    mje_td: (444..448),
    mne_td: (444..448),
    mjs_td: 453,
    mns_td: 453,
    mnm_td: (300..309),
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "A patchwork flesh monstrosity is near as tall as a giant and twice as broad, a lumbering monstrosity cobbled together from spare parts in tactless parody of a human form. Red-tinged serum leaks constantly from the straining stitches that maintain the monster's integrity. Only the barest glimmer of intelligence lurks in the monstrosity's eyes, and that, perhaps, is a blessing: anything with even half of a brain would be horrified to be such an abominable figure. From the looks of it, the monstrosity's has barely a quarter of one."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [
      "Decay rapidly races over a shambling lurk's form as it collapses into foul-smelling compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A patchwork flesh monstrosity raises a hamhock-sized fist overhead and brings it swiftly down at you!",
      "A patchwork flesh monstrosity tries to ensnare you with {pronoun} bloated arms!",
      "Raising one immense foot, a patchwork flesh monstrosity tries to stomp on you!",
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
