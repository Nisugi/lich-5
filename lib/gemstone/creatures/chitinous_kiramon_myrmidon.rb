{
  schema_version: 3,
  name: "chitinous kiramon myrmidon",
  noun: "",
  url: "https://gswiki.play.net/chitinous_kiramon_myrmidon",
  picture: "",
  level: 102,
  family: "Kiramon",
  type: "Insect",
  undead: false,
  blood: nil,
  bones: nil,
  witherable: true,
  sympathy: true,
  muggable: true,
  sleepable: nil,
  boss: false,
  boss_type: nil,
  otherclass: [],
  bcs: true,
  max_hp: 500,
  speed: nil,
  height: 7,
  size: "large",
  areas: [
    {
      name: "The Hive",
      uids: [13041101..13041132, 13041201..13041230, 13041301..13041329]
    },
    {
      name: "unmapped",
      uids: [13041330..13041330]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite"
      },
      {
        name: "Pincer (attack)"
      },
      {
        name: "Bladed forelegs",
        as: (532..541)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Feint"
      },
      {
        name: "Headbutt"
      },
      {
        name: "Crowd Press"
      },
      {
        name: "Charge"
      }
    ],
    special_abilities: [
      {
        name: "Kiramon lunge"
      },
      {
        name: "Durable Carapace"
      },
      {
        name: "Chitin Disarm"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "20N",
    immunities: [],
    melee: nil,
    ranged: (225..474),
    bolt: (225..474),
    udf: 822,
    bar_td: nil,
    cle_td: (402..408),
    emp_td: 420,
    pal_td: (360..369),
    ran_td: (366..375),
    sor_td: nil,
    wiz_td: nil,
    mje_td: nil,
    mne_td: nil,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: [
      "Brace-like effect",
      "Durable carapace"
    ]
  },
  special_other: nil,
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: true,
    boxes: false,
    skin: "some glossy kiramon chitin",
    other: nil
  },
  messaging: {
    description: [
      "The myrmidon's chitin is a cold and lustrous black, infused with an oil slick of darkly rainbowed colors that are almost hypnotically beautiful to behold. Clusters of barbed spines protrude from the upper segments of his spindly arms, each of which ends in a sharp scythe-like claw. Above a set of oversized, prehensile mandibles, the kiramon myrmidon's orb-shaped eyes are a sullen red and are faceted like pristine rubies. They are possessed of an intellect that is as vast as it is otherworldly."
    ],
    arrival: [],
    flee: [],
    death: [
      "A chitinous kiramon myrmidon collapses, its forelegs spasming and twitching before it at last surrenders to death.",
      "A chitinous kiramon myrmidon collapses, his forelegs spasming and twitching before he at last surrenders to death."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A chitinous kiramon myrmidon strikes out at you with all of chitinous kiramon myrmidon might!",
      "Bringing {pronoun} forelegs together, a chitinous kiramon myrmidon attempts to pincer you!",
      "Surging forward powerfully, a chitinous kiramon myrmidon slashes at you with {pronoun} bladed forelegs!"
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
