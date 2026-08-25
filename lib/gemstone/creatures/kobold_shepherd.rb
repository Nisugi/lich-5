{
  schema_version: 3,
  name: "kobold shepherd",
  noun: "",
  url: "https://gswiki.play.net/kobold_shepherd",
  picture: "",
  level: 3,
  family: "Kobold",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 51,
  speed: nil,
  height: 3,
  size: "small",
  areas: [
    {
      name: "Graendlor Pasture",
      uids: [4301001..4301019]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Quarterstaff",
        as: 50
      }
    ],
    bolt_spells: [
      {
        name: "Minor Shock (901)",
        as: 30
      },
      {
        name: "Minor Water (903)",
        as: 30
      }
    ],
    warding_spells: [
      {
        name: "Mana Disruption (702)",
        cs: 35
      }
    ],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "2",
    immunities: [],
    melee: (36..68),
    ranged: (30..46),
    bolt: (30..46),
    udf: 76,
    bar_td: nil,
    cle_td: nil,
    emp_td: (4..14),
    pal_td: nil,
    ran_td: nil,
    sor_td: (5..12),
    wiz_td: nil,
    mje_td: 8,
    mne_td: 3,
    mjs_td: 14,
    mns_td: 14,
    mnm_td: nil,
    defensive_spells: [
      "Elemental Defense I (401)",
      "Elemental Defense II (406)",
      "Spirit Defense (103)",
      "Spirit Warding I (101)",
      "Spirit Warding II (107)"
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
    skin: "a kobold ear",
    other: nil
  },
  messaging: {
    description: [
      "The kobold shepherd is very similar to its kobold brethren. Smaller than a dwarf and even many halflings, it has ruddy skin and a hairless pate topped with small horns. The kobold shepherd does, however, have better habits of cleanliness and a better sense of responsibility. It spends long hours herding the roltons that provide sustenance for it and its family. When its herds are threatened, the kobold shepherd fights valiantly in their defense."
    ],
    arrival: [
      "A kobold shepherd just arrived."
    ],
    flee: [],
    death: [
      "The kobold shepherd howls in agony one last time and dies."
    ],
    decay: [
      "With one last twitch, the kobold shepherd decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A kobold shepherd claps {pronoun} hands together in front of you!"
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
