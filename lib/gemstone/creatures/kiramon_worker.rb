{
  schema_version: 3,
  name: "kiramon worker",
  noun: "",
  url: "https://gswiki.play.net/kiramon_worker",
  picture: "",
  level: 40,
  family: "Kiramon",
  type: "Insect",
  undead: false,
  blood: true,
  bones: false,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 300,
  speed: "8",
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Darkstone Castle",
      uids: [41019..41025, 41027..41029, 41034..41050]
    },
    {
      name: "unmapped",
      uids: [41026..41026]
    },
    {
      name: "Abandoned Mine",
      uids: [3005003..3005012, 3005014..3005022]
    },
    {
      name: "Czeroth Caverns",
      uids: [13007201..13007228]
    },
    {
      name: "Maernstrike Caverns",
      uids: [13037001..13037020]
    },
    {
      name: "The Hive",
      uids: [13041001..13041026]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: 236
      },
      {
        name: "Charge (attack)",
        as: 246
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Disease"
      }
    ],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Lunge"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (249..343),
    ranged: 217,
    bolt: 170,
    udf: 363,
    bar_td: "123 to 135",
    cle_td: 142,
    emp_td: (142..151),
    pal_td: nil,
    ran_td: nil,
    sor_td: "141 to 150",
    wiz_td: nil,
    mje_td: 158,
    mne_td: "154 to 157",
    mjs_td: 142,
    mns_td: 142,
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
    coins: false,
    magic_items: false,
    gems: nil,
    boxes: false,
    skin: "a kiramon mandible",
    other: nil
  },
  messaging: {
    description: [
      "The kiramon worker has a mobile head with huge, bulging, eyes that sparkle in a faceted clustering around a lidless perimeter. Protruding from its massive head is a vicious-looking snout with insectile mandibles, while the back of the cranium is a distended, two-lobed case. Remarkably powerful rear legs jut backward from an extremely hard, resilient exoskeleton that seems to be in constant motion. Though its middle legs have evolved away long ago, the front legs end in strong opposing claws and knobby-jointed fingers. Stunted wings flap uselessly from its long cylindrical body."
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
