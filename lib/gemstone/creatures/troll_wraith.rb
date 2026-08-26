{
  schema_version: 3,
  name: "troll wraith",
  noun: "",
  url: "https://gswiki.play.net/troll_wraith",
  picture: "",
  level: 35,
  family: "Troll",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Non-corporeal undead",
    "Boss"
  ],
  bcs: nil,
  max_hp: nil,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Troll Burial Grounds",
      uids: [13011001..13011035]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (214..215)
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
    asg: nil,
    immunities: [],
    melee: (154..260),
    ranged: 118,
    bolt: 105,
    udf: (279..311),
    bar_td: (118..123),
    cle_td: (129..139),
    emp_td: (130..136),
    pal_td: (109..119),
    ran_td: nil,
    sor_td: (139..142),
    wiz_td: nil,
    mje_td: 148,
    mne_td: (143..148),
    mjs_td: nil,
    mns_td: (132..141),
    mnm_td: (119..128),
    defensive_spells: [
      "Elemental Defense I (401)",
      "Elemental Defense III (414)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "some blackened steel gauntlets"
  ],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: "Glowing Violet Essence Dust,"
  },
  messaging: {
    description: [
      "A sickly, ebony mist encircles the troll wraith, obscuring the entire lower portion of the wraith, if there was one. Brilliant, platinum-hued orbs suspend in the air where the wraith's eyes once resided. The only true evidence of the wraith's former life are remnants of blackened steel gauntlets protecting the hands with only a few boney fingers being exposed."
    ],
    arrival: [],
    flee: [
      "A troll wraith drifts {direction}."
    ],
    death: [
      "The troll wraith goes still for a moment while its head reshapes.",
      "A troll wraith slumps to the ground, lying completely motionless.  A last minute twitch causes the wraith's arm to spasm up into the air before falling limply back to her side.",
      "A troll wraith slumps to the ground, lying completely motionless.  A last minute twitch causes the wraith's arm to spasm up into the air before falling limply back to his side."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [],
    claw: [
      "A troll wraith claws at you!"
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
