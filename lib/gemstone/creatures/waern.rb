{
  schema_version: 3,
  name: "waern",
  noun: "",
  url: "https://gswiki.play.net/waern",
  picture: "",
  level: 49,
  family: "Canine",
  type: "Quadruped",
  undead: true,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Corporeal undead",
    "Boss"
  ],
  bcs: true,
  max_hp: 312,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Bonespear Tower",
      uids: [319001..319015, 319117..319139]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Claw",
        as: 295
      },
      {
        name: "Charge",
        as: 294
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Grapple"
      },
      {
        name: "Lunge"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (240..328),
    ranged: (248..266),
    bolt: 269,
    udf: (291..370),
    bar_td: 165,
    cle_td: 180,
    emp_td: (170..179),
    pal_td: nil,
    ran_td: nil,
    sor_td: (190..199),
    wiz_td: 200,
    mje_td: (200..203),
    mne_td: 199,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: (144..153),
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
    boxes: true,
    skin: "a waern fur",
    other: nil
  },
  messaging: {
    description: [
      "The waern is a vicious-looking embodiment of canine malice and tenacity. The waern's fiendish green eyes glow with insane appetite and her mangy pelt is so ragged, the rotting bones show through in spots. Long, malicious teeth curve out of the waern's rotting muzzle, and the tail that curves over the waern's back is hardly more than segments of bone interspersed with a few pieces of fuzzy, matted hair. Floating over the ground, her paws scarcely leaving a track, the waern dodges almost quicker than the eye can follow."
    ],
    arrival: [],
    flee: [
      "A waern runs {direction}."
    ],
    death: [
      "The waern rolls over and dies.",
      "The waern falls to the ground and dies.",
      "The waern yelps loudly as he slumps to the ground and licks his wounded right foreleg.",
      "The waern yelps loudly as he slumps to the ground and licks his wounded left foreleg.",
      "The waern yelps loudly as she slumps to the ground and licks her wounded right foreleg.",
      "The waern yelps loudly as she slumps to the ground and licks her wounded left foreleg."
    ],
    decay: [
      "A waern decays into a compost of fangs and fur.",
      "A muculent waern decays into a compost of fangs and fur.",
      "A slimy waern decays into a compost of fangs and fur."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A waern charges at you!"
    ],
    bite: [],
    claw: [
      "A waern claws at you!"
    ],
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
