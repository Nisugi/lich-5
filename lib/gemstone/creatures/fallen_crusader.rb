{
  schema_version: 3,
  name: "fallen crusader",
  noun: "",
  url: "https://gswiki.play.net/fallen_crusader",
  picture: "",
  level: 97,
  family: "Ghost",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead",
    "Extraplanar"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "The Rift",
      uids: [4569001..4569023]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Barbed tentacle",
        as: 428
      },
      {
        name: "Gilt-edged steel talon sword",
        as: 515
      },
      {
        name: "Gold-spiked black morning star",
        as: 451
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Gilt-edged steel talon sword",
        cs: 411
      },
      {
        name: "Gold-spiked black morning star",
        cs: 408
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Charge"
      },
      {
        name: "Feint"
      },
      {
        name: "Shield Charge"
      },
      {
        name: "Tail Swipe"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16",
    immunities: [],
    melee: (338..585),
    ranged: nil,
    bolt: nil,
    udf: 716,
    bar_td: "+338 to +360",
    cle_td: nil,
    emp_td: (373..383),
    pal_td: nil,
    ran_td: nil,
    sor_td: "+392",
    wiz_td: nil,
    mje_td: 411,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Spirit Warding I (101)",
      "Spirit Defense (103)",
      "Spirit Warding II (107)",
      "Fasthr's Reward (115)",
      "Lesser Shroud (120)",
      "Mantle of Faith (1601)",
      "Divine Shield (1609)"
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
    magic_items: nil,
    gems: true,
    boxes: nil,
    skin: nil,
    other: "Inky necrotic core"
  },
  messaging: {
    description: [
      "Roiling wisps of ethereal green mist fill in the form of a muscled warrior. Fleshy tones, segments of armor, and humanoid features flicker across her visage, as if the mist was remembering bits and pieces of the paladin's former body, if for only moments at a time. Unable to hold corporeal form, the only meaningful remnants of the crusader's prior existence are her stark conviction, held now in eyes which are no more than swirling grey voids, and her martial prowess."
    ],
    arrival: [
      "A fallen crusader just arrived, looking terrified!"
    ],
    flee: [
      "A fallen crusader bolts {direction}!"
    ],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A fallen crusader swings {weapon} at you!",
      "A glistening cerebralite focuses fallen crusader eye-stalks on you!",
      "A glistening cerebralite lashes at you with fallen crusader barbed tentacle!"
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
