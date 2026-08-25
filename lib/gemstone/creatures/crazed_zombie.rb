{
  schema_version: 3,
  name: "crazed zombie",
  noun: "",
  url: "https://gswiki.play.net/crazed_zombie",
  picture: "",
  level: 23,
  family: "Zombie",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: true,
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
      name: "Lunule Weald",
      uids: [14016001..14016038]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (181..202)
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
    asg: "12N",
    immunities: [],
    melee: (112..149),
    ranged: (93..132),
    bolt: (93..132),
    udf: 169,
    bar_td: 69,
    cle_td: 70,
    emp_td: (60..80),
    pal_td: 69,
    ran_td: nil,
    sor_td: (68..74),
    wiz_td: nil,
    mje_td: nil,
    mne_td: "77 = 83",
    mjs_td: nil,
    mns_td: 78,
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "a zombie scalp",
    other: "Glimmering blue essence shardGlimmering blue mote of essence"
  },
  messaging: {
    description: [
      "Pity the poor crazed zombie, an animated corpse abandoned long ago by her creator. The skin of the crazed zombie has turned a sickly grey, her clothing hangs in tattered ribbons, and she barely keeps control over her death-stiffened muscles. Her mouth, once sewn shut to hold the salt necessary in the animation process, has broken open again, salt dribbling from the parched, thread-covered lips. The crazed zombie verbally threatens and attacks anyone she believes may interfere with her quest to return to the grave."
    ],
    arrival: [
      "A crazed zombie shambles in!",
      "A lustrous crazed zombie shambles in!",
      "A glittering crazed zombie shambles in!",
      "A luminous crazed zombie shambles in!"
    ],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A crazed zombie tries to bite you!"
    ],
    claw: [
      "A crazed zombie claws at you!"
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
