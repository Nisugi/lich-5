{
  schema_version: 3,
  name: "bony tenthsworn occultist",
  noun: "",
  url: "https://gswiki.play.net/bony_tenthsworn_occultist",
  picture: "",
  level: 59,
  family: "Humanoid",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [],
  bcs: true,
  max_hp: 289,
  speed: nil,
  height: 4,
  size: "small",
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
    physical_attacks: [],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Blood Burst (701)",
        cs: (274..283)
      }
    ],
    offensive_spells: [
      {
        name: "Condemn (309)"
      },
      {
        name: "Grasp of the Grave (709)"
      }
    ],
    maneuvers: [
      {
        name: "Crimson Smoke"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "2",
    immunities: [],
    melee: (377..472),
    ranged: nil,
    bolt: nil,
    udf: 305,
    bar_td: nil,
    cle_td: nil,
    emp_td: (244..259),
    pal_td: nil,
    ran_td: nil,
    sor_td: (264..277),
    wiz_td: nil,
    mje_td: (273..279),
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
  equipment: [
    "a crooked bloodwood runestaff carved with sinuous lines",
    "some dark mauve robes threaded with blood red sigils"
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
      "Robed and hooded, the Tenthsworn occultist has fervent eyes the color of dried blood and the sort of pallor earned from days spent out of the sun. His dark robes are stitched with serpentine patterns in crimson, a theme repeated in the symbol at his throat, which takes the form of a pair of intertwined asps. The occultist's face is hollow and he looks as if he has not eaten in some time, though perhaps the zeal within him has burned all spare flesh away. \n\nAppraisal:\nThe Tenthsworn occultist is small in size, about four feet high in his current state."
    ],
    arrival: [
      "A bony Tenthsworn occultist stalks in, overwhelming zeal written upon her face.",
      "A bony Tenthsworn occultist stalks in, overwhelming zeal written upon his face."
    ],
    flee: [
      "Zeal written upon his face, a bony Tenthsworn occultist stalks {direction}.",
      "Zeal written upon her face, a bony Tenthsworn occultist stalks {direction}.",
      "Biting her lip in pain, a bony Tenthsworn occultist stalks {direction}.",
      "Biting his lip in pain, a bony Tenthsworn occultist stalks {direction}."
    ],
    death: [
      "The Tenthsworn occultist twitches violently, then dies.",
      "A bony Tenthsworn occultist goes limp as she is rendered unconscious!"
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the Tenthsworn occultist's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A desiccated half-krolvin strigoi flings bony tenthsworn occultist arms wide and throws himself at you, trying to trap you in a deadly embrace!"
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
