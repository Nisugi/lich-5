{
  schema_version: 3,
  name: "triton assassin",
  noun: "",
  url: "https://gswiki.play.net/triton_assassin",
  picture: "",
  level: 96,
  family: "Triton",
  type: "Biped",
  undead: false,
  blood: nil,
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
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Atoll",
      uids: [7138001..7138015]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Longsword",
        as: "428 to 453"
      },
      {
        name: "Main gauche",
        as: "428 to 453"
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Groin Kick"
      },
      {
        name: "Cutthroat"
      }
    ],
    special_abilities: [
      {
        name: "Ambush"
      },
      {
        name: "Stealth"
      },
      {
        name: "Vanish"
      },
      {
        name: "Hurl"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "8N",
    immunities: [],
    melee: (370..592),
    ranged: nil,
    bolt: nil,
    udf: 483,
    bar_td: 375,
    cle_td: nil,
    emp_td: (379..384),
    pal_td: nil,
    ran_td: nil,
    sor_td: "396 to 426",
    wiz_td: nil,
    mje_td: (432..440),
    mne_td: "413 to 441",
    mjs_td: nil,
    mns_td: "364 to 381",
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
    other: nil
  },
  messaging: {
    description: [
      "Dressed in grey-on-black, a triton assassin watches the area intently. The assassin bares her sharply serrated teeth, and her thick tail twitches silently with each breath. Inked upon one muscular forearm is a broken ivory trident overlaying a series of spiky runes."
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
