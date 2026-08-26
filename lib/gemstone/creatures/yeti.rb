{
  schema_version: 3,
  name: "yeti",
  noun: "",
  url: "https://gswiki.play.net/yeti",
  picture: "",
  level: 67,
  family: "Yeti",
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
  max_hp: 400,
  speed: nil,
  height: 12,
  size: "huge",
  areas: [
    {
      name: "Griffin's Keen",
      uids: [13302101..13302169]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Pound",
        as: (347..359)
      },
      {
        name: "Stomp",
        as: (312..347)
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Ground Slap"
      },
      {
        name: "Hurl Boulder (510)"
      },
      {
        name: "Stomp"
      },
      {
        name: "Ground Slam"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "12N",
    immunities: [],
    melee: (357..465),
    ranged: nil,
    bolt: nil,
    udf: 588,
    bar_td: (226..247),
    cle_td: (251..257),
    emp_td: (256..265),
    pal_td: (216..222),
    ran_td: nil,
    sor_td: (266..275),
    wiz_td: nil,
    mje_td: 285,
    mne_td: 283,
    mjs_td: nil,
    mns_td: (247..256),
    mnm_td: (200..209),
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
      "Standing almost twelve feet tall, the yeti is a large humanoid creature covered in long, stringy black and red hair. His domed pate is matted with twigs and dirt, and his heavy brow forms a shelf over his tiny black eyes. With arms nearly long enough to brush the ground, the yeti has a ferociously strong grip and excellent leverage for the tossing of heavy objects. Broad, flat feet provide stability and traction in the icy, mountainous environments that are his normal habitat."
    ],
    arrival: [
      "A giant shadow towers over the area as a yeti stomps in!",
      "A yeti stomps in!",
      "A yeti moans as it stomps in!",
      "A yeti roars in pain as it stomps in!"
    ],
    flee: [
      "A yeti spins around and retreats as far as it can."
    ],
    death: [
      "A yeti goes limp as it is rendered unconscious!",
      "The mass of hair and bone that was the yeti finally goes still.",
      "The yeti collapses into a pile of hair and bones and goes still."
    ],
    decay: [
      "The yeti collapses into a pile of hair and bones and goes still."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A yeti raises yeti hairy foot and attempts to stomp you into the ground!"
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
