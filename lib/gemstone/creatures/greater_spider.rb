{
  schema_version: 3,
  name: "greater spider",
  noun: "",
  url: "https://gswiki.play.net/greater_spider",
  picture: "",
  level: 8,
  family: "Arachnid",
  type: "Arachnid",
  undead: false,
  blood: true,
  bones: nil,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 90,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "The Graveyard",
      uids: [2162001..2162015]
    },
    {
      name: "Vornavian Coast",
      uids: [4202161..4202180, 4218201..4218221]
    },
    {
      name: "Crystal Caves",
      uids: [24001..24017]
    },
    {
      name: "Sea Caverns",
      uids: [392001..392008]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (104..116)
      },
      {
        name: "Pincer (attack)",
        as: 116
      },
      {
        name: "Pincer",
        as: 104
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Web"
      }
    ],
    special_abilities: [
      {
        name: "Web"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "1N",
    immunities: [],
    melee: (61..137),
    ranged: nil,
    bolt: 48,
    udf: (69..145),
    bar_td: 24,
    cle_td: 24,
    emp_td: 24,
    pal_td: (21..24),
    ran_td: 24,
    sor_td: 24,
    wiz_td: nil,
    mje_td: 24,
    mne_td: 24,
    mjs_td: nil,
    mns_td: 24,
    mnm_td: 24,
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
    skin: "a spider leg",
    other: nil
  },
  messaging: {
    description: [
      "With a spread of nearly eight feet from leg-tip to leg-tip, the greater spider needs fear little as she squats, silent and deadly in her massive web. Shockingly fast for all her bulk, she responds instantly to any vibration along the thousand strands of the web she controls. Her glossy black carapace glistens with the lustre of fine onyx and her multiple eyes stare out at the world with cunning and patience."
    ],
    arrival: [],
    flee: [
      "A greater spider scurries {direction}.",
      "A greater spider hobbles {direction}."
    ],
    death: [
      "The greater spider collapses to the ground and dies.",
      "The greater spider's body jerks one last time and dies.",
      "A greater spider goes limp as it is rendered unconscious!",
      "The greater spider slumps to the ground."
    ],
    decay: [
      "A greater spider's legs shrivel up beneath it as it decays into dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A greater spider snaps at you with {pronoun} pincer!"
    ],
    bite: [],
    claw: [
      "A greater spider claws at you!"
    ],
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
