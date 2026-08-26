{
  schema_version: 3,
  name: "greater kappa",
  noun: "",
  url: "https://gswiki.play.net/greater_kappa",
  picture: "",
  level: 7,
  family: "Reptilian",
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
  max_hp: 100,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Coastal Cliffs",
      uids: [85001..85009]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Handaxe",
        as: 107
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
    asg: "1N",
    immunities: [],
    melee: (19..94),
    ranged: 10,
    bolt: 20,
    udf: (75..140),
    bar_td: 21,
    cle_td: 21,
    emp_td: 21,
    pal_td: (18..21),
    ran_td: nil,
    sor_td: 21,
    wiz_td: nil,
    mje_td: 21,
    mne_td: 21,
    mjs_td: nil,
    mns_td: 21,
    mnm_td: 21,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a handaxe"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a kappa fin",
    other: nil
  },
  messaging: {
    description: [
      "The greater kappa moves slowly on land, its bulk more suited to shallow bays and underwater cities. It stands on short, fleshy legs and observes the world through lidless, bulbous eyes. Totally black from head to webbed foot, the greater kappa easily blends in with the dark sands of its hunting area and is nearly impossible to see once underwater. The flesh of the greater kappa is very oily and, though a good source of lamp fuel, is not good to eat."
    ],
    arrival: [
      "A greater kappa just arrived!",
      "A greater kappa just arrived."
    ],
    flee: [],
    death: [
      "The greater kappa twitches violently, then dies.",
      "The greater kappa falls to the ground motionless.",
      "The greater kappa screams evilly one last time and goes still."
    ],
    decay: [
      "A greater kappa turns to dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A greater kappa swings {weapon} at you!"
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
