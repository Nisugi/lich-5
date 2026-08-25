{
  schema_version: 3,
  name: "ogre warrior",
  noun: "",
  url: "https://gswiki.play.net/ogre_warrior",
  picture: "",
  level: 20,
  family: "Ogre",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 250,
  speed: nil,
  height: 10,
  size: "large",
  areas: [
    {
      name: "Neartofar Forest",
      uids: [14015201..14015212]
    },
    {
      name: "Northern Slopes of Wehntoph",
      uids: [4302020..4302035]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Mace",
        as: (173..201)
      },
      {
        name: "Military pick",
        as: (177..193)
      },
      {
        name: "Broad-bladed steel hatchet",
        as: 169
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Sunder Shield"
      },
      {
        name: "Pounce"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (100..211),
    ranged: (116..121),
    bolt: (116..121),
    udf: 232,
    bar_td: 60,
    cle_td: 60,
    emp_td: (45..64),
    pal_td: 60,
    ran_td: 60,
    sor_td: (57..66),
    wiz_td: nil,
    mje_td: (60..66),
    mne_td: 60,
    mjs_td: nil,
    mns_td: 60,
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
    skin: "an ogre tooth",
    other: "Glimmering blue essence shard"
  },
  messaging: {
    description: [
      "The ogre warrior's bulging muscles and long arms give it an advantage in any encounter it might have. The heavy, rock hard skin serves equally well as armor or to just keep itself dry from the elements. Dark, smoking eyes glare out as it challenges any to oppose it."
    ],
    arrival: [
      "An ogre warrior just arrived."
    ],
    flee: [],
    death: [
      "The ogre warrior falls to the ground and dies.",
      "The ogre warrior screams one last time and dies.",
      "The ogre warrior falls to the floor and dies.",
      "The ogre warrior screams silently one last time and dies.",
      "An ogre warrior goes limp as he is rendered unconscious!"
    ],
    decay: [
      "An ogre warrior decays into compost.",
      "Acid dissolves the knee ligaments.  The ogre warrior's tibia passes his femur in a very unpleasant manner!"
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An ogre warrior swings {weapon} at you!"
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
