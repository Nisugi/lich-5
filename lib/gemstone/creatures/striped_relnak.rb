{
  schema_version: 3,
  name: "striped relnak",
  noun: "",
  url: "https://gswiki.play.net/striped_relnak",
  picture: "",
  level: 3,
  family: "Reptilian",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 42,
  speed: nil,
  height: 1,
  size: "small",
  areas: [
    {
      name: "Rambling Meadows",
      uids: [14006021..14006040]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (31..61)
      },
      {
        name: "Charge (attack)",
        as: 71
      },
      {
        name: "Stomp",
        as: 61
      },
      {
        name: "Foot",
        as: 61
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
    asg: "1N",
    immunities: [],
    melee: (31..41),
    ranged: 37,
    bolt: 34,
    udf: 51,
    bar_td: 9,
    cle_td: nil,
    emp_td: (-23..9),
    pal_td: nil,
    ran_td: 9,
    sor_td: 9,
    wiz_td: 9,
    mje_td: 9,
    mne_td: 9,
    mjs_td: 9,
    mns_td: 9,
    mnm_td: nil,
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
    skin: "a striped relnak sail",
    other: nil
  },
  messaging: {
    description: [
      "The striped relnak is a low-slung, wide-bodied reptile of the chameleon family. Only a few feet long, it is deceptively fast despite its girth. Its skin is scaly and rough with alternating strips of red and charcoal grey, except for the flaring, spiny sail that stands erect on its back which is solid grey. Extending from its thick neck to nearly the tip of its flicking tail, the sail's charcoal grey is punctuated by evenly spaced iridescent blue spines which glow brightly when the relnak is agitated."
    ],
    arrival: [
      "A striped relnak scampers in."
    ],
    flee: [
      "The relnak scampers {direction}."
    ],
    death: [
      "The striped relnak hisses one last time and dies.",
      "The striped relnak falls back into a heap and dies."
    ],
    decay: [
      "A striped relnak decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A striped relnak stomps at you with {pronoun} foot!"
    ],
    bite: [
      "A striped relnak tries to bite you!"
    ],
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
