{
  schema_version: 3,
  name: "mongrel hobgoblin",
  noun: "",
  url: "https://gswiki.play.net/mongrel_hobgoblin",
  picture: "",
  level: 5,
  family: "Goblin",
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
  max_hp: 80,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Ocoma Vale",
      uids: [4300004..4300025]
    },
    {
      name: "Muddy Village",
      uids: [7128001..7128015, 7128026..7128030]
    },
    {
      name: "unmapped",
      uids: [7128016..7128025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Morning star",
        as: 99
      },
      {
        name: "Spiked club",
        as: 79
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
    asg: "8",
    immunities: [],
    melee: (13..72),
    ranged: 0,
    bolt: 0,
    udf: 113,
    bar_td: nil,
    cle_td: nil,
    emp_td: -15,
    pal_td: nil,
    ran_td: nil,
    sor_td: 15,
    wiz_td: nil,
    mje_td: 15,
    mne_td: 15,
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a mongrel hobgoblin snout",
    other: nil
  },
  messaging: {
    description: [
      "The mongrel hobgoblin is a horribly misshapen beast, with a hideously deformed face. The large, knotted muscles on her arms betray the creature's strength, which is capable of rending a man's limbs right out of their sockets. Mottled skin with a greenish-yellow hue is splotched with randomly scattered patches of reddish-brown fur. The dark beady eyes of the hobgoblin glare menacingly, as if crushing the life from someone would somehow make her life more bearable."
    ],
    arrival: [],
    flee: [
      "A mongrel hobgoblin snarls as she retreats!"
    ],
    death: [
      "The mongrel hobgoblin crumples to the ground and dies."
    ],
    decay: [
      "A mongrel hobgoblin decays into a pile of compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A mongrel hobgoblin swings {weapon} at you!"
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
