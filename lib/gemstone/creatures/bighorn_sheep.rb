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
  muggable: nil,
  boss: false,
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
    melee: (76..130),
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: 54,
    cle_td: nil,
    emp_td: (37..62),
    pal_td: nil,
    ran_td: nil,
    sor_td: 54,
    wiz_td: nil,
    mje_td: 54,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
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
    death: [],
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
