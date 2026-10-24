# frozen_string_literal: true

require_relative '../../spec_helper'

load_spell_data

require "common/sharedbuffer"
require "common/buffer"
require "games"

Spell = Lich::Common::Spell unless defined?(Spell)

require "gemstone/overwatch"
require "gemstone/infomon"
require "attributes/stats"
require "attributes/resources"
require "attributes/skills"
require "attributes/spells"
require "gemstone/currency"
require "gemstone/infomon/status"
require "gemstone/experience"
require "util/util"
require "gemstone/psms"
require "gemstone/psms/ascension"
require "gemstone/group"

Skills = Lich::Gemstone::Skills unless defined?(Skills)
Spells = Lich::Gemstone::Spells unless defined?(Spells)

# The caster of a group (EVOKE) spell gets no messaging about who it landed
# on, so Group records a cooldown for everyone grouped at the time and lets
# the next casting correct any member it guessed wrong about.
RSpec.describe Lich::Gemstone::Group, 'per-target group spell cooldowns' do
  let(:spell) { Spell[215] } # Heroism: 180s cooldown on the EVOKE version

  def member(name)
    double(noun: name, id: name.hash.to_s)
  end

  before do
    Lich::Gemstone::Group.spell_cooldowns.clear
    grouped = [member('Grhim'), member('Painz')]
    allow(Lich::Gemstone::Group).to receive(:_members).and_return(grouped)
    allow(Lich::Gemstone::Group).to receive(:members).and_return(grouped)
    allow(spell).to receive(:group_cooldown).and_return(180)
  end

  after { Lich::Gemstone::Group.spell_cooldowns.clear }

  it 'reports an unknown member as ready with no time left' do
    expect(described_class.spell_cooldown_ready?(spell, 'Bransen')).to be true
    expect(described_class.spell_cooldown_left(spell, 'Bransen')).to eq 0.0
  end

  it 'puts every grouped member on cooldown when a group casting lands' do
    described_class.record_spell_cooldown(spell)
    expect(described_class.spell_cooldown_ready?(spell, 'Grhim')).to be false
    expect(described_class.spell_cooldown_left(spell, 'Grhim')).to be_within(2).of(180)
  end

  it 'reports a member as ready once the cooldown has elapsed' do
    described_class.record_spell_cooldown(spell)
    described_class.spell_cooldowns[spell.num]['Grhim'] = Time.now - 1
    expect(described_class.spell_cooldown_ready?(spell, 'Grhim')).to be true
    expect(described_class.spell_cooldown_left(spell, 'Grhim')).to eq 0.0
  end

  it 'never reports negative time left' do
    described_class.spell_cooldowns[spell.num] = { 'Grhim' => Time.now - 500 }
    expect(described_class.spell_cooldown_left(spell, 'Grhim')).to eq 0.0
  end

  it 'leaves someone who joined after the casting ready' do
    described_class.record_spell_cooldown(spell)
    expect(described_class.spell_cooldown_ready(spell)).to be_empty

    allow(Lich::Gemstone::Group).to receive(:members)
      .and_return([member('Grhim'), member('Bransen')])
    expect(described_class.spell_cooldown_ready(spell)).to eq ['Bransen']
  end

  it 'leaves a member who is still locked out on their own cooldown' do
    described_class.record_spell_cooldown(spell)
    # 60 of the 180 seconds gone, then a casting for someone who just joined
    described_class.spell_cooldowns[spell.num]['Grhim'] = Time.now + 120
    described_class.record_spell_cooldown(spell)
    expect(described_class.spell_cooldown_left(spell, 'Grhim')).to be_within(2).of(120)
  end

  it 'stamps a member whose cooldown has run out' do
    described_class.record_spell_cooldown(spell)
    described_class.spell_cooldowns[spell.num]['Grhim'] = Time.now - 1
    described_class.record_spell_cooldown(spell)
    expect(described_class.spell_cooldown_left(spell, 'Grhim')).to be_within(2).of(180)
  end

  it 'does not send GROUP from the parser thread' do
    expect(described_class).not_to receive(:check)
    expect(described_class).not_to receive(:maybe_check)
    described_class.record_spell_cooldown(spell)
    expect(described_class.spell_cooldown_left(spell, 'Grhim')).to be > 0
  end

  it 'records nothing for a spell with no per-target cooldown' do
    allow(spell).to receive(:group_cooldown).and_return(nil)
    described_class.record_spell_cooldown(spell)
    expect(described_class.spell_cooldowns[spell.num]).to be_nil
    expect(described_class.spell_cooldown_ready?(spell, 'Grhim')).to be true
  end

  it 'keeps separate cooldowns per spell' do
    other = Spell[219]
    allow(other).to receive(:group_cooldown).and_return(360)
    described_class.record_spell_cooldown(spell)
    expect(described_class.spell_cooldown_ready?(other, 'Grhim')).to be true
  end

  it 'keeps a nearly-expired stamp rather than extending it' do
    described_class.record_spell_cooldown(spell)
    described_class.spell_cooldowns[spell.num]['Grhim'] = Time.now + 5
    described_class.record_spell_cooldown(spell)
    expect(described_class.spell_cooldown_left(spell, 'Grhim')).to be_within(2).of(5)
  end
end

# The trigger side: only the caster's own group (EVOKE) message starts the
# cooldowns. A self-cast, or seeing someone else's casting land on you, uses
# the same spell and must not stamp anyone.
RSpec.describe Lich::Gemstone::Infomon::Parser, 'group casting messages' do
  let(:heroism) { Spell[215] }
  let(:spell_shield) { Spell[219] }

  def member(name)
    double(noun: name, id: name.hash.to_s)
  end

  before do
    allow(Lich::Gemstone::Infomon).to receive(:set)
    allow(Lich::Gemstone::Spells).to receive(:require_cooldown)
    allow(XMLData).to receive(:level).and_return(100)
    allow(XMLData).to receive(:name).and_return('Nisugi')
    allow(Lich::Gemstone::Spells).to receive(:majorspiritual).and_return(50)
    allow(Lich::Gemstone::Group).to receive(:_members).and_return([member('Grhim')])
    allow(heroism).to receive(:group_cooldown).and_return(180)
    allow(spell_shield).to receive(:group_cooldown).and_return(360)
    Lich::Gemstone::Group.spell_cooldowns.clear
    heroism.putdown
    spell_shield.putdown
  end

  after do
    Lich::Gemstone::Group.spell_cooldowns.clear
    heroism.putdown
    spell_shield.putdown
  end

  it "starts cooldowns on the caster's own group casting" do
    described_class.parse('A brilliant aura surrounds you and your group.  You feel charged with extra vitality.')
    expect(Lich::Gemstone::Group.spell_cooldown_ready?(heroism, 'Grhim')).to be false
    expect(Lich::Gemstone::Group.spell_cooldown_left(heroism, 'Grhim')).to be_within(2).of(180)
  end

  it 'starts no cooldowns on a self-cast of the same spell' do
    described_class.parse('A brilliant aura surrounds you and sinks into your skin.  You feel charged with extra vitality.')
    expect(Lich::Gemstone::Group.spell_cooldowns[heroism.num]).to be_nil
    expect(Lich::Gemstone::Group.spell_cooldown_ready?(heroism, 'Grhim')).to be true
  end

  it 'starts no cooldowns when another caster lands the spell on you' do
    described_class.parse('An opalescent aura surrounds you.')
    expect(Lich::Gemstone::Group.spell_cooldowns[spell_shield.num]).to be_nil
  end

  it "uses each spell's own cooldown length" do
    described_class.parse('An opalescent aura surrounds you and your group.')
    expect(Lich::Gemstone::Group.spell_cooldown_left(spell_shield, 'Grhim')).to be_within(2).of(360)
  end
end

# A spell that names the character it lands on. The cooldown belongs to that
# character however it got there, so the third-person line is enough on its
# own -- no need to know who cast it.
RSpec.describe Lich::Gemstone::Group, 'per-character cooldowns from a named target' do
  let(:wall) { Spell[140] }

  before do
    Lich::Gemstone::Group.spell_cooldowns.clear
    allow(wall).to receive(:target_cooldown).and_return(270)
  end

  after { Lich::Gemstone::Group.spell_cooldowns.clear }

  it 'puts the named character on cooldown' do
    described_class.record_target_cooldown(wall, 'Dicate')
    expect(described_class.spell_cooldown_ready?(wall, 'Dicate')).to be false
    expect(described_class.spell_cooldown_left(wall, 'Dicate')).to be_within(2).of(270)
  end

  it 'leaves everyone else alone' do
    described_class.record_target_cooldown(wall, 'Dicate')
    expect(described_class.spell_cooldown_ready?(wall, 'Nisugi')).to be true
  end

  it 'records nothing for a spell with no per-character cooldown' do
    allow(wall).to receive(:target_cooldown).and_return(nil)
    described_class.record_target_cooldown(wall, 'Dicate')
    expect(described_class.spell_cooldowns[wall.num]).to be_nil
  end

  it 'ignores a nil name' do
    described_class.record_target_cooldown(wall, nil)
    expect(described_class.spell_cooldowns[wall.num]).to be_nil
  end

  it 'shares the store with group castings, so either source answers' do
    described_class.record_target_cooldown(wall, 'Dicate')
    expect(described_class.spell_cooldown_left(wall, 'Dicate')).to be > 0
  end
end

# The cooldown values and the third-person message come straight out of
# effect-list.xml, so a typo in an element name or type would leave every
# spell looking like it simply has no cooldown. These read the parsed fixture
# rather than stubbing, so that mistake fails here instead of going unnoticed.
RSpec.describe Lich::Common::Spell, 'cooldowns parsed from effect-list.xml' do
  it 'reads a group cooldown off a <cooldown type="group"> element' do
    expect(Spell[215].group_cooldown).to eq 180
    expect(Spell[219].group_cooldown).to eq 360
  end

  it 'reads a target cooldown off a <cooldown type="target"> element' do
    expect(Spell[140].target_cooldown).to eq 270
    expect(Spell[506].target_cooldown).to eq 240
  end

  it 'leaves both cooldowns nil for a spell that declares neither' do
    expect(Spell[202].group_cooldown).to be_nil
    expect(Spell[202].target_cooldown).to be_nil
  end

  it 'keeps the two cooldown kinds separate' do
    expect(Spell[215].target_cooldown).to be_nil
    expect(Spell[140].group_cooldown).to be_nil
  end

  it 'reads the third-person message off a <message type="target-start"> element' do
    expect(Spell[140].target_msgup).to eq 'A wall of force surrounds (?<noun>[A-Z][a-z]+)\.'
  end

  it 'leaves target_msgup nil for a spell with no target-start message' do
    expect(Spell[215].target_msgup).to be_nil
  end

  # Parser#parse calls Regexp.last_match(:noun) on any line matching the
  # union of these, which raises IndexError unless the name is declared.
  it 'declares a :noun capture in every target-start message' do
    expect(described_class.target_upmsgs).not_to be_empty
    described_class.target_upmsgs.each do |msg|
      expect(Regexp.new(msg).names).to include('noun'), "missing (?<noun>) in: #{msg}"
    end
  end
end

# Barkskin (605): the lockout starts on the first hit the bark absorbs, not
# on the cast, so a member can be off cooldown and still covered. Group keeps
# both, from the lines the caster sees: the group evoke, a third-person
# casting, an absorb, and the bark wearing off.
RSpec.describe Lich::Gemstone::Group, 'absorb cooldowns and coverage (Barkskin)' do
  let(:bark) { Spell[605] }

  def member(name)
    double(noun: name, id: name.hash.to_s)
  end

  before do
    Lich::Gemstone::Group.spell_cooldowns.clear
    Lich::Gemstone::Group.spell_active_until.clear
    grouped = [member('Grhim'), member('Painz')]
    allow(Lich::Gemstone::Group).to receive(:_members).and_return(grouped)
    allow(Lich::Gemstone::Group).to receive(:members).and_return(grouped)
  end

  after do
    Lich::Gemstone::Group.spell_cooldowns.clear
    Lich::Gemstone::Group.spell_active_until.clear
  end

  it 'starts the 5 minute cooldown on the first absorb' do
    described_class.record_absorb_cooldown(bark, 'Grhim')
    expect(described_class.spell_cooldown_left(bark, 'Grhim')).to be_within(2).of(300)
  end

  it 'does not restart the cooldown on a later absorb' do
    described_class.record_absorb_cooldown(bark, 'Grhim')
    described_class.spell_cooldowns[bark.num]['Grhim'] = Time.now + 100
    described_class.record_absorb_cooldown(bark, 'Grhim')
    expect(described_class.spell_cooldown_left(bark, 'Grhim')).to be_within(2).of(100)
  end

  it 'starts a fresh cooldown once the last one has run out' do
    described_class.spell_cooldowns[bark.num] = { 'Grhim' => Time.now - 1 }
    described_class.record_absorb_cooldown(bark, 'Grhim')
    expect(described_class.spell_cooldown_left(bark, 'Grhim')).to be_within(2).of(300)
  end

  it 'covers every member off cooldown on a group casting, for the spell duration' do
    described_class.record_group_spell_active(bark)
    expect(described_class.spell_active?(bark, 'Grhim')).to be true
    expect(described_class.spell_active_until[bark.num]['Grhim'] - Time.now).to be_within(2).of(60)
  end

  it 'does not cover a member still on cooldown, since the casting misses them' do
    described_class.record_absorb_cooldown(bark, 'Painz')
    described_class.record_group_spell_active(bark)
    expect(described_class.spell_active?(bark, 'Painz')).to be false
  end

  it 'wants a member who is off cooldown and uncovered, even with another locked out' do
    described_class.record_group_spell_active(bark)
    described_class.record_absorb_cooldown(bark, 'Grhim')
    described_class.clear_spell_active(bark, 'Painz')
    expect(described_class.spell_wanted(bark)).to eq ['Painz']
  end

  it 'wants nobody while everyone is covered' do
    described_class.record_group_spell_active(bark)
    expect(described_class.spell_wanted(bark)).to be_empty
  end

  it 'tracks no coverage for a spell without an absorb cooldown' do
    described_class.record_spell_active(Spell[215], 'Grhim')
    expect(described_class.spell_active_until[215]).to be_nil
  end
end

# The same, driven by the lines from the game (taken from Nisugi's logs).
RSpec.describe Lich::Gemstone::Infomon::Parser, 'Barkskin messages' do
  let(:bark) { Spell[605] }

  def member(name)
    double(noun: name, id: name.hash.to_s)
  end

  before do
    allow(Lich::Gemstone::Infomon).to receive(:set)
    allow(Lich::Gemstone::Spells).to receive(:require_cooldown)
    allow(XMLData).to receive(:level).and_return(100)
    allow(XMLData).to receive(:name).and_return('Nisugi')
    grouped = [member('Grhim'), member('Painz')]
    allow(Lich::Gemstone::Group).to receive(:_members).and_return(grouped)
    allow(Lich::Gemstone::Group).to receive(:members).and_return(grouped)
    Lich::Gemstone::Group.spell_cooldowns.clear
    Lich::Gemstone::Group.spell_active_until.clear
    bark.putdown
  end

  after do
    Lich::Gemstone::Group.spell_cooldowns.clear
    Lich::Gemstone::Group.spell_active_until.clear
    bark.putdown
  end

  it 'puts Barkskin up on the caster from the group evoke' do
    described_class.parse('A knobby layer of bark swiftly forms over you and your group.')
    expect(bark.active?).to be true
  end

  it 'covers the group from the group evoke' do
    described_class.parse('A knobby layer of bark swiftly forms over you and your group.')
    expect(Lich::Gemstone::Group.spell_active?(bark, 'Grhim')).to be true
    expect(Lich::Gemstone::Group.spell_wanted(bark)).to be_empty
  end

  it 'takes Barkskin down on the caster from the end message' do
    described_class.parse('A knobby layer of bark swiftly forms on you.')
    described_class.parse('The knobby layer of bark on you creaks and twists briefly before disintegrating.')
    expect(bark.active?).to be false
  end

  it 'covers a member someone else cast it on' do
    described_class.parse('A knobby layer of bark swiftly forms on Grhim.')
    expect(Lich::Gemstone::Group.spell_active?(bark, 'Grhim')).to be true
    expect(Lich::Gemstone::Group.spell_cooldown_ready?(bark, 'Grhim')).to be true
  end

  it 'starts the cooldown from a third-person absorb that holds' do
    described_class.parse('The layer of bark on Grhim hardens and absorbs the attack!  The bark crackles, but maintains its form.')
    expect(Lich::Gemstone::Group.spell_cooldown_left(bark, 'Grhim')).to be_within(2).of(300)
  end

  it 'starts the cooldown from a third-person absorb that crumbles' do
    described_class.parse('The layer of bark on Grhim hardens and absorbs the magical energy!  The bark crackles as it crumbles to dust.')
    expect(Lich::Gemstone::Group.spell_cooldown_ready?(bark, 'Grhim')).to be false
  end

  it 'uncovers a member when their bark wears off' do
    described_class.parse('A knobby layer of bark swiftly forms over you and your group.')
    described_class.parse('The knobby layer of bark on Painz creaks and twists briefly before disintegrating.')
    expect(Lich::Gemstone::Group.spell_wanted(bark)).to eq ['Painz']
  end

  it 'ignores the bark on a pet, which has no capitalised name' do
    described_class.parse('A knobby layer of bark swiftly forms on a hulking semi-melanistic panther.')
    expect(Lich::Gemstone::Group.spell_active_until[bark.num]).to be_nil
  end
end

RSpec.describe Lich::Common::Spell, 'Barkskin parsed from effect-list.xml' do
  it "reads an absorb cooldown off a <cooldown type='absorb'> element" do
    expect(Spell[605].absorb_cooldown).to eq 300
    expect(Spell[605].target_cooldown).to be_nil
    expect(Spell[605].group_cooldown).to be_nil
  end

  it 'leaves absorb_cooldown nil for a spell that declares none' do
    expect(Spell[215].absorb_cooldown).to be_nil
  end

  it 'declares a :noun capture in every target-absorb and target-end message' do
    msgs = described_class.target_absorbmsgs + described_class.target_dnmsgs
    expect(msgs).not_to be_empty
    msgs.each do |msg|
      expect(Regexp.new(msg).names).to include('noun'), "missing (?<noun>) in: #{msg}"
    end
  end
end
