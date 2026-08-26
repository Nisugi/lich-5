{
  schema_version: 3,
  name: "sacristan spirit",
  noun: "",
  url: "https://gswiki.play.net/sacristan_spirit",
  picture: "",
  level: 25,
  family: "Ghost",
  type: "Biped",
  undead: true,
  blood: false,
  bones: false,
  witherable: true,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: true,
  max_hp: 205,
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
        name: "a twisted black steel half moon",
        as: 211
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Blinding (311)",
        cs: 142
      },
      {
        name: "Frenzy (216)",
        cs: 142
      },
      {
        name: "Mind Jolt (706)",
        cs: 146
      },
      {
        name: "Silence (210)",
        cs: 142
      }
    ],
    offensive_spells: [
      {
        name: "Bravery (211)"
      }
    ],
    maneuvers: [],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8",
    immunities: [],
    melee: (136..219),
    ranged: (103..113),
    bolt: (103..113),
    udf: 243,
    bar_td: (81..92),
    cle_td: (88..98),
    emp_td: (90..100),
    pal_td: nil,
    ran_td: nil,
    sor_td: (96..103),
    wiz_td: nil,
    mje_td: 98,
    mne_td: 103,
    mjs_td: nil,
    mns_td: (90..100),
    mnm_td: (75..80),
    defensive_spells: [
      "Prayer of Protection",
      "Prismatic Guard",
      "Spirit Shield",
      "Spirit Warding I",
      "Thurfel's Ward"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a twisted black steel half moon",
    "some tanned dark grey leathers"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Glimmering blue essence shardGlimmering blue mote of essence"
  },
  messaging: {
    description: [
      "Draped in tattered robes, the spirit forever wanders the forests and swamps in search of the sacred objects he once guarded in life. Forever frustrated in his attempts to find his cherished but long-destroyed artifacts, the spirit lashes out violently at all those who would dare trespass into his unholy domain."
    ],
    arrival: [],
    flee: [],
    death: [
      "A sacristan spirit fades into oblivion.",
      "The sacristan spirit goes still for a moment while its head reshapes."
    ],
    decay: [],
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
