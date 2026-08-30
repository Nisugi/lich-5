{
  schema_version: 3,
  name: "flickering mist-wreathed banshee",
  noun: "",
  url: "https://gswiki.play.net/flickering_mist-wreathed_banshee",
  picture: "",
  level: 102,
  family: "Ghost",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: false,
  boss: false,
  boss_type: nil,
  otherclass: [
    "Non-corporeal undead"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 5,
  size: "medium",
  areas: [
    {
      name: "Moonsedge",
      uids: [4577001..4577028, 4577051..4577058, 4577106..4577123, 4577201..4577214, 4577216..4577249]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 520
      },
      {
        name: "Kick",
        as: 555
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Point",
        cs: 448
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Point"
      }
    ],
    special_abilities: [
      {
        name: "Dispel"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "1N",
    immunities: [],
    melee: (390..583),
    ranged: (370..468),
    bolt: (370..468),
    udf: (409..552),
    bar_td: (464..494),
    cle_td: 497,
    emp_td: 484,
    pal_td: (452..459),
    ran_td: (455..467),
    sor_td: "487 to 517",
    wiz_td: nil,
    mje_td: (409..419),
    mne_td: (409..419),
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
    "a tattered grey gown"
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
      "Mists pirouette about the tattered hem of the mist-wreathed banshee's gown so that it is unclear where the garment ends and they begin. Though there are the remnants of loveliness to her visage, the banshee's cheeks are sunken and her eyes are empty chasms of shadow. Dark hair, wild and unkempt, swirls around her face as if constantly blown by a howling breeze. The banshee's form is barely substantial and light filters grimly through her.\n\nAppraisal:\nThe mist-wreathed banshee is medium in size and about five feet high in her current state."
    ],
    arrival: [],
    flee: [],
    death: [],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A flickering mist-wreathed banshee lifts mist-wreathed banshee voice in a terrible screech at you!",
      "A flickering mist-wreathed banshee's shrieking takes on a sepulchral resonance!  A flickering mist-wreathed banshee lifts mist-wreathed banshee voice in a terrible screech at you!",
      "A mist-wreathed banshee lifts a slender hand and points unerringly at you!",
      "A flickering mist-wreathed banshee lifts a slender hand and points unerringly at you!",
      "A flickering mist-wreathed banshee lifts {pronoun} voice in a terrible screech at you!",
      "A flickering mist-wreathed banshee's shrieking takes on a sepulchral resonance!  A flickering mist-wreathed banshee lifts {pronoun} voice in a terrible screech at you!"
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
