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
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: true,
  boss: false,
  boss_type: nil,
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
      },
      {
        name: "(quarantine-recovered)",
        as: 16
      },
      {
        name: "Javelin",
        as: 36
      },
      {
        name: "Unknown",
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
    melee: (14..78),
    ranged: (-7..47),
    bolt: (-7..47),
    udf: (24..77),
    bar_td: 3,
    cle_td: 3,
    emp_td: 3,
    pal_td: (0..3),
    ran_td: 3,
    sor_td: 3,
    wiz_td: nil,
    mje_td: 3,
    mne_td: 3,
    mjs_td: (3..12),
    mns_td: (3..12),
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a javelin",
    "a ratty sack",
    "a short sword",
    "a wooden shield",
    "some light leather"
  ],
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
    arrival: [
      "A kobold just arrived."
    ],
    flee: [
      "A kobold heads {direction}."
    ],
    death: [
      "The kobold crumples to a heap on the ground and dies.",
      "The kobold cries out in pain one last time and dies.",
      "The kobold crumples to a heap on the floor and dies.",
      "Beautiful shot pierces both lungs, the kobold makes a wheezing noise, and drops dead!",
      "The kobold slumps to the ground."
    ],
    decay: [
      "A small, green cloud of smelly gas rises from the body of a kobold as she decays into compost.",
      "A small, green cloud of smelly gas rises from the body of a kobold as he decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A kobold swings {weapon} at you!",
      "A kobold thrusts with a javelin at you!"
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
