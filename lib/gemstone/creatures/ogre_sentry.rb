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
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: true,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 254,
  speed: 8,
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
    melee: (106..211),
    ranged: (104..146),
    bolt: (104..146),
    udf: (137..231),
    bar_td: nil,
    cle_td: (54..60),
    emp_td: (45..73),
    pal_td: (57..66),
    ran_td: (57..66),
    sor_td: (59..66),
    wiz_td: nil,
    mje_td: 60,
    mne_td: 60,
    mjs_td: (54..63),
    mns_td: (54..63),
    mnm_td: (54..60),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a slatted reinforced wooden shield",
    "a thin-bladed steel handaxe"
  ],
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
    flee: [
      "An ogre sentry runs {direction}."
    ],
    death: [
      "The ogre sentry screams one last time and dies.",
      "The ogre sentry falls to the floor and dies.",
      "The ogre sentry falls to the ground and dies.",
      "The ogre sentry screams silently one last time and dies."
    ],
    decay: [
      "An ogre sentry decays into compost.",
      "Tiny fissures quickly spread over the entire form of an earth elemental.  Within moments, it crumbles into a pile of dirt and rubble.",
      "Tiny fissures quickly spread over the entire form of a greater earth elemental.  Within moments, it crumbles into a pile of dirt and rubble.",
      "A small, green cloud of smelly gas rises from the body of a mongrel kobold as he decays into compost.",
      "A small, green cloud of smelly gas rises from the body of a big ugly kobold as she decays into compost.",
      "A small, green cloud of smelly gas rises from the body of a big ugly kobold as he decays into compost.",
      "A small, green cloud of smelly gas rises from the body of a kobold as he decays into compost.",
      "A mammoth arachnid's legs shrivel up beneath it as it decays into dust."
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
