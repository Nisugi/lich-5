{
  schema_version: 3,
  name: "arachne servant",
  noun: "",
  url: "https://gswiki.play.net/arachne_servant",
  picture: "",
  level: 21,
  family: "Humanoid",
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
  max_hp: 240,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Lower Trollfang",
      uids: [12016..12045]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Morning star",
        as: 190
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
    asg: "5",
    immunities: [],
    melee: (150..282),
    ranged: nil,
    bolt: nil,
    udf: 263,
    bar_td: nil,
    cle_td: (63..67),
    emp_td: (73..81),
    pal_td: (66..76),
    ran_td: 63,
    sor_td: (63..76),
    wiz_td: nil,
    mje_td: (60..68),
    mne_td: (60..68),
    mjs_td: nil,
    mns_td: (73..79),
    mnm_td: (60..68),
    defensive_spells: [
      "Spirit Warding I (101)",
      "Spirit Defense (103)",
      "Spirit Warding II (107)",
      "Spirit Shield (202)",
      "Spell Shield (219)"
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
    other: "glimmering blue essence shard"
  },
  messaging: {
    description: [
      "Dressed in a cassock and veil, the Arachne servant looks thin and malnourished. Staring from behind the veil are a pair of eyes that reflect both terror and determination. Bound to the service of Arachne, the Arachne servants are totally dedicated to their master, performing whatever duty is required."
    ],
    arrival: [
      "An Arachne servant just arrived."
    ],
    flee: [],
    death: [
      "The Arachne servant exhales a final curse and dies.",
      "The Arachne servant slumps to the ground and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "An Arachne servant swings {weapon} at you!"
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
