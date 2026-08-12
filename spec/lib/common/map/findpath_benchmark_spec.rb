# frozen_string_literal: true

# Phase 3 gate: routing must not get slower now that timeto costs are
# converted schema rather than eval'd Ruby. Dijkstra touches every timeto in
# the searched region, so this is where a regression would show up if
# anywhere.
#
# Not an assertion of absolute speed - machines differ - but of the ratio
# against the eval baseline this replaced, measured on the same map in the
# same process. The :benchmark tag selects it (bundle exec rspec --tag
# benchmark) and prints the numbers; it runs in the normal suite too, since
# it costs a fraction of a second and its assertions are real gates.

require_relative '../../../spec_helper'
require 'benchmark'
require 'json'
require 'common/map/map_engine'
require 'common/map/map_strategies'
require 'common/map/guarded_proc'

RSpec.describe 'findpath cost resolution', :benchmark do
  let(:guarded) { Lich::Common::MapEngine::GuardedProc }

  # The proc-bearing GS map, if one is present in this checkout.
  def stock_mapdb
    return ENV['MAPDB_FIXTURE'] if ENV['MAPDB_FIXTURE']
    Dir.glob(File.expand_path('../../../../data/GSIV/map-*.json', __dir__))
       .sort_by { |f| -File.mtime(f).to_i }
       .find { |f| File.read(f).include?('";e ') }
  end

  # Every distinct timeto body in the map: exactly the set dijkstra resolves.
  def timeto_bodies(path)
    JSON.parse(File.read(path)).flat_map do |room|
      (room['timeto'] || {}).filter_map do |dest, v|
        [v[3..], room['id'], dest] if v.is_a?(String) && v.start_with?(';e ')
      end
    end
  end

  it 'resolves converted costs faster than evaling them' do
    path = stock_mapdb
    skip 'no proc-bearing mapdb available (set MAPDB_FIXTURE)' unless path

    guarded.reset!
    guarded.use_game(ENV.fetch('MAPDB_GAME', 'GSIV'))
    edges = timeto_bodies(path)
    procs = edges.map { |body, room, dest| guarded.new(body, 'timeto', room, dest) }

    # Cold: what a session pays once, on the first route that touches these.
    cold = Benchmark.realtime { procs.each { |p| p.send(:resolve) } }

    # Warm: what every subsequent dijkstra pass pays per edge.
    warm = Benchmark.realtime { 5.times { procs.each { |p| p.send(:resolve) } } } / 5

    # The baseline this replaced: eval of the same bodies. StringProc#call
    # eval'd the source every single time - there was no memoization.
    #
    # Caveat: outside a live session many bodies reference absent game state
    # and raise, so raise-and-rescue is inside the measurement. That makes
    # this an approximation of the old cost rather than a like-for-like
    # figure. It is not load-bearing: the memoized path does no per-call
    # parsing at all, so the direction of the comparison is not in doubt,
    # and the margin here is far larger than the caveat could explain.
    baseline_procs = edges.map { |body, _, _| Lich::Common::StringProc.new(body) }
    baseline = Benchmark.realtime do
      baseline_procs.each do |p|
        p.call
      rescue StandardError, SyntaxError
        nil # bodies referencing absent game state still cost the eval
      end
    end

    per = ->(t) { (t / edges.length) * 1_000_000 }
    puts format("\n  timeto edges: %d (%d distinct bodies)", edges.length, guarded.cache.size)
    puts format('  cold convert: %.1f ms total, %.2f us/edge', cold * 1000, per.call(cold))
    puts format('  warm lookup : %.2f us/edge', per.call(warm))
    puts format('  eval baseline: %.2f us/edge', per.call(baseline))
    puts format('  warm speedup: %.1fx', baseline / warm)

    # The gate: steady-state routing is not slower than the eval it replaced.
    expect(warm).to be < baseline

    # And the one-time cost is small enough not to be felt on a first route.
    expect(cold).to be < 1.0
  end
end
