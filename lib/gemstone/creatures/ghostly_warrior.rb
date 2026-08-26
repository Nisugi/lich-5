{
  schema_version: 3,
  name: "ghostly warrior",
  noun: "",
  url: "https://gswiki.play.net/ghostly_warrior",
  picture: "",
  level: 18,
  family: "Ghost",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: nil,
  max_hp: 246,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Wolves' Den",
      uids: [390002..390022, 390025..390048]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Broadsword",
        as: 173
      },
      {
        name: "Morning star",
        as: 168
      },
      {
        name: "Flail",
        as: 153
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
    asg: "various",
    immunities: [],
    melee: (107..152),
    ranged: (90..131),
    bolt: (90..131),
    udf: 170,
    bar_td: nil,
    cle_td: (48..60),
    emp_td: 54,
    pal_td: (51..60),
    ran_td: nil,
    sor_td: (51..54),
    wiz_td: nil,
    mje_td: (48..60),
    mne_td: (48..60),
    mjs_td: nil,
    mns_td: (54..57),
    mnm_td: (48..54),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: "Dispel sanctuaries",
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a broadsword",
    "a flail",
    "a morning star",
    "a reinforced shield",
    "some chain mail",
    "some cuirbouilli leather"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Alchemy (common)"
  },
  messaging: {
    description: [
      "You are not quite sure what to make of the ghostly warrior, as you have never seen anything that looks quite like it. Stopping a moment, you try to commit this creature to memory so that you can tell tales of it to your fellow adventurers back in the safety of the local tavern."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A warrior swings {weapon} at you!"
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
