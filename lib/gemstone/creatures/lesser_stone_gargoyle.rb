{
  schema_version: 3,
  name: "lesser stone gargoyle",
  noun: "",
  url: "https://gswiki.play.net/lesser_stone_gargoyle",
  picture: "",
  level: 27,
  family: "Gargoyle",
  type: "Biped",
  undead: false,
  blood: true,
  bones: false,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 318,
  speed: nil,
  height: 13,
  size: "huge",
  areas: [
    {
      name: "Darkstone Castle",
      uids: [45107..45118]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 180
      },
      {
        name: "Claw",
        as: 201
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
    melee: (89..99),
    ranged: nil,
    bolt: nil,
    udf: nil,
    bar_td: nil,
    cle_td: nil,
    emp_td: 88,
    pal_td: nil,
    ran_td: nil,
    sor_td: 92,
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
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "Like its cousin, the stone gargoyle, the lesser stone gargoyle was a grey, granite carving originally placed to overlook the castle's walls. Now animated, it pounds about on powerful hind legs looking for beings it can smash into dust. It has a demon's face, with pointed beard, ruby eyes and long, sweeping goat horns. Bat wings, useless for flying, adorn its scaly back."
    ],
    arrival: [],
    flee: [],
    death: [
      "A lesser stone gargoyle goes limp as it is rendered unconscious!"
    ],
    decay: [
      "A lesser stone gargoyle crumbles to dust."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A lesser stone gargoyle tries to bite you!"
    ],
    claw: [
      "A lesser stone gargoyle claws at you!"
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
