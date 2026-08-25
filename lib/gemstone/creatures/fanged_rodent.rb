{
  schema_version: 3,
  name: "fanged rodent",
  noun: "",
  url: "https://gswiki.play.net/fanged_rodent",
  picture: "",
  level: 1,
  family: "Rodent",
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
  height: 1,
  size: "small",
  areas: [
    {
      name: "Catacombs",
      uids: [14009001..14009040]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 44
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
    melee: (32..34),
    ranged: nil,
    bolt: 22,
    udf: 14,
    bar_td: 3,
    cle_td: 3,
    emp_td: 3,
    pal_td: 3,
    ran_td: 3,
    sor_td: 3,
    wiz_td: 3,
    mje_td: 3,
    mne_td: 3,
    mjs_td: 3,
    mns_td: 3,
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
    skin: "a rodent fang",
    other: nil
  },
  messaging: {
    description: [
      "With scruffy brown fur and dark black naked ears, the fanged rodent stands nearly two feet in height. An elongated snout with violently twitching whiskers gives this ferocious beast its keen sense of smell and the ability to detect even the most stealthy of adventurers. Its beady eyes glare back with unrestrained hatred as drool dribbles down from its vicious maw and clings to the neck of its dirty pelt. Routinely seen in great packs, the rodent has brought more than one over-eager adventurer to an early grave."
    ],
    arrival: [
      "A choking fetid odor heralds the arrival of a fanged rodent!",
      "A fanged rodent scampers in!"
    ],
    flee: [
      "A fanged rodent scampers {direction}."
    ],
    death: [
      "The fanged rodent collapses to the ground, emits a final squeal, and dies.",
      "The fanged rodent twitches and dies.",
      "The fanged rodent collapses to the ground, emits a final silent squeal, and dies."
    ],
    decay: [
      "A fanged rodent decays into a pile of hair and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [],
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
