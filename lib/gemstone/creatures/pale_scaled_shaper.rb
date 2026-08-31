{
  schema_version: 3,
  name: "pale scaled shaper",
  noun: "",
  url: "https://gswiki.play.net/pale_scaled_shaper",
  picture: "",
  level: 102,
  family: "Humanoid",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: true,
  muggable: nil,
  sleepable: false,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 265,
  speed: 8,
  height: 7,
  size: "medium",
  areas: [
    {
      name: "Shadow of the Sanctum",
      uids: [4216001..4216049]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Major Fire"
      },
      {
        name: "Long acacia runestaff",
        as: 517
      }
    ],
    warding_spells: [
      {
        name: "Disintegrate",
        cs: 353
      },
      {
        name: "Cloak of Shadows",
        cs: 431
      },
      {
        name: "Long acacia runestaff",
        cs: 445
      }
    ],
    offensive_spells: [
      {
        name: "Gas cloud"
      },
      {
        name: "Major Elemental Wave"
      },
      {
        name: "Spiritual Abolition"
      },
      {
        name: "Condemn"
      }
    ],
    maneuvers: [
      {
        name: "Skeletal Finger"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "1",
    immunities: [],
    melee: "555+",
    ranged: (429..630),
    bolt: (431..630),
    udf: (698..699),
    bar_td: nil,
    cle_td: 441,
    emp_td: (432..442),
    pal_td: 349,
    ran_td: 368,
    sor_td: nil,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Spirit Warding I",
      "Spirit Warding II",
      "Lesser Shroud",
      "Cloak of Shadows",
      "Spirit Shield",
      "Bravery",
      "Thurfel's Ward"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: "Summons sidewinder cobras",
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a long acacia runestaff capped with a carved ivory serpent",
    "some pallid robes"
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
      "A pale scaled shaper is far taller than a woman ought to be, with a stretched appearance like that of a doll tugged by battling children. That is, if she is even female: the pale robes that she wears, with their faint appliqued patterns of winking copper scales, betray only the most suggestive promise of a feminine form beneath. There is something upsettingly inhuman about the shaper's face, which has the shape and proportions of a human's, but eyes that glow like green embers and a dusting of ridged scales on its cheeks and brow."
    ],
    arrival: [
      "A pale scaled shaper just arrived."
    ],
    flee: [],
    death: [
      "A spectral howl echoes through the air, resonant with pain and anguish, and then fades into heavy silence.  The scaly veneer covering a pale scaled shaper shimmers briefly before melting into his skin.",
      "A spectral howl echoes through the air, resonant with pain and anguish, and then fades into heavy silence.  The scaly veneer covering a pale scaled shaper shimmers briefly before melting into her skin."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A pale scaled shaper smirks, flicking a skeletal finger toward you!",
      "With serpentine speed, a pale scaled shaper swings {weapon} at you!",
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
