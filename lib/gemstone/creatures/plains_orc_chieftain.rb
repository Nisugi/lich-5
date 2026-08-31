{
  schema_version: 3,
  name: "plains orc chieftain",
  noun: "",
  url: "https://gswiki.play.net/plains_orc_chieftain",
  picture: "",
  level: 21,
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
  max_hp: 300,
  speed: 8,
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
        name: "Machete",
        as: (171..195)
      },
      {
        name: "Morning star",
        as: (191..195)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Tackle"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "19",
    immunities: [],
    melee: (80..187),
    ranged: (92..130),
    bolt: (92..130),
    udf: (121..164),
    bar_td: 63,
    cle_td: (60..69),
    emp_td: (63..71),
    pal_td: (59..63),
    ran_td: (63..69),
    sor_td: (60..69),
    wiz_td: nil,
    mje_td: 63,
    mne_td: 63,
    mjs_td: (57..69),
    mns_td: (57..69),
    mnm_td: (63..69),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a bone-hilted iron machete",
    "a crude hound's tooth talisman",
    "a crude iron morning star",
    "some rough iron half plate"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a scraggly orc scalp",
    other: "Glimmering blue essence shardGlimmering blue mote of essence"
  },
  messaging: {
    description: [
      "As tall as a giantman and twice as muscular as most, the plains orc chieftain is taller and more agile than her more primitive orcish brothers, and judging by the cleverness in her beady yellow eyes, probably quite a bit more intelligent as well. Leathery brown skin covers her bulging limbs, the same color as the crude armor that protects her massive torso, and a scraggly red beard frames her heavy jowls."
    ],
    arrival: [],
    flee: [
      "A plains orc chieftain barrels {direction}."
    ],
    death: [
      "A plains orc chieftain's chest heaves one last time then she dies.",
      "A plains orc chieftain's chest heaves one last time then he dies.",
      "Awesome shot skewers skull!  The plains orc chieftain blinks once and falls quite dead!",
      "Beautiful shot pierces both lungs, the plains orc chieftain makes a wheezing noise, and drops dead!"
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A plains orc chieftain swings {weapon} at you!"
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
