{
  schema_version: 3,
  name: "gaunt feral selkie",
  noun: "",
  url: "https://gswiki.play.net/gaunt_feral_selkie",
  picture: "",
  level: 57,
  family: "Fey",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 259,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Crawling Shore",
      uids: [4576101..4576126, 4576151..4576160]
    },
    {
      name: "unmapped",
      uids: [4576127..4576150]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Hand of Tonis (505)"
      },
      {
        name: "Major Cold (907)"
      },
      {
        name: "Charge",
        as: 298
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Hand of Tonis (505)"
      },
      {
        name: "Earthen Fury (917)"
      }
    ],
    maneuvers: [
      {
        name: "Headbutt"
      },
      {
        name: "Bull Rush"
      },
      {
        name: "Sweep"
      },
      {
        name: "Charge"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (326..472),
    ranged: nil,
    bolt: nil,
    udf: 511,
    bar_td: nil,
    cle_td: nil,
    emp_td: (252..261),
    pal_td: nil,
    ran_td: nil,
    sor_td: (272..281),
    wiz_td: nil,
    mje_td: (281..282),
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [
      "Iron Skin (1202)",
      "Foresight (1204)",
      "Brace (1214)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: "Transformation",
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a woven twine necklace adorned with yellowed shark teeth"
  ],
  treasure: {
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "No",
    other: nil
  },
  messaging: {
    description: [
      "Clad in sealskin and sailcloth, the feral selkie is a half-krolvin in his middle years. Her hair is unkempt and her eyes are wild and unfocused. Rattling bones, dried iceblossoms, and bits of kelp adorn her ritualistic attire, held in place by bits of fraying twine. Unwashed and obviously addled, the selkie looks as if she has one foot firmly in a world that you cannot see.\nOr:\nThe selkie's large, dark eyes hold more than a glimmer of unnatural intellect. His fur is soft and sleek over an agile musculature more suited to the water than dry land. The selkie's sharp teeth are yellowed and an overwhelming odor of fish guts rises from his mouth in a noxious cloud. \n\nAppraisal:\nThe feral selkie is medium in size, about six feet high in his current state."
    ],
    arrival: [
      "A gaunt feral selkie wanders in, lost in a pall of befuddlement.",
      "A gaunt feral selkie wanders in, befuddled and seemingly unaware of her injuries."
    ],
    flee: [
      "Lost in a pall of befuddlement, a gaunt feral selkie wanders {direction}.",
      "Seemingly unaware of his injuries, a gaunt feral selkie wanders {direction}.",
      "Seemingly unaware of her injuries, a gaunt feral selkie wanders {direction}."
    ],
    death: [
      "An instant of clarity dawns in a gaunt feral selkie's eyes as he succumbs to his injuries.  Peace blossoms on his face as he dies.",
      "An instant of clarity dawns in a gaunt feral selkie's eyes as she succumbs to her injuries.  Peace blossoms on her face as she dies.",
      "A gaunt feral selkie goes limp as she is rendered unconscious!"
    ],
    decay: [
      "Acid dissolves the knee ligaments.  The feral selkie's tibia passes his femur in a very unpleasant manner!"
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A desiccated half-krolvin strigoi flings gaunt feral selkie arms wide and throws himself at you, trying to trap you in a deadly embrace!",
      "A gaunt feral selkie balls up a grimy hand and takes a swing at you!",
      "Leading with gaunt feral selkie shoulder, a gaunt feral selkie barrels into a charge at you!",
      "Propelling gaunt feral selkie forward with {pronoun} flippers, a gaunt feral selkie charges at you!"
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
