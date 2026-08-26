{
  schema_version: 3,
  name: "writhing icy bush",
  noun: "",
  url: "https://gswiki.play.net/writhing_icy_bush",
  picture: "",
  level: 36,
  family: "Bush",
  type: "Plantlife",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 371,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Abandoned Farm",
      uids: [4124037..4124049]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "small glistening thorn",
        as: 260
      },
      {
        name: "Stinger (attack)",
        as: 220
      },
      {
        name: "Thorn",
        as: 230
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "thorn fling"
      },
      {
        name: "Lash"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (120..284),
    ranged: nil,
    bolt: nil,
    udf: 215,
    bar_td: nil,
    cle_td: (125..131),
    emp_td: (117..126),
    pal_td: (105..111),
    ran_td: nil,
    sor_td: "117 to 147",
    wiz_td: nil,
    mje_td: 139,
    mne_td: "123 to 153",
    mjs_td: nil,
    mns_td: "111 to 141",
    mnm_td: (105..108),
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
    skin: "blood-stained leaf",
    other: nil
  },
  messaging: {
    description: [
      ";Description\nWhen planting a garden or a yard, often one will plant these to prevent unwanted guests and prying eyes. If that was the case for these, they apparently have taken their job a bit too seriously.\n\n;Assess\nThe icy bush is medium in size and about three feet high in its current state."
    ],
    arrival: [
      "A writhing icy bush just arrived!"
    ],
    flee: [],
    death: [
      "A writhing icy bush collapses to the ground, shakes one last time and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A writhing icy bush spits a thorn towards you!"
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
