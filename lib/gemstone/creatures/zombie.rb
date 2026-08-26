{
  schema_version: 3,
  name: "zombie",
  noun: "",
  url: "https://gswiki.play.net/zombie",
  picture: "",
  level: 23,
  family: "Zombie",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Corporeal undead",
    "Boss"
  ],
  bcs: true,
  max_hp: 260,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Upper Trollfang",
      uids: [2122001..2122016]
    },
    {
      name: "Abandoned Farm",
      uids: [4124015..4124022, 4124024..4124026]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 206
      },
      {
        name: "Claw",
        as: 202
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
    asg: "12",
    immunities: [],
    melee: (93..156),
    ranged: (93..135),
    bolt: (93..135),
    udf: 169,
    bar_td: (63..69),
    cle_td: (64..76),
    emp_td: (64..72),
    pal_td: (63..72),
    ran_td: (63..69),
    sor_td: (68..80),
    wiz_td: nil,
    mje_td: 79,
    mne_td: 77,
    mjs_td: 72,
    mns_td: (69..78),
    mnm_td: (63..78),
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "some tattered rags"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "zombie scalp",
    other: nil
  },
  messaging: {
    description: [
      "Pity the poor zombie, an animated corpse abandoned long ago by her creator. The skin of the zombie has turned a sickly grey, her clothing hangs in tattered ribbons, and she barely keeps control over her death-stiffened muscles. Her mouth, once sewn shut to hold the salt necessary in the animation process, has broken open again, salt dribbling from the parched, thread-covered lips. The zombie verbally threatens and attacks anyone she believes may interfere with her quest to return to the grave."
    ],
    arrival: [
      "A zombie shambles in!"
    ],
    flee: [
      "A zombie wails madly as he limps {direction}.",
      "A zombie wails madly as she limps {direction}.",
      "A zombie shambles {direction}."
    ],
    death: [],
    decay: [
      "Acid dissolves connecting cartilage, freeing the zombie's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A zombie waves {pronoun} arms around flinging bits of flesh towards you."
    ],
    bite: [
      "A zombie tries to bite you!"
    ],
    claw: [
      "A zombie claws at you!"
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
