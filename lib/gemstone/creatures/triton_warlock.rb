{
  schema_version: 3,
  name: "triton warlock",
  noun: "",
  url: "https://gswiki.play.net/triton_warlock",
  picture: "",
  level: 94,
  family: "Triton",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Atoll",
      uids: [7138001..7138015]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Runestaff",
        as: (402..427)
      },
      {
        name: "Claw",
        as: 417
      }
    ],
    bolt_spells: [
      {
        name: "Balefire (713)",
        as: (404..429)
      }
    ],
    warding_spells: [
      {
        name: "Disintegrate (705)",
        cs: (402..438)
      },
      {
        name: "Mind Jolt (706)",
        cs: (402..438)
      },
      {
        name: "Torment (718)",
        cs: (402..438)
      },
      {
        name: "Dark Catalyst (719)",
        cs: (402..438)
      },
      {
        name: "Claw",
        cs: 449
      },
      {
        name: "Twisted soot black runestaff",
        cs: 399
      }
    ],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: (334..496),
    ranged: nil,
    bolt: nil,
    udf: (387..590),
    bar_td: 400,
    cle_td: (391..401),
    emp_td: 409,
    pal_td: nil,
    ran_td: nil,
    sor_td: "410 to 440",
    wiz_td: nil,
    mje_td: 436,
    mne_td: 446,
    mjs_td: nil,
    mns_td: (392..399),
    mnm_td: (393..403),
    defensive_spells: [
      "Spirit Warding I (101)",
      "Spirit Defense (103)",
      "Spirit Warding II (107)",
      "Lesser Shroud (120)",
      "Elemental Defense I (401)",
      "Elemental Defense II (406)",
      "Elemental Defense III (414)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a twisted soot black runestaff capped with a gold-caged crystal drop of water"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "curved black claw",
    other: nil
  },
  messaging: {
    description: [
      "The amphibian visage of a triton warlock gazes out beneath a frayed dark blue robe, her sun-cracked lips curled back into a sneer as she observes the area with slitted, sickly yellow eyes. Her emaciated form leans backwards, leaving her sinewy arms exposed to the elements as they grip tightly to her staff, her green-fleshed knuckles branded in rough runes. Her head rotates at the most minute of changes, nostrils flaring as she murmurs indecipherable incantations to herself in preparation of the unknown."
    ],
    arrival: [
      "A triton warlock arrives, striding forth with her robes trailing behind her.",
      "A triton assassin stalks in silently, his cold eyes gleaming with hatred.",
      "A triton assassin stalks in silently, her cold eyes gleaming with hatred.",
      "A glowing triton warlock just arrived.",
      "A triton warlock just arrived.",
      "An unyielding triton warlock just arrived.",
      "A triton warlock just arrived, limping badly."
    ],
    flee: [
      "A triton warlock limps {direction}.",
      "A triton warlock heads {direction}."
    ],
    death: [
      "The triton warlock gurgles once and goes still, a wrathful look on her face."
    ],
    decay: [
      "Acid dissolves the knee ligaments.  The triton warlock's tibia passes her femur in a very unpleasant manner!"
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A triton warlock points a single golden nail toward you!",
      "A triton warlock swings {weapon} at you!"
    ],
    bite: [],
    claw: [
      "A triton warlock claws at you!"
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
