{
  schema_version: 3,
  name: "arachne acolyte",
  noun: "",
  url: "https://gswiki.play.net/arachne_acolyte",
  picture: "",
  level: 23,
  family: "Humanoid",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 190,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Spider Temple",
      uids: [13010..13030]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "War hammer",
        as: 161
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Frenzy (216)",
        cs: 118
      },
      {
        name: "Web (118)",
        cs: 118
      }
    ],
    offensive_spells: [
      {
        name: "Spirit Strike (117)"
      }
    ],
    maneuvers: [
      {
        name: "Disarm"
      },
      {
        name: "Tackle"
      },
      {
        name: "Pounce"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "16",
    immunities: [],
    melee: (106..219),
    ranged: nil,
    bolt: 114,
    udf: 245,
    bar_td: 67,
    cle_td: 66,
    emp_td: (70..80),
    pal_td: (63..73),
    ran_td: nil,
    sor_td: 57,
    wiz_td: (67..72),
    mje_td: (67..72),
    mne_td: 73,
    mjs_td: 76,
    mns_td: (66..104),
    mnm_td: nil,
    defensive_spells: [
      "Spirit Warding I (101)",
      "Spirit Defense (103)",
      "Spirit Warding II (107)",
      "Spirit Fog (106)"
    ],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [
    "a chain hauberk",
    "a war hammer",
    "a wooden shield"
  ],
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
      "The Arachne acolyte's head is clean shaven and bald. Where hair once grew, ornate tattoos of deep red hue decorate every visible bare body part. The Arachne acolytes are muscular but lean. Long years of study and training has produced fanatical allegiance to Arachne. Any semblance of humanity has long since been exorcised through torture and meditation. Only the zealous duty of Arachne now compels their existence."
    ],
    arrival: [
      "An Arachne acolyte just arrived."
    ],
    flee: [
      "An Arachne acolyte winces and anxiously retreats!",
      "An Arachne acolyte heads {direction}.",
      "An Arachne acolyte limps {direction}."
    ],
    death: [
      "The Arachne acolyte slumps to the ground and dies.",
      "The Arachne acolyte exhales a final curse and dies.",
      "An Arachne acolyte goes limp as he is rendered unconscious!"
    ],
    decay: [
      "The Arachne acolyte's body dissolves into a puff of lingering red smoke.",
      "The Arachne acolyte's left leg crumbles briefly and explodes in a shower of gore."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An Arachne acolyte swings {weapon} at you!"
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
