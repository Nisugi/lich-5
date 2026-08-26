{
  schema_version: 3,
  name: "gnarled being",
  noun: "",
  url: "https://gswiki.play.net/gnarled_being",
  picture: "",
  level: 82,
  family: "Chimeric",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 7,
  size: "large",
  areas: [
    {
      name: "Old Ta'Faendryl",
      uids: [17003011..17003038, 17003101..17003150, 17003201..17003217]
    },
    {
      name: "unmapped",
      uids: [17003001..17003010]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: 406
      },
      {
        name: "Impale",
        as: 396
      },
      {
        name: "Smash",
        as: 412
      },
      {
        name: "Tusk",
        as: 356
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Ground Slam"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: 509,
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: (315..335),
    cle_td: nil,
    emp_td: (335..341),
    pal_td: (294..297),
    ran_td: nil,
    sor_td: (354..390),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (326..335),
    mnm_td: (276..285),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Hides when attacked"
    ]
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
    skin: nil,
    other: "Radiant crimson mote of essence"
  },
  messaging: {
    description: [
      "The gnarled being is a twisted amalgamation of flesh and other, less mentionable things. Tusks and horns grow from its head in an impressive array of weaponry. The tough, pale yellow skin of the being looks burnt and scorched in places, but this doesn't seem to bother it. The gnarled being's twisted hands and feet end with wicked, razor-sharp claws that refuse to shine in the light."
    ],
    arrival: [
      "A gnarled being strides in with a snort of derision.",
      "A twisted being stalks in, its tail swishing back and forth menacingly."
    ],
    flee: [],
    death: [
      "A gnarled being coughs up some blood and dies.",
      "A bent being curses through its teeth as it dies."
    ],
    decay: [
      "A gnarled being crumbles away into nothing."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A gnarled being charges at you with {pronoun} tusk!",
      "A lesser construct raises gnarled being massive foot and attempts to smash you!"
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
