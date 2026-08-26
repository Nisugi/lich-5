{
  schema_version: 3,
  name: "raider orc",
  noun: "",
  url: "https://gswiki.play.net/raider_orc",
  picture: "",
  level: 10,
  family: "Orc",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 138,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Yander's Farm",
      uids: [14005038..14005053]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Twohanded sword",
        as: (122..132)
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
    asg: "17",
    immunities: [],
    melee: (51..134),
    ranged: 44,
    bolt: 56,
    udf: 189,
    bar_td: 30,
    cle_td: nil,
    emp_td: 30,
    pal_td: nil,
    ran_td: 30,
    sor_td: 30,
    wiz_td: nil,
    mje_td: nil,
    mne_td: 30,
    mjs_td: nil,
    mns_td: 30,
    mnm_td: 30,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a metal breastplate",
    "a ragged sack",
    "a twohanded sword"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "A glimmer of intelligence actually resides behind the crimson eyes of the raider orc, unusual for a member of the orc species. He shares the same bony cranium and noxious odor of his brethren, but he strides much more upright, and his sharp teeth are only revealed when necessary for rending something. Interestingly, the raider orc's clawed fingers show webbing in between, indicating that this orc may be as much at home on bodies of water as he is on land."
    ],
    arrival: [
      "A raider orc saunters in looking for something to pillage."
    ],
    flee: [
      "A raider orc trots {direction}."
    ],
    death: [
      "A raider orc screams his defiance skyward one last time and dies.",
      "A raider orc screams her defiance skyward one last time and dies.",
      "A raider orc screams his defiance silently skyward one last time and dies.",
      "A raider orc screams her defiance silently skyward one last time and dies."
    ],
    decay: [
      "A raider orc withers away until he is no more.",
      "A raider orc withers away until she is no more.",
      "The raider orc's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A raider orc swings {weapon} at you!"
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
