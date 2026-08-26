{
  schema_version: 3,
  name: "plains orc shaman",
  noun: "",
  url: "https://gswiki.play.net/plains_orc_shaman",
  picture: "",
  level: 18,
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
  max_hp: 210,
  speed: nil,
  height: 7,
  size: "medium",
  areas: [
    {
      name: "Yegharren Plains",
      uids: [13034301..13034338]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Kris",
        as: 164
      },
      {
        name: "Mace",
        as: 164
      }
    ],
    bolt_spells: [
      {
        name: "Minor Acid",
        as: 166
      },
      {
        name: "Major Fire",
        as: 166
      },
      {
        name: "Major Shock",
        as: 166
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Pounce"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "6",
    immunities: [],
    melee: (166..219),
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: (66..76),
    cle_td: (67..73),
    emp_td: (70..79),
    pal_td: (55..62),
    ran_td: nil,
    sor_td: 74,
    wiz_td: nil,
    mje_td: 89,
    mne_td: 78,
    mjs_td: nil,
    mns_td: (73..81),
    mnm_td: (61..71),
    defensive_spells: [
      "Elemental Defense I",
      "Elemental Defense II",
      "Elemental Defense III",
      "Thurfel's Ward",
      "Prismatic Guard",
      "Mass Blur"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a bone-hafted spiked mace",
    "a bone-handled kris",
    "a string of carved bone beads",
    "a tattered leather tunic"
  ],
  treasure: {
    coins: true,
    magic_items: nil,
    gems: true,
    boxes: true,
    skin: "a scraggly orc scalp",
    other: nil
  },
  messaging: {
    description: [
      "The plains orc shaman watches his surroundings diligently through shifting yellow eyes that hint at a cunning and dangerous intelligence. His heavily-muscled limbs bear an almost runelike pattern of ritually inflicted scars, and his tangled red beard is adorned with crude bone and wood beads. The shaman mutters to himself in a series of guttural incantations."
    ],
    arrival: [],
    flee: [],
    death: [
      "A plains orc shaman mutters belaboring his fate and then dies.",
      "A plains orc shaman mutters belaboring her fate and then dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A plains orc shaman closes {pronoun} eyes and gestures at you!"
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
