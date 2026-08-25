{
  schema_version: 3,
  name: "wind wraith",
  noun: "",
  url: "https://gswiki.play.net/wind_wraith",
  picture: "",
  level: 63,
  family: "Wraith",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Non-corporeal undead",
    "Boss"
  ],
  bcs: true,
  max_hp: 323,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Dark Palisade",
      uids: [3040004..3040015]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw (attack)",
        as: 294
      },
      {
        name: "Claw",
        as: 300
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Claw",
        cs: 291
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
    melee: (231..450),
    ranged: nil,
    bolt: 275,
    udf: 534,
    bar_td: nil,
    cle_td: 250,
    emp_td: (250..259),
    pal_td: nil,
    ran_td: nil,
    sor_td: (256..265),
    wiz_td: nil,
    mje_td: 276,
    mne_td: 284,
    mjs_td: nil,
    mns_td: 256,
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
    coins: false,
    magic_items: false,
    gems: true,
    boxes: false,
    skin: nil,
    other: "a small glowing vial"
  },
  messaging: {
    description: [
      "The wind wraith is a miniature windstorm all unto itself. Heavy air currents swirl around the wind wraith, obscuring its form and making it much more difficult to hit the elusive creature. The wind wraith bobs and weaves within the gusting air streams, directing them to maximum effect against its foes. The only part of the wind wraith that seems easy to see is its crimson, glowing eyes, which appear to float steadily despite the thunderous winds around it."
    ],
    arrival: [],
    flee: [],
    death: [
      "A wind wraith releases a groan of mingled ecstasy and relief as it fades away.",
      "A flexile wind wraith releases a groan of mingled ecstasy and relief as it fades away.",
      "A sinuous wind wraith releases a groan of mingled ecstasy and relief as it fades away."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [],
    claw: [
      "A wind wraith claws at you!"
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
