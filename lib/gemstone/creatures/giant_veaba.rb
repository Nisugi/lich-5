{
  schema_version: 3,
  name: "giant veaba",
  noun: "",
  url: "https://gswiki.play.net/giant_veaba",
  picture: "",
  level: 17,
  family: "Veaba",
  type: "Crustacean",
  undead: false,
  blood: true,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 160,
  speed: nil,
  height: 1,
  size: "medium",
  areas: [
    {
      name: "Czeroth Caverns",
      uids: [13007001..13007043]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 178
      },
      {
        name: "Claw",
        as: 189
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Charge"
      },
      {
        name: "Rear"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (147..314),
    ranged: nil,
    bolt: 142,
    udf: 318,
    bar_td: 51,
    cle_td: (75..81),
    emp_td: 75,
    pal_td: (72..75),
    ran_td: nil,
    sor_td: (45..51),
    wiz_td: nil,
    mje_td: (75..78),
    mne_td: 51,
    mjs_td: nil,
    mns_td: (75..78),
    mnm_td: 75,
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
    skin: "a veaba claw",
    other: nil
  },
  messaging: {
    description: [
      "The flattened body of the giant veaba is divided into a head and trunk comprised of several segments. Pairs of legs, too numerous to count, flank each segment of the body. Just below a gaping maw, two appendages of the first segment have large claws that are equipped with poison glands. Long antennae extend from the eyeless head."
    ],
    arrival: [
      "A giant veaba crawls in, its antennae waving with curiousity.",
      "A giant veaba crawls in, low on the ground."
    ],
    flee: [
      "A giant veaba crawls {direction} in pain."
    ],
    death: [
      "A giant veaba shudders violently as it dies.",
      "A giant veaba dies in a squirming, quivering heap.",
      "A giant veaba dies; vitreous fluids escape its body.",
      "A giant veaba slumps to the ground unconscious."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A giant veaba tries to bite you!"
    ],
    claw: [
      "A giant veaba claws at you!"
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
