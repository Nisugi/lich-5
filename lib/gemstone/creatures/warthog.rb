{
  schema_version: 3,
  name: "warthog",
  noun: "",
  url: "https://gswiki.play.net/warthog",
  picture: "",
  level: 22,
  family: "Suine",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 270,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Emerald Forest",
      uids: [13301201..13301232, 13301301..13301335]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge (attack)",
        as: 226
      },
      {
        name: "Impale (attack)",
        as: 216
      },
      {
        name: "Charge",
        as: 206
      },
      {
        name: "Tusk",
        as: 208
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Charge"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (90..154),
    ranged: nil,
    bolt: nil,
    udf: 196,
    bar_td: 63,
    cle_td: nil,
    emp_td: (53..74),
    pal_td: nil,
    ran_td: nil,
    sor_td: 66,
    wiz_td: nil,
    mje_td: 69,
    mne_td: 66,
    mjs_td: nil,
    mns_td: 66,
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "a warthog snout",
    other: nil
  },
  messaging: {
    description: [
      "The warthog stands level-backed on short, thick legs. His large, angular head is balanced on each side by curved tusks. Used for goring or gashing his enemies, the tusks provide the warthog's primary means of defense. The warthog's bright, attentive eyes are set back and up on his head. Around the edges of the eyes are rows of warts that give this creature his name. Mainly found living in woods or underground burrows, the warthog prefers dark and damp areas to hide in and to provide him concealment until he rushes out after his prey."
    ],
    arrival: [],
    flee: [],
    death: [
      "The warthog collapses to the ground, emits a final snuffle, and dies.",
      "The warthog lets out a final agonized snuffle and dies."
    ],
    decay: [
      "A warthog decays into a pile of fur and bone.",
      "The warthog's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A warthog charges at you with {pronoun} tusk!",
      "A warthog charges at you!"
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
