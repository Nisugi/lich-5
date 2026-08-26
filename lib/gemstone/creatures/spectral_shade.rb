{
  schema_version: 3,
  name: "spectral shade",
  noun: "",
  url: "https://gswiki.play.net/spectral_shade",
  picture: "",
  level: 35,
  family: "Ghost",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: nil,
  max_hp: 259,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4214303..4214323]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Blackened scythe",
        as: 239
      },
      {
        name: "Powerful lightning bolt",
        as: 162
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
    asg: nil,
    immunities: [],
    melee: (164..301),
    ranged: nil,
    bolt: nil,
    udf: 324,
    bar_td: nil,
    cle_td: 123,
    emp_td: (136..145),
    pal_td: nil,
    ran_td: nil,
    sor_td: (145..151),
    wiz_td: nil,
    mje_td: 155,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (129..136),
    mnm_td: (104..113),
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
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The spectral shade is a mere shadow of a creature most of the time, yet it can resolve itself into immediate solidity when on the attack. Possessed of both potent physical and magical attacks, the spectral shade calls upon its many offensive capabilities to strike the living whenever possible. The spectral shade is best hunted in the daytime, as it blends easily into the darkness of night."
    ],
    arrival: [],
    flee: [],
    death: [
      "A spectral shade fades into oblivion."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A spectral shade nods at you!",
      "A spectral shade swings {weapon} at you!"
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
