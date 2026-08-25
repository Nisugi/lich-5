{
  schema_version: 3,
  name: "aivren",
  noun: "",
  url: "https://gswiki.play.net/aivren",
  picture: "",
  level: 86,
  family: "Aivren",
  type: "Avian",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: nil,
  size: "medium",
  areas: [
    {
      name: "The Rift",
      uids: [4568028..4568055]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite (attack)",
        as: 398
      },
      {
        name: "Claw (attack)",
        as: 378
      },
      {
        name: "Bite",
        as: 403
      },
      {
        name: "Massive beak",
        as: 358
      },
      {
        name: "Razor-sharp claw",
        as: 410
      },
      {
        name: "Swoop",
        as: 410
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Wing Buffet"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "8",
    immunities: [],
    melee: (300..400),
    ranged: nil,
    bolt: 335,
    udf: nil,
    bar_td: 320,
    cle_td: 338,
    emp_td: (332..341),
    pal_td: 289,
    ran_td: nil,
    sor_td: 354,
    wiz_td: nil,
    mje_td: (367..373),
    mne_td: nil,
    mjs_td: 332,
    mns_td: 332,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "an aivren gizzard",
    other: nil
  },
  messaging: {
    description: [
      "Leathery, ochre wings extending as wide as a giantman is tall, the aivren wheels and swoops with amazing dexterity. The aivren flies low over the landscape, snapping up anything remotely edible in its long, pointed beak or sharp, descending claws. Charcoal grey on the underbelly and a dusky ochre on the back, its speed often surprises its foes, allowing the aivren to strike the death blow before the opponent can react."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "An aivren rakes at you with a razor-sharp claw!",
      "An aivren tries to spear you with {pronoun} massive beak!"
    ],
    bite: [
      "An aivren tries to bite you!"
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
