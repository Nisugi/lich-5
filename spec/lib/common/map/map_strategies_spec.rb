# frozen_string_literal: true

require_relative '../../../spec_helper'
require 'common/map/map_engine'
require 'common/map/map_strategies'
require 'common/map/map_crossings'

RSpec.describe Lich::Common::MapEngine::Strategies do
  it 'registers the strategy set with required params' do
    %w[table_join confluence_explorer guided_route patrol_search shifting_maze].each do |name|
      expect(described_class.known?(name)).to be(true), "expected #{name} to be registered"
      expect(described_class::REQUIRED_PARAMS[name]).not_to be_empty
    end
  end

  it 'fails validation when required params are missing' do
    validator = Lich::Common::MapEngine::Validator
    expect(validator.errors_for_wayto({ 'strategy' => 'guided_route' }).join)
      .to include('missing required param')
    expect(validator.errors_for_wayto(
             { 'strategy' => 'guided_route', 'target' => 12677, 'dirs' => { '12662' => 'south' } }
           )).to be_empty
  end

  describe Lich::Common::MapEngine::Strategies::ConfluenceExplorer do
    describe '.dir_toward' do
      # Learned graph: 1 -[n]-> 2 -[e]-> 3; room 1 also has an unexplored exit.
      let(:learned) do
        { 1 => { 'north' => 2, 'west' => nil },
          2 => { 'east' => 3, 'south' => 1 },
          3 => { 'west' => 2 } }
      end

      it 'finds a direct exit toward the target' do
        expect(described_class.dir_toward(learned, 2, [3])).to eq('east')
      end

      it 'chains backward through rooms known to reach the target' do
        expect(described_class.dir_toward(learned, 1, [3])).to eq('north')
      end

      it 'finds the nearest unexplored exit when targeting nil' do
        expect(described_class.dir_toward(learned, 1, [nil])).to eq('west')
      end

      it 'returns nil when the target is unreachable in the learned graph' do
        expect(described_class.dir_toward(learned, 3, [99])).to be_nil
      end
    end

    it 'keeps hot and cold zones disjoint and complete' do
      hot = described_class::HOT_ROOMS
      cold = described_class::COLD_ROOMS
      expect(hot & cold).to be_empty
      expect(hot.length + cold.length).to eq(53)
    end
  end

  describe Lich::Common::MapEngine::Strategies::DayPass do
    before { described_class.passes.clear }

    it 'reports a live pass for its town pair only' do
      described_class.passes['123'] = { :towns   => ["Wehnimer's Landing", 'Icemule Trace'],
                                        :expires => Time.now + 3600 }
      expect(described_class.usable?("Wehnimer's Landing", 'Icemule Trace')).to be(true)
      expect(described_class.usable?('Icemule Trace', "Wehnimer's Landing")).to be(true)
      expect(described_class.usable?('Solhaven', "Wehnimer's Landing")).to be(false)
    end

    it 'rejects expired and expiry-less passes' do
      described_class.passes['1'] = { :towns => %w[A B], :expires => Time.now - 5 }
      described_class.passes['2'] = { :towns => %w[A B] } # look seen, expiry line not yet
      expect(described_class.usable?('A', 'B')).to be(false)
    end
  end

  describe Lich::Common::MapEngine::Strategies::ManaCrown do
    it 'spends the budget on spells this character actually knows' do
      cheap = double('cheap', num: 105, known?: true, mana_cost: 5)
      big   = double('big', num: 420, known?: true, mana_cost: 40)
      unknown = double('unknown', num: 110, known?: false, mana_cost: 10)
      spell515 = double('515', active?: false)
      lookup = { 105 => cheap, 420 => big, 110 => unknown, 515 => spell515 }
      spell_class = class_double('Spell').as_stubbed_const
      allow(spell_class).to receive(:[]) { |n| lookup[n] }

      crown = described_class.new('amount' => 80, 'target' => 'crown',
                                  'castables' => [110, 420], 'cheap' => [105])
      allow(crown).to receive(:mana).and_return(999)
      allow(crown).to receive(:sleep)
      # 420 costs 40 and fits twice; 110 is unknown and never chosen.
      expect(big).to receive(:cast).with('crown').twice.and_return('You gesture.')
      expect(unknown).not_to receive(:cast)
      crown.send(:fill_crown)
    end
  end

  describe Lich::Common::MapEngine::UniqueCrossings do
    # Naming a specific crossing here pins a moving target: every block is a
    # candidate to become schema. Take whatever is registered instead.
    let(:a_crossing) { described_class::REGISTRY.keys.first }

    it 'carries the relocated one-off crossings' do
      # Deliberately not a size floor: this registry is meant to shrink as
      # each idiom becomes schema. GS has reached zero - every GS edge is now
      # data - so only assert that what IS registered is callable.
      expect(described_class::REGISTRY).not_to be_empty
      expect(described_class.known?(a_crossing)).to be(true)
      expect(described_class::REGISTRY[a_crossing]).to be_a(Proc)
    end

    it 'has no GS crossings left: every GS edge is schema' do
      gs = described_class::REGISTRY.keys.reject { |k| k.start_with?('crossing_dr_') }
      expect(gs).to be_empty
      # DR has not been through this pass yet.
      expect(described_class::REGISTRY.keys).to include(a_string_starting_with('crossing_dr_'))
    end

    it 'validates unique_crossing strategy references' do
      validator = Lich::Common::MapEngine::Validator
      expect(validator.errors_for_wayto({ 'strategy' => 'unique_crossing', 'name' => a_crossing }))
        .to be_empty
      expect(validator.errors_for_wayto({ 'strategy' => 'unique_crossing' }).join)
        .to include('missing required param')
    end
  end

  describe Lich::Common::MapEngine::Strategies::GuidedRoute do
    it 'builds commands from the verb' do
      route = described_class.new('target' => 12677, 'verb' => 'swim', 'dirs' => { '12662' => 'south' })
      expect(route.command_for('south')).to eq('swim south')
    end

    it 'passes bare commands through without a verb' do
      route = described_class.new('target' => 5, 'dirs' => { '4' => 'go bridge' })
      expect(route.command_for('go bridge')).to eq('go bridge')
    end
  end
end
