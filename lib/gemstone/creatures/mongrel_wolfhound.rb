{
  schema_version: 3,
  name: "mongrel wolfhound",
  noun: "",
  url: "https://gswiki.play.net/mongrel_wolfhound",
  picture: "",
  level: 16,
  family: "Canine",
  type: "Quadruped",
  undead: false,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 150,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Yegharren Plains",
      uids: [13034301..13034309, 13034314..13034337]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (132..150)
      },
      {
        name: "Charge",
        as: 161
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Pounce"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (102..150),
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: (42..48),
    cle_td: 42,
    emp_td: (29..48),
    pal_td: nil,
    ran_td: nil,
    sor_td: nil,
    wiz_td: nil,
    mje_td: nil,
    mne_td: 51,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: (47..54),
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a yellowed canine",
    other: nil
  },
  messaging: {
    description: [
      "The large canine is obviously closely related to her domestic cousins, but her vicious growl and the feral gleam in her intelligent eyes speak of her far wilder nature. Ticks and burs speckle her matted, dusty fur, and her wolflike tail sweeps from side to side as she prepares to spring on her intended prey."
    ],
    arrival: [],
    flee: [],
    death: [
      "The mongrel wolfhound falls to the ground and dies.",
      "The mangy wild hound rolls over and dies.",
      "The mongrel wild dog rolls over and dies.",
      "The black mongrel wolfhound falls to the ground and dies.",
      "The black mongrel wolfhound rolls over and dies.",
      "The mongrel wild dog falls to the ground and dies.",
      "The mongrel wolfhound rolls over and dies."
    ],
    decay: [
      "A mongrel wolfhound decays into a pile of matted fur.",
      "A black mongrel wolfhound decays into a pile of matted fur."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A mongrel wolfhound charges at you!"
    ],
    bite: [
      "A mongrel wolfhound tries to bite you!"
    ],
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
