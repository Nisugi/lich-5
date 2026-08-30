{
  schema_version: 3,
  name: "bighorn sheep",
  noun: "",
  url: "https://gswiki.play.net/bighorn_sheep",
  picture: "",
  level: 18,
  family: "Caprine",
  type: "Quadruped",
  undead: false,
  blood: false,
  bones: true,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 172,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Emerald Forest",
      uids: [13301170..13301191, 13301201..13301232]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Impale",
        as: (168..183)
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
    asg: "11N",
    immunities: [],
    melee: (67..130),
    ranged: (65..72),
    bolt: (65..72),
    udf: 164,
    bar_td: 54,
    cle_td: (51..54),
    emp_td: (54..62),
    pal_td: (48..57),
    ran_td: (54..60),
    sor_td: 54,
    wiz_td: nil,
    mje_td: 54,
    mne_td: 54,
    mjs_td: 81,
    mns_td: 81,
    mnm_td: (51..60),
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
    skin: "a bighorn sheepskin",
    other: nil
  },
  messaging: {
    description: [
      "The bighorn sheep's body is compact and muscular with a short, stubby tail. His triangular-shaped head features a narrow pointed muzzle and short, flopppy ears. The fur is almost deerlike in nature and is shaded brown with the occasional whitish rump patches. The sheep's fur is smooth and composed of an outer coat of brittle guard hairs and short, gray, crimped fleece underfur. Atop his head rest two massive brown horns twisted in a full curl. Each looks out of place on the small triangular-shaped head let alone both. Together they form a symmetry that just looks right."
    ],
    arrival: [
      "A bighorn sheep just arrived."
    ],
    flee: [],
    death: [
      "A bighorn sheep collapses, his head dropping heavily to the ground as he goes still.",
      "A bighorn sheep collapses, her head dropping heavily to the ground as she goes still.",
      "A bighorn sheep rolls over, his head dropping heavily to the ground as he goes still.",
      "A bighorn sheep rolls over, her head dropping heavily to the ground as she goes still."
    ],
    decay: [
      "A bighorn sheep decays into a pile of fur and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A bighorn sheep lowers {pronoun} head and tries to impale you on {pronoun} horns!"
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
