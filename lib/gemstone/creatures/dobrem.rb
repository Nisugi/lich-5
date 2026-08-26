{
  schema_version: 3,
  name: "dobrem",
  noun: "",
  url: "https://gswiki.play.net/dobrem",
  picture: "",
  level: 28,
  family: "Canine",
  type: "Quadruped",
  undead: false,
  blood: nil,
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
  max_hp: 250,
  speed: nil,
  height: 3,
  size: "medium",
  areas: [
    {
      name: "Outlands",
      uids: [2152003..2152029, 4215100..4215118, 4215133..4215160, 4215164..4215182]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite"
      },
      {
        name: "Claw",
        as: 198
      }
    ],
    bolt_spells: [],
    warding_spells: [],
    offensive_spells: [],
    maneuvers: [
      {
        name: "Canine lunge"
      },
      {
        name: "Lunge"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: nil,
    immunities: [],
    melee: "+140 to +160 DS",
    ranged: nil,
    bolt: "+154 DS",
    udf: 172,
    bar_td: "+84 TD",
    cle_td: "+84 TD",
    emp_td: (76..84),
    pal_td: "+84 TD",
    ran_td: "+84 TD",
    sor_td: "+84 TD",
    wiz_td: "+84 TD",
    mje_td: "+84 TD",
    mne_td: "+84 TD",
    mjs_td: "+84 TD",
    mns_td: "+84 TD",
    mnm_td: "+84 TD",
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
    skin: "a dobrem snout",
    other: "no"
  },
  messaging: {
    description: [
      "The dobrem is a dog of medium size, with a body that is square, compactly built, muscular and powerful. The fierce animal is elegant in appearance, of proud carriage, reflecting great nobility. Almost three feet tall at the shoulders, the dobrem is covered by short black fur with sharply defined rust coloured markings appearing about each eye and on muzzle, throat and forechest, on all legs and feet and below the tail."
    ],
    arrival: [],
    flee: [],
    death: [
      "The dobrem falls to the ground and dies.",
      "The dobrem rolls over and dies.",
      "The dobrem yelps loudly as she slumps to the ground and licks her wounded right paw.",
      "The dobrem yelps loudly as she slumps to the ground and licks her wounded right foreleg."
    ],
    decay: [
      "A dobrem decays into a compost of fangs and fur."
    ],
    search: [],
    spell_prep: [],
    attack: [],
    bite: [],
    claw: [
      "A dobrem claws at you!"
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
