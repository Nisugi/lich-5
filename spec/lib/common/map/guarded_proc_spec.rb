# frozen_string_literal: true

require_relative '../../../spec_helper'
require 'json'
require 'common/map/map_engine'
require 'common/map/map_strategies'
require 'common/map/guarded_proc'

RSpec.describe Lich::Common::MapEngine::GuardedProc do
  before { described_class.reset! }
  after  { described_class.reset! }

  # A body every recognizer set handles: the portmaster setting gate.
  let(:gate) { 'UserVars.mapdb_use_portmasters == true ? 1200 : nil' }

  describe 'proc fidelity' do
    it 'reports the original source from _dump, so maps round-trip unedited' do
      proc = described_class.new(gate, 'timeto', 250, '10838')
      expect(proc._dump).to eq(gate)
      expect(proc.to_json).to eq(";e #{gate}".to_json)
    end

    it 'still claims to be a Proc, which ecosystem scripts test for' do
      proc = described_class.new(gate, 'timeto', 250, '10838')
      # mapmap and friends branch on `way.class == Proc` / kind_of?(Proc).
      expect(proc.class).to eq(Proc)
      expect(proc.kind_of?(Proc)).to be(true)
    end

    it 'normalizes newlines exactly as StringProc does' do
      expect(described_class.new("a\r\nb", 'wayto', 1, '2')._dump).to eq("a\nb")
    end
  end

  describe 'conversion' do
    it 'builds schema instead of evaling, and executes that' do
      proc = described_class.new(gate, 'timeto', 250, '10838')
      built = proc.send(:resolve)
      expect(built).to be_a(Lich::Common::MapEngine::Cost)
      expect(built.raw).to eq('cost' => 1200, 'requires' => ['setting:portmasters'])
    end

    it 'memoizes by source, so duplicated bodies convert once' do
      2.times { |i| described_class.new(gate, 'timeto', 250 + i, '10838').send(:resolve) }
      expect(described_class.cache.size).to eq(1)
    end

    it 'records which recognizer matched, so idiom drift is visible' do
      described_class.new(gate, 'timeto', 250, '10838').send(:resolve)
      described_class.new("fput 'go arch'", 'wayto', 1, '2').send(:resolve)
      expect(described_class.idioms['timeto:setting_gate']).to eq(1)
      expect(described_class.idioms.values.sum).to eq(2)
    end

    it 'counts idioms per body, not per edge, matching what the cache holds' do
      3.times { |i| described_class.new(gate, 'timeto', 250 + i, '10838').send(:resolve) }
      expect(described_class.idioms['timeto:setting_gate']).to eq(1)
    end

    it 'does not count a refused body as an idiom' do
      described_class.new('some_helper_no_recognizer_knows(42)', 'wayto', 1, '2').send(:resolve)
      expect(described_class.idioms).to be_empty
    end

    it 'prefers a hand-authored overlay entry, keyed per edge' do
      described_class.use_game('GSIV')
      overlay = described_class.converter
      allow(overlay).to receive(:manual_for).and_call_original
      allow(overlay).to receive(:manual_for).with('wayto', 1, '2')
                                            .and_return([{ 'do' => 'move', 'cmd' => 'go arch' }])
      proc = described_class.new('anything at all', 'wayto', 1, '2')
      built = proc.send(:resolve)
      # Crossing masquerades as Proc, so identify it by its schema instead.
      expect(built.raw).to eq([{ 'do' => 'move', 'cmd' => 'go arch' }])
      expect(described_class.edge_cache).to have_key('1:2')
      # Body cache untouched: the entry belongs to the edge, not the body.
      expect(described_class.cache).to be_empty
    end
  end

  describe 'refusal (fail closed, never eval)' do
    let(:unknown) { 'some_helper_no_recognizer_knows(42)' }

    it 'returns nil for an unconvertible timeto, which dijkstra skips' do
      expect(described_class.new(unknown, 'timeto', 1, '2').call).to be_nil
    end

    it 'returns false for an unconvertible wayto, which go2 treats as failed' do
      expect(described_class.new(unknown, 'wayto', 1, '2').call).to be(false)
    end

    it 'never evaluates the refused body' do
      # If the source were eval'd this would raise NoMethodError rather than
      # returning nil - that is the whole security property.
      expect { described_class.new('raise "evaled!"', 'timeto', 1, '2').call }.not_to raise_error
    end

    it 'clusters refusals by normalized body so one idiom reports once' do
      described_class.new('mystery_call(1)', 'wayto', 1, '2').call
      described_class.new('mystery_call(2)', 'wayto', 3, '4').call
      clusters = described_class.refusal_clusters
      expect(clusters.length).to eq(1)
      expect(clusters.first[:count]).to eq(2)
      expect(clusters.first[:field]).to eq('wayto')
    end
  end

  describe 'a real DR submission' do
    # Every new StringProc from an actual DR mapper submission (the
    # lich_repo_mirror dr_map report), 266 edges over 32 distinct bodies.
    # It converted with no recognizer changes; this keeps it that way.
    let(:fixture) do
      path = File.expand_path('../../../fixtures/map/dr_submission_2026_08.json', __dir__)
      JSON.parse(File.read(path))
    end

    it 'converts every submitted proc without a recognizer change' do
      described_class.use_game('DR')
      refused = fixture.reject do |entry|
        described_class.new(entry['body'], entry['field'], entry['room'], entry['dest'])
                       .send(:resolve) != :refused
      end
      expect(refused.map { |e| e['body'] }).to be_empty
    end

    it 'keeps move and fput distinct, since only move expects a room change' do
      described_class.use_game('DR')
      converter = described_class.converter
      steps = converter.convert_wayto("move 'climb heavy barricade'; waitrt?; fput('look')").schema
      expect(steps.map { |s| s['do'] }).to eq(%w[move wait_rt send])
      steps = converter.convert_wayto("fput('search'); waitrt?; move('go log')").schema
      expect(steps.map { |s| s['do'] }).to eq(%w[send wait_rt move])
    end

    it 'escapes a waitfor literal so punctuation is not read as a regex' do
      described_class.use_game('DR')
      steps = described_class.converter.convert_wayto("fput 'climb ramp'; waitfor 'Obvious paths:'").schema
      pattern = Lich::Common::MapEngine.send(:compile_pattern, steps[0]['for'])
      expect('Obvious paths: north, east').to match(pattern)
      # waitfor has no timeout of its own, so converted awaits get the long
      # ceiling and fail rather than falling through silently.
      expect(steps[0]['timeout']).to eq(1800)
      expect(steps[0]['on_timeout']).to eq('fail')
    end
  end

  describe 'coverage against real map data', :slow do
    # The gate that matters: a stock tillmen map must convert completely,
    # since a refusal is an edge the user can no longer travel.
    def refusals_for(path, game)
      skip "no map at #{path}" unless File.exist?(path)
      described_class.reset!
      described_class.use_game(game)
      JSON.parse(File.read(path)).each do |room|
        %w[wayto timeto].each do |field|
          (room[field] || {}).each do |dest, value|
            next unless value.is_a?(String) && value.start_with?(';e ')
            described_class.new(value[3..], field, room['id'], dest).send(:resolve)
          end
        end
      end
      described_class.refusal_clusters
    end

    # The real gate: a stock tillmen mapdb must convert completely, since a
    # refusal is an edge the user can no longer travel. Prefers the newest
    # proc-bearing map in the repo's data dir; MAPDB_FIXTURE overrides.
    # A converted map has no procs and would pass vacuously, so maps without
    # any are skipped rather than counted as a pass.
    def stock_mapdb
      return ENV['MAPDB_FIXTURE'] if ENV['MAPDB_FIXTURE']
      Dir.glob(File.expand_path('../../../../data/GSIV/map-*.json', __dir__))
         .sort_by { |f| -File.mtime(f).to_i }
         .find { |f| File.read(f).include?('";e ') }
    end

    it 'converts every proc in a stock GS mapdb' do
      path = stock_mapdb
      skip 'no proc-bearing mapdb available (set MAPDB_FIXTURE)' unless path && File.exist?(path)
      skip "#{path} has no StringProcs" unless File.read(path).include?('";e ')
      expect(refusals_for(path, ENV.fetch('MAPDB_GAME', 'GSIV'))).to be_empty
      # Every conversion is attributed to a recognizer with nothing falling
      # through. Manual-overlay hits cache per edge rather than per body, so
      # the profile spans both caches.
      expect(described_class.idioms.values.sum)
        .to eq(described_class.cache.size + described_class.edge_cache.size)
      expect(described_class.idioms.keys).to all(match(%r{\A(wayto|timeto):\w+\z}))
    end

    it 'dumps every proc edge byte-identically, so saving a map is lossless' do
      path = stock_mapdb
      skip 'no proc-bearing mapdb available (set MAPDB_FIXTURE)' unless path && File.exist?(path)
      described_class.reset!
      mismatched = []
      JSON.parse(File.read(path)).each do |room|
        %w[wayto timeto].each do |field|
          (room[field] || {}).each do |dest, value|
            next unless value.is_a?(String) && value.start_with?(';e ')
            proc = described_class.new(value[3..], field, room['id'], dest)
            # What the loader writes back out on save. CRLF is normalized on
            # the way in, exactly as StringProc has always done.
            mismatched << [room['id'], dest] unless ";e #{proc._dump}" == value.gsub(/\r\n?/, "\n")
          end
        end
      end
      expect(mismatched).to be_empty
    end
  end
end
