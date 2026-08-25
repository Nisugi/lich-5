{
  schema_version: 3,
  name: "fanged viper",
  noun: "",
  url: "https://gswiki.play.net/fanged_viper",
  picture: "",
  level: 4,
  family: "Reptilian",
  type: "Ophidian",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 50,
  speed: nil,
  height: 1,
  size: "small",
  areas: [
    {
      name: "The Toadwort",
      uids: [14007012..14007041]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 68
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
    asg: "5N",
    immunities: [],
    melee: 37,
    ranged: 33,
    bolt: 33,
    udf: 51,
    bar_td: 12,
    cle_td: nil,
    emp_td: 12,
    pal_td: nil,
    ran_td: 12,
    sor_td: 12,
    wiz_td: nil,
    mje_td: 12,
    mne_td: 12,
    mjs_td: nil,
    mns_td: 12,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a viper skin",
    other: nil
  },
  messaging: {
    description: [
      "The fanged viper slithers quickly through the landscape, searching for small prey upon which to feed. Its massive venomous fangs hidden by small flaps of skin, this docile snake until disturbed, appears non-threatening. Once it is disturbed and its ire is aroused, the small flaps pull back revealing the true monster it is. Death rapidly awaits any who doubt its abilities."
    ],
    arrival: [],
    flee: [
      "A fanged viper slithers {direction}."
    ],
    death: [],
    decay: [
      "A fanged viper decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A fanged viper tries to bite you!"
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
