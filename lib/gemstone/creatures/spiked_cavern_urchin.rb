{
  schema_version: 3,
  name: "spiked cavern urchin",
  noun: "",
  url: "https://gswiki.play.net/spiked_cavern_urchin",
  picture: "",
  level: 17,
  family: "Urchin",
  type: "Globoid",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 160,
  speed: nil,
  height: 1,
  size: "tiny",
  areas: [
    {
      name: "Thurfel's Island",
      uids: [7532001..7532033]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pincer (attack)",
        as: "(barbed spines) 176"
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Barbed spines"
      },
      {
        name: "Spine Barrage"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (85..92),
    ranged: 62,
    bolt: 62,
    udf: 125,
    bar_td: 51,
    cle_td: 51,
    emp_td: (33..41),
    pal_td: nil,
    ran_td: nil,
    sor_td: (48..57),
    wiz_td: nil,
    mje_td: 54,
    mne_td: 51,
    mjs_td: nil,
    mns_td: 51,
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
    skin: "a long fiery red spine",
    other: nil
  },
  messaging: {
    description: [
      "Long barbed spines erupt outward from the cavern urchin, almost completely covering its body. The spear-like growths form a formidable defense, and also pose a lethal threat to anything that might find itself close enough to become impaled upon the spiked ends."
    ],
    arrival: [],
    flee: [],
    death: [
      "A spiked cavern urchin goes limp as it is rendered unconscious!"
    ],
    decay: [
      "Spines litter the ground as the cavern urchin crumbles into a pile of splinters and skin.",
      "A spiked cavern urchin simply withers away, bits of grayish dust scattered about in its wake."
    ],
    search: [],
    spell_prep: [],
    attack: [],
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
