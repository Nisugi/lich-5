{
  schema_version: 3,
  name: "dark frosty plant",
  noun: "",
  url: "https://gswiki.play.net/dark_frosty_plant",
  picture: "",
  level: 45,
  family: "Plant",
  type: "Plantlife",
  undead: true,
  blood: false,
  bones: nil,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "corporeal undead"
  ],
  bcs: true,
  max_hp: 400,
  speed: "fast (3 - 6 RT)",
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Abandoned Farm",
      uids: [4124050..4124062]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "ranged: frosty seed",
        as: 260
      },
      {
        name: "Frost-covered crystalline flower",
        as: (138..260)
      },
      {
        name: "melee: stab",
        as: 260
      },
      {
        name: "Stinger",
        as: 242
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Point"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (95..259),
    ranged: nil,
    bolt: nil,
    udf: 375,
    bar_td: nil,
    cle_td: nil,
    emp_td: (180..186),
    pal_td: nil,
    ran_td: nil,
    sor_td: (186..195),
    wiz_td: nil,
    mje_td: 201,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "frosted branch",
    other: nil
  },
  messaging: {
    description: [
      "Though this plant with its droopy leafs and sickly flowers is a bit on the far gone side, it might still benefit from being re-potted. Preferably six feet under!"
    ],
    arrival: [
      "A dark frosty plant stalks in and plants its roots."
    ],
    flee: [
      "A dark frosty plant stalks {direction}."
    ],
    death: [
      "A dark frosty plant collapses to the ground, twitches one last time and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A dark frosty plant flings a frost-covered crystalline flower towards you!",
      "A dark frosty plant rotates until it points a large flower at you!",
      "A dark frosty plant stabs at you with {pronoun} stinger!",
      "A dark frosty plant turns one of {pronoun} massive flowers towards you and spits a seed in your direction!"
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
