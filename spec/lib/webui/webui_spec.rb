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

    it 'stays available while running even when the flag is off (pre-login launcher)' do
      # the login launcher force-starts the server under :webui_login; a
      # disabled :webui flag must not break open_page afterwards
      allow(described_class).to receive(:enabled?).and_return(false)
      expect(described_class.ensure_service!(force: true)).to be(true)

      allow(described_class).to receive(:open_browser).and_return(true)
      expect(described_class.ensure_service!).to be(true)
      expect(described_class.open_page('lich/login', app: true, size: [560, 580])).to be(true)
      expect(described_class.auth_url_for('lich/login')).to match(%r{/auth\?token=[0-9a-f]{64}&to=/%23/lich/login\z})
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

  describe 'window geometry memory' do
    before { described_class.instance_variable_set(:@geometry_store, {}) }
    after { described_class.instance_variable_set(:@geometry_store, nil) }

    it 'remembers reported geometry for client-side restore' do
      described_class.remember_window_geometry('map/map', { w: 640, h: 480, x: 100, y: 60 })
      expect(described_class.window_geometry('map/map')).to eq({ 'w' => 640, 'h' => 480, 'x' => 100, 'y' => 60 })
    end

    it 'launches with caller default flags, NOT stored geometry (stored geometry breaks --app on a running browser)' do
      described_class.remember_window_geometry('map/map', { w: 640, h: 480, x: 100, y: 60 })
      allow(described_class).to receive(:enabled?).and_return(true)
      allow(described_class).to receive(:open_browser).and_return(true)
      described_class.ensure_service!

      described_class.open_page('map/map', app: true, size: [520, 560])
      expect(described_class).to have_received(:open_browser)
        .with(anything, app: true, size: [520, 560], position: nil)
    end

    it 'rejects junk geometry' do
      described_class.remember_window_geometry('a/b', { w: 0, h: 0, x: 5, y: 5 })
      described_class.remember_window_geometry('a/b', 'nonsense')
      expect(described_class.window_geometry('a/b')).to be_nil
    end

    it 'keeps ordinary negative coords (monitors left of / above primary)' do
      described_class.remember_window_geometry('m/m', { w: 600, h: 400, x: -1200, y: -500 })
      expect(described_class.window_geometry('m/m')).to eq({ 'w' => 600, 'h' => 400, 'x' => -1200, 'y' => -500 })
    end

    it 'never records a minimized window (the -32000 sentinel)' do
      described_class.remember_window_geometry('m/m', { w: 600, h: 400, x: 100, y: 80 })
      described_class.remember_window_geometry('m/m', { w: 600, h: 400, x: -32000, y: -32000 })
      # last good geometry preserved, not overwritten by the minimized report
      expect(described_class.window_geometry('m/m')).to eq({ 'w' => 600, 'h' => 400, 'x' => 100, 'y' => 80 })
    end

    it 'drops an off-screen stored position on read but keeps the size' do
      described_class.instance_variable_get(:@geometry_store)['m/m'] =
        { 'w' => 600, 'h' => 400, 'x' => -32000, 'y' => -32000 } # simulate old poisoned data
      expect(described_class.window_geometry('m/m')).to eq({ 'w' => 600, 'h' => 400 })
    end

    it 'a registered core page carries stored geometry in its render tree (drives client restore)' do
      described_class.remember_window_geometry('lich/probe', { w: 700, h: 500, x: 40, y: 30 })
      allow(described_class).to receive(:enabled?).and_return(true)
      described_class.ensure_service!

      page = described_class.register_core_page('probe', bare: true, size: [300, 300]) { |ui| ui.text 'hi' }
      conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
      page.subscribe(conn)
      tree = JSON.parse(conn.sent.last)['tree']
      expect(tree['size']).to eq([700, 500])
      expect(tree['position']).to eq([40, 30])
    ensure
      Lich::WebUI::Registry.clear!
    end
  end

  describe 'preferred port' do
    it 'binds the preferred port when available' do
      probe = TCPServer.new('127.0.0.1', 0)
      free_port = probe.addr[1]
      probe.close

      allow(described_class).to receive(:enabled?).and_return(true)
      allow(described_class).to receive(:preferred_port).and_return(free_port)
      expect(described_class.ensure_service!).to be(true)
      expect(described_class.port).to eq(free_port)
    end
  end

  describe '.reset_window_geometry!' do
    it 'forgets every remembered window and reports the count' do
      described_class.instance_variable_set(:@geometry_store, {})
      described_class.remember_window_geometry('a/b', { w: 300, h: 200, x: 10, y: 10 })
      described_class.remember_window_geometry('c/d', { w: 400, h: 300, x: 20, y: 20 })

      expect(described_class.reset_window_geometry!).to eq(2)
      expect(described_class.window_geometry('a/b')).to be_nil
      described_class.instance_variable_set(:@geometry_store, nil)
    end
  end

  describe '.handshake_payload' do
    it 'reports stopped when not running and a parseable descriptor when running' do
      expect(described_class.handshake_payload).to eq('<LichWebUI status="stopped"/>')

      allow(described_class).to receive(:enabled?).and_return(true)
      described_class.ensure_service!
      expect(described_class.handshake_payload).to match(
        %r{\A<LichWebUI status="ok" port="\d+" url="http://127\.0\.0\.1:\d+/" auth="http://127\.0\.0\.1:\d+/auth\?token=[0-9a-f]{64}" schema="\d+"/>\z}
      )
    end
  end

  describe '.refresh_hello' do
    it 'rewrites the discovery file with the post-login session identity' do
      allow(described_class).to receive(:enabled?).and_return(true)
      described_class.ensure_service!
      allow(described_class).to receive(:session_info).and_return({ name: 'Nisugi', game: 'GSIV' })

      described_class.refresh_hello

      entry = JSON.parse(File.read(File.join(described_class::DISCOVERY_DIR, "#{Process.pid}.json")), symbolize_names: true)
      expect(entry[:name]).to eq('Nisugi')
      expect(entry[:game]).to eq('GSIV')
    end

    it 'is a no-op when the service is not running' do
      expect { described_class.refresh_hello }.not_to raise_error
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
