{
  schema_version: 3,
  name: "glistening cerebralite",
  noun: "",
  url: "https://gswiki.play.net/glistening_cerebralite",
  picture: "",
  level: 100,
  family: "Cerebralite",
  type: "Globoid",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Extraplanar",
    "Living"
  ],
  bcs: true,
  max_hp: 509,
  speed: nil,
  height: 2,
  size: "small",
  areas: [
    {
      name: "The Rift",
      uids: [4569001..4569023, 4571001..4571030]
    }
  ],
  attack_attributes: {
    physical_attacks: [],
    bolt_spells: [
      {
        name: "Balefire (713)",
        as: 402
      },
      {
        name: "Empathic Assault (1110)",
        as: 402
      },
      {
        name: "Major Shock (910)",
        as: 402
      }
    ],
    warding_spells: [
      {
        name: "Cloak of Shadows (712)",
        cs: 406
      },
      {
        name: "Sympathy (1120)",
        cs: 424
      }
    ],
    offensive_spells: [
      {
        name: "Heroism (215)"
      },
      {
        name: "Song of Depression (1015)"
      },
      {
        name: "Spiritual Abolition (230)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (339..473),
    ranged: nil,
    bolt: 338,
    udf: 514,
    bar_td: (381..398),
    cle_td: nil,
    emp_td: (434..439),
    pal_td: nil,
    ran_td: nil,
    sor_td: (442..446),
    wiz_td: nil,
    mje_td: nil,
    mne_td: 455,
    mjs_td: nil,
    mns_td: 425,
    mnm_td: nil,
    defensive_spells: [
      "Cloak of Shadows (712)",
      "Elemental Defense I (401)",
      "Elemental Defense II (406)",
      "Elemental Defense III (414)",
      "Spirit Shield (202)"
    ],
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
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "a cerebralite tentacle",
    other: nil
  },
  messaging: {
    description: [
      "A grey-splotched pink, the glistening cerebralite is a fleshy mass that somewhat resembles a humanoid brain, though it is oversized and grossly proportioned. Eye-stalks sprout from either hemisphere, supporting a pair of lidless eyes with iridescent irises and ebony pupils. Thick veins span the wrinkled surface of the creature's body, pulsing rhythmically with a writhing mass of barbed tentacles sprouting from its underside. A viscous fluid coats the cerebralite's surface, the substance phlegm-like in consistency."
    ],
    arrival: [
      "A glistening cerebralite just arrived, looking terrified!"
    ],
    flee: [
      "A glistening cerebralite bolts {direction}!"
    ],
    death: [
      "An intangible ripple of pure energy courses through the air as the cerebralite's pupils widen a final time, its eyes clouding over as it dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A glistening cerebralite focuses glistening cerebralite eye-stalks on you!"
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
