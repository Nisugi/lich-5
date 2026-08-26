{
  schema_version: 3,
  name: "undertaker bat",
  noun: "",
  url: "https://gswiki.play.net/undertaker_bat",
  picture: "",
  level: 36,
  family: "Bat",
  type: "Avian",
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
  max_hp: 248,
  speed: nil,
  height: nil,
  size: "small",
  areas: [
    {
      name: "Troll Burial Grounds",
      uids: [13011009..13011035]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (217..242)
      },
      {
        name: "Claw",
        as: (182..226)
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
    melee: nil,
    ranged: 186,
    bolt: 166,
    udf: nil,
    bar_td: (113..122),
    cle_td: (120..134),
    emp_td: (126..135),
    pal_td: 108,
    ran_td: nil,
    sor_td: (132..138),
    wiz_td: nil,
    mje_td: nil,
    mne_td: 147,
    mjs_td: nil,
    mns_td: 126,
    mnm_td: (108..114),
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
    skin: "a bat wing",
    other: nil
  },
  messaging: {
    description: [
      "A rodent-like creature with a small head and distinct ears, its head covered with a fine textured short fur. The undertaker bat's leathery wings outstretch to three times its body length, with its skeletal features visable through its black skin. Small fangs protrude beyond its closed mouth."
    ],
    arrival: [],
    flee: [],
    death: [
      "The undertaker bat twitches violently, then dies.",
      "An undertaker bat goes limp as it is rendered unconscious!",
      "The undertaker bat flaps its wings in a last ditch effort to ascend from the ground, but fails and finally lies still.",
      "As the strength drains out of the undertaker bat's wings, it falls to the ground in a motionless heap."
    ],
    decay: [
      "The undertaker bat decays into a tuft of matted hair and leathery wings."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An undertaker bat rakes at you with a bony claw!"
    ],
    bite: [
      "An undertaker bat tries to bite you!"
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
