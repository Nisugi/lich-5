{
  schema_version: 3,
  name: "cave lizard",
  noun: "",
  url: "https://gswiki.play.net/cave_lizard",
  picture: "",
  level: 18,
  family: "Reptilian",
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
  max_hp: 167,
  speed: nil,
  height: 1,
  size: "small",
  areas: [
    {
      name: "Czeroth Caverns",
      uids: [13007001..13007043]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (183..203)
      },
      {
        name: "Bite",
        as: 189
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Tail Sweep"
      },
      {
        name: "Tail Swipe"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (109..209),
    ranged: nil,
    bolt: 147,
    udf: 167,
    bar_td: 54,
    cle_td: nil,
    emp_td: (54..62),
    pal_td: nil,
    ran_td: nil,
    sor_td: (48..57),
    wiz_td: nil,
    mje_td: (51..54),
    mne_td: 54,
    mjs_td: 54,
    mns_td: 54,
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
    skin: "a stone-grey lizard tail",
    other: nil
  },
  messaging: {
    description: [
      "When safe in the confines of its underground home, the cave lizard is easily mistaken for just another rock on the floor, albeit a rather long, thick rock. Its low-slung body and stubby legs allow it to squeeze through cracks that would defy attempts by the smaller humanoid races. A mottled, scaly hide of charcoal grey intermixed with deep crimson helps it hide in low light conditions. Bright light reveals not only the more scintillating aspects of its crimson coloration but rows of razor-sharp teeth set in a protruding snout. One should not fixate on the snout, though, lest the powerful tail of the cave lizard land a devastating blow."
    ],
    arrival: [
      "A dance of dust and gravel heralds the arrival of a speckled cave lizard!",
      "A dance of dust and gravel heralds the arrival of a cave lizard!"
    ],
    flee: [],
    death: [
      "The cave lizard shudders a final time and goes still."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A cave lizard tries to bite you!"
    ],
    claw: [
      "A cave lizard claws at you!"
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
