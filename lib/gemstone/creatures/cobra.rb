{
  schema_version: 3,
  name: "cobra",
  noun: "",
  url: "https://gswiki.play.net/cobra",
  picture: "",
  level: 4,
  family: "Reptilian",
  type: "Ophidian",
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
  max_hp: 51,
  speed: nil,
  height: 1,
  size: "small",
  areas: [
    {
      name: "The Graveyard",
      uids: [18048..18051, 18053..18054, 2156001..2156015]
    },
    {
      name: "Vornavian Coast",
      uids: [4202101..4202111]
    },
    {
      name: "unmapped",
      uids: [18045..18047]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 68
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
    asg: "5N",
    immunities: [],
    melee: (23..37),
    ranged: 33,
    bolt: 23,
    udf: 21,
    bar_td: 12,
    cle_td: 12,
    emp_td: 12,
    pal_td: nil,
    ran_td: nil,
    sor_td: 12,
    wiz_td: nil,
    mje_td: 12,
    mne_td: 12,
    mjs_td: nil,
    mns_td: 12,
    mnm_td: 12,
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
    skin: "a cobra skin",
    other: nil
  },
  messaging: {
    description: [
      "The long, thin, varicolored cobra slithers quickly through the landscape, searching for small prey upon which to feed. It is a docile snake until disturbed, at which time it raises its head high off the ground and expands the loose skin around its neck, forming an intimidating dark hood. An angered cobra is not to be trifled with, as its fangs contain a potent poison known to cause death in many instances."
    ],
    arrival: [
      "A cobra slithers in!"
    ],
    flee: [
      "A cobra slithers {direction}."
    ],
    death: [],
    decay: [
      "A cobra decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A cobra tries to bite you!"
    ],
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
