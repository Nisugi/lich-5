{
  schema_version: 3,
  name: "sea nymph",
  noun: "",
  url: "https://gswiki.play.net/sea_nymph",
  picture: "",
  level: 2,
  family: "Fey",
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
  max_hp: 44,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Coastal Cliffs",
      uids: [67007..67020]
    },
    {
      name: "Vornavian Coast",
      uids: [4202101..4202111]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Dagger",
        as: 50
      },
      {
        name: "Handaxe",
        as: 50
      },
      {
        name: "Spear",
        as: 50
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Calm (201)",
        cs: 10
      },
      {
        name: "Vibration Chant (1002)",
        cs: 2
      }
    ],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "2",
    immunities: [],
    melee: 10,
    ranged: 7,
    bolt: 7,
    udf: 52,
    bar_td: 6,
    cle_td: nil,
    emp_td: 6,
    pal_td: nil,
    ran_td: nil,
    sor_td: 6,
    wiz_td: nil,
    mje_td: 6,
    mne_td: 6,
    mjs_td: 6,
    mns_td: 6,
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
    other: "pristine nymph's hair"
  },
  messaging: {
    description: [
      "Never found far from the life-giving sea, the sea nymph slips onto dry land to waylay unwary adventurers. Depending mostly on her seductive song, she charms her prey into submission, then strikes quickly and deeply with her dagger. From a distance she is often mistaken for a slim sylvan lady. The flowing robe she wears conceals the webbed appendages that give her speed in the ocean."
    ],
    arrival: [
      "A sea nymph just arrived."
    ],
    flee: [
      "A sea nymph draped in seaweed and a wet, clinging robe slithers {direction} {direction} of a crevice."
    ],
    death: [
      "The sea nymph falls to the ground and dies.",
      "The sea nymph screams one last time and dies."
    ],
    decay: [
      "A sea nymph decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A sea nymph swings {weapon} at you!",
      "A sea nymph thrusts with a blue-tasseled white steel spear at you!"
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
