{
  schema_version: 3,
  name: "steel golem",
  noun: "",
  url: "https://gswiki.play.net/steel_golem",
  picture: "",
  level: 20,
  family: "Golem",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: nil,
  witherable: false,
  sympathy: false,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 190,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Glatoph",
      uids: [35041..35067]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Ensnare",
        as: (168..178)
      },
      {
        name: "Pound",
        as: 188
      },
      {
        name: "Stomp",
        as: 198
      },
      {
        name: "Metallic hand",
        as: 169
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Twin Hammerfists"
      },
      {
        name: "Ground Slam"
      }
    ],
    special_abilities: [
      {
        name: "Foot slam"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "19N",
    immunities: [],
    melee: (65..208),
    ranged: (65..97),
    bolt: (65..97),
    udf: (125..194),
    bar_td: nil,
    cle_td: (54..60),
    emp_td: nil,
    pal_td: (57..60),
    ran_td: (54..63),
    sor_td: (55..67),
    wiz_td: nil,
    mje_td: (56..68),
    mne_td: (57..69),
    mjs_td: nil,
    mns_td: (54..60),
    mnm_td: (60..63),
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
    skin: "No",
    other: "crystal core (alchemy)"
  },
  messaging: {
    description: [
      "The squeal of rusty gears and the shriek of cracked pipes expelling steam is nearly deafening, but the sharp sound of a steel golem's claws rhythmically sharpening themselves against each other still grate distinctly throughout the area. Thick plates of armor cover the golem, but nothing could hide the mass of mechanized motion underneath. In a horrifying mimicry of life, a lining of sharp steel teeth are embedded within its large jaw, just underneath eye sockets that slowly expel a stream of black smoke."
    ],
    arrival: [
      "A steel golem arrives, emitting a horrible screeching noise.",
      "A steel golem strides in, head swiveling and gears twirling rapidly."
    ],
    flee: [],
    death: [
      "A steel golem freezes completely before falling to the floor in pieces."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A steel golem pounds at you with steel golem metallic hand!",
      "A steel golem pounds at you with {pronoun} metallic hand!",
      "The gears of a steel golem spin viciously as it tries to ensnare you!"
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
