{
  schema_version: 3,
  name: "nedum vereri",
  noun: "",
  url: "https://gswiki.play.net/nedum_vereri",
  picture: "",
  level: 18,
  family: "Ghost",
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
  max_hp: 160,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Temple of Love",
      uids: [2155012..2155044, 2155046..2155048]
    },
    {
      name: "Abbey",
      uids: [4132101..4132118]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Morning star",
        as: 161
      },
      {
        name: "Gilt-thorned steel spikestar",
        as: 120
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Calm (201)",
        cs: 95
      },
      {
        name: "Repel (Fear)",
        cs: 95
      }
    ],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: (144..170),
    ranged: nil,
    bolt: 87,
    udf: 168,
    bar_td: nil,
    cle_td: 54,
    emp_td: 54,
    pal_td: nil,
    ran_td: 87,
    sor_td: 54,
    wiz_td: nil,
    mje_td: 54,
    mne_td: 54,
    mjs_td: 54,
    mns_td: 54,
    mnm_td: 54,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a gilt-thorned steel spikestar",
    "an age-blanched raw silk shift patterned with faded red roses"
  ],
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
      "Once a priestess, this woman's service to her deity has ended tragically with her binding to life after death. Tattered robes hang from her form, and although she is lovely in spite of her glowing eyes, you cannot look upon her for long without feeling that you might run from her in fear."
    ],
    arrival: [
      "A nedum vereri just arrived."
    ],
    flee: [],
    death: [],
    decay: [
      "Acid dissolves connecting cartilage, freeing the nedum vereri's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A nedum vereri swings {weapon} at you!"
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
