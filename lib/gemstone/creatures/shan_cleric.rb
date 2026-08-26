{
  schema_version: 3,
  name: "shan cleric",
  noun: "",
  url: "https://gswiki.play.net/shan_cleric",
  picture: "",
  level: 42,
  family: "Shan",
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
  max_hp: 240,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4218301..4218325]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Morning star",
        as: 212
      },
      {
        name: "Spiked holy-water sprinkler",
        as: 307
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Bind (214)",
        cs: 209
      }
    ],
    offensive_spells: [
      {
        name: "Spirit Strike (117)"
      }
    ],
    maneuvers: [
      {
        name: "Disarm"
      },
      {
        name: "Web"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8",
    immunities: [],
    melee: (273..352),
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: (116..157),
    cle_td: (160..170),
    emp_td: (159..169),
    pal_td: nil,
    ran_td: nil,
    sor_td: (170..180),
    wiz_td: nil,
    mje_td: 177,
    mne_td: 182,
    mjs_td: nil,
    mns_td: (159..169),
    mnm_td: 172,
    defensive_spells: [
      "Lesser Shroud (120)",
      "Prayer (313)",
      "Spirit Defense (103)",
      "Spirit Warding I (101)",
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
    magic_items: nil,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Tiny golden seed"
  },
  messaging: {
    description: [
      "The shan cleric stands in a half-crouch, her long, knotty legs giving her that lanky, dangerous look of a wolf. Walking upright, the body covered with mottled grey fur and her long arms conclude in large, clawed hands with semi-opposable thumbs. The shan cleric's dog-like visage is fierce, with slavering jaws and eyes that glow like something out of a bad dream."
    ],
    arrival: [],
    flee: [],
    death: [
      "The shan cleric howls out one last time and dies.",
      "The shan cleric yips in pain as she falls to the ground motionless.",
      "The shan cleric yips in pain as he falls to the ground motionless.",
      "A shan cleric's body shimmers slightly.  Suddenly, his features cave in, falling grotesquely into a haunting visage of decay, before abruptly fraying to a pile of fur and fangs that marks the spot of his death like a silhouette.",
      "A shan cleric's body shimmers slightly.  Suddenly, her features cave in, falling grotesquely into a haunting visage of decay, before abruptly fraying to a pile of fur and fangs that marks the spot of her death like a silhouette."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A shan cleric swings {weapon} at you!"
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
