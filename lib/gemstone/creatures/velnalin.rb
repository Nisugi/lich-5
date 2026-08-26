{
  schema_version: 3,
  name: "velnalin",
  noun: "",
  url: "https://gswiki.play.net/velnalin",
  picture: "",
  level: 3,
  family: "Deer",
  type: "Quadruped",
  undead: false,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 44,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Lower Dragonsclaw",
      uids: [9028..9041, 9065..9068, 9070..9071]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (48..61)
      },
      {
        name: "Charge",
        as: (61..71)
      },
      {
        name: "Stomp",
        as: 61
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
    asg: "1N",
    immunities: [],
    melee: (17..41),
    ranged: (4..14),
    bolt: 13,
    udf: 66,
    bar_td: nil,
    cle_td: 9,
    emp_td: 9,
    pal_td: (6..9),
    ran_td: 9,
    sor_td: 9,
    wiz_td: nil,
    mje_td: 9,
    mne_td: 9,
    mjs_td: nil,
    mns_td: 9,
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
    skin: "a velnalin hide",
    other: "No"
  },
  messaging: {
    description: [
      "Graceful as an antelope, this member of the deer family stands proud and fierce before you. The velnalin is covered with thick mottled brown and white fur, and from his head, long, straight horns the length of a good sword taper to points that glimmer like hard, polished bone. The beast moves like quicksilver as he brings his formidable weapons to bear."
    ],
    arrival: [],
    flee: [],
    death: [
      "The velnalin collapses to the ground, emits a final sigh, and dies.",
      "The velnalin lets out a final agonized sigh and dies.",
      "The velnalin collapses to the ground, emits a final silent sigh, and dies.",
      "The velnalin groans loudly as she slumps to the ground and cradles her wounded right foreleg.",
      "The velnalin groans loudly as he slumps to the ground and cradles his wounded left foreleg.",
      "The velnalin groans loudly as she slumps to the ground and cradles her wounded left foreleg.",
      "The velnalin groans loudly as he slumps to the ground and cradles his wounded right foreleg."
    ],
    decay: [
      "A velnalin decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A velnalin charges at you!"
    ],
    bite: [
      "A velnalin tries to bite you!"
    ],
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
