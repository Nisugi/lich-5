{
  schema_version: 3,
  name: "tegursh sentry",
  noun: "",
  url: "https://gswiki.play.net/tegursh_sentry",
  picture: "",
  level: 30,
  family: "Tegursh",
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
  max_hp: 368,
  speed: nil,
  height: 7,
  size: "large",
  areas: [
    {
      name: "Sorcerer's Isle",
      uids: [14202001..14202023]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Falchion"
      },
      {
        name: "Jeddart-axe",
        as: (176..225)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Shield Charge"
      },
      {
        name: "Tail Swipe"
      }
    ],
    special_abilities: [
      {
        name: "Tail sweep"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (226..326),
    ranged: 189,
    bolt: 197,
    udf: 336,
    bar_td: 96,
    cle_td: nil,
    emp_td: (111..119),
    pal_td: nil,
    ran_td: nil,
    sor_td: (109..118),
    wiz_td: nil,
    mje_td: 123,
    mne_td: 120,
    mjs_td: 111,
    mns_td: 111,
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
    skin: "a tegursh claw",
    other: nil
  },
  messaging: {
    description: [
      "Taller than a common human and of substantially heavier build, the tegursh sentry is a solid mass of bone and gristle overlaid with bony plates that cover most of his torso, legs, and arms. Beady, black eyes rimmed in red peer out from a twisted, deformed face, clearly orcish but with an elongated snout. The sentry's arms are as thick as tree branches, ending in three incredibly sharp claws. Unlike any orc you have seen, this creature has an armored tail tipped with pointy spikes."
    ],
    arrival: [],
    flee: [],
    death: [
      "A tegursh sentry rasps a final scream and dies.",
      "A tegursh sentry silently rasps a final scream and dies."
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the tegursh sentry's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A tegursh sentry swings {weapon} at you!",
      "A tegursh sentry throws {weapon} at you!"
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
