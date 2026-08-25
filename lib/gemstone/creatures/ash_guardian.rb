{
  schema_version: 3,
  name: "ash guardian",
  noun: "",
  url: "https://gswiki.play.net/ash_guardian",
  picture: "",
  level: 87,
  family: "elemental",
  type: "Biped",
  undead: false,
  blood: false,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Element-based"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 8,
  size: "medium",
  areas: [
    {
      name: "Volcanic Flats",
      uids: [3023107..3023123]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Falchion",
        as: 402
      },
      {
        name: "Ensnare",
        as: 346
      },
      {
        name: "Jagged shard of obsidian",
        as: 406
      },
      {
        name: "Sharp beak",
        as: 295
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Feint"
      },
      {
        name: "Dirtkick"
      },
      {
        name: "Shield Bash"
      },
      {
        name: "Dust Kick"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (241..494),
    ranged: nil,
    bolt: nil,
    udf: 616,
    bar_td: nil,
    cle_td: 342,
    emp_td: (336..342),
    pal_td: nil,
    ran_td: nil,
    sor_td: (370..397),
    wiz_td: nil,
    mje_td: 390,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: "Guards any phoenix killed in the room as it attempts its rebirth",
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "No",
    other: nil
  },
  messaging: {
    description: [
      "Distinct features are difficult to determine as clouds of ash obscure the form of the ash guardian. What is visible is a towering humanoid shadow that drifts through the ash clouds."
    ],
    arrival: [
      "A firebird flies in, a trail of flame behind it."
    ],
    flee: [],
    death: [],
    decay: [
      "The form of an ash guardian dissolves into the surroundings."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A firebird cranes ash guardian neck, snapping at you with ash guardian sharp beak!",
      "An ash guardian swings {weapon} at you!",
      "An ash guardian tries to ensnare you!",
      "In a trail of flames, a firebird extends ash guardian fearsome talons as it dives at you!"
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
