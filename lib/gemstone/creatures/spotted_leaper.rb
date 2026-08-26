{
  schema_version: 3,
  name: "spotted leaper",
  noun: "",
  url: "https://gswiki.play.net/spotted_leaper",
  picture: "",
  level: 4,
  family: "Leaper",
  type: "Quadruped",
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
  max_hp: 51,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Rambling Meadows",
      uids: [14006021..14006040]
    },
    {
      name: "Noralgar Forest",
      uids: [4286004..4286012]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (68..76)
      },
      {
        name: "Claw",
        as: 76
      },
      {
        name: "Stomp",
        as: 76
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
    asg: "5N",
    immunities: [],
    melee: (9..33),
    ranged: 17,
    bolt: 15,
    udf: (72..74),
    bar_td: 12,
    cle_td: 12,
    emp_td: 12,
    pal_td: (9..12),
    ran_td: 12,
    sor_td: 12,
    wiz_td: 12,
    mje_td: 12,
    mne_td: 12,
    mjs_td: 12,
    mns_td: 12,
    mnm_td: 12,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a spotted leaper pelt",
    other: "No"
  },
  messaging: {
    description: [
      "The spotted leaper appears a bizarre cross between a wolf and a frog. Perhaps six feet from snout to rump, covered with slick, hairless skin that is a dark green color with occasional pink splotches, it lacks all trace of fur but has a set of fangs worthy of any wolf that ever strode the land. Extra long front legs tipped with raking claws give it the bounding gait that has earned it its name."
    ],
    arrival: [],
    flee: [
      "A spotted leaper bounds {direction}."
    ],
    death: [
      "The spotted leaper collapses to the ground, emits a final snarl, and dies.",
      "The spotted leaper twitches and dies.",
      "The spotted leaper collapses to the ground, emits a final silent snarl, and dies.",
      "The spotted leaper growls as it slumps to the ground and licks at its wounded right claw.",
      "The spotted leaper growls as it slumps to the ground and licks at its wounded right foreleg.",
      "The spotted leaper growls as it slumps to the ground and licks at its wounded left foreleg.",
      "The spotted leaper growls as it slumps to the ground and licks at its wounded left claw."
    ],
    decay: [
      "A spotted leaper decays into a pile of hair and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A spotted leaper tries to bite you!"
    ],
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
