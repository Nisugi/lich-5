# frozen_string_literal: true

require_relative '../../../spec_helper'
require 'json'
require 'common/map/map_engine'

MapEngine = Lich::Common::MapEngine unless defined?(MapEngine)

RSpec.describe Lich::Common::MapEngine do
  describe '.build_timeto' do
    it 'wraps schema hashes in a Cost' do
      expect(described_class.build_timeto({ 'cost' => 0.2 })).to be_a(described_class::Cost)
    end

    it 'passes numerics through untouched' do
      expect(described_class.build_timeto(0.2)).to eq(0.2)
    end
  end

  # Crossing masquerades as Proc (kind_of?/class), so identity checks must
  # bypass the overrides via the unbound Object#class.
  def real_class(obj)
    Object.instance_method(:class).bind(obj).call
  end

  describe '.build_wayto' do
    it 'wraps step arrays in a Crossing' do
      built = described_class.build_wayto([{ 'do' => 'move', 'cmd' => 'go gate' }])
      expect(real_class(built)).to eq(described_class::Crossing)
    end

    it 'wraps strategy hashes in a Crossing' do
      built = described_class.build_wayto({ 'strategy' => 'table_join', 'table' => 'hammer' })
      expect(real_class(built)).to eq(described_class::Crossing)
    end

    it 'passes plain movement strings through untouched' do
      expect(described_class.build_wayto('go gate')).to eq('go gate')
    end
  end

  describe 'Crossing' do
    it 'masquerades as a Proc for go2 dispatch' do
      crossing = described_class::Crossing.new([])
      expect(crossing).to be_kind_of(Proc)
      expect(crossing.class).to eq(Proc)
    end

    it 'serializes back to its schema JSON' do
      raw = [{ 'do' => 'move', 'cmd' => 'go gate' }]
      expect(JSON.parse(described_class::Crossing.new(raw).to_json)).to eq(raw)
    end

    it 'answers _dump for proc-introspecting scripts (mapmap room merge)' do
      raw = [{ 'do' => 'cross', 'room' => 284, 'dest' => '3668' }]
      dump = described_class::Crossing.new(raw)._dump
      expect(dump).to include('3668') # id-searchable, like StringProc source
      expect(JSON.parse(dump)).to eq(raw)
    end
  end

  describe 'Cost' do
    it 'serializes back to its schema JSON' do
      raw = { 'cost' => 0.2, 'requires' => ['setting:urchins'] }
      expect(JSON.parse(described_class::Cost.new(raw).to_json)).to eq(raw)
    end
  end

  describe '.resolve_cost' do
    before do
      stub_const('UserVars', double('UserVars'))
    end

    it 'returns plain numerics' do
      expect(described_class.resolve_cost(1.5)).to eq(1.5)
    end

    it 'returns the cost when all requirements pass' do
      allow(UserVars).to receive(:respond_to?).and_return(true)
      allow(UserVars).to receive(:mapdb_use_urchins).and_return(true)
      entry = { 'cost' => 0.1, 'requires' => ['setting:urchins'] }
      expect(described_class.resolve_cost(entry)).to eq(0.1)
    end

    it 'returns nil (not routable) when a requirement fails' do
      allow(UserVars).to receive(:respond_to?).and_return(true)
      allow(UserVars).to receive(:mapdb_use_urchins).and_return(nil)
      entry = { 'cost' => 0.1, 'requires' => ['setting:urchins'] }
      expect(described_class.resolve_cost(entry)).to be_nil
    end

    it 'falls through to the else branch' do
      entry = { 'cost' => 0.8, 'requires' => ['pass:A+B'], 'else' => { 'cost' => 4.4 } }
      expect(described_class.resolve_cost(entry)).to eq(4.4)
    end

    it 'treats unknown requirement kinds as not routable' do
      entry = { 'cost' => 0.1, 'requires' => ['quantum:flux'] }
      expect(described_class.resolve_cost(entry)).to be_nil
    end

    it 'honors timed grants' do
      allow(UserVars).to receive(:respond_to?).and_return(true)
      allow(UserVars).to receive(:mapdb_urchins_expire).and_return(Time.now.to_i + 600)
      entry = { 'cost' => 0.1, 'requires' => ['grant:urchins_expire'] }
      expect(described_class.resolve_cost(entry)).to eq(0.1)
    end

    it 'gates on profession, permissively when Stats is unavailable' do
      entry = { 'cost' => 0.2, 'requires' => ['prof:Rogue'] }
      expect(described_class.resolve_cost(entry)).to eq(0.2) # no Stats defined here

      stub_const('Stats', double('Stats', prof: 'Wizard'))
      expect(described_class.resolve_cost(entry)).to be_nil
      stub_const('Stats', double('Stats', prof: 'Rogue'))
      expect(described_class.resolve_cost(entry)).to eq(0.2)
    end

    it 'gates on var equality and truthiness' do
      allow(UserVars).to receive(:respond_to?).and_return(true)
      allow(UserVars).to receive(:mapdb_duskruin_origin).and_return(7)
      expect(described_class.resolve_cost({ 'cost' => 1, 'requires' => ['var:duskruin_origin=7'] })).to eq(1)
      expect(described_class.resolve_cost({ 'cost' => 1, 'requires' => ['var:duskruin_origin=8'] })).to be_nil
      expect(described_class.resolve_cost({ 'cost' => 1, 'requires' => ['var:duskruin_origin'] })).to eq(1)
    end

    it 'rejects expired grants' do
      allow(UserVars).to receive(:respond_to?).and_return(true)
      allow(UserVars).to receive(:mapdb_urchins_expire).and_return(Time.now.to_i - 600)
      entry = { 'cost' => 0.1, 'requires' => ['grant:urchins_expire'] }
      expect(described_class.resolve_cost(entry)).to be_nil
    end

    it 'resolves event tables through the registry' do
      $mapdb_instability_timeto = { 2300 => 3.5 }
      expect(described_class.resolve_cost({ 'event' => 'instability', 'key' => 2300 })).to eq(3.5)
    ensure
      $mapdb_instability_timeto = nil
    end

    it 'returns nil for event tables that are not populated' do
      expect(described_class.resolve_cost({ 'event' => 'instability', 'key' => 2300 })).to be_nil
    end

    it 'does not loop on same_as cycles' do
      entry = { 'same_as' => '1:2' }
      room = double('room', timeto: { '2' => described_class::Cost.new(entry) })
      stub_const('Lich::Common::Map', double('Map'))
      allow(Lich::Common::Map).to receive(:[]).with(1).and_return(room)
      expect(described_class.resolve_cost(entry)).to be_nil
    end
  end

  describe '.run_repeat' do
    it 'compares until_room against the mapdb id, not the game uid' do
      # Live regression (5868->5867): XMLData.room_id is the game uid
      # (u14008034); until_room targets are mapdb ids. The loop must stop on
      # arrival even though the uid never equals the target.
      stub_const('XMLData', double('XMLData', room_id: 14_008_034))
      stub_const('Lich::Common::Map', double('Map', current: double('room', id: 5867)))
      step = { 'do' => 'repeat', 'until_room' => 5867,
               'steps' => [{ 'do' => 'send', 'cmd' => 'south' }] }
      # If the loop body ran, the send step would blow up on undefined fput.
      expect { described_class.run_repeat(step) }.not_to raise_error
    end
  end

  describe 'capture binding' do
    after { described_class.clear_captures }

    it 'binds a numbered group and interpolates it into later commands' do
      pattern = described_class.compile_pattern('heads off to the (\\w+)')
      described_class.send(:bind_captures, { 'bind' => { 'dir' => 1 } },
                           'the trail heads off to the north', pattern)
      expect(described_class.captures['dir']).to eq('north')
      expect(described_class.expand_tokens('move {capture:dir}')).to eq('move north')
    end

    it 'binds an ordinal position (rotating staircase shape)' do
      # The real proc's pattern repeats an unnamed alternation once per
      # staircase; ordinal binding finds which occurrence matches and yields
      # that position's word.
      pattern = described_class.compile_pattern(
        '(northern|eastern) wall, a flight of steps (northern|eastern) wall'
      )
      spec = { 'bind' => { 'which' => { 'group' => 'wall', 'equals' => 'eastern',
                                        'words' => ['steps', 'second steps'] } } }
      described_class.send(:bind_captures, spec,
                           'northern wall, a flight of steps eastern wall', pattern)
      expect(described_class.captures['which']).to eq('second steps')
    end

    it 'treats an unbound capture as empty and false' do
      expect(described_class.expand_tokens('move {capture:missing}')).to eq('move ')
      expect(described_class.condition?('capture:missing')).to be(false)
    end

    describe 'use_item' do
      let(:trinket) { double('trinket', id: 12_345) }

      before do
        allow(described_class).to receive(:fput)
        allow(described_class).to receive(:dothistimeout).and_return('You get the feeling')
        allow(described_class).to receive(:empty_hand)
        allow(described_class).to receive(:fill_hand)
      end

      it 'uses an item already in hand without putting it away' do
        stub_const('Lich::Common::GameObj', double('GameObj').tap { |g|
          allow(g).to receive(:[]).with('trinket').and_return(trinket)
        })
        expect(described_class).not_to receive(:fput).with(/stow|put /)
        described_class.send(:run_use_item, { 'item' => 'trinket', 'verb' => 'turn' })
      end

      it 'returns a borrowed item to the container it came from' do
        gameobj = double('GameObj')
        # absent at first (so it must be fetched), present afterwards
        allow(gameobj).to receive(:[]).with('trinket').and_return(nil, trinket, trinket)
        allow(gameobj).to receive(:left_hand).and_return(double(id: nil))
        allow(gameobj).to receive(:right_hand).and_return(double(id: nil))
        stub_const('Lich::Common::GameObj', gameobj)
        allow(described_class).to receive(:fetch_item).and_return('999')

        expect(described_class).to receive(:fput).with('put #12345 in #999')
        described_class.send(:run_use_item, { 'item' => 'trinket', 'verb' => 'turn' })
      end

      it 'stows a borrowed item when the container is unknown' do
        gameobj = double('GameObj')
        allow(gameobj).to receive(:[]).with('trinket').and_return(nil, trinket, trinket)
        allow(gameobj).to receive(:left_hand).and_return(double(id: nil))
        allow(gameobj).to receive(:right_hand).and_return(double(id: nil))
        stub_const('Lich::Common::GameObj', gameobj)
        allow(described_class).to receive(:fetch_item).and_return(nil)

        expect(described_class).to receive(:fput).with('stow #12345')
        described_class.send(:run_use_item, { 'item' => 'trinket', 'verb' => 'turn' })
      end

      it 'fails the crossing when the item cannot be found' do
        gameobj = double('GameObj')
        allow(gameobj).to receive(:[]).with('trinket').and_return(nil)
        allow(gameobj).to receive(:left_hand).and_return(double(id: nil))
        allow(gameobj).to receive(:right_hand).and_return(double(id: nil))
        stub_const('Lich::Common::GameObj', gameobj)
        allow(described_class).to receive(:fetch_item).and_return(nil)

        expect { described_class.send(:run_use_item, { 'item' => 'trinket' }) }
          .to raise_error(described_class::StepFailed, /could not find/)
      end

      it 'validates item and verb' do
        v = described_class::Validator
        expect(v.errors_for_wayto([{ 'do' => 'use_item', 'item' => 'x' }])).to be_empty
        expect(v.errors_for_wayto([{ 'do' => 'use_item' }]).join).to include('requires item')
      end
    end

    it 'branches on which alternative a bound line matched' do
      described_class.captures['outcome'] = 'It appears to be locked.'
      expect(described_class.condition?('capture_match:outcome=It appears to be locked')).to be(true)
      expect(described_class.condition?('capture_match:outcome=You open')).to be(false)
    end

    it 'matches loot by exact noun, not by name regex' do
      item = double('item', noun: 'path', name: 'a winding pathway')
      # The engine resolves GameObj inside Lich::Common, so stub it there.
      stub_const('Lich::Common::GameObj', double('GameObj', loot: [item]))
      expect(described_class.condition?('loot_noun:path')).to be(true)
      expect(described_class.condition?('loot_noun:pathway')).to be(false)
    end

    it 'derates the climbing bonus by encumbrance against a threshold' do
      # (1 - encumbrance%) * to_bonus(climbing) >= N. Distinct from
      # climb_vs_encumbrance, which compares raw ranks.
      stub_const('Char', double('Char', percent_encumbrance: 50))
      stub_const('Skills', double('Skills', climbing: 200, to_bonus: 100))
      expect(described_class.requirement?('climb_bonus:50')).to be(true)  # 0.5 * 100
      expect(described_class.requirement?('climb_bonus:60')).to be(false)
      stub_const('Char', double('Char', percent_encumbrance: 80))
      expect(described_class.requirement?('climb_bonus:50')).to be(false) # 0.2 * 100
    end

    it 'casts the first known spell from a preference list' do
      known = double('known', known?: true, num: 1207)
      unknown = double('unknown', known?: false, num: 407)
      # Stub the lookup only, so Spell keeps behaving like the real class for
      # everything else in this file.
      spell_class = class_double('Spell').as_stubbed_const
      allow(spell_class).to receive(:[]).with(407).and_return(unknown)
      allow(spell_class).to receive(:[]).with(1207).and_return(known)
      expect(described_class.send(:resolve_castable, [407, 1207])).to be(known)
      # knowing none of them is a step failure, not a blind cast
      expect(described_class.send(:resolve_castable, [407])).to be_nil
    end

    it 'validates cast spell lists' do
      v = described_class::Validator
      expect(v.errors_for_wayto([{ 'do' => 'cast', 'spell' => [407, 1207] }])).to be_empty
      expect(v.errors_for_wayto([{ 'do' => 'cast', 'spell' => [] }]).join).to include('numeric spell')
      expect(v.errors_for_wayto([{ 'do' => 'cast', 'spell' => ['407'] }]).join).to include('numeric spell')
    end

    it 'reads room_loaded from the room description, not the room id' do
      # Fog spheres and teleports deliver an empty description while the game
      # is still placing you; the id may already have changed.
      stub_const('XMLData', double('XMLData', room_description: '   '))
      expect(described_class.condition?('room_loaded')).to be(false)
      stub_const('XMLData', double('XMLData', room_description: 'A misty clearing.'))
      expect(described_class.condition?('room_loaded')).to be(true)
    end

    it 'validates bind specs' do
      v = described_class::Validator
      good = [{ 'do' => 'await', 'cmd' => 'look', 'for' => '(\\w+)', 'bind' => { 'dir' => 1 } }]
      expect(v.errors_for_wayto(good)).to be_empty
      bad = [{ 'do' => 'await', 'cmd' => 'look', 'for' => '(\\w+)', 'bind' => { 'dir' => [] } }]
      expect(v.errors_for_wayto(bad).join).to include('bind target')
    end
  end

  describe 'dual-currency room references' do
    it 'resolves uNNN through the uid index, conservatively on ambiguity' do
      map = double('Map')
      stub_const('Lich::Common::Map', map)
      room = double('room', id: 5867)
      allow(map).to receive(:respond_to?).and_return(true)
      allow(map).to receive(:ids_from_uid).with(14_008_034).and_return([5867])
      allow(map).to receive(:[]).with(5867).and_return(room)
      expect(described_class.resolve_room_ref('u14008034')).to eq(room)
      allow(map).to receive(:ids_from_uid).with(99).and_return([1, 2]) # ambiguous
      expect(described_class.resolve_room_ref('u99')).to be_nil
      allow(map).to receive(:[]).with(5867).and_return(room)
      expect(described_class.resolve_room_ref(5867)).to eq(room)
    end

    it 'compares uid refs against the live game stream in at_room_ref?' do
      stub_const('XMLData', double('XMLData', room_id: 14_008_034))
      stub_const('Lich::Common::Map', double('Map', current: double(id: 5867), respond_to?: true))
      expect(described_class.at_room_ref?('u14008034')).to be(true)
      expect(described_class.at_room_ref?('u14008035')).to be(false)
      expect(described_class.at_room_ref?(5867)).to be(true)
    end

    it 'validates uid forms in same_as and cross' do
      v = described_class::Validator
      expect(v.errors_for_timeto({ 'same_as' => 'u7000:30714' })).to be_empty
      expect(v.errors_for_wayto([{ 'do' => 'cross', 'room' => 'u7000', 'dest' => '3668' }])).to be_empty
      expect(v.errors_for_wayto([{ 'do' => 'cross', 'room' => 'nonsense', 'dest' => '3668' }])).not_to be_empty
    end
  end

  describe '.compile_pattern' do
    it 'compiles valid patterns once' do
      pattern = described_class.compile_pattern('A crew member escorts you')
      expect(pattern).to be_a(Regexp)
      expect(described_class.compile_pattern('A crew member escorts you')).to equal(pattern)
    end

    it 'returns nil for invalid patterns instead of raising' do
      expect(described_class.compile_pattern('[unclosed')).to be_nil
    end
  end

  describe Lich::Common::MapEngine::Strategies do
    it 'registers table_join' do
      expect(described_class.known?('table_join')).to be(true)
    end

    it 'raises StepFailed for unknown strategies' do
      expect { described_class.run({ 'strategy' => 'warp_drive' }) }
        .to raise_error(Lich::Common::MapEngine::StepFailed, /unknown strategy/)
    end
  end

  describe Lich::Common::MapEngine::Validator do
    describe '.errors_for_timeto' do
      it 'accepts a well-formed gate' do
        entry = { 'cost' => 0.1, 'requires' => ['setting:urchins', 'not:hidden'] }
        expect(described_class.errors_for_timeto(entry)).to be_empty
      end

      it 'rejects unknown requirement kinds' do
        entry = { 'cost' => 0.1, 'requires' => ['quantum:flux'] }
        expect(described_class.errors_for_timeto(entry).join).to include('quantum')
      end

      it 'rejects a missing cost' do
        expect(described_class.errors_for_timeto({ 'requires' => ['setting:urchins'] })).not_to be_empty
      end

      it 'validates same_as references' do
        expect(described_class.errors_for_timeto({ 'same_as' => '7:30714' })).to be_empty
        expect(described_class.errors_for_timeto({ 'same_as' => 'bogus' })).not_to be_empty
      end

      it 'validates else branches recursively' do
        entry = { 'cost' => 0.8, 'requires' => ['pass:A+B'], 'else' => { 'requires' => ['setting:x'] } }
        expect(described_class.errors_for_timeto(entry)).not_to be_empty
      end
    end

    describe '.errors_for_wayto' do
      it 'accepts a well-formed step list' do
        steps = [
          { 'do' => 'send', 'cmd' => 'ask portmaster about travel 2' },
          { 'do' => 'await', 'cmd' => 'ask portmaster about travel 2',
            'for' => 'A crew member escorts you off the ship\\.', 'timeout' => 30 }
        ]
        expect(described_class.errors_for_wayto(steps)).to be_empty
      end

      it 'accepts a known strategy' do
        expect(described_class.errors_for_wayto({ 'strategy' => 'table_join', 'table' => 'hammer' })).to be_empty
      end

      it 'rejects unknown strategies' do
        expect(described_class.errors_for_wayto({ 'strategy' => 'warp_drive' })).not_to be_empty
      end

      it 'rejects unknown steps' do
        expect(described_class.errors_for_wayto([{ 'do' => 'teleport' }]).join).to include('teleport')
      end

      it 'rejects invalid await regexes' do
        steps = [{ 'do' => 'await', 'cmd' => 'search', 'for' => '[unclosed' }]
        expect(described_class.errors_for_wayto(steps).join).to include('invalid regex')
      end

      it 'rejects unknown on_timeout policies' do
        steps = [{ 'do' => 'await', 'cmd' => 'search', 'for' => 'ok', 'on_timeout' => 'explode' }]
        expect(described_class.errors_for_wayto(steps).join).to include('on_timeout')
      end

      it 'validates if branches recursively' do
        steps = [{ 'do' => 'if', 'when' => 'spell:506', 'then' => [{ 'do' => 'bogus' }] }]
        expect(described_class.errors_for_wayto(steps).join).to include('bogus')
      end

      it 'accepts bounded repeat steps and rejects unbounded ones' do
        good = [{ 'do' => 'repeat', 'times' => 30, 'until_room' => 13183,
                  'steps' => [{ 'do' => 'move', 'cmd' => 'north' }] }]
        expect(described_class.errors_for_wayto(good)).to be_empty
        unbounded = [{ 'do' => 'repeat', 'steps' => [{ 'do' => 'wait_rt' }] }]
        expect(described_class.errors_for_wayto(unbounded).join).to include('repeat requires')
        empty = [{ 'do' => 'repeat', 'times' => 3, 'steps' => [] }]
        expect(described_class.errors_for_wayto(empty).join).to include('repeat requires steps')
      end
    end
  end
end
