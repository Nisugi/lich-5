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
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 240,
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
    melee: (138..219),
    ranged: (111..174),
    bolt: (111..174),
    udf: 157,
    bar_td: (66..76),
    cle_td: (67..73),
    emp_td: (70..79),
    pal_td: (55..62),
    ran_td: 70,
    sor_td: 74,
    wiz_td: nil,
    mje_td: (78..89),
    mne_td: (78..89),
    mjs_td: (73..81),
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
    flee: [
      "A plains orc shaman traipses {direction}."
    ],
    death: [
      "A plains orc shaman mutters belaboring his fate and then dies.",
      "A plains orc shaman mutters belaboring her fate and then dies.",
      "Beautiful shot pierces both lungs, the plains orc shaman makes a wheezing noise, and drops dead!",
      "Awesome shot skewers skull!  The plains orc shaman blinks once and falls quite dead!"
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
