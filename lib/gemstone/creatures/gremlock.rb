{
  schema_version: 3,
  name: "gremlock",
  noun: "",
  url: "https://gswiki.play.net/gremlock",
  picture: "",
  level: 84,
  family: "Gremlin",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Old Ta'Faendryl",
      uids: [17002201..17002247, 17002301..17002325, 17003011..17003038, 17003101..17003150, 17003201..17003217]
    },
    {
      name: "unmapped",
      uids: [17003001..17003010]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: (406..422)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Garrote"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (381..614),
    ranged: nil,
    bolt: 302,
    udf: 727,
    bar_td: (297..306),
    cle_td: nil,
    emp_td: (326..335),
    pal_td: 282,
    ran_td: nil,
    sor_td: (338..348),
    wiz_td: nil,
    mje_td: 364,
    mne_td: 361,
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
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: nil,
    other: "Radiant crimson essence dust"
  },
  messaging: {
    description: [
      "The gremlock is larger than her relative, the gremlin, stretching five to six feet in height. The back hunched over from her time spent in the shadows stalking her prey, her actual height cannot be determined accurately. Tufts of dirty fur form a straggly mane around the savage looking face. Her long bulky arms tipped with massive claws only add to the deformity of the gremlock with her razor-sharp maw and potentially fatal, hungry glare."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
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
