{
  schema_version: 3,
  name: "cave troll",
  noun: "",
  url: "https://gswiki.play.net/cave_troll",
  picture: "",
  level: 16,
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
  max_hp: 150,
  speed: nil,
  height: 10,
  size: "medium",
  areas: [
    {
      name: "Hidden Vale",
      uids: [36001..36005]
    },
    {
      name: "Vornavian Coast",
      uids: [4202161..4202180]
    },
    {
      name: "Upper Trollfang",
      uids: [14032..14043, 14052..14060, 17020..17028, 17101..17115]
    },
    {
      name: "Crystal Caves",
      uids: [24019..24057]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Short sword",
        as: 191
      },
      {
        name: "Spear",
        as: 191
      },
      {
        name: "Pitted battle axe",
        as: 191
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
    asg: "11N",
    immunities: [],
    melee: (104..105),
    ranged: (97..100),
    bolt: (97..100),
    udf: nil,
    bar_td: nil,
    cle_td: 63,
    emp_td: 44,
    pal_td: nil,
    ran_td: nil,
    sor_td: 59,
    wiz_td: nil,
    mje_td: 55,
    mne_td: 63,
    mjs_td: 63,
    mns_td: 63,
    mnm_td: nil,
    defensive_spells: [
      "Spirit Warding II (107)"
    ],
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
    skin: "a troll skin",
    other: nil
  },
  messaging: {
    description: [
      "Huge and dangerous, the cave troll towers above even a tall giantman. Grey skin so thick that it serves quite well as armor covers most of the troll, with tufts of thick hair sprouting here and there like weeds between cracked stones. A hideous grin splits its face displaying fangs crusted with dried blood and less guessable matter. No light of intellect glows in its narrow piggish eyes. The lust for slaughter and thirst for blood are what drive this hulkish beast's existence."
    ],
    arrival: [],
    flee: [
      "A cave troll lumbers {direction}."
    ],
    death: [
      "The cave troll falls to the ground and dies.",
      "The cave troll screams one last time and dies."
    ],
    decay: [
      "A cave troll decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A cave troll swings {weapon} at you!",
      "A cave troll thrusts with a spear at you!"
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
