{
  schema_version: 3,
  name: "skeletal soldier",
  noun: "",
  url: "https://gswiki.play.net/skeletal_soldier",
  picture: "",
  level: 34,
  family: "Humanoid",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Miasmal Forest",
      uids: [5003001..5003027, 5003030..5003030, 5003032..5003032, 5003036..5003039, 5004016..5004034]
    },
    {
      name: "unmapped",
      uids: [5003028..5003029, 5003031..5003031, 5003033..5003035]
    }
  ],
  attack_attributes: {
    physical_attacks: [],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Disarm Weapon"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: 238,
    ranged: nil,
    bolt: nil,
    udf: 303,
    bar_td: (102..111),
    cle_td: 108,
    emp_td: (108..115),
    pal_td: nil,
    ran_td: nil,
    sor_td: (115..124),
    wiz_td: nil,
    mje_td: nil,
    mne_td: 121,
    mjs_td: nil,
    mns_td: 109,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "Clad in broken chain armor, the soldier's pale white bones are exposed in certain points in which the armor has completely rusted away. Dark leather gloves cover its bony hands. A very small glimmer of life can be seen in the depths of the soldier's eye sockets."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
