{
  schema_version: 3,
  name: "greater skayl",
  noun: "",
  url: "https://gswiki.play.net/greater_skayl",
  picture: "",
  level: 81,
  family: "Elemental",
  type: "Globoid",
  undead: false,
  blood: nil,
  bones: false,
  witherable: false,
  sympathy: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Magical",
    "Element-based"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "McKyren's End",
      uids: [3063001..3063013]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound",
        as: 392
      },
      {
        name: "Ensnare",
        as: 424
      },
      {
        name: "Fist",
        as: 410
      }
    ],
    bolt_spells: [
      {
        name: "Balefire (713)",
        as: 342
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Earthen Fury (917)"
      }
    ],
    maneuvers: [
      {
        name: "Fire Wave"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (275..411),
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: nil,
    cle_td: nil,
    emp_td: 321,
    pal_td: (280..289),
    ran_td: nil,
    sor_td: (346..358),
    wiz_td: nil,
    mje_td: nil,
    mne_td: 379,
    mjs_td: nil,
    mns_td: (321..327),
    mnm_td: (263..266),
    defensive_spells: [
      "Thurfel's Ward (503)",
      "Elemental Bias (508)",
      "Strength (509)",
      "Mass Blur (911)"
    ],
    defensive_abilities: [],
    special_defenses: [
      "Immune to Unbalance (110)"
    ]
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
    other: "Essence of fire"
  },
  messaging: {
    description: [
      "Flame suddenly hisses and spits from thin air, which shimmers in the resulting smoke like reflective crystal. Then abruptly, the air roils and begins to take on form. In mere heartbeats, it becomes obvious that the transparent bubble of conflagration is a sentient being. The greater skayl opens its gaping maw of fire and bellows a malign growl that is more felt than heard. In the next instant, the greater skayl melts down then reforms a short distance away, leaving a drift of smoke in its wake like a fraying shadow."
    ],
    arrival: [],
    flee: [],
    death: [
      "The greater skayl goes limp and it falls over as the fire slowly fades from its eyes."
    ],
    decay: [
      "Bright orange lava oozes out of the greater skayl before it crumbles into a lifeless pile of glaes."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A greater skayl pounds at you with {pronoun} fist!",
      "A greater skayl releases a wave of fiery red energy at you!",
      "A greater skayl tries to ensnare you!"
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
