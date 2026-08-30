{
  schema_version: 3,
  name: "red-scaled thrak",
  noun: "",
  url: "https://gswiki.play.net/red-scaled_thrak",
  picture: "",
  level: 48,
  family: "Reptilian",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: false,
  sleepable: true,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living",
    "Element-based"
  ],
  bcs: true,
  max_hp: 380,
  speed: 6,
  height: 2,
  size: "medium",
  areas: [
    {
      name: "Volcano",
      uids: [3050015..3050036, 3052003..3052025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite (attack)",
        as: 278
      },
      {
        name: "Claw (attack)",
        as: 278
      },
      {
        name: "Bite",
        as: 278
      },
      {
        name: "Claw",
        as: 278
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
    asg: "12N",
    immunities: [],
    melee: (226..492),
    ranged: (149..232),
    bolt: (149..232),
    udf: 264,
    bar_td: nil,
    cle_td: 176,
    emp_td: 175,
    pal_td: (146..149),
    ran_td: 149,
    sor_td: 185,
    wiz_td: nil,
    mje_td: (195..196),
    mne_td: (195..196),
    mjs_td: (213..216),
    mns_td: (213..216),
    mnm_td: 144,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a bruised left eye",
    "a bruised right eye",
    "a completely severed left foreleg",
    "a blinded left eye",
    "a completely severed right foreleg"
  ],
  treasure: {
    coins: true,
    magic_items: nil,
    gems: true,
    boxes: nil,
    skin: "a thrak tail",
    other: nil
  },
  messaging: {
    description: [
      "A red-scaled thrak is nearly twice the size of its mundane relative, the common thrak. Armed with heavy claws on all four feet and a nasty set of long razor-sharp fangs, it appears rather well equipped for offense. Its skin has a rough pebbled texture, dark gray to black on the back, with a brilliant red underbelly and tail."
    ],
    arrival: [],
    flee: [
      "A red-scaled thrak darts {direction}."
    ],
    death: [
      "The red-scaled thrak falls back into a heap and dies.",
      "The red-scaled thrak hisses one last time and dies.",
      "The red-scaled thrak twitches violently, then dies.",
      "Beautiful shot pierces both lungs, the red-scaled thrak makes a wheezing noise, and drops dead!"
    ],
    decay: [
      "A red-scaled thrak decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A red-scaled thrak tries to bite you!"
    ],
    claw: [
      "A red-scaled thrak claws at you!"
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
