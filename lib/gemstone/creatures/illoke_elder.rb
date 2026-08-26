{
  schema_version: 3,
  name: "illoke elder",
  noun: "",
  url: "https://gswiki.play.net/illoke_elder",
  picture: "",
  level: 86,
  family: "Giant",
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
  max_hp: 610,
  speed: nil,
  height: 21,
  size: "huge",
  areas: [
    {
      name: "Bowels of Thanatoph",
      uids: [4293015..4293057]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Stomp (attack)"
      },
      {
        name: "Sledgehammer"
      },
      {
        name: "Stalagmite"
      },
      {
        name: "Rock (hurled)"
      },
      {
        name: "Enormous stalagmite",
        as: 419
      },
      {
        name: "Fist",
        as: 389
      },
      {
        name: "Foot",
        as: 292
      },
      {
        name: "Giant granite sledgehammer",
        as: 417
      },
      {
        name: "Heavy earthen fists",
        as: 431
      },
      {
        name: "Heavy stone hammer",
        as: 409
      },
      {
        name: "Large rock",
        as: 429
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Stone Fist (514)"
      }
    ],
    offensive_spells: [
      {
        name: "Major Elemental Wave (435)"
      },
      {
        name: "Elemental Disjunction (530)"
      },
      {
        name: "Sandstorm (914)"
      }
    ],
    maneuvers: [
      {
        name: "Divine Wrath"
      },
      {
        name: "Ethereal Wave"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (259..504),
    ranged: "+285-309",
    bolt: "+202",
    udf: 759,
    bar_td: nil,
    cle_td: (361..366),
    emp_td: 360,
    pal_td: (311..319),
    ran_td: nil,
    sor_td: 393,
    wiz_td: nil,
    mje_td: 425,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (355..365),
    mnm_td: 307,
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "radiant crimson essence shard"
  },
  messaging: {
    description: [
      "The enormous form of the Illoke elder occupies a large section of the area, over twenty feet at his full height. He carries himself with an air of confident superiority, casting a hate-filled gaze around him. Thick and rough grey skin covers him from head to toe, providing protection against all but the strongest of blows. A deep crimson symbol of Illoke is chiseled into his forehead, bathing his face in a lurid illumination."
    ],
    arrival: [
      "The boulder comes to a sudden stop and rises into the form of a greater krynch!"
    ],
    flee: [],
    death: [
      "The Illoke elder grumbles in pain one last time before lying still."
    ],
    decay: [
      "An Illoke elder's body shudders and crumbles into itself in a mass of rough grey stone.",
      "The Illoke elder's right leg crumbles briefly and explodes in a shower of gore.",
      "A dazzling Illoke elder's body shudders and crumbles into itself in a mass of rough grey stone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A greater earth elemental pounds at you with illoke elder heavy earthen fists!",
      "An Illoke elder pounds at you with {pronoun} fist!",
      "An Illoke elder stomps at you with {pronoun} foot!",
      "An Illoke elder swings {weapon} at you!",
      "An Illoke elder throws {weapon} at you!",
      "An earth elemental pounds at you with illoke elder heavy earthen fists!"
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
