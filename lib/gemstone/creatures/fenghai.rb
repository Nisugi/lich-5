{
  schema_version: 3,
  name: "fenghai",
  noun: "",
  url: "https://gswiki.play.net/fenghai",
  picture: "",
  level: 23,
  family: "Fey",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Magical",
    "Boss"
  ],
  bcs: true,
  max_hp: 190,
  speed: nil,
  height: 2,
  size: "medium",
  areas: [
    {
      name: "Vornavian Coast",
      uids: [4006001..4006031, 4218101..4218121]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "kris",
        as: 173
      },
      {
        name: "Freezing ball of pure cold",
        as: 200
      },
      {
        name: "Hissing stream of acid",
        as: 206
      },
      {
        name: "Large boulder",
        as: 123
      },
      {
        name: "Powerful lightning bolt",
        as: 208
      },
      {
        name: "Scimitar",
        as: 209
      },
      {
        name: "Small surge of electricity",
        as: 202
      },
      {
        name: "Stream of fire",
        as: 167
      }
    ],
    bolt_spells: [
      {
        name: "Minor Acid (904)",
        as: 167
      },
      {
        name: "Major Cold (907)",
        as: (160..167)
      },
      {
        name: "Major Fire (908)",
        as: 178
      },
      {
        name: "Minor Shock (901)",
        as: 167
      }
    ],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "1N",
    immunities: [],
    melee: (165..333),
    ranged: nil,
    bolt: nil,
    udf: 285,
    bar_td: 76,
    cle_td: (78..83),
    emp_td: (161..171),
    pal_td: nil,
    ran_td: nil,
    sor_td: (94..165),
    wiz_td: nil,
    mje_td: (89..97),
    mne_td: 83,
    mjs_td: nil,
    mns_td: (151..160),
    mnm_td: (155..165),
    defensive_spells: [
      "Elemental Defense I (401)",
      "Elemental Defense II (406)",
      "Elemental Defense III (414)",
      "Elemental Focus (513)",
      "Thurfel's Ward (503)",
      "Wizard's Shield (919)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a bruised left eye",
    "a bruised right eye",
    "a greatsword",
    "a scimitar"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a fenghai fur",
    other: "Glimmering blue essence shard"
  },
  messaging: {
    description: [
      "The fenghai seems to be a furry little ball with feet. Sparkling eyes peer out from a mop of russet fur, looking about with a happy curiousity. Stubby arms end in pudgy little hands that appear dextrous despite their dimensions, and the round-toed feet are covered in hair and dirt. While comical in appearance, it is obvious that the furball can take care of itself."
    ],
    arrival: [],
    flee: [],
    death: [
      "The fenghai falls to the ground motionless.",
      "A fenghai goes limp as it is rendered unconscious!",
      "The fenghai cries out one last time and lies still."
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the fenghai's ribs to move independently.",
      "The fenghai's left leg crumbles briefly and explodes in a shower of gore.",
      "Acid dissolves the knee ligaments.  The fenghai's tibia passes its femur in a very unpleasant manner!",
      "The fenghai's right leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A fenghai hurls {weapon} at you!",
      "A fenghai points a furry finger at you!",
      "A fenghai spins {pronoun} head in your direction and spews a massive stream of spittle and blood at you!  With a quick duck of your head, you step out of {pronoun} path.",
      "A fenghai swings {weapon} at you!"
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
