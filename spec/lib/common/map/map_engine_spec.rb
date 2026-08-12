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

    describe 'steps_ref' do
      it 'runs a body the crossing defined once' do
        stub_const('XMLData', double('XMLData', room_id: 1, name: 'Tester'))
        seen = []
        allow(described_class).to receive(:run_step).and_call_original
        allow(described_class).to receive(:fput) { |c| seen << c }
        described_class.cross({ 'define' => { 'leg' => [{ 'do' => 'send', 'cmd' => 'go' }] },
                                'steps'  => [{ 'do' => 'steps_ref', 'name' => 'leg' },
                                             { 'do' => 'steps_ref', 'name' => 'leg' }] })
        expect(seen).to eq(%w[go go])
      end

      it 'refuses a definition that recurses, rather than looping forever' do
        stub_const('XMLData', double('XMLData', room_id: 1, name: 'Tester'))
        raw = { 'define' => { 'loop' => [{ 'do' => 'steps_ref', 'name' => 'loop' }] },
                'steps'  => [{ 'do' => 'steps_ref', 'name' => 'loop' }] }
        expect { described_class.cross(raw) }
          .to raise_error(described_class::StepFailed, /nested too deeply/)
        # Crossing#call turns that into "not crossable" rather than an escape.
        expect(described_class::Crossing.new(raw).call).to be(false)
      end

      it 'rejects a steps_ref with no matching define at build time' do
        v = described_class::Validator
        entry = { 'define' => { 'leg' => [{ 'do' => 'wait_rt' }] },
                  'steps'  => [{ 'do' => 'steps_ref', 'name' => 'missing' }] }
        expect(v.errors_for_wayto(entry).join).to include('no matching define')
        good = { 'define' => { 'leg' => [{ 'do' => 'wait_rt' }] },
                 'steps'  => [{ 'do' => 'steps_ref', 'name' => 'leg' }] }
        expect(v.errors_for_wayto(good)).to be_empty
      end
    end

    describe 'for_each' do
      it 'binds each item in turn for the body to interpolate' do
        stub_const('XMLData', double('XMLData', room_id: 1, name: 'Tester'))
        seen = []
        allow(described_class).to receive(:run_step) do |s|
          seen << described_class.expand_tokens(s['cmd'])
        end
        described_class.send(:run_for_each,
                             { 'as' => 'dir', 'items' => %w[w s arch],
                               'steps' => [{ 'do' => 'send', 'cmd' => 'go {capture:dir}' }] })
        expect(seen).to eq(['go w', 'go s', 'go arch'])
      end

      it 'restores any previous binding of the same name' do
        stub_const('XMLData', double('XMLData', room_id: 1))
        described_class.captures['dir'] = 'original'
        allow(described_class).to receive(:run_step)
        described_class.send(:run_for_each,
                             { 'as' => 'dir', 'items' => %w[w s], 'steps' => [{ 'do' => 'send' }] })
        expect(described_class.captures['dir']).to eq('original')
      end

      it 'validates items and steps' do
        v = described_class::Validator
        good = { 'do' => 'for_each', 'items' => ['w'], 'steps' => [{ 'do' => 'wait_rt' }] }
        expect(v.errors_for_wayto([good])).to be_empty
        expect(v.errors_for_wayto([good.merge('items' => [])]).join).to include('non-empty items')
        expect(v.errors_for_wayto([good.merge('steps' => [])]).join).to include('requires steps')
      end
    end

    it 'binds several independent values from one response' do
      # The altar grid arrives as a single line; each colour is sliced out
      # separately, so nothing may depend on the order they appear in.
      line = 'A red glow illuminates Green 4, Yellow 2 and Blue 5.'
      described_class.send(:bind_scan,
                           { 'bind_all' => { 'yellow' => 'Yellow ([0-9])',
                                             'blue'   => 'Blue ([0-9])',
                                             'green'  => 'Green ([0-9])' } },
                           line)
      expect(described_class.captures['yellow']).to eq('2')
      expect(described_class.captures['blue']).to eq('5')
      expect(described_class.captures['green']).to eq('4')
    end

    it 'validates bind_all patterns' do
      v = described_class::Validator
      good = { 'do' => 'await', 'for' => 'x', 'bind_all' => { 'a' => 'A ([0-9])' } }
      expect(v.errors_for_wayto([good])).to be_empty
      expect(v.errors_for_wayto([good.merge('bind_all' => { 'a' => 3 })]).join)
        .to include('must be a pattern')
    end

    it 'treats an unbound capture as empty and false' do
      expect(described_class.expand_tokens('move {capture:missing}')).to eq('move ')
      expect(described_class.condition?('capture:missing')).to be(false)
    end

    describe 'use_item' do
      let(:trinket) { double('trinket', id: 12_345, noun: 'trinket', name: 'a jade trinket') }

      before do
        allow(described_class).to receive(:fput)
        allow(described_class).to receive(:dothistimeout).and_return('You get the feeling')
        allow(described_class).to receive(:empty_hand)
        allow(described_class).to receive(:fill_hand)
      end

      # Builds a coherent GameObj: hands, the worn/carried registry, and the
      # id lookup that spans both.
      def stub_gameobj(right: nil, left: nil, inv: [], lookup: nil)
        empty = double(id: nil, noun: nil, name: nil)
        gameobj = double('GameObj',
                         right_hand: right || empty,
                         left_hand: left || empty,
                         inv: inv)
        allow(gameobj).to receive(:[]) { |_| lookup }
        stub_const('Lich::Common::GameObj', gameobj)
        gameobj
      end

      it 'uses an item already in hand without putting it away' do
        stub_gameobj(right: trinket, lookup: trinket)
        expect(described_class).not_to receive(:fput).with(/stow|put |wear /)
        described_class.send(:run_use_item, { 'item' => 'trinket', 'verb' => 'turn' })
      end

      it 'removes a worn item and wears it again afterwards' do
        # GameObj[] finds worn items too, so a bare lookup would have used the
        # key while it was still on the belt.
        key = double('key', id: 555, noun: 'key', name: 'a brass key')
        stub_gameobj(inv: [key], lookup: key)
        expect(described_class).to receive(:fput).with('remove #555').ordered
        expect(described_class).to receive(:fput).with('wear #555').ordered
        described_class.send(:run_borrow_item, { 'item' => 'key' })
        described_class.send(:run_return_item)
      end

      it 'binds the item and container for the steps between borrow and return' do
        stub_gameobj(lookup: trinket)
        allow(described_class).to receive(:fetch_item).and_return('999')

        described_class.send(:run_borrow_item, { 'item' => 'lockpick' })
        # An edge composes its own middle out of these two captures.
        expect(described_class.expand_tokens('_drag {capture:item} {capture:container}'))
          .to eq('_drag #12345 #999')
      end

      it 'leaves container unbound when it could not be read' do
        stub_gameobj(lookup: trinket)
        allow(described_class).to receive(:fetch_item).and_return(nil)

        described_class.send(:run_borrow_item, { 'item' => 'key' })
        # So an edge can guard on it rather than send a half-formed command.
        expect(described_class.condition?('capture:container')).to be(false)
      end

      it 'return_item is a no-op for an item that was already in hand' do
        stub_gameobj(right: trinket, lookup: trinket)
        described_class.send(:run_borrow_item, { 'item' => 'trinket' })
        expect(described_class).not_to receive(:fput)
        described_class.send(:run_return_item)
      end

      it 'returns a borrowed item to the container it came from' do
        # Not in hand and not worn, so it has to be fetched.
        stub_gameobj(lookup: trinket)
        allow(described_class).to receive(:fetch_item).and_return('999')

        expect(described_class).to receive(:fput).with('put #12345 in #999')
        described_class.send(:run_use_item, { 'item' => 'trinket', 'verb' => 'turn' })
      end

      it 'stows a borrowed item when the container is unknown' do
        stub_gameobj(lookup: trinket)
        allow(described_class).to receive(:fetch_item).and_return(nil)

        expect(described_class).to receive(:fput).with('stow #12345')
        described_class.send(:run_use_item, { 'item' => 'trinket', 'verb' => 'turn' })
      end

      it 'fails the crossing when the item cannot be found' do
        stub_gameobj(lookup: nil)
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

    describe 'travel_to' do
      it 'refuses to nest, so bad data cannot loop forever' do
        room = double('room', id: 400)
        allow(described_class).to receive(:resolve_room_ref).and_return(room)
        allow(described_class).to receive(:at_room_ref?).and_return(false)
        described_class.instance_variable_set(:@travel_depth, described_class::MAX_TRAVEL_DEPTH)

        expect(described_class).not_to receive(:force_start_script)
        expect { described_class.send(:run_travel_to, { 'room' => 400 }) }
          .to raise_error(described_class::StepFailed, /nested routing refused/)
      ensure
        described_class.instance_variable_set(:@travel_depth, 0)
      end

      it 'does nothing when already in the target room' do
        allow(described_class).to receive(:resolve_room_ref).and_return(double('room', id: 400))
        allow(described_class).to receive(:at_room_ref?).and_return(true)
        expect(described_class).not_to receive(:force_start_script)
        described_class.send(:run_travel_to, { 'room' => 400 })
      end

      it 'routes to the nearest room with a tag' do
        # Which bank is right depends on where you are, so services are named
        # by tag rather than by a fixed id.
        current = double('room', find_nearest_by_tag: 399)
        stub_const('Lich::Common::Map', double('Map', current: current))
        allow(described_class).to receive(:resolve_room_ref).with(399).and_return(double(id: 399))
        allow(described_class).to receive(:at_room_ref?).with(399).and_return(true)

        expect(current).to receive(:find_nearest_by_tag).with('bank')
        described_class.send(:run_travel_to, { 'tag' => 'bank' })
      end

      it 'validates the room reference' do
        v = described_class::Validator
        expect(v.errors_for_wayto([{ 'do' => 'travel_to', 'room' => 400 }])).to be_empty
        expect(v.errors_for_wayto([{ 'do' => 'travel_to', 'room' => 'u123' }])).to be_empty
        expect(v.errors_for_wayto([{ 'do' => 'travel_to', 'tag' => 'bank' }])).to be_empty
        expect(v.errors_for_wayto([{ 'do' => 'travel_to' }]).join).to include('requires room')
      end
    end

    describe 'search_rooms' do
      it 'stops as soon as the condition holds, without walking anywhere' do
        allow(described_class).to receive(:condition?).with('loot_noun:doorframe').and_return(true)
        expect(described_class).not_to receive(:run_travel_to)
        expect(described_class.send(:run_search_rooms,
                                    { 'rooms' => [1, 2], 'until' => 'loot_noun:doorframe' })).to be(true)
      end

      it 'skips rooms it cannot reach rather than giving up' do
        # false on entry, false after reaching room 2's predecessor, true once
        # we actually arrive somewhere useful.
        visited = []
        allow(described_class).to receive(:condition?) { visited.include?(2) }
        allow(described_class).to receive(:at_room_ref?).and_return(false)
        allow(described_class).to receive(:run_travel_to) do |step|
          raise described_class::StepFailed, 'unreachable' if step['room'] == 1
          visited << step['room']
        end
        expect(described_class.send(:run_search_rooms,
                                    { 'rooms' => [1, 2], 'until' => 'loot_noun:x' })).to be(true)
      end

      it 'fails when the whole list is exhausted' do
        allow(described_class).to receive(:condition?).and_return(false)
        allow(described_class).to receive(:at_room_ref?).and_return(false)
        allow(described_class).to receive(:run_travel_to)
        expect { described_class.send(:run_search_rooms, { 'rooms' => [1], 'until' => 'loot_noun:x' }) }
          .to raise_error(described_class::StepFailed, /not found in 1 rooms/)
      end

      it 'validates rooms and until, accepting uids' do
        v = described_class::Validator
        good = { 'do' => 'search_rooms', 'rooms' => [1, 'u474204'], 'until' => 'loot_noun:x' }
        expect(v.errors_for_wayto([good])).to be_empty
        expect(v.errors_for_wayto([good.merge('rooms' => [])]).join).to include('requires rooms')
        expect(v.errors_for_wayto([good.reject { |k, _| k == 'until' }]).join).to include('requires until')
      end
    end

    describe 'find_item' do
      it 'verifies candidates and binds the one that matches' do
        mine = double('mine', id: 111, noun: 'scrip')
        theirs = double('theirs', id: 222, noun: 'scrip')
        stub_const('Lich::Common::GameObj',
                   double('GameObj',
                          right_hand: double(id: nil, noun: nil),
                          left_hand: double(id: nil, noun: nil),
                          inv: [double('sack', contents: [theirs, mine])]))
        allow(described_class).to receive(:fput)
        allow(described_class).to receive(:empty_hand)
        # Only the second look carries the character name.
        allow(described_class).to receive(:dothistimeout)
          .and_return('You see nothing unusual.', 'reads, "Nisugi')

        described_class.send(:run_find_item,
                             { 'nouns' => ['scrip'], 'verify' => 'look {item}',
                               'matching' => 'reads, ".*Nisugi' })
        expect(described_class.captures['item']).to eq('#111')
      end

      it 'opens containers it cannot see into, and closes the ones it opened' do
        ticket = double('ticket', id: 333, noun: 'scrip')
        # contents empty at first (so it must be opened), populated after.
        sack = double('sack', id: 900)
        # Empty until we look inside, then populated - as the game reports it.
        looked = false
        allow(sack).to receive(:contents) { looked ? [ticket] : nil }
        stub_const('Lich::Common::GameObj',
                   double('GameObj',
                          right_hand: double(id: nil, noun: nil),
                          left_hand: double(id: nil, noun: nil),
                          inv: [sack]))
        allow(described_class).to receive(:fput)
        allow(described_class).to receive(:empty_hand)
        allow(described_class).to receive(:dothistimeout) do |cmd, _t, _p|
          case cmd
          when /\Aopen / then 'You open the sack.'
          when /\Alook in /
            looked = true
            'In the sack you see a scrip.'
          else 'reads, "Nisugi'
          end
        end

        expect(described_class).to receive(:fput).with('close #900')
        described_class.send(:run_find_item,
                             { 'nouns' => ['scrip'], 'verify' => 'look {item}',
                               'matching' => 'reads, ".*Nisugi' })
        expect(described_class.captures['item']).to eq('#333')
      end

      it 'leaves item unbound when nothing matches, so an edge can offer a fallback' do
        stub_const('Lich::Common::GameObj',
                   double('GameObj',
                          right_hand: double(id: nil, noun: nil),
                          left_hand: double(id: nil, noun: nil),
                          inv: []))
        described_class.send(:run_find_item,
                             { 'nouns' => ['scrip'], 'verify' => 'look {item}',
                               'matching' => 'reads, ".*Nisugi' })
        expect(described_class.condition?('capture:item')).to be(false)
      end

      it 'validates its required params' do
        v = described_class::Validator
        good = { 'do' => 'find_item', 'nouns' => ['scrip'], 'verify' => 'look {item}',
                 'matching' => 'x' }
        expect(v.errors_for_wayto([good])).to be_empty
        expect(v.errors_for_wayto([good.merge('nouns' => [])]).join).to include('requires nouns')
      end
    end

    it 'branches on which alternative a bound line matched' do
      described_class.captures['outcome'] = 'It appears to be locked.'
      expect(described_class.condition?('capture_match:outcome=It appears to be locked')).to be(true)
      expect(described_class.condition?('capture_match:outcome=You open')).to be(false)
    end

    it 'expands room_id from things in the room, not your inventory' do
      shop = double('shop', id: 4242, name: 'an ivy-covered building', noun: 'building')
      stub_const('Lich::Common::GameObj',
                 double('GameObj', loot: [shop], room_desc: [], inv: []))
      expect(described_class.expand_tokens('go {room_id:an ivy-covered building}')).to eq('go #4242')
      expect { described_class.expand_tokens('go {room_id:a missing thing}') }
        .to raise_error(described_class::StepFailed, /not in this room/)
    end

    it 'matches room scenery by full name when it varies by adjective' do
      barrier = double('barrier', name: 'a blue barrier', noun: 'barrier')
      stub_const('Lich::Common::GameObj', double('GameObj', room_desc: [barrier]))
      expect(described_class.condition?('room_object_match:blue barrier')).to be(true)
      expect(described_class.condition?('room_object_match:red barrier')).to be(false)
      # the bare-noun form cannot tell the colours apart
      expect(described_class.condition?('room_object:barrier')).to be(true)
    end

    it 'tests what is in hand, by type or by name' do
      gem = double('gem', id: 77, type: 'gem', noun: 'diamond', name: 'a flawed diamond')
      empty = double('empty', id: nil, type: nil, noun: nil, name: nil)
      stub_const('Lich::Common::GameObj', double('GameObj', right_hand: gem, left_hand: empty))
      expect(described_class.condition?('holding:')).to be(true)
      expect(described_class.condition?('holding:gem')).to be(true)      # type
      expect(described_class.condition?('holding:diamond')).to be(true)  # noun
      expect(described_class.condition?('holding:sword')).to be(false)
      expect(described_class.expand_tokens('put {hand_id} in door')).to eq('put #77 in door')
    end

    it 'reports empty hands rather than guessing an id' do
      empty = double('empty', id: nil, type: nil, noun: nil, name: nil)
      stub_const('Lich::Common::GameObj', double('GameObj', right_hand: empty, left_hand: empty))
      expect(described_class.condition?('holding:')).to be(false)
      expect { described_class.expand_tokens('put {hand_id} in door') }
        .to raise_error(described_class::StepFailed, /nothing in hand/)
    end

    it 'matches npcs separately from loot' do
      # GameObj.loot is items; a bandit is an npc and would never appear there.
      bandit = double('bandit', name: 'a burly bandit', noun: 'bandit')
      stub_const('Lich::Common::GameObj', double('GameObj', npcs: [bandit], loot: []))
      expect(described_class.condition?('npc_match:bandit|thief')).to be(true)
      expect(described_class.condition?('loot_match:bandit')).to be(false)
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
