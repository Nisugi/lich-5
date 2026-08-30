{
  schema_version: 3,
  name: "ithzir initiate",
  noun: "",
  url: "https://gswiki.play.net/ithzir_initiate",
  picture: "",
  level: 91,
  family: "Ithzir",
  type: "Biped",
  undead: false,
  blood: true,
  bones: nil,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: true,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living",
    "Extraplanar"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Old Ta'Faendryl",
      uids: [17004001..17004028, 17004031..17004079, 17004160..17004168, 17004180..17004187, 17004190..17004195]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Quarterstaff",
        as: 433
      },
      {
        name: "Twisted crystal-tipped staff",
        as: (428..503)
      }
    ],
    bolt_spells: [
      {
        name: "Fire Spirit (111)",
        as: 407
      },
      {
        name: "Web (118)",
        as: 407
      }
    ],
    warding_spells: [
      {
        name: "Bind (214)",
        cs: 386
      },
      {
        name: "Divine Fury (317)",
        cs: 386
      },
      {
        name: "Divine Wrath (335)",
        cs: 386
      },
      {
        name: "Fervent Reproach (312)",
        cs: 386
      },
      {
        name: "Mass Interference (217)",
        cs: 386
      },
      {
        name: "Web (118)",
        cs: 398
      },
      {
        name: "Twisted crystal-tipped staff",
        cs: 383
      }
    ],
    offensive_spells: [
      {
        name: "Heroism (215)"
      },
      {
        name: "Spirit Strike (117)"
      }
    ],
    maneuvers: [
      {
        name: "Mind Stun"
      },
      {
        name: "Ground Slam"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "6",
    immunities: [],
    melee: (354..579),
    ranged: nil,
    bolt: (362..387),
    udf: (452..562),
    bar_td: (351..363),
    cle_td: (370..385),
    emp_td: (375..385),
    pal_td: (328..337),
    ran_td: 328,
    sor_td: (394..403),
    wiz_td: nil,
    mje_td: (408..458),
    mne_td: (408..458),
    mjs_td: (388..398),
    mns_td: (388..398),
    mnm_td: (355..364),
    defensive_spells: [
      "Lesser Shroud (120)",
      "Minor Sanctuary (213)",
      "Spell Shield (219)",
      "Spirit Defense (103)",
      "Spirit Shield (202)",
      "Spirit Warding I (101)",
      "Spirit Warding II (107)",
      "Wall of Force (140)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a suit of trimmed leather",
    "a twisted crystal-tipped staff"
  ],
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
      "The Ithzir initiate carries herself with a humble bearing, her arresting, pupil-less green eyes taking in her surroundings with confidence and surety. Even when battle rages around her, each movement of the initiate seems eerily effortless and calm. The Ithzir initiate is slightly taller than a human, and while her humanoid form is similar to scores of other races, the hairless, blue-skinned body is nonetheless alien in its appearance. The initiate wears a crisply-cut, blue tunic with a green palm-print emblazoned on the right breast."
    ],
    arrival: [
      "An Ithzir initiate strides in, his hands clasped before him.",
      "An Ithzir initiate strides in, her hands clasped before her.",
      "An Ithzir initiate strides in."
    ],
    flee: [
      "An Ithzir initiate strides {direction}."
    ],
    death: [
      "The Ithzir initiate vainly struggles to rise, then goes still.",
      "Just as you incant, the Ithzir initiate shimmers and fades away, leaving you gesturing at nothingness!",
      "Just as you move to cast, the Ithzir initiate shimmers and fades away, leaving you gesturing at nothingness!",
      "Beautiful shot pierces both lungs, the Ithzir initiate makes a wheezing noise, and drops dead!"
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "An Ithzir initiate places one palm on {pronoun} chest, and raises the other toward you!",
      "An Ithzir initiate swings {weapon} at you!"
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
