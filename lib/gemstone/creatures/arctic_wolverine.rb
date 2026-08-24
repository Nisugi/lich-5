{
  schema_version: 3,
  name: "arctic wolverine",
  noun: "",
  url: "https://gswiki.play.net/arctic_wolverine",
  picture: "",
  level: 24,
  family: "Mustelid",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 210,
  speed: nil,
  height: 2,
  size: "small",
  areas: [
    {
      name: "Pinefar Forests",
      uids: [4563008..4563020]
    },
    {
      name: "Sleeping Lady Mountains",
      uids: [4565016..4565037]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 194
      },
      {
        name: "Claw",
        as: 204
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
    asg: "10N",
    immunities: [],
    melee: (123..180),
    ranged: (121..145),
    bolt: (121..145),
    udf: 194,
    bar_td: 72,
    cle_td: nil,
    emp_td: (61..69),
    pal_td: 75,
    ran_td: nil,
    sor_td: (66..75),
    wiz_td: nil,
    mje_td: 72,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "a wolverine tail",
    other: nil
  },
  messaging: {
    description: [
      "Similar to his cousin of the more temperate climates, the arctic wolverine is possessed with a ferocious nature far out of proportion to his size, making him an extremely vicious opponent. Swift and agile, with claws and teeth backed by muscles like coiled springs, the arctic wolverine will take on and defeat foes three times his size. His shaggy hide is a mixture of light brown and icy white, affording him good cover in the frosty fields, and his toes are webbed, providing a snowshoe effect for increased agility in the snow."
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
