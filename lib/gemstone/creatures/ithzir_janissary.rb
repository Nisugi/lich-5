{
  schema_version: 3,
  name: "ithzir janissary",
  noun: "",
  url: "https://gswiki.play.net/ithzir_janissary",
  picture: "",
  level: 92,
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
  max_hp: 300,
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
        name: "Longsword",
        as: 428
      },
      {
        name: "Military fork"
      },
      {
        name: "Mace",
        as: 421
      },
      {
        name: "Smash",
        as: 453
      },
      {
        name: "Spiral-hafted crystal-edged handaxe",
        as: 423
      },
      {
        name: "Spiral-hafted handaxe",
        as: 421
      },
      {
        name: "Twisted crystal-tipped staff",
        as: 431
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Disarm Weapon"
      },
      {
        name: "Trip"
      },
      {
        name: "Warcries"
      },
      {
        name: "Disarm"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16",
    immunities: [],
    melee: (240..490),
    ranged: 289,
    bolt: 249,
    udf: 485,
    bar_td: 299,
    cle_td: (323..337),
    emp_td: 344,
    pal_td: nil,
    ran_td: nil,
    sor_td: (353..368),
    wiz_td: nil,
    mje_td: 377,
    mne_td: 376,
    mjs_td: nil,
    mns_td: (317..332),
    mnm_td: nil,
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "crystal-edged weapons"
  },
  messaging: {
    description: [
      "The Ithzir janissary's movements are both aggressive and graceful, his muscular, lithe form the envy of any acrobat or student of the martial arts. Wide, upward-slanted, green eyes take in his surroundings with an easy confidence, as if the fate of any opponent is not a matter of chance, only of time. The Ithzir janissary is a head taller than a human, and while his humanoid form is similar to scores of other races, the hairless, blue-skinned body is nonetheless alien in its appearance. The janissary wears a crisply-cut silvery blue tunic emblazoned with a feline silhouette on the right breast."
    ],
    arrival: [
      "An Ithzir janissary strides in, surveying the surroundings alertly."
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A greater construct raises ithzir janissary massive foot and attempts to smash you!",
      "An Ithzir janissary swings {weapon} at you!",
      "The Ithzir janissary points at you for emphasis.",
      "The Ithzir janissary points at you."
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
