{
  schema_version: 3,
  name: "bog troll",
  noun: "",
  url: "https://gswiki.play.net/bog_troll",
  picture: "",
  level: 35,
  family: "Troll",
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
  max_hp: 400,
  speed: nil,
  height: 10,
  size: "large",
  areas: [
    {
      name: "Miasmal Forest",
      uids: [5003001..5003027, 5003030..5003030, 5003032..5003032, 5003036..5003050, 5004001..5004034]
    },
    {
      name: "unmapped",
      uids: [5003028..5003029, 5003031..5003031, 5003033..5003035]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Thick Wooden Knurl",
        as: (244..314)
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
    melee: (135..243),
    ranged: 147,
    bolt: 172,
    udf: 214,
    bar_td: nil,
    cle_td: nil,
    emp_td: 120,
    pal_td: nil,
    ran_td: nil,
    sor_td: (122..130),
    wiz_td: nil,
    mje_td: 124,
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
    skin: "troll ear",
    other: nil
  },
  messaging: {
    description: [
      "Hunched over and bow-legged, the bog troll bears many resemblances to the frogs that inhabit the bogs along with it. Its skin is a dark yellow mottled with patches of brownish green. Its mouth, wide and thick-lipped, displays rows of misaligned, jagged teeth, and the troll keeps a constant grin, as if its teeth are too large for it to completely close its mouth. Bulbous green eyes sit nearly atop its flat cranium, and sharp claws extend from its oversized, webbed hands and feet."
    ],
    arrival: [
      "A bog troll lumbers in, his face set in an angry scowl!",
      "A bog troll lumbers in, her face set in an angry scowl!",
      "A bog troll just arrived!"
    ],
    flee: [],
    death: [
      "A bog troll goes limp as she is rendered unconscious!",
      "A bog troll goes limp as he is rendered unconscious!",
      "The bog troll twitches violently, then dies."
    ],
    decay: [
      "A bog troll decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A bog troll swings {weapon} at you!"
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
