{
  schema_version: 3,
  name: "grutik savage",
  noun: "",
  url: "https://gswiki.play.net/grutik_savage",
  picture: "",
  level: 27,
  family: "Grutik",
  type: "Biped",
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
  max_hp: 290,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Zaerthu Tunnels",
      uids: [13009001..13009039]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Spear",
        as: (206..230)
      },
      {
        name: "Dart",
        as: 249
      },
      {
        name: "Closed fist",
        as: 200
      },
      {
        name: "Crude stone axe",
        as: 206
      },
      {
        name: "Crude wooden club",
        as: 215
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
    asg: "5N",
    immunities: [],
    melee: (273..306),
    ranged: nil,
    bolt: 167,
    udf: 300,
    bar_td: 81,
    cle_td: (81..90),
    emp_td: (88..96),
    pal_td: nil,
    ran_td: nil,
    sor_td: 92,
    wiz_td: 96,
    mje_td: 96,
    mne_td: 96,
    mjs_td: 88,
    mns_td: (82..91),
    mnm_td: (81..84),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a crude stone axe",
    "a crude wooden club",
    "a crude wooden shield",
    "a crude wooden spear",
    "some crude leather armor"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Glimmering blue essence shard"
  },
  messaging: {
    description: [
      "This misshapen humanoid has large luminous eyes from many years of living underground. It's dressed in scraps of leather armor and odd bits of mismatched clothing, apparently scavenged from various sources. The flesh you can see underneath is mostly grey though well muscled."
    ],
    arrival: [
      "A Grutik savage shambles in."
    ],
    flee: [],
    death: [
      "A Grutik savage goes limp as he is rendered unconscious!"
    ],
    decay: [
      "A Grutik savage collapses into a lifeless heap upon the ground.",
      "A Grutik savage's body turns to dust.",
      "Acid dissolves connecting cartilage, freeing the Grutik savage's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A Grutik savage swings {weapon} at you!",
      "A Grutik savage thrusts with a crude wooden spear at you!"
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
