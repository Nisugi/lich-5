{
  schema_version: 3,
  name: "manticore",
  noun: "",
  url: "https://gswiki.play.net/manticore",
  picture: "",
  level: 9,
  family: "Chimeric",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 91,
  speed: nil,
  height: 3,
  size: "large",
  areas: [
    {
      name: "Old Mine Road",
      uids: [20030..20038]
    },
    {
      name: "Vornavian Coast",
      uids: [4202182..4202199]
    },
    {
      name: "Slope",
      uids: [395002..395015]
    },
    {
      name: "Liath Bheinn and Aillidh Brae",
      uids: [4250004..4250021]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: 112
      },
      {
        name: "Closed fist",
        as: 122
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
    asg: "7N",
    immunities: [],
    melee: (35..40),
    ranged: (27..30),
    bolt: 27,
    udf: 74,
    bar_td: 27,
    cle_td: 27,
    emp_td: (1..27),
    pal_td: nil,
    ran_td: nil,
    sor_td: 27,
    wiz_td: nil,
    mje_td: 27,
    mne_td: 27,
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
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a manticore tail",
    other: nil
  },
  messaging: {
    description: [
      "The first thing that strikes you about the manticore is its noxious smell. At first it appears somewhat like an unkempt lion, but after you wipe away the tears brought to your eyes by its vile stench, you see that its head is more like that of a man, and it has a long segmented tail like that of a scorpion.\n\nThe manticore is large in size and about three feet high."
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
