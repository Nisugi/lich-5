{
  schema_version: 3,
  name: "centaur",
  noun: "",
  url: "https://gswiki.play.net/centaur",
  picture: "",
  level: 23,
  family: "Centaur",
  type: "Hybrid",
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
  max_hp: 265,
  speed: nil,
  height: 7,
  size: "large",
  areas: [
    {
      name: "Rambling Meadows",
      uids: [14006041..14006046, 14006048..14006060]
    },
    {
      name: "Vornavian Coast",
      uids: [4218101..4218121]
    },
    {
      name: "Locksmehr Trail",
      uids: [13001043..13001079]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Longsword",
        as: 208
      },
      {
        name: "Greatsword",
        as: 208
      },
      {
        name: "Scimitar",
        as: 166
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Kick"
      },
      {
        name: "Bull Rush"
      },
      {
        name: "Charge"
      },
      {
        name: "Tail Swipe"
      }
    ],
    special_abilities: [],
    special_notes: []
  },
  defense_attributes: {
    asg: "10",
    immunities: [],
    melee: (127..233),
    ranged: (125..155),
    bolt: nil,
    udf: 246,
    bar_td: (69..75),
    cle_td: (66..75),
    emp_td: (69..77),
    pal_td: nil,
    ran_td: nil,
    sor_td: (66..75),
    wiz_td: nil,
    mje_td: (63..72),
    mne_td: 69,
    mjs_td: nil,
    mns_td: (66..75),
    mnm_td: (66..75),
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
    skin: "a centaur hide",
    other: "Glimmering blue essence shard"
  },
  messaging: {
    description: [
      "Seeming to be a blend of mannish torso upon the body of a light horse, the centaur has a certain charm and aura of mystery. That is, until you encounter one, for the centaur is a savage and wilder cousin to the great centaurs of legend and will lash out in terrible fury when it deems a threat is at hand. Their hide which varies in color from tan, black, white or roan is valued for its toughness and durability and thus, many will brave the danger of flying hooves and the threat held by these fierce creatures to gain this prize."
    ],
    arrival: [],
    flee: [],
    death: [
      "The white centaur falls to the ground and dies.",
      "The white centaur screams one last time and dies.",
      "The bay centaur falls to the ground and dies.",
      "The tan centaur screams one last time and dies.",
      "The roan centaur falls to the ground and dies.",
      "The bay centaur screams one last time and dies.",
      "The black centaur falls to the ground and dies.",
      "The tan centaur falls to the ground and dies.",
      "The roan centaur screams one last time and dies.",
      "The black centaur screams one last time and dies.",
      "A roan centaur goes limp as he is rendered unconscious!",
      "A black centaur goes limp as he is rendered unconscious!",
      "A tan centaur goes limp as she is rendered unconscious!",
      "A roan centaur goes limp as she is rendered unconscious!",
      "A white centaur goes limp as she is rendered unconscious!",
      "A white centaur goes limp as he is rendered unconscious!",
      "A bay centaur goes limp as he is rendered unconscious!"
    ],
    decay: [
      "A white centaur dissolves into a puff of red smoke.",
      "A bay centaur dissolves into a puff of red smoke.",
      "A tan centaur dissolves into a puff of red smoke.",
      "A roan centaur dissolves into a puff of red smoke.",
      "A black centaur dissolves into a puff of red smoke.",
      "Acid dissolves connecting cartilage, freeing the bay centaur's ribs to move independently."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A centaur swings {weapon} at you!",
      "A centaur throws {weapon} at you!",
      "Tightening centaur grip on centaur greatsword, a black centaur strikes out at you with all of centaur might!",
      "Tightening centaur grip on centaur polished longsword, a tan centaur strikes out at you with all of centaur might!",
      "Tightening centaur grip on centaur polished longsword, a white centaur strikes out at you with all of centaur might!"
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
