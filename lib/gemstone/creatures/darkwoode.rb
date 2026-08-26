{
  schema_version: 3,
  name: "darkwoode",
  noun: "",
  url: "https://gswiki.play.net/darkwoode",
  picture: "",
  level: 13,
  family: "Tree",
  type: "Plantlife",
  undead: true,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 120,
  speed: "5",
  height: 8,
  size: "large",
  areas: [
    {
      name: "The Toadwort",
      uids: [14007024..14007031]
    },
    {
      name: "Upper Trollfang",
      uids: [16036..16044]
    },
    {
      name: "Vornavian Coast",
      uids: [4218201..4218221]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: 127
      },
      {
        name: "Ensnare",
        as: 137
      }
    ],
    bolt_spells: [
      {
        name: "Minor Water (903)",
        as: 125
      },
      {
        name: "Major Shock (910)",
        as: 125
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Call Wind (912)"
      },
      {
        name: "Tremors (909)"
      }
    ],
    maneuvers: [
      {
        name: "Mystic Gesture"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "7N",
    immunities: [],
    melee: (63..142),
    ranged: (52..63),
    bolt: (52..63),
    udf: (86..175),
    bar_td: 39,
    cle_td: 39,
    emp_td: 39,
    pal_td: (36..39),
    ran_td: 39,
    sor_td: 39,
    wiz_td: nil,
    mje_td: 39,
    mne_td: 39,
    mjs_td: 39,
    mns_td: 39,
    mnm_td: 39,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a wooden shield"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "No"
  },
  messaging: {
    description: [
      "A skeletal tree-trunk with long straggling branches, the darkwoode holds the unliving force of a once sentient tree-spirit. An unfelt breeze seems to stir the dead and decaying leaves that still cling to it, giving it a travesty of the beauty it once held as a living tree. Given its original form long ago to protect sacred groves, it remains now, warped and twisted, yet still attempting to carry out the duties it failed in long ago."
    ],
    arrival: [
      "A darkwoode just arrived."
    ],
    flee: [
      "A darkwoode runs {direction}."
    ],
    death: [
      "The darkwoode slowly settles to the ground and begins to dissipate."
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the darkwoode's ribs to move independently.",
      "The darkwoode's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A darkwoode gestures at you!",
      "A darkwoode tries to ensnare you!"
    ],
    bite: [],
    claw: [
      "A darkwoode claws at you!"
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
