{
  schema_version: 3,
  name: "moor eagle",
  noun: "",
  url: "https://gswiki.play.net/moor_eagle",
  picture: "",
  level: 35,
  family: "Bird",
  type: "Avian",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 2,
  size: "large",
  areas: [
    {
      name: "Shattered Moors",
      uids: [420001..420025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (233..259)
      },
      {
        name: "Impale",
        as: 249
      },
      {
        name: "Swoop",
        as: 267
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
    melee: (171..198),
    ranged: 173,
    bolt: nil,
    udf: nil,
    bar_td: 109,
    cle_td: nil,
    emp_td: (117..127),
    pal_td: nil,
    ran_td: nil,
    sor_td: (125..134),
    wiz_td: nil,
    mje_td: 134,
    mne_td: 134,
    mjs_td: nil,
    mns_td: 121,
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
    gems: false,
    boxes: false,
    skin: "moor eagle talon",
    other: nil
  },
  messaging: {
    description: [
      "Wide, snow white wings spread ten feet across as the moor eagle soars in flight. Pale yellow feet extend below the bird's light grey, feathered body, the feet displaying razor-sharp talons that look long and strong enough to powerfully grasp most anything the eagle might encounter. A large, hooked beak protrudes from the moor eagle's head. In contrast to the muted colors on the rest of the moor eagle, the eagle's eyes are a striking sky blue."
    ],
    arrival: [],
    flee: [
      "A moor eagle flies {direction}."
    ],
    death: [
      "A moor eagle goes limp as it is rendered unconscious!"
    ],
    decay: [
      "The moor eagle decays into a pile of feathers.",
      "Acid dissolves connecting cartilage, freeing the moor eagle's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A moor eagle rakes at you with a razor-sharp claw!",
      "A moor eagle tries to impale you on {pronoun} beak!"
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
