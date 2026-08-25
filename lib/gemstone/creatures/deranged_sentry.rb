{
  schema_version: 3,
  name: "deranged sentry",
  noun: "",
  url: "https://gswiki.play.net/deranged_sentry",
  picture: "",
  level: 13,
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
  max_hp: 162,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Thurfel's Island",
      uids: [7531026..7531042]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Halberd",
        as: 167
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Disarm Weapon"
      },
      {
        name: "Tackle"
      },
      {
        name: "Trip"
      },
      {
        name: "Halberd Sweep"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "11",
    immunities: [],
    melee: (103..196),
    ranged: (81..91),
    bolt: (81..91),
    udf: 224,
    bar_td: (39..42),
    cle_td: nil,
    emp_td: (39..47),
    pal_td: nil,
    ran_td: nil,
    sor_td: (33..45),
    wiz_td: nil,
    mje_td: 45,
    mne_td: 39,
    mjs_td: nil,
    mns_td: 39,
    mnm_td: (33..39),
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
      "Garbed in bright crimson armor, the deranged sentry appears alert and ready for battle. The sentry is haphazardly dressed with unlaced boots, leathers and a helm that looks to be about three sizes to big."
    ],
    arrival: [
      "A deranged sentry lumbers in."
    ],
    flee: [
      "A deranged sentry lumbers {direction}."
    ],
    death: [],
    decay: [
      "The deranged sentry decays into a grisly pile of armor, blood, and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A deranged sentry swings {weapon} at you!"
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
