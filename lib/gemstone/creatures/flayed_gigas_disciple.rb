{
  schema_version: 3,
  name: "flayed gigas disciple",
  noun: "",
  url: "https://gswiki.play.net/flayed_gigas_disciple",
  picture: "",
  level: 113,
  family: "Gigas",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [],
  bcs: true,
  max_hp: nil,
  speed: 6,
  height: 30,
  size: "huge",
  areas: [
    {
      name: "Hinterwilds",
      uids: [7503401..7503421, 7503467..7503478, 7503490..7503498]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Gigantic hand",
        as: 597
      },
      {
        name: "Skinless fist down",
        as: 587
      }
    ],
    bolt_spells: [
      {
        name: "903",
        as: 521
      }
    ],
    warding_spells: [
      {
        name: "1115",
        cs: 521
      },
      {
        name: "719",
        cs: 535
      },
      {
        name: "Point",
        cs: 517
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Point"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: nil,
    ranged: (520..625),
    bolt: (520..625),
    udf: 680,
    bar_td: nil,
    cle_td: nil,
    emp_td: 504,
    pal_td: nil,
    ran_td: 421,
    sor_td: nil,
    wiz_td: nil,
    mje_td: (405..525),
    mne_td: (405..525),
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
  equipment: [
    "a crude wooden cudgel",
    "a tattered hide cloak painted with dark sigils"
  ],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "A flayed gigas disciple is a hugely imposing figure. His monumental physique is all the more evident because his skin has been torn away, revealing wet and weeping tendons and raw muscle beneath. With no lips to conceal his teeth, the disciple appears to be ever grinning, but above his ruined nose are scarlet eyes ablaze with hateful zeal. A flayed gigas disciple wears a hooded shroud, ragged and threadbare, that is stained through with his own blood."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A flayed gigas disciple attempts to stamp you out with one great foot!",
      "A flayed gigas disciple raises {pronoun} hand and conjures a fountain of steaming blood to gush at you!",
      "A flayed gigas disciple swings {weapon} at you!",
      "A flayed gigas disciple tries to strangle you with a gigantic hand!",
      "A flayed gigas disciple whirls into a deadly form, swinging a crude wooden cudgel at you!",
      "A flayed gigas disciple whirls into a deadly form, swinging a gnarled dark wooden crook adorned with sinuous patterns at you!"
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
