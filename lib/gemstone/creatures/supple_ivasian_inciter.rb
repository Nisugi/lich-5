{
  schema_version: 3,
  name: "supple ivasian inciter",
  noun: "",
  url: "https://gswiki.play.net/supple_ivasian_inciter",
  picture: "",
  level: 66,
  family: "Humanoid",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Abbey",
      uids: [4132201..4132240, 4132243..4132248]
    },
    {
      name: "unmapped",
      uids: [4132241..4132242]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Kick",
        as: 329
      },
      {
        name: "Whip",
        as: 329
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Spirit Strike"
      },
      {
        name: "Spike Thorn"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "11",
    immunities: [],
    melee: (284..371),
    ranged: (242..246),
    bolt: (242..246),
    udf: 578,
    bar_td: (215..227),
    cle_td: 255,
    emp_td: (254..264),
    pal_td: nil,
    ran_td: nil,
    sor_td: nil,
    wiz_td: nil,
    mje_td: (273..276),
    mne_td: nil,
    mjs_td: 265,
    mns_td: 226,
    mnm_td: nil,
    defensive_spells: [
      "Pestilence (716)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  treasure: {
    coins: true,
    magic_items: nil,
    gems: true,
    boxes: true,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "A supple Ivasian inciter is a surpassingly attractive figure clad in a loose silken shirt of shimmering green cloth of a vivid bile green hue and a darker loincloth. More than just a hint of zealotry glimmers in her kohl-rimmed eyes. She wears a glinting steel symbol, painted red and bordered in a wreath of tentacles, that depicts a stylized wisp of green smoke."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
