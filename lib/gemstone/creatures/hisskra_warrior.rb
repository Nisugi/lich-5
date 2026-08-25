{
  schema_version: 3,
  name: "hisskra warrior",
  noun: "",
  url: "https://gswiki.play.net/hisskra_warrior",
  picture: "",
  level: 30,
  family: "Hisskra",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "The Ruined Tower",
      uids: [305001..305030, 305032..305038, 305050..305056]
    },
    {
      name: "unmapped",
      uids: [305031..305031]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Dart",
        as: 247
      },
      {
        name: "Trident",
        as: (222..227)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Lash"
      },
      {
        name: "Tail Swipe"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (182..327),
    ranged: nil,
    bolt: nil,
    udf: 337,
    bar_td: (87..90),
    cle_td: nil,
    emp_td: (92..100),
    pal_td: nil,
    ran_td: nil,
    sor_td: (102..111),
    wiz_td: nil,
    mje_td: (104..110),
    mne_td: 110,
    mjs_td: nil,
    mns_td: nil,
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
    skin: "hisskra skin",
    other: nil
  },
  messaging: {
    description: [
      "Nearly as tall as a typical human, the humanoid reptilian hisskra shares many characteristics with mankind. A long snout filled with an array of sharp teeth dominates the hisskra's facial features, giving him the appearance of a bipedal iguana. Well-defined pectorals and a muscular torso are nearly man-like, but for the dull, dark green scales that fade to a paler shade at the throat, and the ridge of mottled, boney spines that runs from between the hisskra warrior's shoulder blades to the tip of his four-foot tail. The hisskra's muscular limbs end in thick-fingered, partially-webbed hands and feet tipped with blackened claws, which are formidable weapons should the creature lose his more civilized martial implements. The hisskra warrior peers about with milky white eyes, his tongue flicking over his scaly lips."
    ],
    arrival: [],
    flee: [],
    death: [
      "The hisskra warrior rolls over on his back and dies.",
      "A hisskra warrior goes limp as he is rendered unconscious!"
    ],
    decay: [
      "A hisskra warrior collapses into a putrid lump of scaly flesh.",
      "A hisskra warrior decays into a pile of scales and bone.",
      "A hisskra warrior's scales wither as he decays into dust.",
      "A hisskra warrior withers away, leaving nothing but a few scales that blow away on a gentle breeze.",
      "Acid dissolves connecting cartilage, freeing the hisskra warrior's ribs to move independently.",
      "The hisskra warrior's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A hisskra warrior slings a long, hollow reed from over {pronoun} shoulder and raises one end to {pronoun} lips.  {Pronoun} points the other end toward you and exhales sharply!",
      "A hisskra warrior swings {weapon} at you!"
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
