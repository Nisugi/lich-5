{
  schema_version: 3,
  name: "giant fog beetle",
  noun: "",
  url: "https://gswiki.play.net/giant_fog_beetle",
  picture: "",
  level: 32,
  family: "Beetle",
  type: "Insect",
  undead: false,
  blood: nil,
  bones: false,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 260,
  speed: nil,
  height: 2,
  size: "large",
  areas: [
    {
      name: "The Broken Lands",
      uids: [306016..306048]
    },
    {
      name: "Greymist Woods",
      uids: [3021001..3021016, 3022001..3022017]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pincer (attack)",
        as: 228
      },
      {
        name: "Pincer",
        as: 208
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Gas cloud"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (195..239),
    ranged: (90..141),
    bolt: (90..141),
    udf: 288,
    bar_td: 97,
    cle_td: nil,
    emp_td: (109..118),
    pal_td: nil,
    ran_td: nil,
    sor_td: 114,
    wiz_td: nil,
    mje_td: 114,
    mne_td: 119,
    mjs_td: 109,
    mns_td: 109,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a fog beetle carapace",
    other: "No"
  },
  messaging: {
    description: [
      "The giant fog beetle appears to be some sort of giant insect. It looks a little like some misshapen scorpion, but the tail on it is not as long as a scorpion's would be, and it flares like the tail of a lobster rather than ending in a poison sting. The segmented body is wide, supported by six short multi-jointed legs. A dull red chitinous shell covers most of its body, and a broad carapace protects its head. Two massive claws provide the creature with formidable weapons."
    ],
    arrival: [],
    flee: [],
    death: [
      "A giant fog beetle goes limp as it is rendered unconscious!"
    ],
    decay: [
      "A giant fog beetle's legs shrivel up beneath it as it decays into dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A giant fog beetle snaps at you with {pronoun} pincer!"
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
