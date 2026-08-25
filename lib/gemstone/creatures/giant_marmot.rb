{
  schema_version: 3,
  name: "giant marmot",
  noun: "",
  url: "https://gswiki.play.net/giant_marmot",
  picture: "",
  level: 10,
  family: "Rodent",
  type: "Quadruped",
  undead: false,
  blood: true,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Living"
  ],
  bcs: true,
  max_hp: 150,
  speed: nil,
  height: 1,
  size: "medium",
  areas: [
    {
      name: "Yander's Farm",
      uids: [14005038..14005053]
    },
    {
      name: "Smuggling Tunnels",
      uids: [37002..37041]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 131
      },
      {
        name: "Claw",
        as: (121..131)
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
    asg: "8N",
    immunities: [],
    melee: (88..117),
    ranged: 84,
    bolt: 83,
    udf: 102,
    bar_td: 30,
    cle_td: nil,
    emp_td: 30,
    pal_td: nil,
    ran_td: 30,
    sor_td: 30,
    wiz_td: nil,
    mje_td: 30,
    mne_td: 30,
    mjs_td: nil,
    mns_td: 30,
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
    coins: false,
    magic_items: false,
    gems: false,
    boxes: false,
    skin: "a marmot pelt",
    other: "No"
  },
  messaging: {
    description: [
      "Normally rodents don't grow this big, but these must have been eating something special. The giant marmot is as long as a human is tall. Thick-bodied, with coarse, brown fur and a stubby tail, the giant marmot still moves with amazing speed, zipping around obstacles and through doorways in search of its next meal. Fresh blood and pieces of flesh surrounding its mouth indicate that it's been using its long incisors to gnaw on something that probably didn't wish to be gnawed on."
    ],
    arrival: [],
    flee: [],
    death: [
      "The giant marmot collapses to the ground, emits a final squeal, and dies.",
      "The giant marmot collapses to the ground, emits a final silent squeal, and dies.",
      "The giant marmot twitches and dies.",
      "The giant marmot twitches violently, then dies.",
      "A giant marmot goes limp as it is rendered unconscious!"
    ],
    decay: [
      "A giant marmot decays into a pile of hair and bone."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [
      "A giant marmot tries to bite you!"
    ],
    claw: [
      "A giant marmot claws at you!"
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
