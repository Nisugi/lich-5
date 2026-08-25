{
  schema_version: 3,
  name: "plains orc warrior",
  noun: "",
  url: "https://gswiki.play.net/plains_orc_warrior",
  picture: "",
  level: 16,
  family: "Orc",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 190,
  speed: nil,
  height: 7,
  size: "medium",
  areas: [
    {
      name: "Yegharren Plains",
      uids: [13034201..13034221, 13034301..13034338, 13034401..13034416]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Morning star",
        as: (176..180)
      },
      {
        name: "Handaxe",
        as: (140..180)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Tackle"
      },
      {
        name: "Pounce"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16",
    immunities: [],
    melee: (88..185),
    ranged: nil,
    bolt: nil,
    udf: 167,
    bar_td: 48,
    cle_td: nil,
    emp_td: (48..56),
    pal_td: nil,
    ran_td: nil,
    sor_td: (48..54),
    wiz_td: nil,
    mje_td: (45..48),
    mne_td: 48,
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a scraggly orc scalp",
    other: nil
  },
  messaging: {
    description: [
      "As tall as a giantman and twice as muscular as most, the plains orc warrior is taller and more agile than his more primitive orcish brothers, and judging by the cleverness in his beady yellow eyes, probably quite a bit more intelligent as well. Leathery brown skin covers his bulging limbs, the same color as the crude armor that protects his massive torso, and a scraggly red beard frames his heavy jowls."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [
      "The plains orc warrior's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A plains orc warrior swings {weapon} at you!"
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
