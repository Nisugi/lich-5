{
  schema_version: 3,
  name: "tomb troll",
  noun: "",
  url: "https://gswiki.play.net/tomb_troll",
  picture: "",
  level: 52,
  family: "Troll",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: true,
  boss: true,
  boss_type: "miniboss",
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 400,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Marsh Keep",
      uids: [376063..376083]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Morning star",
        as: (248..273)
      },
      {
        name: "Huge swollen right fist",
        as: 235
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Shield Bash"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12",
    immunities: [],
    melee: (187..352),
    ranged: (155..295),
    bolt: (155..295),
    udf: (281..453),
    bar_td: 177,
    cle_td: (193..214),
    emp_td: (191..197),
    pal_td: (164..173),
    ran_td: (164..170),
    sor_td: (194..214),
    wiz_td: nil,
    mje_td: (213..215),
    mne_td: (213..215),
    mjs_td: 248,
    mns_td: 248,
    mnm_td: (159..168),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a bone-hafted black iron morning star",
    "a pitted wooden shield covered in rusty black iron spikes",
    "a small glaes morning star"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "troll thumb",
    other: nil
  },
  messaging: {
    description: [
      "Shorter than the common troll, but no less ugly, the tomb troll is squat and covered in a mottled and oily albino skin. Bare but for patches of lanky yellow strands of hair that cover the back, chest and arms of the troll, the tomb troll has adapted to a world far from the sun -- the darkness of crypts, the source of her favorite food. Fat, pointed ears extend from the side of her head, framing larger than normal silver eyes with horizontal slits set above a maw full of jagged teeth."
    ],
    arrival: [],
    flee: [
      "A tomb troll lopes {direction}.",
      "A tomb troll limps {direction}."
    ],
    death: [
      "A low sigh fills the air and the tomb troll fades to nothing.",
      "A tomb troll blinks in astonishment, then collapses in a motionless heap.",
      "Beautiful shot pierces both lungs, the tomb troll makes a wheezing noise, and drops dead!",
      "The tomb troll slumps to the ground."
    ],
    decay: [
      "The tomb troll's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A tomb troll swings {weapon} at you!",
      "A flesh golem lifts tomb troll fat fleshy foot and tries to stomp on you!"
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
