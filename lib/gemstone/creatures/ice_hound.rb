{
  schema_version: 3,
  name: "ice hound",
  noun: "",
  url: "https://gswiki.play.net/ice_hound",
  picture: "",
  level: 24,
  family: "Canine",
  type: "Quadruped",
  undead: false,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 211,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Icemule Trail",
      uids: [4044002..4044019]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 192
      },
      {
        name: "Freezing ball of pure cold",
        as: 171
      }
    ],
    bolt_spells: [
      {
        name: "Major Cold (907)",
        as: 171
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: 117,
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: nil,
    cle_td: nil,
    emp_td: 65,
    pal_td: 72,
    ran_td: nil,
    sor_td: 79,
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
    skin: "an ice hound ear",
    other: nil
  },
  messaging: {
    description: [
      "The ice hound, protected by a long fur coat, is at home in the most frozen areas of the lands. One of the largest breeds of dog, its blue and silver fur blends well with the frozen lakes and rivers. A nasty bite and frosty breath make this canine a very formidable foe. A strange feature of this hound is that its eyes are completely white, giving its gaze a vacant, unfocused look."
    ],
    arrival: [
      "An ice hound arrives leaving puffs of ice crystal clouds in its wake."
    ],
    flee: [],
    death: [
      "The ice hound lets out one last whimpering sigh of frosty mist and dies.",
      "An ice hound goes limp as it is rendered unconscious!"
    ],
    decay: [
      "An ice hound decays into a compost of fur and fangs."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An ice hound hurls {weapon} at you!"
    ],
    bite: [
      "An ice hound tries to bite you!"
    ],
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
