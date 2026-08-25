{
  schema_version: 3,
  name: "moor witch",
  noun: "",
  url: "https://gswiki.play.net/moor_witch",
  picture: "",
  level: 34,
  family: "Witch",
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
  max_hp: 240,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Shattered Moors",
      uids: [420001..420037, 420040..420046]
    },
    {
      name: "unmapped",
      uids: [420038..420039]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Dagger",
        as: (211..252)
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
    asg: "2",
    immunities: [],
    melee: (251..301),
    ranged: 197,
    bolt: nil,
    udf: 320,
    bar_td: 135,
    cle_td: nil,
    emp_td: (125..135),
    pal_td: nil,
    ran_td: nil,
    sor_td: (134..147),
    wiz_td: nil,
    mje_td: 135,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Elemental Defense I",
      "Elemental Defense II",
      "Elemental Defense III",
      "Elemental Targeting",
      "Lesser Shroud",
      "Spirit Defense",
      "Spirit Warding II"
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
    other: nil
  },
  messaging: {
    description: [
      "You are not quite sure what to make of the moor witch, as you have never seen anything that looks quite like it. Stopping a moment, you try to commit this creature to memory so that you can tell tales of it to your fellow adventurers back in the safety of the local tavern."
    ],
    arrival: [],
    flee: [],
    death: [
      "A moor witch goes limp as she is rendered unconscious!"
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A moor witch swings {weapon} at you!"
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
