{
  schema_version: 3,
  name: "triton fanatic",
  noun: "",
  url: "https://gswiki.play.net/triton_fanatic",
  picture: "",
  level: 100,
  family: "Triton",
  type: "Biped",
  undead: false,
  blood: nil,
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
  size: "medium",
  areas: [
    {
      name: "Atoll",
      uids: [7138201..7138218]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Hammer of Kai",
        as: (423..539)
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Pious Trial (1602)",
        cs: (430..442)
      },
      {
        name: "Repentance (1615)",
        cs: (430..442)
      },
      {
        name: "Point",
        cs: 454
      }
    ],
    offensive_spells: [
      {
        name: "Arm of the Arkati (1605)"
      },
      {
        name: "Zealot (1617)"
      },
      {
        name: "Fervor (1618)"
      },
      {
        name: "Spirit Strike (117)"
      }
    ],
    maneuvers: [
      {
        name: "Feint"
      },
      {
        name: "Lash"
      },
      {
        name: "Charge"
      }
    ],
    special_abilities: [
      {
        name: "Cyclone"
      },
      {
        name: "Mstrike"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "17N",
    immunities: [],
    melee: (246..282),
    ranged: nil,
    bolt: nil,
    udf: 455,
    bar_td: nil,
    cle_td: nil,
    emp_td: (418..423),
    pal_td: nil,
    ran_td: nil,
    sor_td: "422 to 455",
    wiz_td: nil,
    mje_td: 451,
    mne_td: "433 to 468",
    mjs_td: nil,
    mns_td: (423..433),
    mnm_td: (408..417),
    defensive_spells: [
      "Mantle of Faith (1601)",
      "Higher Vision (1610)",
      "Patron's Blessing (1611)",
      "Faith Shield (1619)"
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
    skin: "thick triton spine",
    other: nil
  },
  messaging: {
    description: [
      "A triton fanatic visibly twitches as he clutches a contorted driftwood fetish within his sigil-gouged fingers, his crazed bloodshot eyes darting to and fro beneath a shredded miter of dark oilskin. The last vestiges of a hair-sewn tunic barely cling to his emaciated form, stained in rust-colored splotches from collar to knee, and lashed together with knots of thick sinew. Branded across his forehead is the image of a broken trident, the forks splayed between his brows."
    ],
    arrival: [
      "A triton assassin stalks in silently, her cold eyes gleaming with hatred.",
      "A triton fanatic just arrived."
    ],
    flee: [],
    death: [
      "A triton fanatic goes limp as she is rendered unconscious!",
      "The triton fanatic gurgles once and goes still, a wrathful look on her face.",
      "The triton fanatic gurgles once and goes still, a wrathful look on his face."
    ],
    decay: [
      "The triton fanatic's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A triton fanatic swings {weapon} at you!"
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
