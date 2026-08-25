{
  schema_version: 3,
  name: "shambling lurk",
  noun: "",
  url: "https://gswiki.play.net/shambling_lurk",
  picture: "",
  level: 95,
  family: "Zombie",
  type: "Biped",
  undead: true,
  blood: nil,
  bones: true,
  muggable: nil,
  boss: false,
  otherclass: [
    "Corporeal undead"
  ],
  bcs: true,
  max_hp: 550,
  speed: nil,
  height: 6,
  size: "medium",
  areas: [
    {
      name: "Shadow of the Sanctum",
      uids: [4216001..4216049]
    }
  ],
  attack_attributes: {
    physical_attacks: [
      {
        name: "Bite",
        as: 450
      },
      {
        name: "Bloated arms",
        as: 470
      },
      {
        name: "Strike",
        as: 459
      }
    ],
    bolt_spells: [
      {
        name: "Web (118)",
        as: 417
      }
    ],
    warding_spells: [],
    offensive_spells: [
      {
        name: "Elemental Wave"
      }
    ],
    maneuvers: [
      {
        name: "Vomit"
      },
      {
        name: "Bite"
      },
      {
        name: "Gesture"
      },
      {
        name: "Strike"
      }
    ],
    special_notes: []
  },
  defense_attributes: {
    asg: "1",
    immunities: [],
    melee: (329..584),
    ranged: (358..377),
    bolt: nil,
    udf: 700,
    bar_td: nil,
    cle_td: nil,
    emp_td: 416,
    pal_td: 342,
    ran_td: 352,
    sor_td: nil,
    wiz_td: nil,
    mje_td: 465,
    mne_td: 461,
    mjs_td: nil,
    mns_td: nil,
    mnm_td: nil,
    defensive_spells: [],
    defensive_abilities: [],
    special_defenses: []
  },
  special_other: "Animate dead characters",
  abilities: [],
  alchemy: [],
  abilities_misc: [],
  equipment: [],
  treasure: {
    coins: nil,
    magic_items: nil,
    gems: nil,
    boxes: nil,
    skin: nil,
    other: nil
  },
  messaging: {
    description: [
      "Not dead so long that its body has begun to lose the unwinnable war against decay, a shambling lurk is firmly in the grip of rigor mortis. Its face is paralyzed in a slack-jawed smile that reveals broken teeth and a dry and swollen tongue. From the viridian firelight dancing in its eyes, it is clear that it is beyond the services of a cleric, except perhaps to grant the blessing of a swift release."
    ],
    arrival: [
      "A shambling lurk just arrived.",
      "Vital fluids seeping from its orifices, a shambling lurk shambles in with a piteous moan."
    ],
    flee: [],
    death: [],
    decay: [
      "Decay rapidly races over a shambling lurk's form as it collapses into foul-smelling compost."
    ],
    search: [],
    spell_prep: [],
    attack: [
      "A patchwork flesh monstrosity tries to ensnare you with shambling lurk bloated arms!",
      "A shambling lurk manages a fumbling gesture toward you!",
      "A sheen of venom glistening from shambling lurk needle-sharp fangs, a white sidewinder strikes at you!",
      "Desperate in shambling lurk hunger for flesh, a shambling lurk throws itself at you!",
      "Gnawing blindly with shattered teeth, a shambling lurk tries to bite into you!"
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
