{
  schema_version: 3,
  name: "mongrel kobold",
  noun: "",
  url: "https://gswiki.play.net/mongrel_kobold",
  picture: "",
  level: 4,
  family: "Kobold",
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
  max_hp: 80,
  speed: nil,
  height: 3,
  size: "small",
  areas: [
    {
      name: "The Citadel",
      uids: [377101..377128]
    },
    {
      name: "Vornavian Coast",
      uids: [4202401..4202416]
    },
    {
      name: "Plains of Vornavis",
      uids: [4212101..4212130, 4213101..4213130]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Handaxe",
        as: (65..73)
      },
      {
        name: "Short sword",
        as: 65
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: (29..97),
    ranged: (32..33),
    bolt: (32..33),
    udf: 126,
    bar_td: 12,
    cle_td: 12,
    emp_td: 12,
    pal_td: (9..12),
    ran_td: 12,
    sor_td: 12,
    wiz_td: nil,
    mje_td: 12,
    mne_td: 12,
    mjs_td: nil,
    mns_td: 12,
    mnm_td: 12,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a handaxe",
    "a short sword",
    "a wooden shield",
    "some reinforced leather"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "mangy kobold scalp",
    other: nil
  },
  messaging: {
    description: [
      "This mongrel kobold mostly resembles her kobold brethren. Smaller than a dwarf and even many halflings, she has splotchy skin and a fairly hairy head topped with small horns. Long-limbed for her size, the mongrel kobold eschews any display of brute strength and relies on what agility she pretends to have. The mongrel kobold stares back at you with beady little black eyes, sizing you up as a foe."
    ],
    arrival: [
      "A mongrel kobold just arrived."
    ],
    flee: [
      "A mongrel kobold heads {direction}.",
      "A mongrel kobold limps {direction}."
    ],
    death: [
      "The mongrel kobold screams one last time and dies.",
      "The mongrel kobold falls to the ground and dies."
    ],
    decay: [
      "A small, green cloud of smelly gas rises from the body of a mongrel kobold as she decays into compost.",
      "A small, green cloud of smelly gas rises from the body of a mongrel kobold as he decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A mongrel kobold swings {weapon} at you!"
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
