{
  schema_version: 3,
  name: "lesser minotaur",
  noun: "",
  url: "https://gswiki.play.net/lesser_minotaur",
  picture: "",
  level: 74,
  family: "Minotaur",
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
  max_hp: 300,
  speed: nil,
  height: 7,
  size: "medium",
  areas: [
    {
      name: "The Hidden Plateau",
      uids: [2167001..2167031, 2167033..2167040, 2167050..2167067, 2167111..2167122]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Greataxe",
        as: 338
      },
      {
        name: "Waraxe",
        as: (341..376)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Bull Rush"
      },
      {
        name: "Feint"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12",
    immunities: [],
    melee: (311..495),
    ranged: 260,
    bolt: nil,
    udf: 510,
    bar_td: (239..251),
    cle_td: (254..269),
    emp_td: (239..264),
    pal_td: (210..234),
    ran_td: nil,
    sor_td: (261..285),
    wiz_td: nil,
    mje_td: (290..299),
    mne_td: (288..297),
    mjs_td: (249..264),
    mns_td: (249..264),
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a minotaur hide",
    other: "Tiny golden seed"
  },
  messaging: {
    description: [
      "The lesser minotaur is an ugly, brutish looking beast. Taller than most average men, the minotaur has a bull-like appearance while his muscular body is humanoid with thick arms and broad shoulders. The lesser minotaur feet end in hooves that rattle the ground with every step. Despite his barbaric features, a great intelligence is reflected in the depths of his eyes and mannerisms."
    ],
    arrival: [
      "A lesser minotaur stomps in!",
      "A lesser minotaur stomps in, squinting warily."
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A lesser minotaur swings {weapon} at you!"
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
