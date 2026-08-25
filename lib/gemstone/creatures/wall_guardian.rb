{
  schema_version: 3,
  name: "wall guardian",
  noun: "",
  url: "https://gswiki.play.net/wall_guardian",
  picture: "",
  level: 11,
  family: "Humanoid",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 159,
  speed: nil,
  height: 3,
  size: "small",
  areas: [
    {
      name: "Thurfel's Island",
      uids: [7531001..7531042]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Military pick",
        as: 153
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
    asg: "16",
    immunities: [],
    melee: (62..144),
    ranged: (61..76),
    bolt: (61..76),
    udf: 171,
    bar_td: 27,
    cle_td: 33,
    emp_td: (33..41),
    pal_td: nil,
    ran_td: nil,
    sor_td: (27..33),
    wiz_td: nil,
    mje_td: 33,
    mne_td: 33,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: 33,
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
    other: nil
  },
  messaging: {
    description: [
      "The wall guardian is a bit taller than a halfling, but not by much. Filthy, stinky and smelly, she looks as if she hasn't bathed in years. A faint smirk is etched on the face of the guardian."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [
      "The wall guardian decays into a grisly pile of armor, blood, and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A wall guardian swings {weapon} at you!"
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
