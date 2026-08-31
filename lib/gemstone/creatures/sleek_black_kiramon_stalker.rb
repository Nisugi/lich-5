{
  schema_version: 3,
  name: "sleek black kiramon stalker",
  noun: "",
  url: "https://gswiki.play.net/sleek_black_kiramon_stalker",
  picture: "",
  level: 108,
  family: "Kiramon",
  type: "Insect",
  undead: false,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: false,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [],
  bcs: true,
  max_hp: 331,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "The Hive",
      uids: [13041101..13041132, 13041201..13041230, 13041301..13041329]
    },
    {
      name: "unmapped",
      uids: [13041330..13041330]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw"
      },
      {
        name: "Stinger (attack)",
        as: (591..597)
      },
      {
        name: "Bite",
        as: (565..597)
      },
      {
        name: "Bladed forelegs",
        as: 519
      },
      {
        name: "Razor-sharp foreleg",
        as: (600..607)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Eviscerate"
      },
      {
        name: "Coup de Grace"
      },
      {
        name: "Dirtkick"
      },
      {
        name: "Charge"
      },
      {
        name: "Dust Kick"
      }
    ],
    special_abilities: [
      {
        name: "Weapon Web"
      },
      {
        name: "Stealth"
      },
      {
        name: "On the Hunt"
      },
      {
        name: "Durable Carapace"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: nil,
    ranged: (445..621),
    bolt: (445..621),
    udf: (727..1064),
    bar_td: nil,
    cle_td: (454..463),
    emp_td: 463,
    pal_td: (425..428),
    ran_td: (416..428),
    sor_td: nil,
    wiz_td: nil,
    mje_td: 515,
    mne_td: 515,
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
    gems: true,
    boxes: false,
    skin: "a mottled kiramon poison gland",
    other: nil
  },
  messaging: {
    description: [
      "Glittering, spherical eyes stand out from the matte black of the kiramon stalker's carapace, which is so dark that it seems to drink the surrounding light. The stalker is a creature seemingly tailored for speed and stealth. Roughly shaped like a mantis, it balances on stick-like legs with powerful hindquarters, and it looks ever ready to spring. Wings like gossamer shadows enfold the stalker's thorax like a dusky cloak."
    ],
    arrival: [],
    flee: [],
    death: [
      "A sleek black kiramon stalker grabs you by the head and twists violently.  You hear a loud *CRACK* as your neck bones snap and your body goes limp!",
      "A sleek black kiramon stalker goes still, and for a moment she seems to blend with the surrounding shadows.",
      "A sleek black kiramon stalker goes still, and for a moment it seems to blend with the surrounding shadows.",
      "A chitinous kiramon myrmidon collapses, its forelegs spasming and twitching before it at last surrenders to death."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A sleek black kiramon stalker skitters mercilessly forward to slash at you with a razor-sharp foreleg!",
      "A sleek black kiramon stalker twists fluidly to spear you with {pronoun} barbed stinger!",
      "Without warning, a sleek black kiramon stalker glides from the shadows and skitters mercilessly forward to slash at you with a razor-sharp foreleg!",
      "Without warning, a sleek black kiramon stalker glides from the shadows and twists fluidly to spear you with {pronoun} barbed stinger!"
    ],
    bite: [
      "A sleek black kiramon stalker aims a preternaturally swift bite at you!",
      "Without warning, a sleek black kiramon stalker glides from the shadows and aims a preternaturally swift bite at you!",
      "NoneWithout warning, a sleek black kiramon stalker glides from the shadows and aims a preternaturally swift bite at you!"
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
