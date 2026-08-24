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
        as: 102
      },
      {
        name: "Claw",
        as: 102
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
    udf: 98,
    bar_td: 18,
    cle_td: nil,
    emp_td: -11,
    pal_td: nil,
    ran_td: 18,
    sor_td: 18,
    wiz_td: nil,
    mje_td: 18,
    mne_td: 18,
    mjs_td: nil,
    mns_td: 18,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
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
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
