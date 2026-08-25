{
  schema_version: 3,
  name: "mastodonic leopard",
  noun: "",
  url: "https://gswiki.play.net/mastodonic_leopard",
  picture: "",
  level: 44,
  family: "Feline",
  type: "Quadruped",
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
  max_hp: 400,
  speed: nil,
  height: 3,
  size: "large",
  areas: [
    {
      name: "Gyldemar Forest",
      uids: [13028001..13028037, 13028084..13028091]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: (242..269)
      },
      {
        name: "Claw",
        as: 279
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Caterwaul"
      },
      {
        name: "Leap"
      }
    ],
    special_abilities: [
      {
        name: "Pounce"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "10N",
    immunities: [],
    melee: (235..252),
    ranged: 211,
    bolt: nil,
    udf: 296,
    bar_td: 135,
    cle_td: nil,
    emp_td: (148..157),
    pal_td: nil,
    ran_td: 132,
    sor_td: (157..163),
    wiz_td: nil,
    mje_td: 158,
    mne_td: 166,
    mjs_td: nil,
    mns_td: 142,
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
    gems: nil,
    boxes: nil,
    skin: "a spotted leopard pelt",
    other: nil
  },
  messaging: {
    description: [
      "The mastodonic leopard has a long, narrow body, relatively short muscular legs and large broad paws. His large, broad tail is used for balancing himself in the trees. Two alert yellow eyes gaze over his broad snout, capped on the leopard's narrow head by his tufted ears. Most striking are his markings: six large, narrow, brown blotches, edged in black, with pale areas separating the blotches on his sides. Along his back, the leopard has a series of large open-centered spots, and his underside is solidly pale. The mastodonic leopard's square jaw and extra long canine teeth, characteristic of the northern sabre-toothed tiger, are ideal for shredding meat."
    ],
    arrival: [
      "A mastodonic leopard prowls in!",
      "A mastodonic leopard crouches as she stalks into view!",
      "A mastodonic leopard crouches as he stalks into view!",
      "A stalwart mastodonic leopard prowls in!"
    ],
    flee: [],
    death: [
      "The mastodonic leopard lets out a final caterwaul and dies.",
      "The mastodonic leopard crumples to the ground and dies.",
      "A mastodonic leopard goes limp as he is rendered unconscious!",
      "A mastodonic leopard goes limp as she is rendered unconscious!"
    ],
    decay: [
      "A mastodonic leopard decays into a compost of fangs, fur and claws.",
      "A robust mastodonic leopard decays into a compost of fangs, fur and claws.",
      "A stalwart mastodonic leopard decays into a compost of fangs, fur and claws."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A mastodonic leopard tries to bite you!"
    ],
    claw: [
      "A mastodonic leopard claws at you!"
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
