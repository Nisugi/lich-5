{
  schema_version: 3,
  name: "war troll",
  noun: "",
  url: "https://gswiki.play.net/war_troll",
  picture: "",
  level: 18,
  family: "Troll",
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
  max_hp: 230,
  speed: nil,
  height: 10,
  size: "large",
  areas: [
    {
      name: "Upper Trollfang",
      uids: [14001..14005, 14010..14020, 17102..17118]
    },
    {
      name: "Slope",
      uids: [395017..395051]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Two-handed sword"
      },
      {
        name: "War hammer",
        as: 175
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Attack strength boost"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "various",
    immunities: [],
    melee: (61..66),
    ranged: (61..76),
    bolt: (61..76),
    udf: 118,
    bar_td: nil,
    cle_td: 69,
    emp_td: 69,
    pal_td: (66..69),
    ran_td: 54,
    sor_td: 65,
    wiz_td: nil,
    mje_td: (61..69),
    mne_td: (61..69),
    mjs_td: nil,
    mns_td: 42,
    mnm_td: (54..61),
    defensive_spells: [
      "Spirit Warding II (107)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: "Health regeneration",
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a troll heart",
    other: nil
  },
  messaging: {
    description: [
      "Huge and dangerous, the war troll towers above even a tall giantman. Grey skin so thick that it serves quite well as armor covers most of the troll, with tufts of thick hair sprouting here and there like weeds between cracked stones. A hideous grin splits its face displaying fangs crusted with dried blood and less guessable matter. No light of intellect glows in its narrow piggish eyes. The lust for slaughter and thirst for blood are what drive this hulkish beast's existence.\n\nAppraisal:\nThe war troll is large in size, about ten feet high in his current state, appears to be of hardy constitution, is in an offensive stance, and is in relatively good shape."
    ],
    arrival: [],
    flee: [],
    death: [
      "The war troll falls to the ground and dies.",
      "The war troll screams one last time and dies."
    ],
    decay: [
      "A war troll decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A war troll swings {weapon} at you!"
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
