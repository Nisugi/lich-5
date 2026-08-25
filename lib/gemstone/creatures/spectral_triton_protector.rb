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
  muggable: nil,
  boss: true,
  otherclass: [
    "non-corporeal undead",
    "Boss"
  ],
  bcs: true,
  max_hp: 381,
  speed: nil,
  height: nil,
  size: "",
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
    ranged: nil,
    bolt: nil,
    udf: 628,
    bar_td: 390,
    cle_td: nil,
    emp_td: (404..406),
    pal_td: nil,
    ran_td: nil,
    sor_td: (419..426),
    wiz_td: nil,
    mje_td: nil,
    mne_td: 437,
    mjs_td: nil,
    mns_td: 393,
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
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "Coral-spiked pauldrons are draped across a spectral triton protector's shoulders, the leather straps taut across her bare chest, the hide cutting into her tattooed blue-green flesh. Thick rings of ivory encircle her forearms and calves, etched in crude runes caked with blackish mud. Uneven streaks of pigment decorate her sunken cheekbones, the remnants splattered across her trident-inked collarbones."
    ],
    arrival: [
      "A spectral triton protector just arrived."
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A spectral triton protector swings {weapon} at you!",
      "A spectral triton protector throws {weapon} at you!",
      "Tightening spectral triton protector grip on spectral triton protector heavy ball and chain, a spectral triton protector strikes out at you with all of spectral triton protector might!"
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
