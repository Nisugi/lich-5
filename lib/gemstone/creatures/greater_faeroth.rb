{
  schema_version: 3,
  name: "greater faeroth",
  noun: "",
  url: "https://gswiki.play.net/greater_faeroth",
  picture: "",
  level: 50,
  family: "Faeroth",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: true,
  otherclass: [
    "Living",
    "Boss"
  ],
  bcs: true,
  max_hp: 300,
  speed: nil,
  height: 7,
  size: "large",
  areas: [
    {
      name: "Gyldemar Forest",
      uids: [13030041..13030076]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (302..342)
      },
      {
        name: "Claw",
        as: (318..340)
      },
      {
        name: "Pound",
        as: (305..338)
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
    asg: "12N",
    immunities: [],
    melee: (269..472),
    ranged: 269,
    bolt: 269,
    udf: 342,
    bar_td: nil,
    cle_td: 175,
    emp_td: (173..182),
    pal_td: (147..153),
    ran_td: nil,
    sor_td: (175..193),
    wiz_td: nil,
    mje_td: 195,
    mne_td: 194,
    mjs_td: nil,
    mns_td: (164..184),
    mnm_td: (147..150),
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
    boxes: false,
    skin: "a faeroth fang",
    other: nil
  },
  messaging: {
    description: [
      "The greater faeroth looks as though he might be a relative to a yeti, although his fur is a mottled dingy brown and carries a pungent stench. Similar to its lesser cousin, the greater faeroth stands on mighty forelimbs that lift his entire body into the air. Much more powerful hind legs dangle with sharp, filthy claws extruding. The beast stands at least seven feet tall, with a face that might look human if not for the heavy brow and deeply set eyes. Black lips curl over ivory white teeth that appear to drip some sort of vile green liquid."
    ],
    arrival: [],
    flee: [],
    death: [
      "A greater faeroth emits a roar as he goes still.",
      "A greater faeroth emits a roar as she goes still.",
      "A greater faeroth releases a roar as she falls to the ground and goes still.",
      "A greater faeroth releases a roar as he falls to the ground and goes still."
    ],
    decay: [
      "A greater faeroth decays into a pile of foul-smelling compost."
    ],
    search: [],
    spell_prep: [],
    attack: [],
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
