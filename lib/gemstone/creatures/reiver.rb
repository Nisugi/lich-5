{
  schema_version: 3,
  name: "reiver",
  noun: "",
  url: "https://gswiki.play.net/reiver",
  picture: "",
  level: 24,
  family: "Reiver",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 270,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Luinne Bheinn",
      uids: [4251011..4251013, 4251015..4251056]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Broadsword",
        as: 222
      },
      {
        name: "Handaxe",
        as: 222
      },
      {
        name: "Falchion",
        as: 222
      },
      {
        name: "Spear",
        as: 222
      },
      {
        name: "Two-handed sword",
        as: 222
      },
      {
        name: "Fist",
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
    asg: "various",
    immunities: [],
    melee: (113..144),
    ranged: (92..118),
    bolt: (92..118),
    udf: 155,
    bar_td: 72,
    cle_td: nil,
    emp_td: 72,
    pal_td: nil,
    ran_td: nil,
    sor_td: 72,
    wiz_td: nil,
    mje_td: 72,
    mne_td: 72,
    mjs_td: nil,
    mns_td: 72,
    mnm_td: 72,
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
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "The reiver stands tall and proud. Moss-green eyes dominate the strong face and tousled, dark hair crowns the head. The reiver is well-muscled and toned, with calloused hands used to the wielding of weapons. Forged by a hard history and a harsh climate, the reiver is a tough fighter with a sense of honor and duty. Normally calm and amiable, the reiver's visage is thunderous when kith and kin are threatened or there are krolvins lurking."
    ],
    arrival: [
      "A reiver just arrived.",
      "A reiver just arrived, limping."
    ],
    flee: [],
    death: [
      "The reiver takes one last breath, then dies.",
      "A reiver goes limp as it is rendered unconscious!",
      "The reiver falls to the ground motionless."
    ],
    decay: [
      "A reiver turns to dust.",
      "Acid dissolves connecting cartilage, freeing the reiver's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A reiver pounds at you with {pronoun} fist!",
      "A reiver swings {weapon} at you!"
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
