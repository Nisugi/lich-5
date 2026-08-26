{
  schema_version: 3,
  name: "lesser wood sprite",
  noun: "",
  url: "https://gswiki.play.net/lesser_wood_sprite",
  picture: "",
  level: 30,
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
  max_hp: 230,
  speed: nil,
  height: 3,
  size: "tiny",
  areas: [
    {
      name: "Sorcerer's Isle",
      uids: [14202001..14202023]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Estoc",
        as: (190..222)
      },
      {
        name: "Composite bow"
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [
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
    melee: (239..286),
    ranged: nil,
    bolt: nil,
    udf: (196..296),
    bar_td: 55,
    cle_td: nil,
    emp_td: (140..150),
    pal_td: (110..120),
    ran_td: nil,
    sor_td: (74..82),
    wiz_td: nil,
    mje_td: 49,
    mne_td: 109,
    mjs_td: nil,
    mns_td: (85..94),
    mnm_td: (117..125),
    defensive_spells: [
      "Lesser Shroud (120)",
      "Natural Colors (601)",
      "Phoen's Strength (606)",
      "Resist Elements (602)",
      "Self Control (613)",
      "Spirit Defense (103)",
      "Spirit Warding I (101)",
      "Spirit Warding II (107)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a pitted iron falchion",
    "a pitted iron jeddart-axe",
    "a wood buckler",
    "a wood composite bow",
    "a wood-gripped estoc"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Pristine sprite's hairGlowing violet essence shard"
  },
  messaging: {
    description: [
      "Appearing more like an animated stick figure than a fleshy humanoid, the slight brown form of the lesser wood sprite stands just over two feet. Her eyes, two sparkling almond-shapes in her wood-like visage, belie a fervent sort of insanity as a frantic, incomprehensible whispering issues from her small mouth."
    ],
    arrival: [
      "Seemingly from nowhere, a lesser wood sprite wanders in!"
    ],
    flee: [
      "A lesser wood sprite glances around and then wanders {direction}!",
      "A lesser wood sprite screams loudly as she stands {direction}!"
    ],
    death: [
      "The lesser wood sprite twitches violently, then dies.",
      "A lesser wood sprite goes limp as he is rendered unconscious!",
      "The lesser wood sprite's eyes grow dim as her lifeforce fades away.",
      "The lesser wood sprite's eyes grow dim as his lifeforce fades away."
    ],
    decay: [
      "A lesser wood sprite crumbles into a pile of dry splinters.",
      "The lesser wood sprite's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A lesser wood sprite thrusts with a wood-gripped estoc at you!"
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
