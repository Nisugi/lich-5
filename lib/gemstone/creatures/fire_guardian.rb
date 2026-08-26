{
  schema_version: 3,
  name: "fire guardian",
  noun: "",
  url: "https://gswiki.play.net/fire_guardian",
  picture: "",
  level: 16,
  family: "Elemental",
  type: "Biped",
  undead: false,
  blood: false,
  bones: false,
  witherable: false,
  sympathy: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Element-based"
  ],
  bcs: true,
  max_hp: 140,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Glatoph",
      uids: [35010..35024]
    },
    {
      name: "Vornavian Coast",
      uids: [4202301..4202320]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Closed fist",
        as: 152
      },
      {
        name: "Ensnare (attack)",
        as: 152
      },
      {
        name: "Charge (attack)",
        as: 152
      }
    ],
    bolt_spells: [
      {
        name: "Minor Fire (906)",
        as: 124
      },
      {
        name: "Major Fire (908)",
        as: 124
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "7N",
    immunities: [],
    melee: (37..51),
    ranged: 37,
    bolt: 37,
    udf: 67,
    bar_td: nil,
    cle_td: 48,
    emp_td: 48,
    pal_td: nil,
    ran_td: nil,
    sor_td: 48,
    wiz_td: nil,
    mje_td: 48,
    mne_td: 48,
    mjs_td: nil,
    mns_td: 48,
    mnm_td: 48,
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
    other: "Essence of fire"
  },
  messaging: {
    description: [
      "A towering mass of flame and smoke formed into a caricature of a living being, the fire guardian is awesome to behold. The fumes of endless burning and the fierce heat serve this foul thing as well as any armor made by mortal; and the power of its flame has fused even the finest vultite shields to the hands of their wearers and turned mighty swords into dripping stubs of molten alloy."
    ],
    arrival: [],
    flee: [],
    death: [
      "The fire guardian falls to the ground motionless.",
      "The fire guardian screams evilly one last time and goes still."
    ],
    decay: [
      "A fire guardian turns to dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A fire guardian gestures at you!"
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
