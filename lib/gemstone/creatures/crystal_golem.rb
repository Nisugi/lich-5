{
  schema_version: 3,
  name: "crystal golem",
  noun: "",
  url: "https://gswiki.play.net/crystal_golem",
  picture: "",
  level: 12,
  family: "Golem",
  type: "Biped",
  undead: false,
  blood: false,
  bones: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Magical"
  ],
  bcs: true,
  max_hp: 140,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Crystal Caves",
      uids: [24058..24064]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Ensnare",
        as: 140
      },
      {
        name: "Pound",
        as: 134
      },
      {
        name: "Stomp",
        as: 144
      },
      {
        name: "Crystalline fist",
        as: 117
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Foot stomp"
      },
      {
        name: "Ground Slam"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "14N",
    immunities: [],
    melee: (60..130),
    ranged: nil,
    bolt: 60,
    udf: 136,
    bar_td: nil,
    cle_td: nil,
    emp_td: nil,
    pal_td: nil,
    ran_td: nil,
    sor_td: (30..42),
    wiz_td: nil,
    mje_td: (30..42),
    mne_td: (30..42),
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "a crystal core"
  },
  messaging: {
    description: [
      "Towering about three yards tall, a crystal golem's form is nothing short of massive. Deeply set fires glimmer coldly from its eye sockets, throwing a myriad of colors throughout the large crystal spikes jutting sharply away from its thick crystalline skin. As it moves, the rainbow color flickers through the facets of its body in a dizzying array of color."
    ],
    arrival: [
      "A gnoll ranger wanders in, alertly surveying its surroundings.",
      "A crystal golem stomps in, fiery eyes the only clue to its deadly intent."
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A crystal golem pounds at you with {pronoun} crystalline fist!",
      "A crystal golem tries to ensnare you in {pronoun} thick arms!"
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
