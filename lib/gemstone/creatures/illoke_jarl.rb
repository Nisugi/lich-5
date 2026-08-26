{
  schema_version: 3,
  name: "illoke jarl",
  noun: "",
  url: "https://gswiki.play.net/illoke_jarl",
  picture: "",
  level: 89,
  family: "Giant",
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
  max_hp: 600,
  speed: nil,
  height: nil,
  size: "",
  areas: [
    {
      name: "Bowels of Thanatoph",
      uids: [4293016..4293057]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Fist",
        as: 392
      },
      {
        name: "Hammer",
        as: (422..435)
      },
      {
        name: "Foot",
        as: 405
      },
      {
        name: "Heavy earthen fists",
        as: 419
      },
      {
        name: "Huge rock",
        as: 434
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Divine Strike (1615)",
        cs: (363..375)
      },
      {
        name: "Heavy black stone hammer",
        cs: 366
      },
      {
        name: "Slate grey stone hammer",
        cs: 338
      },
      {
        name: "Charge",
        cs: 363
      }
    ],
    offensive_spells: [
      {
        name: "Spirit Strike (117)"
      }
    ],
    maneuvers: [
      {
        name: "Mstrike"
      },
      {
        name: "Divine Wrath"
      },
      {
        name: "Feint"
      },
      {
        name: "Ground Slam"
      },
      {
        name: "Charge"
      },
      {
        name: "Ethereal Wave"
      },
      {
        name: "Shield Charge"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (256..268),
    ranged: nil,
    bolt: nil,
    udf: 699,
    bar_td: 336,
    cle_td: (364..373),
    emp_td: (354..363),
    pal_td: (310..319),
    ran_td: nil,
    sor_td: (373..382),
    wiz_td: nil,
    mje_td: 397,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (351..360),
    mnm_td: (280..289),
    defensive_spells: [
      "Divine Shield",
      "Fasthr's Reward",
      "Lesser Shroud",
      "Song of Unravelling (1013)"
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
    other: "radiant crimson essence shard"
  },
  messaging: {
    description: [
      "The hulking frame of the Illoke jarl towers high overhead, ready to obliterate any who would intrude upon his territory. Craggy, deep grey skin sheathes him in a natural armor, with little hindrance to his movements. A pair of piercing black eyes stare out with contempt, barely distinguishable against his dark complexion. In contrast, a shimmering crimson symbol of Illoke is chiseled deep into his forehead, radiating a dull red glow."
    ],
    arrival: [],
    flee: [],
    death: [
      "An Illoke jarl's form goes limp as he falls unconscious.",
      "The Illoke jarl grumbles in pain one last time before lying still.",
      "The Illoke jarl shudders one last time before lying still."
    ],
    decay: [
      "An Illoke jarl cracks and collapses into a pile of craggy dark rock that rapidly disappears without a trace.",
      "The Illoke jarl's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A greater earth elemental pounds at you with illoke jarl heavy earthen fists!",
      "An Illoke jarl pounds at you with {pronoun} fist!",
      "An Illoke jarl stomps at you with {pronoun} foot!",
      "An Illoke jarl swings {weapon} at you!",
      "An Illoke jarl throws {weapon} at you!",
      "An earth elemental pounds at you with illoke jarl heavy earthen fists!"
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
