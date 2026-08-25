{
  schema_version: 3,
  name: "troll chieftain",
  noun: "",
  url: "https://gswiki.play.net/troll_chieftain",
  picture: "",
  level: 27,
  family: "Troll",
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
  max_hp: nil,
  speed: nil,
  height: 8,
  size: "large",
  areas: [
    {
      name: "Hidden Vale",
      uids: [40001..40013, 40020..40020]
    },
    {
      name: "unmapped",
      uids: [40014..40019]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Battle axe",
        as: 270
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
    asg: "13",
    immunities: [],
    melee: 96,
    ranged: nil,
    bolt: 89,
    udf: nil,
    bar_td: nil,
    cle_td: 96,
    emp_td: (88..96),
    pal_td: nil,
    ran_td: nil,
    sor_td: 92,
    wiz_td: nil,
    mje_td: nil,
    mne_td: 88,
    mjs_td: nil,
    mns_td: 96,
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
    skin: "troll fang",
    other: nil
  },
  messaging: {
    description: [
      "Similar to most trolls, the grey muscular body of the troll chieftain displays immense strength from head to toe. It is different from its lesser-ranked brethren in two respects, however. First, there is a glimmer of intelligence in its small, close-set, pink eyes. Second, two long, inflamed scars run from its chest, down its forearms, to end at its elbows. These signify the testing the troll shamans have put the troll chieftain through to ensure it is qualified for its rank. It is rumored that no one ever again sees those that do not qualify."
    ],
    arrival: [
      "A troll chieftain just arrived!",
      "A troll chieftain just arrived."
    ],
    flee: [],
    death: [
      "The troll chieftain bellows in rage one last time and dies."
    ],
    decay: [
      "A troll chieftain decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A troll chieftain swings {weapon} at you!"
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
