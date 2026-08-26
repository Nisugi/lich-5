{
  schema_version: 3,
  name: "ice wraith",
  noun: "",
  url: "https://gswiki.play.net/ice_wraith",
  picture: "",
  level: 45,
  family: "Wraith",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead",
    "Element-based"
  ],
  bcs: nil,
  max_hp: 240,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Great Mountain Aenatumgana",
      uids: [4561001..4561010]
    },
    {
      name: "Pinefar Forests",
      uids: [4563039..4563060]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Kaskara",
        as: 238
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Point",
        cs: 227
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Point"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (132..312),
    ranged: (124..158),
    bolt: (124..158),
    udf: 270,
    bar_td: nil,
    cle_td: 176,
    emp_td: (178..187),
    pal_td: (140..143),
    ran_td: nil,
    sor_td: (184..193),
    wiz_td: nil,
    mje_td: (197..207),
    mne_td: nil,
    mjs_td: nil,
    mns_td: (168..178),
    mnm_td: (150..157),
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
    other: nil
  },
  messaging: {
    description: [
      "Glistening from head to toe with brilliant clear ice, the ice wraith is a picture of deadly beauty. Long, razor-sharp shards of ice form his claws, and two thin ice stalactites serve as fangs. When illuminated by the sun, the crystalline ice wraith reflects all colors of the rainbow, often mesmerizing his prey, then striking with potent magic."
    ],
    arrival: [],
    flee: [],
    death: [
      "An ice wraith fades into oblivion."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "An ice wraith points a ghostly finger at you!",
      "An ice wraith swings {weapon} at you!"
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
