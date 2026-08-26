{
  schema_version: 3,
  name: "firebird",
  noun: "",
  url: "https://gswiki.play.net/firebird",
  picture: "",
  level: 85,
  family: "Bird",
  type: "Avian",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living",
    "Element-based",
    "Magical"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 6,
  size: "large",
  areas: [
    {
      name: "Volcanic Flats",
      uids: [3023107..3023123]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw (attack)",
        as: (288..385)
      },
      {
        name: "Bite (attack)",
        as: 375
      },
      {
        name: "Impale (attack)",
        as: 380
      },
      {
        name: "Beak",
        as: 375
      },
      {
        name: "Roaring ball of fire",
        as: 302
      },
      {
        name: "Sharp beak",
        as: 381
      },
      {
        name: "Stream of fire",
        as: 322
      }
    ],
    bolt_spells: [
      {
        name: "Major Fire (908)",
        as: 302
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Wing Buffet"
      },
      {
        name: "Screech"
      },
      {
        name: "Fire Mote"
      },
      {
        name: "Drop"
      },
      {
        name: "Fire flares"
      },
      {
        name: "Dive"
      },
      {
        name: "Ethereal Wave"
      },
      {
        name: "Shield Bash"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: nil,
    ranged: nil,
    bolt: nil,
    udf: (463..467),
    bar_td: nil,
    cle_td: (341..344),
    emp_td: (328..337),
    pal_td: (298..307),
    ran_td: nil,
    sor_td: (359..368),
    wiz_td: nil,
    mje_td: 378,
    mne_td: nil,
    mjs_td: nil,
    mns_td: 333,
    mnm_td: (255..258),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: "Flying",
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: true,
    boxes: nil,
    skin: "a red firebird feather",
    other: nil
  },
  messaging: {
    description: [
      "Smoldering black eyes and a sharp golden beak display the fury of the firebird. A golden crest of feathers adorn the head of this large but nimble avian that continues down its long craning neck, transitioning to orange around its sleek body, then deep red along its narrow legs that end in wickedly sharp black talons. Flames dance from the firebird's wide arcing wings that leave a trail with its long tail feathers in its wake."
    ],
    arrival: [
      "A firebird flies in, a trail of flame behind it.",
      "A firebird flies in, struggling to flap its flaming wings."
    ],
    flee: [
      "A firebird struggles to flap its flaming wings as it flies {direction}.",
      "A firebird leaves a trail of flame as it flies {direction}.",
      "The firebird flaps its great flaming wings as it retreats upwards into the air."
    ],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A firebird cranes firebird neck, snapping at you with firebird sharp beak!",
      "A firebird hurls {weapon} at you!",
      "A firebird tries to spear you with firebird beak!",
      "In a trail of flames, a firebird extends firebird fearsome talons as it dives at you!",
      "A firebird rakes at you with a razor-sharp claw!"
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
