{
  schema_version: 3,
  name: "ithzir herald",
  noun: "",
  url: "https://gswiki.play.net/ithzir_herald",
  picture: "",
  level: 92,
  family: "Ithzir",
  type: "Biped",
  undead: false,
  blood: true,
  bones: nil,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Extraplanar"
  ],
  bcs: true,
  max_hp: 194,
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
        name: "Falchion"
      },
      {
        name: "Curved crystal-edged blade",
        as: 413
      },
      {
        name: "Curved silvery blade",
        as: 413
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Lullabye (1005)"
      },
      {
        name: "Song of Depression (1015)",
        cs: 384
      },
      {
        name: "Song of Rage (1016)"
      },
      {
        name: "Song of Sonic Disruption (1030)",
        cs: 384
      },
      {
        name: "Vibration Chant (1002)",
        cs: 384
      },
      {
        name: "Curved silvery blade",
        cs: 375
      }
    ],
    offensive_spells: [
      {
        name: "Elemental Wave (410)"
      },
      {
        name: "Mass Calm (619)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "9",
    immunities: [],
    melee: (377..570),
    ranged: nil,
    bolt: 386,
    udf: 579,
    bar_td: (358..371),
    cle_td: (364..380),
    emp_td: (361..370),
    pal_td: nil,
    ran_td: nil,
    sor_td: (399..409),
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (349..369),
    mnm_td: nil,
    defensive_spells: [
      "Elemental Defense I (401)",
      "Elemental Defense II (406)",
      "Elemental Defense III (414)",
      "Elemental Barrier (430)"
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
    other: "crystal-edged weapons"
  },
  messaging: {
    description: [
      "A trio of black tattooed stripes run from center of the Ithzir herald's forehead and over the crown of his bald, blue-skinned head. The Ithzir herald is slightly taller than a human, and while his humanoid form is similar to scores of other races, the hairless, blue body is nonetheless alien in its appearance. The herald wears a fine silvery-blue tunic crossed with a green tabard."
    ],
    arrival: [
      "An Ithzir initiate strides in, his hands clasped before him.",
      "An Ithzir initiate strides in, her hands clasped before her."
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "An Ithzir herald swings {weapon} at you!",
      "An Ithzir initiate places one palm on ithzir herald chest, and raises the other toward you!",
      "The Ithzir herald points at you for emphasis.",
      "The Ithzir herald points at you."
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
