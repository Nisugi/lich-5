{
  schema_version: 3,
  name: "vvrael warlock",
  noun: "",
  url: "https://gswiki.play.net/vvrael_warlock",
  picture: "",
  level: 84,
  family: "Vvrael",
  type: "Biped",
  undead: false,
  blood: false,
  bones: false,
  witherable: false,
  sympathy: false,
  muggable: nil,
  boss: true,
  otherclass: [
    "Extraplanar",
    "Anti-mana",
    "Boss"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "The Rift",
      uids: [4567001..4567055, 4568001..4568055]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Whip",
        as: 356
      },
      {
        name: "Ball of greenish-black flame",
        as: 466
      },
      {
        name: "Midnight black longsword",
        as: 470
      }
    ],
    bolt_spells: [
      {
        name: "Balefire (713)",
        as: 379
      }
    ],
    warding_spells: [
      {
        name: "Corrupt Essence (703)",
        cs: 360
      },
      {
        name: "Curse (715)",
        cs: 360
      },
      {
        name: "Elemental Blast (409)",
        cs: 364
      },
      {
        name: "Evil Eye (717)",
        cs: 360
      },
      {
        name: "Dark Catalyst (719)",
        cs: 360
      },
      {
        name: "Torment (718)",
        cs: 360
      },
      {
        name: "Midnight black longsword",
        cs: 364
      },
      {
        name: "Midnight black spiked whip",
        cs: 360
      }
    ],
    offensive_spells: [
      {
        name: "Spirit Strike (117)"
      },
      {
        name: "Bravery (211)"
      },
      {
        name: "Elemental Dispel (417)"
      }
    ],
    maneuvers: [
      {
        name: "Gesture"
      },
      {
        name: "Pounce"
      },
      {
        name: "Wing Buffet"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "2",
    immunities: ["magic"],
    melee: (388..657),
    ranged: (312..328),
    bolt: nil,
    udf: 682,
    bar_td: nil,
    cle_td: nil,
    emp_td: nil,
    pal_td: nil,
    ran_td: nil,
    sor_td: nil,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Spirit Warding I (101)",
      "Spirit Warding II (107)",
      "Lesser Shroud (120)",
      "Wall of Force (140)",
      "Elemental Defense II (406)",
      "Elemental Defense III (414)",
      "Elemental Barrier (430)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a midnight black longsword",
    "a midnight black ora choker",
    "a midnight black spiked whip",
    "a midnight black tower shield",
    "some flowing midnight-black robes"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Radiant crimson essence shard"
  },
  messaging: {
    description: [
      "The Vvrael warlock's figure is tall and thin, with stark proportions that call to mind sharp, unforgiving angles. His features are stoic, however the eyes held in that pale, rigidly handsome face are full of fury and malignant intent. The creature seems to move in slow motion, each gesture full of drama and elegance. But the appearance of languid grace is insubstantial. Experience soon dispells this illusion and reveals the true nature of this enemy, whose movements are both lightning quick and deadly."
    ],
    arrival: [
      "The air becomes deathly cold as a Vvrael warlock strides into view!",
      "A Vvrael warlock strides in!"
    ],
    flee: [],
    death: [
      "The Vvrael warlock writhes in black agony and dies."
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the Vvrael warlock's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A Vvrael warlock hurls {weapon} at you!",
      "A Vvrael warlock swings {weapon} at you!"
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
