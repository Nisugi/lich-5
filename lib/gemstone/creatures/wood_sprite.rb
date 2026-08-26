{
  schema_version: 3,
  name: "wood sprite",
  noun: "",
  url: "https://gswiki.play.net/wood_sprite",
  picture: "",
  level: 38,
  family: "Fey",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Magical"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 3,
  size: "tiny",
  areas: [
    {
      name: "Gyldemar Forest",
      uids: [13031001..13031012, 13031025..13031043, 13031055..13031081]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Jeddart-axe",
        as: 214
      },
      {
        name: "Spear",
        as: 230
      },
      {
        name: "Quarterstaff",
        as: 250
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Call Swarm (615)"
      },
      {
        name: "Lullabye (1005)"
      },
      {
        name: "Sounds (607)"
      },
      {
        name: "Tangleweed (610)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "9N",
    immunities: [],
    melee: (238..353),
    ranged: 107,
    bolt: nil,
    udf: 358,
    bar_td: (119..124),
    cle_td: (130..140),
    emp_td: (140..150),
    pal_td: (111..120),
    ran_td: nil,
    sor_td: (140..149),
    wiz_td: nil,
    mje_td: 146,
    mne_td: 157,
    mjs_td: nil,
    mns_td: (131..141),
    mnm_td: (122..127),
    defensive_spells: [
      "Natural Colors (601)",
      "Phoen's Strength (606)",
      "Resist Elements (602)",
      "Self Control (613)",
      "Spirit Defense (103)",
      "Spirit Warding I (101)",
      "Spirit Warding II (107)",
      "Lesser Shroud (120)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a battered helm",
    "a frayed leather helm",
    "a jeddart-axe",
    "a quarter staff",
    "a spear",
    "a torn leather bracers",
    "some tattered bracers"
  ],
  treasure: {
    coins: true,
    magic_items: nil,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Glowing violet essence shardPristine sprite's hair"
  },
  messaging: {
    description: [
      "Appearing more like an animated stick figure than a fleshy humanoid, the slender brown form of the wood sprite stands just under three feet. Her eyes, two sparkling almond-shapes in her wood-like visage, belie a fervent sort of insanity as a frantic, incomprehensible whispering issues from her small mouth."
    ],
    arrival: [
      "Seemingly from nowhere, a wood sprite wanders in!"
    ],
    flee: [
      "A wood sprite glances around and then wanders {direction}!",
      "A wood sprite screams loudly as he stands {direction}!"
    ],
    death: [
      "A wood sprite goes limp as he is rendered unconscious!",
      "The wood sprite's eyes grow dim as his lifeforce fades away.",
      "The wood sprite's eyes grow dim as her lifeforce fades away.",
      "The wood sprite slumps to the ground."
    ],
    decay: [
      "A wood sprite crumbles into a pile of dry splinters.",
      "Acid dissolves connecting cartilage, freeing the wood sprite's ribs to move independently.",
      "Acid dissolves the knee ligaments.  The wood sprite's tibia passes her femur in a very unpleasant manner!",
      "The wood sprite's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A wood sprite swings {weapon} at you!"
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
