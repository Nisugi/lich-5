{
  schema_version: 3,
  name: "soldier ant",
  noun: "ant",
  url: "https://gswiki.play.net/giant_ant",
  picture: "",
  level: 5,
  family: "Ant",
  type: "Insect",
  undead: false,
  blood: nil,
  bones: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 55,
  speed: nil,
  height: 1,
  size: "medium",
  areas: [
    {
      name: "Dark Caverns",
      uids: [47001..47033]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 45
      },
      {
        name: "Charge (attack)",
        as: 55
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
    melee: 85,
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: nil,
    cle_td: nil,
    emp_td: nil,
    pal_td: nil,
    ran_td: nil,
    sor_td: nil,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
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
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The soldier ant looks like a giant armored version of a common ordinary ant. Its faceted eyes stare back at you with apparent disinterest."
    ],
    arrival: [
      "A soldier ant just arrived."
    ],
    flee: [],
    death: [
      "The soldier ant feebly twitches a feeler one last time and dies.",
      "The soldier ant falls to the ground and dies, its feelers twitching."
    ],
    decay: [
      "A soldier ant decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [],
    claw: [],
    info: {
      general: [
        "Not in the Bestiary. Uncommon; shares the Wehnimer's Landing ant nest with giant ants (mongen profile 1194, rooms u47001-u47033).",
        "Cannot be skinned. Treasure unconfirmed - possibly ant larva, as giant ants drop."
      ],
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
