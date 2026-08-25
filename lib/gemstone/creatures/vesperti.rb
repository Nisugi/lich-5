{
  schema_version: 3,
  name: "vesperti",
  noun: "",
  url: "https://gswiki.play.net/vesperti",
  picture: "",
  level: 38,
  family: "Vesperti",
  type: "Biped",
  undead: false,
  blood: false,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Anti-mana"
  ],
  bcs: true,
  max_hp: 240,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Deep Woods",
      uids: [4007001..4007038]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Flail",
        as: 229
      },
      {
        name: "Whip",
        as: 229
      },
      {
        name: "Scimitar",
        as: 229
      },
      {
        name: "Blackened cutlass",
        as: 202
      }
    ],
    bolt_spells: [],
    warding_spells: [
      {
        name: "Energy Maelstrom (710)"
      },
      {
        name: "Pain (711)"
      },
      {
        name: "Curse (715)"
      },
      {
        name: "Pestilence (716)"
      },
      {
        name: "Mana Drain"
      }
    ],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Charge"
      }
    ],
    special_abilities: [
      {
        name: "Dodge"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "6N",
    immunities: ["magic"],
    melee: (254..268),
    ranged: 261,
    bolt: 261,
    udf: 328,
    bar_td: nil,
    cle_td: nil,
    emp_td: nil,
    pal_td: nil,
    ran_td: nil,
    sor_td: nil,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
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
    skin: "a vesperti claw",
    other: "Glowing violet essence dust"
  },
  messaging: {
    description: [
      "The vesperti stands roughly six feet tall, with coarse black fur covering his willowy frame. A veined membrane of skin extends from his ankle up to his wrists, edges scalloped like those of a bat's wings. Capping off the wings are taloned hands and feet, the long, tapered digits bearing glossy black claws. Intense eyes stare out from beneath a mane of tousled hair, looking far too sentient for any measure of comfort."
    ],
    arrival: [
      "With a flurry of his wings, a vesperti flies in!",
      "With a flurry of her wings, a vesperti flies in!"
    ],
    flee: [
      "With a flurry of her wings, a lustrous vesperti flies {direction}.",
      "With a flurry of his wings, a vesperti flies {direction}.",
      "With a flurry of her wings, a vesperti flies {direction}."
    ],
    death: [
      "A vesperti goes limp as he is rendered unconscious!",
      "A vesperti goes limp as she is rendered unconscious!",
      "The vesperti twitches violently, then dies."
    ],
    decay: [
      "Acid dissolves connecting cartilage, freeing the vesperti's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A vesperti swings {weapon} at you!"
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
