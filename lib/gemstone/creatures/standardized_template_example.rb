{
  # ---------- Identity ----------
  name: "savage fork-tongued wendigo", # REQUIRED: lowercase, exact creature name
  url: "https://gswiki.play.net/Savage_fork-tongued_wendigo",
  picture: nil,

  # ---------- Basic Stats ----------
  level: 105,                             # REQUIRED: integer, nil if unknown
  family: "humanoid",                     # REQUIRED: string, "unknown" if unknown
  type: "biped",                          # REQUIRED: biped/quadruped/avian/etc
  undead: false,                          # REQUIRED: boolean, not string
  otherclass: [],                         # array of strings
  bcs: true,                              # boolean or nil

  # ---------- Physical ----------
  max_hp: 600, # integer or nil (not string)
  speed: nil,                             # integer/string or nil
  height: 8,                              # integer (feet) or nil
  size: "large",                          # small/medium/large/huge or nil

  # ---------- Areas ----------
  areas: ["hinterwilds"], # array of area names (lowercase)

  # ---------- Attack Attributes ----------
  attack_attributes: {
    physical_attacks: [
      {
        name: "attack", # standardized names
        as: 530..630 # Range or integer, nil if unknown
      },
      {
        name: "bite",
        as: 505..605
      }
    ],
    bolt_spells: [
      # { name: "Minor Cold (1709)", cs: 410..420 }
    ],
    warding_spells: [
      {
        name: "frenzy (216)",
        cs: 438..450
      }
    ],
    offensive_spells: [],
    maneuvers: [
      # { name: "shield bash" }
    ],
    special_abilities: [
      {
        name: "enrage",
        note: "+100 AS"
      }
    ]
  },

  # ---------- Defense Attributes ----------
  defense_attributes: {
    asg: "10N",                           # string format like "10N", "15", etc
    immunities: [],                       # ["knockdown", "crit_kill", etc]
    melee: 428,                           # integer or range
    ranged: 404,
    bolt: 404,
    udf: 656,
    # TDs - use consistent naming
    bar_td: 432..434,
    cle_td: nil,
    emp_td: nil,
    pal_td: nil,
    ran_td: 398..403,
    sor_td: 471..483,
    wiz_td: nil,
    mje_td: nil,
    mne_td: 489..495,
    mjs_td: nil,
    mns_td: 444,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },

  # ---------- Treasure ----------
  treasure: {
    coins: true,                          # boolean or nil (not string)
    gems: true,                           # boolean or nil
    boxes: true,                          # boolean or nil
    skin: nil,                            # string name or nil/false
    magic_items: nil,                     # boolean or nil
    other: nil,                           # string or array of strings
    blunt_required: false                 # boolean
  },

  # ---------- Abilities & Alchemy ----------
  abilities: [],                          # future expansion
  alchemy: [],                            # array of alchemy products
  special_other: nil, # free-form notes

  # ---------- Messaging ----------
  messaging: {
    description: "The wendigo looks to have once been humanoid...",

    # Standard creature messages (arrays for variants)
    arrival: [
      "A savage fork-tongued wendigo steps in, eyes like luminous pools searching the surroundings."
    ],
    flee: [
      "Heedless of its grievous wounds, a savage fork-tongued wendigo stalks {direction}."
    ],
    death: "Rage flickers in the wendigo's eyes as it collapses...",
    decay: "Rot sets into a savage fork-tongued wendigo's body...",
    search: [
      "A savage fork-tongued wendigo tilts its head, eyeing the shadows..."
    ],

    # Spell/ability specific messages
    spell_prep: "A savage fork-tongued wendigo rasps out a dissonant, sing-song phrase.",
    frenzy: "A savage fork-tongued wendigo crooks an oddly elongated finger at you!",

    # Attack messages with placeholders
    attack: "With inhuman swiftness, a savage fork-tongued wendigo swings its {weapon} at you!",
    bite: "A savage fork-tongued wendigo's jaw unhinges as it tries to ravage you!",

    # Special ability messages
    enrage: "A savage fork-tongued wendigo's eyes blaze a murderous crimson!",

    # Optional: General combat advice
    general_advice: "Combat tips and strategies for this creature..."
  }
}
