{
  schema_version: 3,
  name: "kobold",
  noun: "",
  url: "https://gswiki.play.net/kobold",
  picture: "",
  level: 1,
  family: "Kobold",
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
  max_hp: 40,
  speed: nil,
  height: 3,
  size: "small",
  areas: [
    {
      name: "Briar Thicket",
      uids: [14013001..14013018]
    },
    {
      name: "Lower Dragonsclaw",
      uids: [9028..9041, 372005..372014, 372020..372026, 373005..373016, 373020..373021]
    },
    {
      name: "Old Mine Road",
      uids: [20002..20018, 401002..401009, 401011..401015, 401101..401102, 401201..401207, 401209..401209]
    },
    {
      name: "unmapped",
      uids: [401010..401010, 401208..401208]
    },
    {
      name: "Southern Snowfields",
      uids: [4128005..4128008, 4128012..4128016]
    },
    {
      name: "Plains of Vornavis",
      uids: [4212101..4212130, 4213101..4213130]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Short sword",
        as: 36
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
    melee: (37..78),
    ranged: nil,
    bolt: nil,
    udf: 77,
    bar_td: 3,
    cle_td: nil,
    emp_td: (-31..3),
    pal_td: 3,
    ran_td: 3,
    sor_td: 3,
    wiz_td: nil,
    mje_td: 3,
    mne_td: 3,
    mjs_td: 3,
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
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "kobold skin",
    other: nil
  },
  messaging: {
    description: [
      "Smaller than a dwarf and even many halflings, she has ruddy skin and a hairless pate topped with small horns. Long-limbed for her size, the kobold eschews any display of brute strength and relies on what agility she pretends to have. The kobold stares back at you with beady little black eyes, sizing you up as a foe.\n\nAppraisal:\nThe kobold is small in size, about three feet high in his current state, appears to be of weak constitution, is in a forward stance, and is in relatively good shape."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
