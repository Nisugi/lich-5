{
  schema_version: 3,
  name: "hisskra chieftain",
  noun: "",
  url: "https://gswiki.play.net/hisskra_chieftain",
  picture: "",
  level: 34,
  family: "Hisskra",
  type: "Biped",
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
  height: 5,
  size: "medium",
  areas: [
    {
      name: "The Ruined Tower",
      uids: [305001..305022]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Dart",
        as: 260
      },
      {
        name: "Trident",
        as: 235
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Tail Swipe"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (191..330),
    ranged: nil,
    bolt: nil,
    udf: 196,
    bar_td: 105,
    cle_td: nil,
    emp_td: (117..124),
    pal_td: nil,
    ran_td: nil,
    sor_td: (123..132),
    wiz_td: nil,
    mje_td: 129,
    mne_td: 129,
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
    coins: true,
    magic_items: true,
    gems: true,
    boxes: true,
    skin: "hisskra crest",
    other: nil
  },
  messaging: {
    description: [
      "As tall as a typical human, the humanoid reptilian hisskra shares many characteristics with mankind. A long snout filled with an array of sharp teeth dominates the hisskra's facial features, giving him the appearance of a bipedal, ruby-crested iguana. Well-defined pectorals and a muscular torso are nearly man-like, but for the dull, dark green scales that fade to a paler shade at the throat, and the ridge of boney, red-tinged spines that runs from between the hisskra chieftain's shoulder blades to the tip of his five-foot tail. The hisskra's muscular limbs end in thick-fingered, partially-webbed hands and feet tipped with blackened claws, which are formidable weapons should the creature lose his more civilized martial implements. A glint of cunning is revealed in the depths of the hisskra chieftain's eyes as he peers about, his tongue flicking over his scaly lips."
    ],
    arrival: [
      "A hisskra chieftain stalks in, gripping his slimy trident menacingly!"
    ],
    flee: [],
    death: [
      "The hisskra chieftain rolls over on his back and dies.",
      "The hisskra chieftain twitches violently, then dies.",
      "A hisskra chieftain goes limp as he is rendered unconscious!"
    ],
    decay: [
      "A hisskra chieftain decays into a pile of scales and bone.",
      "A hisskra chieftain withers away, leaving nothing but a few scales that blow away on a gentle breeze.",
      "A hisskra chieftain's scales wither as he decays into dust.",
      "A hisskra chieftain collapses into a putrid lump of scaly flesh."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A hisskra chieftain swings {weapon} at you!",
      "A hisskra chieftain throws {weapon} at you!"
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
