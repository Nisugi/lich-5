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
    melee: 509,
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: (315..335),
    cle_td: nil,
    emp_td: (335..341),
    pal_td: 294,
    ran_td: nil,
    sor_td: (354..390),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
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
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
