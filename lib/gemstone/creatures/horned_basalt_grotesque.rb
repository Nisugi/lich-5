{
  schema_version: 3,
  name: "horned basalt grotesque",
  noun: "",
  url: "https://gswiki.play.net/horned_basalt_grotesque",
  picture: "",
  level: 105,
  family: "Golem",
  type: "Biped",
  undead: false,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: true,
  muggable: nil,
  sleepable: false,
  boss: false,
  boss_type: nil,
  otherclass: [],
  bcs: true,
  max_hp: 794,
  speed: nil,
  height: 8,
  size: "large",
  areas: [
    {
      name: "Moonsedge",
      uids: [4577001..4577028, 4577051..4577058, 4577101..4577123, 4577201..4577214, 4577216..4577249]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Closed fist",
        as: (525..565)
      },
      {
        name: "Stomp",
        as: (526..555)
      },
      {
        name: "Bite",
        as: 530
      }
    ],
    bolt_spells: [
      {
        name: "Hurl Boulder (510)",
        as: (387..417)
      }
    ],
    warding_spells: [
      {
        name: "Stone Fist (514)",
        cs: 452
      }
    ],
    offensive_spells: [
      {
        name: "Major Elemental Wave (435)"
      },
      {
        name: "Call Wind (912)"
      },
      {
        name: "Earthen Fury (917)"
      }
    ],
    maneuvers: [
      {
        name: "Haymaker"
      },
      {
        name: "Bearhug"
      },
      {
        name: "Charge"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "20N",
    immunities: [],
    melee: (294..607),
    ranged: (247..448),
    bolt: (247..448),
    udf: (481..693),
    bar_td: (490..520),
    cle_td: nil,
    emp_td: 471,
    pal_td: (439..442),
    ran_td: 521,
    sor_td: "483 to 504",
    wiz_td: nil,
    mje_td: 476,
    mne_td: "487 to 522",
    mjs_td: nil,
    mns_td: 471,
    mnm_td: nil,
    defensive_spells: [
      "Arcane Barrier (1720)",
      "Soul Ward (319)"
    ],
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
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "Huge and hulking, the basalt grotesque is an imposing figure cut from black basalt. Roughly humanoid in shape though not in particulars, the grotesque has a bestial visage. The carved musculature of its back joins with two great wings that span wider than it is tall. From its head sprouts a quintet of rounded horns. Its eyes, a burning green, match the hue of a viridian soulstone embedded into the rock of its broad chest.\n\nAppraisal:\nThe basalt grotesque is large in size, about eight feet high in its current state, appears to be of exceptionally hardy constitution, is in a guarded stance, and is in relatively good shape."
    ],
    arrival: [
      "A horned basalt grotesque stomps in, stony wings spread behind it like a flourished cloak.",
      "A horned basalt grotesque stomps in, shedding chips of stone from cracks along its limbs."
    ],
    flee: [],
    death: [],
    decay: [
      "Cracks race across a horned basalt grotesque's carved stone physique, deepening into jagged chasms.  The grotesque crumbles swiftly, its composite pieces breaking into fine black powder."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A horned basalt grotesque opens {pronoun} stony jaws and tries to savage you with jaggedly carved teeth!",
      "A horned basalt grotesque twists a stony claw toward you!",
      "Clenching a carved claw into an unyielding fist, a horned basalt grotesque takes a swing at you!",
      "Raising a heavy stone foot, a horned basalt grotesque attempts to crush you with a vicious stomp!"
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
