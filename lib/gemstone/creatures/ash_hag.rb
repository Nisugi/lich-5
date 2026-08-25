{
  schema_version: 3,
  name: "ash hag",
  noun: "",
  url: "https://gswiki.play.net/ash_hag",
  picture: "",
  level: 31,
  family: "Witch",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Element-based",
    "Boss"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 4,
  size: "medium",
  areas: [
    {
      name: "Volcanic Flats",
      uids: [3023001..3023028]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Slap",
        as: 210
      },
      {
        name: "Bite (attack)",
        as: 180
      }
    ],
    bolt_spells: [
      {
        name: "Minor Fire (906)",
        as: 200
      }
    ],
    warding_spells: [
      {
        name: "Immolation (519)",
        cs: 183
      }
    ],
    offensive_spells: [
      {
        name: "Elemental Wave (410)"
      },
      {
        name: "Fire Storm"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: [],
    melee: 240,
    ranged: 142,
    bolt: 149,
    udf: 280,
    bar_td: 110,
    cle_td: nil,
    emp_td: (105..118),
    pal_td: nil,
    ran_td: nil,
    sor_td: (119..128),
    wiz_td: nil,
    mje_td: 135,
    mne_td: 141,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Elemental Defense II (406)",
      "Elemental Defense III (414)",
      "Thurfel's Ward (503)"
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
    coins: true,
    magic_items: nil,
    gems: true,
    boxes: nil,
    skin: "a hag nose",
    other: "glimmering blue essence shard"
  },
  messaging: {
    description: [
      "You are not quite sure what to make of the ash hag, as you have never seen anything that looks quite like it. Stopping a moment, you try to commit this creature to memory so that you can tell tales of it to your fellow adventurers back in the safety of the local tavern."
    ],
    arrival: [
      "An ash hag just arrived, shrieking in pain!"
    ],
    flee: [],
    death: [
      "The ash hag twitches violently, then dies.",
      "An ash hag goes limp as she is rendered unconscious!"
    ],
    decay: [
      "An ash hag crumbles into a pile of ash.",
      "Acid dissolves connecting cartilage, freeing the ash hag's ribs to move independently."
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
