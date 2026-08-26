{
  schema_version: 3,
  name: "wasp nest",
  noun: "",
  url: "https://gswiki.play.net/wasp_nest",
  picture: "",
  level: 43,
  family: "Wasp",
  type: "Insect",
  undead: false,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 143,
  speed: nil,
  height: 8,
  size: "large",
  areas: [
    {
      name: "Fhorian Village",
      uids: [3030011..3030023, 3030225..3030234, 3030250..3030254]
    },
    {
      name: "Volcano",
      uids: [3050008..3050036, 3052001..3052025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Dreadful droning of their wings",
        as: 367
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (139..206),
    ranged: nil,
    bolt: nil,
    udf: (235..242),
    bar_td: 72,
    cle_td: nil,
    emp_td: 85,
    pal_td: (59..62),
    ran_td: nil,
    sor_td: nil,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: 204,
    mnm_td: 60,
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: "reticulated orbs"
  },
  messaging: {
    description: [
      "Smooth black basalt forms a squat cone, taller than many giantmen. The rock looks almost to have been molded or poured into shape, lacking any sign of having been worked. The top is apparently open, allowing the wasps access to the interior. A deep hum radiates from the nest, implying a feverish level of activity inside."
    ],
    arrival: [],
    flee: [
      "A mud wasp crawls {direction} of the wasp nest!",
      "A cinder wasp crawls {direction} of the wasp nest!"
    ],
    death: [],
    decay: [
      "The wasp nest collapses into a pile of rubble.",
      "A wasp nest decays into dust."
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
