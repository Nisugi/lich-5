{
  schema_version: 3,
  name: "mongrel troll",
  noun: "",
  url: "https://gswiki.play.net/mongrel_troll",
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
  max_hp: 190,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4214101..4214115]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Spear",
        as: 167
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
    melee: (81..100),
    ranged: (87..109),
    bolt: (87..109),
    udf: 133,
    bar_td: 55,
    cle_td: nil,
    emp_td: 44,
    pal_td: nil,
    ran_td: nil,
    sor_td: 59,
    wiz_td: nil,
    mje_td: 55,
    mne_td: 55,
    mjs_td: nil,
    mns_td: nil,
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
    skin: "a chipped troll tusk",
    other: "Small troll tooth"
  },
  messaging: {
    description: [
      "The mongrel troll is a repulsive combination of troll and some other lesser creature, if there could be a creature considered lower on the scale of life than a troll. Loathesome and hideous, the mongrel troll would tower above you if its bent, crooked spine didn't force it to hunch over. Mottled grey and brown skin so lumpy and loose, that it doesn't so much cover the troll, but sags loosely over from the troll's frame. Tufts of thick black hair sprout over the skin like a series of ill placed shrubs. A hideously toothy grin spreads across the troll's face displaying misshapen fangs crusted with dried blood. No spark of intellect fires in its narrow piggish eyes."
    ],
    arrival: [
      "A mongrel troll just arrived!",
      "A mongrel troll shambles in!",
      "A mongrel troll just arrived, limping in!"
    ],
    flee: [],
    death: [
      "The mongrel troll twitches violently, then dies.",
      "The mongrel troll whimpers pitifully one last time and dies."
    ],
    decay: [
      "A mongrel troll decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A mongrel troll thrusts with a spear at you!"
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
