{
  schema_version: 3,
  name: "rolton",
  noun: "",
  url: "https://gswiki.play.net/rolton",
  picture: "",
  level: 1,
  family: "Caprine",
  type: "Quadruped",
  undead: false,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 28,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Lower Dragonsclaw",
      uids: [9008..9032]
    },
    {
      name: "South River Road",
      uids: [2104011..2104017]
    },
    {
      name: "Southern Snowfields",
      uids: [4128001..4128008]
    },
    {
      name: "Graendlor Pasture",
      uids: [4301001..4301025]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 32
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
    asg: "1",
    immunities: [],
    melee: (28..78),
    ranged: "+5",
    bolt: "+5",
    udf: nil,
    bar_td: "+3",
    cle_td: "+3",
    emp_td: 3,
    pal_td: "+3",
    ran_td: "+3",
    sor_td: "+3",
    wiz_td: "+3",
    mje_td: 3,
    mne_td: 3,
    mjs_td: "+3",
    mns_td: "+3",
    mnm_td: "+3",
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
    skin: "rolton pelt",
    other: "no"
  },
  messaging: {
    description: [
      "This is obviously a prime example of the beast of legend, the fiend of song and tale. Known near and far as an implacable enemy of early settlers, it was this ferocious sheeplike creature that earned the epithet of Warrior-Killer in its sordid past. The rolton is covered with a dirty, matted, disgusting-looking grey pelt that might once have been white and is still abysmally smelly. However, it isn't this trait alone that gives him such a terrifying appearance. As the animal bleats at you, it is then you get a view of the 'maw of death', with its long, curved incisors that gnash and gnaw. The critter has some nasty-looking hooves as well."
    ],
    arrival: [],
    flee: [],
    death: [
      "The rolton collapses to the ground, emits a final bleat, and dies.",
      "The rolton collapses to the ground, emits a final silent bleat, and dies.",
      "The rolton lets out a final agonized bleat and dies."
    ],
    decay: [
      "A rolton decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A rolton tries to bite you!"
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
