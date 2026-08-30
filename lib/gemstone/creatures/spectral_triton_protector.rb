{
  schema_version: 3,
  name: "spectral triton protector",
  noun: "",
  url: "https://gswiki.play.net/spectral_triton_protector",
  picture: "",
  level: 98,
  family: "Triton",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: false,
  boss: true,
  boss_type: "miniboss",
  otherclass: [
    "non-corporeal undead",
    "Boss"
  ],
  bcs: true,
  max_hp: 381,
  speed: 6,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Atoll",
      uids: [7138101..7138119]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Ball and chain",
        as: (424..449)
      },
      {
        name: "Claw",
        as: 414
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Shield Charge"
      }
    ],
    special_abilities: [
      {
        name: "Dizzying Swing"
      },
      {
        name: "Mstrike"
      },
      {
        name: "Hurl"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "20N",
    immunities: [],
    melee: (270..277),
    ranged: (142..435),
    bolt: (142..435),
    udf: (358..628),
    bar_td: 390,
    cle_td: (392..417),
    emp_td: (404..406),
    pal_td: (339..349),
    ran_td: (353..362),
    sor_td: (419..441),
    wiz_td: nil,
    mje_td: (437..439),
    mne_td: (437..439),
    mjs_td: (385..388),
    mns_td: (385..388),
    mnm_td: (391..399),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a bronze-bound driftwood greatshield",
    "a coral-hilted heavy ball and chain"
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
      "Coral-spiked pauldrons are draped across a spectral triton protector's shoulders, the leather straps taut across her bare chest, the hide cutting into her tattooed blue-green flesh. Thick rings of ivory encircle her forearms and calves, etched in crude runes caked with blackish mud. Uneven streaks of pigment decorate her sunken cheekbones, the remnants splattered across her trident-inked collarbones."
    ],
    arrival: [
      "A spectral triton protector just arrived.",
    ],
    flee: [
      "A spectral triton protector heads {direction}."
    ],
    death: [
      "The triton protector fades into transparency, his remnants rapidly dissolving into the air.",
      "The triton protector fades into transparency, her remnants rapidly dissolving into the air."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A spectral triton protector swings {weapon} at you!",
      "A spectral triton protector throws {weapon} at you!",
      "Tightening {pronoun} grip on {pronoun} heavy ball and chain, a spectral triton protector strikes out at you with all of spectral triton protector might!"
    ],
    bite: [],
    claw: [
      "A spectral triton protector claws at you!"
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
