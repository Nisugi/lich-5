{
  schema_version: 3,
  name: "spotted lynx",
  noun: "",
  url: "https://gswiki.play.net/spotted_lynx",
  picture: "",
  level: 6,
  family: "Feline",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 68,
  speed: nil,
  height: 2,
  size: "small",
  areas: [
    {
      name: "Yander's Farm",
      uids: [14005023..14005025, 14005027..14005036]
    },
    {
      name: "Ocoma Vale",
      uids: [4300001..4300025]
    },
    {
      name: "Central Caravansary",
      uids: [4748310..4748312, 4748321..4748321]
    },
    {
      name: "unmapped",
      uids: [4748313..4748320]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 92
      },
      {
        name: "Charge",
        as: (92..102)
      },
      {
        name: "Claw",
        as: (91..102)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Pounce"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: (37..77),
    ranged: 41,
    bolt: 41,
    udf: (66..98),
    bar_td: 18,
    cle_td: 18,
    emp_td: 18,
    pal_td: (15..18),
    ran_td: 18,
    sor_td: 18,
    wiz_td: nil,
    mje_td: 18,
    mne_td: 18,
    mjs_td: nil,
    mns_td: 18,
    mnm_td: 18,
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
    skin: "a lynx pelt",
    other: nil
  },
  messaging: {
    description: [
      "The medium-sized lynx possesses a lush coat, greyish-white marked with a pattern of black spots and a dark dorsal stripe. Black tufts top both of the lynx's large ears and her jaws sport long whiskery fur, giving the animals a mischievous look. Her black-tipped tail is only a few inches long and it whips back and forth nervously as the lynx moves."
    ],
    arrival: [],
    flee: [
      "A spotted lynx darts {direction}."
    ],
    death: [
      "The spotted lynx crumples to the ground and dies.",
      "The spotted lynx lets out a final caterwaul and dies.",
      "The spotted lynx mewls in pain as he slumps to the ground and licks his wounded left foreleg.",
      "The spotted lynx mewls in pain as he slumps to the ground and licks his wounded left paw.",
      "The spotted lynx mewls in pain as he slumps to the ground and licks his wounded right foreleg.",
      "The spotted lynx mewls in pain as she slumps to the ground and licks her wounded right foreleg.",
      "The spotted lynx mewls in pain as she slumps to the ground and licks her wounded left paw.",
      "The spotted lynx mewls in pain as she slumps to the ground and licks her wounded right paw."
    ],
    decay: [
      "A spotted lynx decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A spotted lynx charges at you!"
    ],
    bite: [],
    claw: [
      "A spotted lynx claws at you!"
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
