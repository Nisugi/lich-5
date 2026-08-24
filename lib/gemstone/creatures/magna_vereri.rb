{
  schema_version: 3,
  name: "magna vereri",
  noun: "",
  url: "https://gswiki.play.net/magna_vereri",
  picture: "",
  level: 72,
  family: "Ghost",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 5,
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
    physical_attacks: [],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Repel (Fear)"
      }
    ],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (387..549),
    ranged: nil,
    bolt: "319 (in offensive)",
    udf: 567,
    bar_td: 290,
    cle_td: (290..301),
    emp_td: (297..306),
    pal_td: nil,
    ran_td: nil,
    sor_td: nil,
    wiz_td: nil,
    mje_td: 328,
    mne_td: nil,
    mjs_td: 254,
    mns_td: 269,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
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
      "A horrific magna vereri is the animated corpse of a woman, twisted into a perverse parody of beauty. Glowing white eyes glare out of a face whose cheeks are rouged with streaks of blood, and the lips are bloated and red around needle-like teeth. The obscene curvature of her body is at odds with her skeletal limbs, which are little more than bones clad in pale blue-grey corpseflesh. The vereri's movements are jerky and uneven as she totters around, driven by feral rage."
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
