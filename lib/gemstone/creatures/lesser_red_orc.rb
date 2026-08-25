{
  schema_version: 3,
  name: "lesser red orc",
  noun: "",
  url: "https://gswiki.play.net/lesser_red_orc",
  picture: "",
  level: 7,
  family: "Orc",
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
  max_hp: 100,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Coastal Cliffs",
      uids: [68001..68004, 68010..68016]
    },
    {
      name: "Yander's Farm",
      uids: [14005023..14005025, 14005027..14005036]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Scimitar",
        as: (99..111)
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
    asg: "9",
    immunities: [],
    melee: (40..107),
    ranged: (29..34),
    bolt: (29..34),
    udf: 114,
    bar_td: 21,
    cle_td: nil,
    emp_td: -7,
    pal_td: nil,
    ran_td: 21,
    sor_td: 21,
    wiz_td: nil,
    mje_td: 21,
    mne_td: 21,
    mjs_td: 21,
    mns_td: 21,
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
    skin: "a red orc scalp",
    other: nil
  },
  messaging: {
    description: [
      "Erect, the red orc would stand approximately six feet high. However, her hunched shoulders and curved spine bring her head nearly two feet closer to the ground. Thick, matted, deep burgundy fur covers most of the orc's body, probably accounting for the red name applied to her. Her muzzle protrudes from the bony cranium, and her lips seem to be constantly pulled back to reveal pointed, discolored fangs. The evil smile goes well with the malevolent yellow eyes behind it."
    ],
    arrival: [],
    flee: [],
    death: [
      "A lesser red orc collapses in a red mess and dies."
    ],
    decay: [
      "A lesser red orc collapses into dust."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A lesser red orc swings {weapon} at you!"
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
