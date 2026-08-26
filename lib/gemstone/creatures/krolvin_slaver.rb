{
  schema_version: 3,
  name: "krolvin slaver",
  noun: "",
  url: "https://gswiki.play.net/krolvin_slaver",
  picture: "",
  level: 36,
  family: "Krolvin",
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
      name: "Shattered Moors",
      uids: [420501..420542]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Scimitar",
        as: (212..230)
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Bind (214)"
      },
      {
        name: "Silence (210)"
      }
    ],
    offensive_spells: [
      {
        name: "Major Elemental Wave (435)"
      },
      {
        name: "Tremors (909)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (164..250),
    ranged: 164,
    bolt: 164,
    udf: (235..259),
    bar_td: (99..117),
    cle_td: (108..117),
    emp_td: (108..117),
    pal_td: (96..105),
    ran_td: nil,
    sor_td: (99..117),
    wiz_td: nil,
    mje_td: 123,
    mne_td: (104..122),
    mjs_td: nil,
    mns_td: (99..117),
    mnm_td: (108..114),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a length of spiked chain",
    "a plain steel scimitar",
    "some double chain armor"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "Although taller than the average krolvin, the slaver retains the characteristic long-fingered hands. His sturdy musculature is apparent beneath the grey-blue skin. Thick, coarse, white hair covers his head and spreads across his shoulders and down his back."
    ],
    arrival: [],
    flee: [
      "A krolvin slaver slinks {direction}."
    ],
    death: [
      "The krolvin slaver's body goes stiff and cold as he dies.",
      "A krolvin slaver goes limp as he is rendered unconscious!"
    ],
    decay: [
      "A krolvin slaver collapses into a pile of dirty rags."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A krolvin slaver swings {weapon} at you!"
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
