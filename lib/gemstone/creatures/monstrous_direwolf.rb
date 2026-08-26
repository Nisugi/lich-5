{
  schema_version: 3,
  name: "monstrous direwolf",
  noun: "",
  url: "https://gswiki.play.net/monstrous_direwolf",
  picture: "",
  level: 68,
  family: "Canine",
  type: "Quadruped",
  undead: false,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 5,
  size: "large",
  areas: [
    {
      name: "Red Forest",
      uids: [480216..480230, 17006216..17006230]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite (attack)",
        as: 365
      },
      {
        name: "Claw (attack)",
        as: 355
      },
      {
        name: "Bite",
        as: 345
      },
      {
        name: "Claw",
        as: 319
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Pounce"
      },
      {
        name: "Lunge"
      },
      {
        name: "Leap"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "16N",
    immunities: [],
    melee: (215..305),
    ranged: (215..291),
    bolt: (215..291),
    udf: 463,
    bar_td: 240,
    cle_td: (312..321),
    emp_td: 329,
    pal_td: (280..283),
    ran_td: 271,
    sor_td: (272..284),
    wiz_td: nil,
    mje_td: 303,
    mne_td: 298,
    mjs_td: nil,
    mns_td: 267,
    mnm_td: 266,
    defensive_spells: [
      "TD boost"
    ],
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
    skin: "Red eye",
    other: "No"
  },
  messaging: {
    description: [
      "The monstrous direwolf is a huge powerful beast with baleful red eyes that seem to bore through to the very soul. Impressively large bone deposits protrude across the breadth of the beast's back and neck. Large teeth that seem too big even for the massive maw can easily be seen even when the powerful jaws are closed. Mist, or perhaps tendrils of smoke, occasionally drift up from the flaring nostrils. Sharp eyes, and a sense of smell to match, and a cunning said to rival demons make a direwolf something to avoid."
    ],
    arrival: [
      "A monstrous direwolf lumbers in with a vicious snarl!",
      "A monstrous direwolf stalks in!",
      "A monstrous direwolf stalks in, growling in pain!"
    ],
    flee: [
      "A monstrous direwolf stalks {direction}.",
      "A monstrous direwolf stalks {direction}, growling in pain."
    ],
    death: [
      "The monstrous direwolf rolls over and dies.",
      "The monstrous direwolf falls to the ground and dies.",
      "The monstrous direwolf yelps loudly as he slumps to the ground and licks his wounded right foreleg.",
      "The monstrous direwolf yelps loudly as she slumps to the ground and licks her wounded right foreleg.",
      "The monstrous direwolf yelps loudly as she slumps to the ground and licks her wounded left paw.",
      "The monstrous direwolf yelps loudly as she slumps to the ground and licks her wounded left foreleg.",
      "The monstrous direwolf yelps loudly as he slumps to the ground and licks his wounded left foreleg.",
      "The monstrous direwolf yelps loudly as she slumps to the ground and licks her wounded right paw.",
      "The monstrous direwolf yelps loudly as he slumps to the ground and licks his wounded left paw."
    ],
    decay: [
      "A monstrous direwolf decays into a mound of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A monstrous direwolf tries to bite you!"
    ],
    claw: [
      "A monstrous direwolf claws at you!"
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
