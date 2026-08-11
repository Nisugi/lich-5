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

  describe Lich::Common::MapEngine::UniqueCrossings do
    it 'carries the relocated one-off crossings' do
      # Deliberately not a size floor: this registry is meant to shrink as
      # recognizers learn each idiom family. Assert both game sections loaded
      # and that a named block is callable.
      expect(described_class::REGISTRY).not_to be_empty
      expect(described_class.known?('crossing_6274_11032')).to be(true)
      expect(described_class::REGISTRY.keys).to include(a_string_starting_with('crossing_dr_'))
      expect(described_class::REGISTRY['crossing_6274_11032']).to be_a(Proc)
    end

    it 'validates unique_crossing strategy references' do
      validator = Lich::Common::MapEngine::Validator
      expect(validator.errors_for_wayto({ 'strategy' => 'unique_crossing', 'name' => 'crossing_6274_11032' }))
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
