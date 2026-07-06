# frozen_string_literal: true

require 'json'
require 'fileutils'
require 'socket'
require 'timeout'

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

  describe 'end-to-end page flow over a live WebSocket' do
    # has_thread? => true makes the production dispatcher run callbacks
    # inline on the calling thread, so no real Script engine is needed.
    let(:fake_script) do
      Struct.new(:name) do
        def has_thread?(_thread)
          true
        end
      end.new('demo')
    end

    def read_message(socket)
      frame = Timeout.timeout(3) { Lich::WebUI::WebSocket.read_frame(socket, require_mask: false) }
      JSON.parse(frame.payload, symbolize_names: true)
    end

    def read_message_of_type(socket, type)
      5.times do
        message = read_message(socket)
        return message if message[:type] == type
      end
      raise "no #{type} message received"
    end

    it 'subscribes, renders, dispatches a click, and re-renders' do
      allow(described_class).to receive(:enabled?).and_return(true)
      expect(described_class.ensure_service!).to be(true)

      page = Lich::WebUI::Page.new(
        id: 'demo/counter',
        title: 'Counter',
        script: fake_script,
        block: proc { |ui|
          ui.text "count: #{ui.state[:count] || 0}"
          ui.button('Bump') { ui.state[:count] = (ui.state[:count] || 0) + 1 }
        }
      )
      Lich::WebUI::Registry.register(page)

      token = described_class.auth_url[/token=(\h+)/, 1]
      socket = TCPSocket.new('127.0.0.1', described_class.port)
      socket.write(
        "GET /ws HTTP/1.1\r\nHost: 127.0.0.1:#{described_class.port}\r\n" \
        "Upgrade: websocket\r\nConnection: Upgrade\r\n" \
        "Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==\r\n" \
        "Origin: http://127.0.0.1:#{described_class.port}\r\n" \
        "Cookie: lich_webui=#{token}\r\n\r\n"
      )
      head = +''
      head << socket.read(1) until head.end_with?("\r\n\r\n")
      expect(head).to include('101 Switching Protocols')

      hello = read_message_of_type(socket, 'hello')
      expect(hello[:pages]).to eq([{ id: 'demo/counter', title: 'Counter', script: 'demo' }])

      socket.write(Lich::WebUI::WebSocket.encode_client_frame(
                     JSON.generate(type: 'subscribe', page: 'demo/counter')
                   ))
      render = read_message_of_type(socket, 'render')
      expect(render[:tree][:children].first[:text]).to eq('count: 0')

      socket.write(Lich::WebUI::WebSocket.encode_client_frame(
                     JSON.generate(type: 'event', page: 'demo/counter', cid: 'button:1', event: 'click', value: nil)
                   ))
      rerender = read_message_of_type(socket, 'render')
      expect(rerender[:tree][:children].first[:text]).to eq('count: 1')
      expect(rerender[:seq]).to eq(2)

      socket.close
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
