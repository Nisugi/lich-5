{
  schema_version: 3,
  name: "agresh troll chieftain",
  noun: "",
  url: "https://gswiki.play.net/agresh_troll_chieftain",
  picture: "",
  level: 20,
  family: "Troll",
  type: "Biped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 250,
  speed: nil,
  height: 9,
  size: "large",
  areas: [
    {
      name: "Grasslands",
      uids: [14012100..14012120, 14012150..14012165]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Flail",
        as: 247
      },
      {
        name: "Military pick",
        as: 227
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "+40 AS boost"
      },
      {
        name: "Pounce"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "12",
    immunities: [],
    melee: (75..195),
    ranged: (89..104),
    bolt: (89..104),
    udf: 133,
    bar_td: 67,
    cle_td: nil,
    emp_td: 60,
    pal_td: nil,
    ran_td: nil,
    sor_td: 71,
    wiz_td: nil,
    mje_td: 67,
    mne_td: 67,
    mjs_td: nil,
    mns_td: 75,
    mnm_td: nil,
    defensive_spells: [
      "Spirit Warding II (107)"
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
    other: "Glimmering blue essence shardGlimmering blue mote of essence"
  },
  messaging: {
    description: [
      "The troll chieftain splatters its surroundings with flecks of spittle as it lifts its head and snarls. Crudely drawn symbols painted with ash on its face do little to improve its gruesome visage as it scrunches its face into an expression of rage. Tufts of golden hair on its otherwise barren body make it look that much more ugly."
    ],
    arrival: [
      "An Agresh troll chieftain just arrived!"
    ],
    flee: [],
    death: [
      "The troll chieftain bellows in rage one last time and dies.",
      "An Agresh troll chieftain goes limp as she is rendered unconscious!"
    ],
    decay: [
      "An Agresh troll chieftain decays into compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "An Agresh troll chieftain swings {weapon} at you!"
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
