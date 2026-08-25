{
  schema_version: 3,
  name: "mud wasp",
  noun: "",
  url: "https://gswiki.play.net/mud_wasp",
  picture: "",
  level: 38,
  family: "Wasp",
  type: "Insect",
  undead: false,
  blood: true,
  bones: nil,
  witherable: true,
  sympathy: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 260,
  speed: nil,
  height: 1,
  size: "small",
  areas: [
    {
      name: "Fhorian Village",
      uids: [3030011..3030023, 3030225..3030234, 3030250..3030255]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Stinger (attack)",
        as: 254
      },
      {
        name: "Stinger",
        as: 254
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
    asg: "8N",
    immunities: [],
    melee: (210..250),
    ranged: nil,
    bolt: nil,
    udf: 238,
    bar_td: 174,
    cle_td: 123,
    emp_td: (180..184),
    pal_td: nil,
    ran_td: nil,
    sor_td: (131..191),
    wiz_td: nil,
    mje_td: 198,
    mne_td: 138,
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "a wasp stinger",
    other: nil
  },
  messaging: {
    description: [
      "With a body about the size of a human hand, and a wingspan approaching a foot, the mud wasp is a rather intimidating sight. It is a superb example of camouflage, with a brown body covered in splatters of mud, and eyes the color of muddy water. The wings are the only exception to the brown color scheme, being transparent with a faint touch of blue."
    ],
    arrival: [
      "A mud wasp just arrived.",
      "A mud wasp wobbles as it flies in.",
      "A mud wasp weaves slowly as it flies in."
    ],
    flee: [],
    death: [
      "The mud wasp flutters its wings one last time and dies.",
      "The mud wasp twitches violently, then dies.",
      "A mud wasp goes limp as it is rendered unconscious!"
    ],
    decay: [
      "A mud wasp decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A mud wasp stabs at you with {pronoun} stinger!"
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
