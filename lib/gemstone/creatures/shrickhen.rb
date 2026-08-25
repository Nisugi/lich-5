{
  schema_version: 3,
  name: "shrickhen",
  noun: "",
  url: "https://gswiki.play.net/shrickhen",
  picture: "",
  level: 76,
  family: "Chimeric",
  type: "Hybrid",
  undead: true,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead",
    "Magical"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Maaghara Tower",
      uids: [13022008..13022049]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 393
      },
      {
        name: "Claw",
        as: 403
      },
      {
        name: "Severed shrickhen arm",
        as: 50
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Elemental Dispel (417)"
      },
      {
        name: "Elemental Wave (410)"
      },
      {
        name: "Major Elemental Wave (435)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (327..450),
    ranged: 265,
    bolt: 285,
    udf: 648,
    bar_td: (281..285),
    cle_td: (295..320),
    emp_td: (296..303),
    pal_td: 260,
    ran_td: nil,
    sor_td: (306..338),
    wiz_td: nil,
    mje_td: 344,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (290..315),
    mnm_td: nil,
    defensive_spells: [
      "Elemental Defense II",
      "Elemental Defense III",
      "Elemental Targetting"
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
    skin: "No",
    other: nil
  },
  messaging: {
    description: [
      "Seemingly cobbled together from leftover bodily parts, no two shrickhen are alike. One may have the lower body of a troll supporting the torso of a fire salamander from which a dark orc's arm extends on one side and a gremlin's arm extends on the other, all topped by a timberwolf's head. A second may have a mezic's leg, a coyote's leg, a pyrothag's arm, and a shan warrior's arm, each connected in almost the right place to the torso of a krolvin warfarer, with the entire grouping utilizing the one-eyed head of a cyclops for navigation. These hideous conglomerations definitely have two things in common: a total lack of fear and an insatiable need to consume flesh."
    ],
    arrival: [
      "A dhu goleras arrives with a loping, uneven gait, her body rocking side-to-side and her head and arms flopping wildly.",
      "A resolute dhu goleras arrives with a loping, uneven gait, her body rocking side-to-side and her head and arms flopping wildly.",
      "A dhu goleras arrives with a loping, uneven gait, his body rocking side-to-side and his head and arms flopping wildly."
    ],
    flee: [],
    death: [],
    decay: [
      "Acid dissolves the knee ligaments.  The shrickhen's tibia passes his femur in a very unpleasant manner!"
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A moulis bud rolls into a ball and flings shrickhen at you!",
      "A moulis scraping rolls into a ball and flings shrickhen at you!",
      "A moulis sprout rolls into a ball and flings shrickhen at you!",
      "A moulis stalk rolls into a ball and flings shrickhen at you!",
      "A shrickhen throws {weapon} at you!"
    ],
    bite: [
      "A shrickhen tries to bite you!"
    ],
    claw: [
      "A shrickhen claws at you!"
    ],
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
