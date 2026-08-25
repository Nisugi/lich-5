{
  schema_version: 3,
  name: "csetairi",
  noun: "",
  url: "https://gswiki.play.net/csetairi",
  picture: "",
  level: 81,
  family: "Csetairi",
  type: "Hybrid",
  undead: false,
  blood: true,
  bones: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Magical"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 6,
  size: "large",
  areas: [
    {
      name: "The Rift",
      uids: [4567001..4567055]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Scimitar",
        as: (369..417)
      }
    ],
    bolt_spells: [
      {
        name: "Major Fire (908)",
        as: 352
      }
    ],
    warding_spells: [
      {
        name: "Web (118)",
        cs: 329
      },
      {
        name: "Bind (214)",
        cs: 329
      },
      {
        name: "Frenzy (216)",
        cs: 329
      }
    ],
    offensive_spells: [
      {
        name: "Bravery (211)"
      },
      {
        name: "Heroism (215)"
      }
    ],
    maneuvers: [
      {
        name: "Multi-strike"
      },
      {
        name: "Dispel"
      },
      {
        name: "Point"
      },
      {
        name: "Air Blast"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "5N",
    immunities: [],
    melee: (366..545),
    ranged: (272..334),
    bolt: nil,
    udf: 486,
    bar_td: (292..300),
    cle_td: nil,
    emp_td: (322..332),
    pal_td: nil,
    ran_td: nil,
    sor_td: (341..349),
    wiz_td: nil,
    mje_td: 365,
    mne_td: 362,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Spirit Warding I (101)",
      "Spirit Defense (103)",
      "Spirit Warding II (107)",
      "Lesser Shroud (120)",
      "Spirit Shield (202)",
      "Spell Shield (219)"
    ],
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
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "__noTOC__\nThe csetairi has several humanoid features, appearing as a shapely woman with long, silky, black hair. However, the differences are readily apparent. Instead of legs, she has a long, thick, coiled tail, and her locomotion is definitely snakelike. Four arms sprout from her chest, and long, pointed fangs extend down below her upper lip. Her slitted, olive green eyes scan the area rapidly, looking for potential victims."
    ],
    arrival: [
      "A csetairi slithers in!"
    ],
    flee: [
      "A csetairi slithers {direction}."
    ],
    death: [
      "Intestines rupture from intense heat; a csetairi dies a slow, painful death."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A csetairi swings {weapon} at you!"
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
