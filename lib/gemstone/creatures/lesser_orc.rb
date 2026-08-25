{
  schema_version: 3,
  name: "lesser orc",
  noun: "",
  url: "https://gswiki.play.net/lesser_orc",
  picture: "",
  level: 6,
  family: "Orc",
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
  max_hp: 89,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Melgorehn's Valley",
      uids: [2148002..2148024]
    },
    {
      name: "Old Mine Road",
      uids: [20001..20018]
    },
    {
      name: "Upper Trollfang",
      uids: [15001..15034]
    },
    {
      name: "Southern Snowfields",
      uids: [4128031..4128042]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Cudgel",
        as: 108
      },
      {
        name: "Short sword",
        as: (88..108)
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
    asg: nil,
    immunities: [],
    melee: (37..114),
    ranged: (32..37),
    bolt: (32..37),
    udf: 127,
    bar_td: 18,
    cle_td: nil,
    emp_td: 18,
    pal_td: 18,
    ran_td: nil,
    sor_td: 18,
    wiz_td: nil,
    mje_td: 18,
    mne_td: nil,
    mjs_td: 18,
    mns_td: 18,
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
    skin: "an orc hide",
    other: nil
  },
  messaging: {
    description: [
      "The lesser orc stands almost man high but is much thicker so that it appears stunted for its height. Heavy brow ridges and a sloping forehead give the beast a brutish appearance not aided by its rank breath and foul odor. It glares blankly around ignoring anything that it can't eat or pillage."
    ],
    arrival: [
      "A lesser orc wanders in looking a bit unsteady on her feet.",
      "A lesser orc wanders in looking a bit unsteady on his feet."
    ],
    flee: [],
    death: [
      "A lesser orc screams one last time and dies.",
      "A lesser orc screams silently one last time and dies."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A lesser orc swings {weapon} at you!"
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
