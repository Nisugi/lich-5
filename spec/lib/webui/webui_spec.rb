# frozen_string_literal: true

require 'json'
require 'fileutils'

require_relative '../../spec_helper'
require_relative '../../../lib/webui/webui'

RSpec.describe Lich::WebUI do
  after do
    described_class.stop_service!
  end

  describe '.ensure_service!' do
    it 'stays inert when the feature flag is off' do
      allow(described_class).to receive(:enabled?).and_return(false)
      expect(described_class.ensure_service!).to be(false)
      expect(described_class).not_to be_running
      expect(described_class.url).to be_nil
      expect(described_class.auth_url).to be_nil
    end

    it 'starts the server, exposes URLs, and writes a discovery file when enabled' do
      allow(described_class).to receive(:enabled?).and_return(true)

      expect(described_class.ensure_service!).to be(true)
      expect(described_class).to be_running
      expect(described_class.port).to be > 0
      expect(described_class.url).to eq("http://127.0.0.1:#{described_class.port}/")
      expect(described_class.auth_url).to match(%r{\Ahttp://127\.0\.0\.1:#{described_class.port}/auth\?token=[0-9a-f]{64}\z})

      discovery = File.join(described_class::DISCOVERY_DIR, "#{Process.pid}.json")
      expect(File).to exist(discovery)
      entry = JSON.parse(File.read(discovery), symbolize_names: true)
      expect(entry[:pid]).to eq(Process.pid)
      expect(entry[:port]).to eq(described_class.port)

      # idempotent
      expect(described_class.ensure_service!).to be(true)
    end
  end

  describe '.stop_service!' do
    it 'stops the server and removes the discovery file' do
      allow(described_class).to receive(:enabled?).and_return(true)
      described_class.ensure_service!
      discovery = File.join(described_class::DISCOVERY_DIR, "#{Process.pid}.json")
      expect(File).to exist(discovery)

      described_class.stop_service!
      expect(described_class).not_to be_running
      expect(File).not_to exist(discovery)
    end

    it 'is safe to call when never started' do
      expect { described_class.stop_service! }.not_to raise_error
    end
  end

  describe '.sibling_sessions' do
    it 'lists live siblings and prunes entries for dead pids' do
      FileUtils.mkdir_p(described_class::DISCOVERY_DIR)
      dead_pid = 4_999_999
      live_file = File.join(described_class::DISCOVERY_DIR, 'spec-live.json')
      dead_file = File.join(described_class::DISCOVERY_DIR, 'spec-dead.json')
      own_file = File.join(described_class::DISCOVERY_DIR, 'spec-own.json')
      File.write(live_file, JSON.generate(name: 'Alt', game: 'GSIV', port: 50_001, pid: Process.ppid))
      File.write(dead_file, JSON.generate(name: 'Gone', game: 'GSIV', port: 50_002, pid: dead_pid))
      File.write(own_file, JSON.generate(name: 'Self', game: 'GSIV', port: 50_003, pid: Process.pid))

      begin
        siblings = described_class.sibling_sessions
        names = siblings.map { |sibling| sibling[:name] }
        expect(names).to include('Alt')       # parent pid is alive and not us
        expect(names).not_to include('Self')  # own pid skipped
        expect(names).not_to include('Gone')  # dead pid pruned
        expect(File).not_to exist(dead_file)
      ensure
        [live_file, dead_file, own_file].each { |file| File.delete(file) if File.exist?(file) }
      end
    end
  end
end
