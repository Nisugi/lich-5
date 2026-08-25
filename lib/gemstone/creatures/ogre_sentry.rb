{
  schema_version: 3,
  name: "ogre sentry",
  noun: "",
  url: "https://gswiki.play.net/ogre_sentry",
  picture: "",
  level: nil,
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
  max_hp: 254,
  speed: nil,
  height: 10,
  size: "large",
  areas: [
    {
      name: "Hornwort Cavern",
      uids: [7131001..7131018]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Sunder Shield"
      },
      {
        name: "Thin-bladed steel handaxe",
        as: (193..199)
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (120..211),
    ranged: (106..146),
    bolt: (106..146),
    udf: 231,
    bar_td: nil,
    cle_td: nil,
    emp_td: (45..53),
    pal_td: 63,
    ran_td: nil,
    sor_td: (59..66),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
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
    skin: "Ogre tooth",
    other: nil
  },
  messaging: {
    description: [
      "You are not quite sure what to make of the ogre sentry, as you have never seen anything that looks quite like it. Stopping a moment, you try to commit this creature to memory so that you can tell tales of it to your fellow adventurers back in the safety of the local tavern."
    ],
    arrival: [
      "An ogre sentry just arrived."
    ],
    flee: [],
    death: [
      "The ogre sentry screams one last time and dies.",
      "The ogre sentry falls to the floor and dies.",
      "The ogre sentry falls to the ground and dies.",
      "The ogre sentry screams silently one last time and dies.",
      "An ogre sentry goes limp as he is rendered unconscious!"
    ],
    decay: [
      "An ogre sentry decays into compost.",
      "Acid dissolves the knee ligaments.  The ogre sentry's tibia passes his femur in a very unpleasant manner!"
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An ogre sentry swings {weapon} at you!"
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
