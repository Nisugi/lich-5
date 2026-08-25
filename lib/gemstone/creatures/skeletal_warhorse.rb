{
  schema_version: 3,
  name: "skeletal warhorse",
  noun: "",
  url: "https://gswiki.play.net/skeletal_warhorse",
  picture: "",
  level: 37,
  family: "Equine",
  type: "Quadruped",
  undead: true,
  blood: nil,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 407,
  speed: nil,
  height: 6,
  size: "large",
  areas: [
    {
      name: "Castle Varunar",
      uids: [4750034..4750039, 4750071..4750076]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Charge",
        as: 262
      },
      {
        name: "Stomp",
        as: 240
      },
      {
        name: "Foot",
        as: 235
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Kick"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (183..248),
    ranged: 194,
    bolt: 194,
    udf: 220,
    bar_td: nil,
    cle_td: 111,
    emp_td: (111..120),
    pal_td: nil,
    ran_td: nil,
    sor_td: (102..114),
    wiz_td: nil,
    mje_td: 111,
    mne_td: 111,
    mjs_td: nil,
    mns_td: 114,
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
    skin: "a skeletal warhorse jaw",
    other: nil
  },
  messaging: {
    description: [
      "A bulky skeleton belies the skeletal warhorse's speed and quick reflexes. Even encased in heavy steel barding and lacking its muscular body, the warhorse charges, stomps and bites with the same ferocity it displayed in life. Now, long decomposed, its hide has turned to a moldy gray and the once-proud mane hangs in tattered strands."
    ],
    arrival: [
      "A skeletal warhorse just arrived."
    ],
    flee: [],
    death: [
      "The skeletal warhorse falls to the ground motionless.",
      "The skeletal warhorse wails in terrifying pain one last time and lies still."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A skeletal warhorse charges at you!",
      "A skeletal warhorse stomps at you with {pronoun} foot!"
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
