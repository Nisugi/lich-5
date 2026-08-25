{
  schema_version: 3,
  name: "large thorned shrub",
  noun: "",
  url: "https://gswiki.play.net/large_thorned_shrub",
  picture: "",
  level: 48,
  family: "Shrub",
  type: "Plantlife",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "corporeal undead"
  ],
  bcs: true,
  max_hp: 409,
  speed: nil,
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
        name: "small glistening thorn",
        as: 299
      },
      {
        name: "Twig",
        as: 279
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
    asg: nil,
    immunities: [],
    melee: (149..604),
    ranged: nil,
    bolt: nil,
    udf: 404,
    bar_td: nil,
    cle_td: nil,
    emp_td: (175..184),
    pal_td: nil,
    ran_td: nil,
    sor_td: (182..189),
    wiz_td: nil,
    mje_td: (196..202),
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
    skin: "bleached thorn",
    other: nil
  },
  messaging: {
    description: [
      "Sometime when you are clearing shrubs from your property, think back on how much easier it is than when the shrub decides it should be you that gets cleared."
    ],
    arrival: [],
    flee: [],
    death: [
      "A large thorned shrub collapses to the ground, shakes one last time and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A large thorned shrub snaps a twig towards you!"
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
