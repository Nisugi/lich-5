{
  schema_version: 3,
  name: "cockatrice",
  noun: "",
  url: "https://gswiki.play.net/cockatrice",
  picture: "",
  level: 6,
  family: "Basilisk",
  type: "Hybrid",
  undead: false,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 69,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Upper Trollfang",
      uids: [15009..15015]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw (attack)",
        as: 99
      },
      {
        name: "Pincer (attack)",
        as: 99
      },
      {
        name: "Charge (attack)",
        as: 109
      },
      {
        name: "Strike",
        as: 80
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Dust Kick"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "1",
    immunities: [],
    melee: (53..114),
    ranged: nil,
    bolt: nil,
    udf: 138,
    bar_td: nil,
    cle_td: nil,
    emp_td: -11,
    pal_td: nil,
    ran_td: nil,
    sor_td: 18,
    wiz_td: nil,
    mje_td: 18,
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
  equipment: [],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a cockatrice feather",
    other: nil
  },
  messaging: {
    description: [
      "A smaller relative of the basilisk, the cockatrice has a serpentine body, with feathered head, wings, and legs. Having the cold, freezing gaze of its larger cousin, the cockatrice should not be treated lightly. A sharp beak and raking claws complete this small but deadly package of evil."
    ],
    arrival: [
      "A cockatrice just arrived!"
    ],
    flee: [],
    death: [
      "The cockatrice rolls over on its back, emits a final screech and dies."
    ],
    decay: [
      "A cockatrice decays into a useless pile of scales and feathers."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A cockatrice screeches and strikes at you!"
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
