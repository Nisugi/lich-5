{
  schema_version: 3,
  name: "grisly corpse hulk",
  noun: "",
  url: "https://gswiki.play.net/grisly_corpse_hulk",
  picture: "",
  level: 55,
  family: "Humanoid",
  type: "Biped",
  undead: true,
  blood: false,
  bones: true,
  witherable: nil,
  sympathy: nil,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 432,
  speed: nil,
  height: 8,
  size: "large",
  areas: [
    {
      name: "Crawling Shore",
      uids: [4576101..4576126, 4576151..4576160]
    },
    {
      name: "unmapped",
      uids: [4576127..4576150]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Stomp (attack)",
        as: 310
      },
      {
        name: "Closed fist",
        as: 310
      },
      {
        name: "Ensnare",
        as: 326
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Tackle"
      }
    ],
    special_abilities: [
      {
        name: "Tremors"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: (178..385),
    ranged: nil,
    bolt: nil,
    udf: (391..469),
    bar_td: nil,
    cle_td: nil,
    emp_td: (184..188),
    pal_td: nil,
    ran_td: nil,
    sor_td: (187..197),
    wiz_td: nil,
    mje_td: 197,
    mne_td: nil,
    mjs_td: nil,
    mns_td: (176..186),
    mnm_td: 168,
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
    skin: "No",
    other: nil
  },
  messaging: {
    description: [
      "A grisly corpse hulk is a collection of corpse parts roughly arranged into a humanoid form within a handspan of a giant's height. Milky pinkish fluid drips from the uneven stitches that hold its body together. Its eyes are tiny and appear piggish in such an oversized head. They hold only a rudimentary spark of intellect. \n\nAppraisal:\nThe corpse hulk is large in size, about eight feet high in its current state."
    ],
    arrival: [],
    flee: [],
    death: [
      "Torn and strained stitches pop all over a grisly corpse hulk's body as it surrenders to death, allowing necrotic organs and ichor to spill free."
    ],
    decay: [],
    search: [],
    spell_prep: [],
    attack: [
      "A desiccated half-krolvin strigoi flings grisly corpse hulk arms wide and throws herself at you, trying to trap you in a deadly embrace!",
      "A desiccated half-krolvin strigoi flings grisly corpse hulk arms wide and throws himself at you, trying to trap you in a deadly embrace!",
      "A grisly corpse hulk spreads grisly corpse hulk sloughing arms and tries to lock you in a bearhug!",
      "A grisly corpse hulk tries to stomp on you with one massive, rotting foot!"
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
