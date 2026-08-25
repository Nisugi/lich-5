{
  schema_version: 3,
  name: "black bear",
  noun: "",
  url: "https://gswiki.play.net/black_bear",
  picture: "",
  level: 16,
  family: "Bear",
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
  height: 3,
  size: "large",
  areas: [
    {
      name: "Neartofar Forest",
      uids: [14015101..14015118]
    },
    {
      name: "Lysierian Hills",
      uids: [92002..92018]
    },
    {
      name: "Slope",
      uids: [395002..395015]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite (attack)",
        as: 180
      },
      {
        name: "Claw (attack)",
        as: 190
      },
      {
        name: "Charge (attack)",
        as: 190
      },
      {
        name: "Bite",
        as: 150
      },
      {
        name: "Claw",
        as: 171
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [
      {
        name: "Pounce"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (137..152),
    ranged: (92..104),
    bolt: (92..104),
    udf: 160,
    bar_td: (48..54),
    cle_td: (45..48),
    emp_td: (29..56),
    pal_td: nil,
    ran_td: 48,
    sor_td: (45..54),
    wiz_td: nil,
    mje_td: 42,
    mne_td: nil,
    mjs_td: 48,
    mns_td: (45..48),
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
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: "a bear hide",
    other: nil
  },
  messaging: {
    description: [
      "The black bear is a medium sized bear with a body about six feet long and appears to weigh around 440 pounds. Mostly blackish in color, asone would expect from a black bear, its muzzle is somewhat lighter and a distinct V-shaped patch of cream colored fur can be found on the chest. Also of note are the ears which appear much larger than those of other bears."
    ],
    arrival: [
      "A black bear lumbers in!"
    ],
    flee: [
      "A black bear lumbers {direction}.",
      "A black bear slowly lumbers {direction}, growling in pain."
    ],
    death: [
      "The black bear lets out a blood-curdling roar and dies.",
      "The black bear collapses heavily into a heap on the ground and dies.",
      "A black bear goes limp as she is rendered unconscious!",
      "A black bear goes limp as he is rendered unconscious!"
    ],
    decay: [
      "A black bear decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A black bear tries to bite you!"
    ],
    claw: [
      "A black bear claws at you!"
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
