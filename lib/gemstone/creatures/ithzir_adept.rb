{
  schema_version: 3,
  name: "ithzir adept",
  noun: "",
  url: "https://gswiki.play.net/ithzir_adept",
  picture: "",
  level: 96,
  family: "Ithzir",
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
      uids: [17001101..17001107, 17004001..17004028, 17004031..17004120, 17004160..17004168, 17004180..17004187, 17004190..17004195]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Quarterstaff",
        as: 408
      },
      {
        name: "Twisted crystal-tipped staff",
        as: 428
      }
    ],
    bolt_spells: [
      {
        name: "Cone of Elements (518)",
        as: 379
      },
      {
        name: "Major Cold (907)",
        as: 379
      },
      {
        name: "Major Fire (908)",
        as: 379
      },
      {
        name: "Major Shock (910)",
        as: 379
      },
      {
        name: "Minor Acid (904)",
        as: 379
      },
      {
        name: "Minor Fire (906)",
        as: 379
      },
      {
        name: "Minor Water (903)",
        as: 379
      }
    ],
    warding_spells: [
      {
        name: "Weapon Fire (915)",
        cs: 402
      },
      {
        name: "Twisted crystal-tipped staff",
        cs: 402
      }
    ],
    offensive_spells: [
      {
        name: "Call Wind (912)"
      },
      {
        name: "Lightning mote"
      }
    ],
    maneuvers: [
      {
        name: "Palm Thrust"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "6",
    immunities: [],
    melee: (386..605),
    ranged: (369..413),
    bolt: (364..421),
    udf: 579,
    bar_td: (379..391),
    cle_td: (398..409),
    emp_td: (397..405),
    pal_td: nil,
    ran_td: nil,
    sor_td: (411..436),
    wiz_td: nil,
    mje_td: 440,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (376..392),
    mnm_td: nil,
    defensive_spells: [
      "Elemental Defense I (401)",
      "Elemental Defense II (406)",
      "Elemental Defense III (414)",
      "Elemental Barrier (430)",
      "Thurfel's Ward (503)",
      "Elemental Focus (513)",
      "Prismatic Guard (905)",
      "Mass Blur (911)",
      "Wizard Shield (919)"
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
      "The Ithzir adept carries a bearing of absolute confidence, his piercing, pupil-less green eyes shrewdly taking in his surroundings. The Ithzir adept is slightly taller than a human, and while his humanoid form is similar to scores of other races, the hairless, blue-skinned body is nonetheless alien in its appearance. The adept wears a crisply-cut, silvery-blue tunic with high shoulders and a deep vee-neck. Emblazoned on the right breast of the tunic is a single green eye."
    ],
    arrival: [
      "An Ithzir initiate strides in, her hands clasped before her.",
      "An Ithzir initiate strides in, his hands clasped before him."
    ],
    flee: [],
    death: [
      "An Ithzir adept goes limp as she is rendered unconscious!"
    ],
    decay: [
      "The crystal crumbles into a fine blue powder that sifts through the adept's fingers."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An Ithzir adept swings {weapon} at you!",
      "An Ithzir adept thrusts both palms toward you!",
      "An Ithzir initiate places one palm on ithzir adept chest, and raises the other toward you!",
      "An Ithzir seer suddenly opens ithzir adept eyes and stares directly at you!"
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
