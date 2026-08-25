{
  schema_version: 3,
  name: "cave gnoll",
  noun: "",
  url: "https://gswiki.play.net/cave_gnoll",
  picture: "",
  level: 3,
  family: "Gnoll",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 60,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Upper Dragonsclaw",
      uids: [2121015..2121024]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Scimitar",
        as: (58..68)
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
    asg: "7",
    immunities: [],
    melee: (21..26),
    ranged: 9,
    bolt: 9,
    udf: 44,
    bar_td: nil,
    cle_td: nil,
    emp_td: -23,
    pal_td: nil,
    ran_td: nil,
    sor_td: 9,
    wiz_td: nil,
    mje_td: 9,
    mne_td: 9,
    mjs_td: 9,
    mns_td: 9,
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
      "Standing only three feet tall, the man-like gnoll watches your every move with piercing grey eyes. It mutters something in an oddly resonant voice that sounds like the ring of hammer on stone. There is little doubt that the stealthy gnoll can be a formidable opponent when need arises, or when it is hard pressed. A faint odor of fermented mushroom wine wafts from its drab and slightly musty clothing."
    ],
    arrival: [
      "A cave gnoll just arrived."
    ],
    flee: [],
    death: [
      "The cave gnoll falls to the ground and dies.",
      "The cave gnoll screams one last time and dies."
    ],
    decay: [
      "A cave gnoll decays into compost.",
      "The cave gnoll's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A cave gnoll swings {weapon} at you!"
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
