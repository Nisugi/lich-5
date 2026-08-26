{
  schema_version: 3,
  name: "storm griffin",
  noun: "",
  url: "https://gswiki.play.net/storm_griffin",
  picture: "",
  level: 73,
  family: "Griffin",
  type: "Hybrid",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Magical"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 5,
  size: "large",
  areas: [
    {
      name: "Griffin's Keen",
      uids: [13302101..13302142]
    },
    {
      name: "Stormpeak",
      uids: [13150301..13150322]
    },
    {
      name: "unmapped",
      uids: [13150323..13150324]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (338..368)
      },
      {
        name: "Impale",
        as: 358
      },
      {
        name: "Bite",
        as: (327..358)
      },
      {
        name: "Swoop",
        as: 368
      }
    ],
    bolt_spells: [
      {
        name: "Major Shock (910)",
        as: 321
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Call Wind (912)"
      },
      {
        name: "Lightning mote"
      },
      {
        name: "Screech"
      }
    ],
    maneuvers: [
      {
        name: "Wing Buffet"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: 264,
    ranged: nil,
    bolt: 263,
    udf: nil,
    bar_td: nil,
    cle_td: (287..293),
    emp_td: 288,
    pal_td: (242..251),
    ran_td: nil,
    sor_td: (297..315),
    wiz_td: nil,
    mje_td: 314,
    mne_td: nil,
    mjs_td: nil,
    mns_td: 279,
    mnm_td: (234..243),
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
    magic_items: nil,
    gems: true,
    boxes: false,
    skin: "soft blue griffin feather",
    other: nil
  },
  messaging: {
    description: [
      "The storm griffin is a magnificent beast, as if designed by the gods to embody fierce and graceful predation. Its front legs, forebody, wings, and head are those of a great eagle, complete with large powder-blue feathers and aquiline beak. The rear half of the creature's body is that of a powerful lion, with short, sandy blonde fur and a long feline tail. A tendril of electricity snakes across one outstreched claw as the storm griffin glares about with its piercing blue eyes."
    ],
    arrival: [
      "A storm griffin just arrived."
    ],
    flee: [],
    death: [
      "A storm griffin goes limp as it is rendered unconscious!",
      "The storm griffin writhes in agony, its wings flapping fruitlessly as it dies.",
      "The storm griffin crashes to the ground, motionless."
    ],
    decay: [
      "The storm griffin decays into a pile of feathers and fur."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A storm griffin rakes at you with a razor-sharp claw!"
    ],
    bite: [
      "A storm griffin tries to bite you!"
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
