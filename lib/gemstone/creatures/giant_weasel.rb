{
  schema_version: 3,
  name: "giant weasel",
  noun: "",
  url: "https://gswiki.play.net/giant_weasel",
  picture: "",
  level: 14,
  family: "Mustelid",
  type: "Quadruped",
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
  max_hp: 130,
  speed: nil,
  height: 2,
  size: "medium",
  areas: [
    {
      name: "Yegharren Plains",
      uids: [13034401..13034416]
    },
    {
      name: "Emerald Forest",
      uids: [13301201..13301232, 13301301..13301335]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 151
      },
      {
        name: "Claw",
        as: (144..166)
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
    asg: "6N",
    immunities: [],
    melee: (127..153),
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: (42..48),
    cle_td: (36..45),
    emp_td: (42..50),
    pal_td: (36..45),
    ran_td: nil,
    sor_td: (36..45),
    wiz_td: nil,
    mje_td: nil,
    mne_td: (42..48),
    mjs_td: nil,
    mns_td: (39..48),
    mnm_td: (39..48),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Hides when attacked"
    ]
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
    skin: "a weasel pelt",
    other: nil
  },
  messaging: {
    description: [
      "Darting with amazing speed, the giant weasel often pounces upon its prey before the startled victim can react. Nearly six feet from the tip of its wiggling nose to the end of its furred tail, its short legs propel it rapidly, albeit with an amusingly wavy motion. The body is covered with long, chocolate brown fur, darker on top than underneath. Yellow eyes peer out from its head, glancing about the area with a devious intelligence as the giant weasel sniffs the air, searching for its next meal."
    ],
    arrival: [
      "A giant weasel just arrived.",
      "A giant weasel scampers in, chittering to announce its arrival!",
      "A giant weasel scampers in!"
    ],
    flee: [
      "A giant weasel scampers {direction}."
    ],
    death: [
      "The giant weasel collapses to the ground, emits a final cry, and dies.",
      "The giant weasel lets out a final agonized cry and dies.",
      "The giant weasel cries loudly as it slumps to the ground and cradles its wounded left foreleg.",
      "The giant weasel cries loudly as it slumps to the ground and cradles its wounded right foreleg.",
      "The giant weasel cries loudly as it slumps to the ground and cradles its wounded left paw.",
      "The giant weasel slumps to the ground.",
      "The giant weasel cries loudly as it slumps to the ground and cradles its wounded right paw."
    ],
    decay: [
      "A giant weasel decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [],
    claw: [
      "A giant weasel claws at you!"
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
