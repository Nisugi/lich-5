{
  schema_version: 3,
  name: "ithzir seer",
  noun: "",
  url: "https://gswiki.play.net/ithzir_seer",
  picture: "",
  level: 97,
  family: "Ithzir",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Extraplanar"
  ],
  bcs: true,
  max_hp: 313,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Old Ta'Faendryl",
      uids: [17001101..17001107, 17004001..17004028, 17004031..17004120, 17004160..17004168, 17004180..17004187, 17004190..17004195]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Quarterstaff",
        as: 398
      },
      {
        name: "Twisted crystal-tipped staff",
        as: 411
      }
    ],
    bolt_spells: [
      {
        name: "Fire Spirit",
        as: 476
      },
      {
        name: "Telekinesis",
        as: 476
      },
      {
        name: "Web",
        as: 476
      }
    ],
    warding_spells: [
      {
        name: "Bone Shatter",
        cs: 423
      },
      {
        name: "Frenzy",
        cs: (411..431)
      },
      {
        name: "Mass Interference",
        cs: (411..431)
      },
      {
        name: "Silence",
        cs: (425..431)
      },
      {
        name: "Torment",
        cs: 411
      },
      {
        name: "Web",
        cs: 431
      },
      {
        name: "Twisted crystal-tipped staff",
        cs: 431
      }
    ],
    offensive_spells: [
      {
        name: "Spirit Strike"
      },
      {
        name: "Spiritual Abolition"
      },
      {
        name: "Bravery (211)"
      },
      {
        name: "Elemental Focus (513)"
      }
    ],
    maneuvers: [],
    special_abilities: [
      {
        name: "Psionic stun"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "6",
    immunities: [],
    melee: (363..591),
    ranged: 279,
    bolt: (369..386),
    udf: 540,
    bar_td: (373..385),
    cle_td: (371..431),
    emp_td: (378..423),
    pal_td: nil,
    ran_td: nil,
    sor_td: (431..445),
    wiz_td: nil,
    mje_td: (450..459),
    mne_td: nil,
    mjs_td: nil,
    mns_td: (363..423),
    mnm_td: nil,
    defensive_spells: [
      "Minor Sanctuary (213)",
      "Self Control (613)",
      "Spirit Fog (106)",
      "Wall of Force (140)",
      "Spirit Warding I (101)",
      "Spirit Defense (103)",
      "Spirit Warding II (107)",
      "Spirit Shield (202)",
      "Spell Shield (219)",
      "Self Control (613)"
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
      "The Ithzir seer carries an authoritative bearing, her arresting, pupil-less green eyes taking in her surroundings with both confidence and cunning. Even when battle rages around her, each movement of the seer seems eerily effortless and calm. The Ithzir seer is slightly taller than a human, and while her humanoid form is similar to scores of other races, the hairless, blue-skinned body is nonetheless alien in its appearance. The seer wears a crisply-cut, silvery-blue tunic with high shoulders and a deep vee-neck. Emblazoned on the right breast of the tunic is a twelve-pointed golden star."
    ],
    arrival: [
      "A faint rippling in the air heralds the arrival of an Ithzir seer!"
    ],
    flee: [],
    death: [],
    decay: [
      "Acid dissolves the knee ligaments.  The Ithzir seer's tibia passes his femur in a very unpleasant manner!",
      "Acid dissolves connecting cartilage, freeing the Ithzir seer's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An Ithzir seer suddenly opens ithzir seer eyes and stares directly at you!",
      "An Ithzir seer swings {weapon} at you!",
      "An Ithzir seer throws {weapon} at you!",
      "The Ithzir seer points at you."
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
