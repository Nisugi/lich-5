{
  schema_version: 3,
  name: "minotaur warrior",
  noun: "",
  url: "https://gswiki.play.net/minotaur_warrior",
  picture: "",
  level: 76,
  family: "Minotaur",
  type: "Biped",
  undead: false,
  blood: true,
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
  height: 8,
  size: "medium",
  areas: [
    {
      name: "The Hidden Plateau",
      uids: [2167050..2167067, 2167070..2167108, 2167111..2167122]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Greataxe",
        as: 368
      },
      {
        name: "Moon axe",
        as: (368..384)
      },
      {
        name: "Lustrous steel battle axe",
        as: 348
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Bull Rush"
      },
      {
        name: "Disarm"
      },
      {
        name: "Charge"
      },
      {
        name: "Ground Slam"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12",
    immunities: [],
    melee: (293..489),
    ranged: nil,
    bolt: nil,
    udf: (542..660),
    bar_td: nil,
    cle_td: (274..280),
    emp_td: (260..263),
    pal_td: (219..228),
    ran_td: (228..237),
    sor_td: (273..294),
    wiz_td: nil,
    mje_td: 297,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (251..269),
    mnm_td: (222..228),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a blackened steel moon axe",
    "a deep blue heater shield",
    "a lustrous steel battle axe",
    "some banded grey brigandine armor"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a minotaur horn",
    other: "Tiny golden seed"
  },
  messaging: {
    description: [
      "The minotaur warrior has the head of a bull while his muscular body is humanoid with thick arms and broad shoulders. Wearing a mish-mash of leather and chain armor, the fierce minotaur stomps about with hoofed feet brandishing its longsword at every possible foe."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [
      "The thick skin of a minotaur warrior falls in upon itself as his enormous form decays into a fine dust.",
      "Acid dissolves connecting cartilage, freeing the minotaur warrior's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A minotaur warrior swings {weapon} at you!",
      "Tightening minotaur warrior grip on minotaur warrior steel battle axe, a minotaur warrior strikes out at you with all of minotaur warrior might!"
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
