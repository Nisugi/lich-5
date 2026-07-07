# frozen_string_literal: true

require 'socket'
require 'json'
require 'timeout'
require 'fileutils'
require 'tmpdir'

require_relative '../../spec_helper'
require_relative '../../../lib/webui/server'
require_relative '../../../lib/webui/file_routes'

# These specs exercise the real transport end-to-end on an ephemeral loopback
# port: raw HTTP requests over TCPSocket, including a full RFC 6455 upgrade
# and frame exchange, with no browser involved.
RSpec.describe Lich::WebUI::Server do
  let(:token) { 'a' * 64 }
  let(:received_messages) { Queue.new }
  let(:server) do
    described_class.new(
      auth_token: token,
      assets_dir: File.expand_path('../../../lib/webui/assets', __dir__),
      port: 0,
      session_info: -> { { name: 'Testchar', game: 'GSIV' } },
      pages_provider: -> { [] },
      siblings_provider: -> { [] },
      message_handler: ->(_conn, message) { received_messages << message },
      file_resolver: Lich::WebUI::FileRoutes.method(:resolve)
    )
  end

  before do
    raise 'server failed to start' unless server.start
  end

  after do
    server.stop
  end

  def open_socket
    TCPSocket.new('127.0.0.1', server.port)
  end

  # Sends one HTTP request and returns [status, headers_hash, body].
  def http_request(path, headers: {}, host: nil)
    socket = open_socket
    host ||= "127.0.0.1:#{server.port}"
    request = "GET #{path} HTTP/1.1\r\nHost: #{host}\r\n"
    headers.each { |name, value| request << "#{name}: #{value}\r\n" }
    request << "\r\n"
    socket.write(request)
    response = socket.read.to_s
    socket.close rescue nil
    parse_response(response)
  end

  def parse_response(raw)
    head, body = raw.split("\r\n\r\n", 2)
    lines = head.to_s.split("\r\n")
    status = lines.shift.to_s.split(' ')[1].to_i
    headers = {}
    lines.each do |line|
      name, value = line.split(':', 2)
      headers[name.to_s.strip.downcase] = value.to_s.strip if name && value
    end
    [status, headers, body.to_s]
  end

  def auth_cookie
    { 'Cookie' => "lich_webui=#{token}" }
  end

  describe 'GET /auth' do
    it 'exchanges a valid token for a cookie and redirects' do
      status, headers, = http_request("/auth?token=#{token}")
      expect(status).to eq(302)
      expect(headers['location']).to eq('/')
      expect(headers['set-cookie']).to include("lich_webui=#{token}")
      expect(headers['set-cookie']).to include('HttpOnly')
      expect(headers['set-cookie']).to include('SameSite=Strict')
    end

    it 'rejects a bad token without reflecting the expected value' do
      status, headers, body = http_request('/auth?token=wrong')
      expect(status).to eq(403)
      expect(headers['set-cookie']).to be_nil
      expect(body).not_to include(token)
    end
  end

  describe 'asset routes' do
    it 'requires the auth cookie' do
      status, _, body = http_request('/')
      expect(status).to eq(403)
      expect(body).to include(';ui')
    end

    it 'serves the landing page with an ETag when authorized' do
      status, headers, body = http_request('/', headers: auth_cookie)
      expect(status).to eq(200)
      expect(headers['content-type']).to include('text/html')
      expect(headers['etag']).to match(/\A"[0-9a-f]{40}"\z/)
      expect(body).to include('Lich WebUI')
    end

    it 'returns 304 for a matching If-None-Match' do
      _, headers, = http_request('/', headers: auth_cookie)
      status, _, body = http_request('/', headers: auth_cookie.merge('If-None-Match' => headers['etag']))
      expect(status).to eq(304)
      expect(body).to be_empty
    end

    it 'serves whitelisted assets and 404s everything else' do
      status, headers, = http_request('/assets/app.js', headers: auth_cookie)
      expect(status).to eq(200)
      expect(headers['content-type']).to include('javascript')

      status, = http_request('/assets/../lib/webui/server.rb', headers: auth_cookie)
      expect(status).to eq(404)

      status, = http_request('/etc/passwd', headers: auth_cookie)
      expect(status).to eq(404)
    end
  end

  describe 'GET /files' do
    let(:files_root) do
      dir = File.join(Dir.tmpdir, "webui-files-spec-#{Process.pid}")
      FileUtils.mkdir_p(dir)
      File.binwrite(File.join(dir, 'map1.png'), 'PNGDATA')
      dir
    end

    before do
      Lich::WebUI::FileRoutes.register('maps', files_root)
    end

    after do
      Lich::WebUI::FileRoutes.clear!
      FileUtils.rm_rf(files_root)
    end

    it 'serves registered images with caching headers' do
      status, headers, body = http_request('/files/maps/map1.png', headers: auth_cookie)
      expect(status).to eq(200)
      expect(headers['content-type']).to eq('image/png')
      expect(headers['cache-control']).to include('max-age=60')
      expect(body).to eq('PNGDATA')

      status, = http_request('/files/maps/map1.png', headers: auth_cookie.merge('If-None-Match' => headers['etag']))
      expect(status).to eq(304)
    end

    it 'requires auth and 404s traversal, unknown aliases, and non-images' do
      status, = http_request('/files/maps/map1.png')
      expect(status).to eq(403)

      ['/files/maps/../server.rb', '/files/maps/%2e%2e/secrets.png',
       '/files/other/map1.png', '/files/maps/notes.txt'].each do |path|
        status, = http_request(path, headers: auth_cookie)
        expect(status).to eq(404), "expected 404 for #{path}, got #{status}"
      end
    end
  end

  describe 'Host validation' do
    it 'rejects requests with a foreign Host header (DNS rebinding)' do
      status, = http_request('/', headers: auth_cookie, host: 'evil.example.com')
      expect(status).to eq(403)
    end

    it 'accepts localhost as an alternate host' do
      status, = http_request('/', headers: auth_cookie, host: "localhost:#{server.port}")
      expect(status).to eq(200)
    end
  end

  describe 'WebSocket upgrade' do
    def upgrade_headers(origin: nil, cookie: true)
      origin ||= "http://127.0.0.1:#{server.port}"
      headers = {
        'Upgrade'               => 'websocket',
        'Connection'            => 'Upgrade',
        'Sec-WebSocket-Key'     => 'dGhlIHNhbXBsZSBub25jZQ==',
        'Sec-WebSocket-Version' => '13',
        'Origin'                => origin
      }
      headers.merge!(auth_cookie) if cookie
      headers
    end

    def start_upgrade(headers)
      socket = open_socket
      request = "GET /ws HTTP/1.1\r\nHost: 127.0.0.1:#{server.port}\r\n"
      headers.each { |name, value| request << "#{name}: #{value}\r\n" }
      request << "\r\n"
      socket.write(request)
      head = +''
      head << socket.read(1) until head.end_with?("\r\n\r\n")
      [socket, *parse_response(head)]
    end

    it 'completes the handshake with the RFC accept key and sends hello' do
      socket, status, headers, = start_upgrade(upgrade_headers)
      expect(status).to eq(101)
      expect(headers['sec-websocket-accept']).to eq('s3pPLMBiTxaQ9kYGzzhZRbK+xOo=')

      frame = Lich::WebUI::WebSocket.read_frame(socket, require_mask: false)
      hello = JSON.parse(frame.payload, symbolize_names: true)
      expect(hello[:type]).to eq('hello')
      expect(hello[:schema_version]).to eq(Lich::WebUI::Protocol::SCHEMA_VERSION)
      expect(hello[:session]).to eq(name: 'Testchar', game: 'GSIV')
      socket.close
    end

    it 'routes parsed client messages to the message handler' do
      socket, status, = start_upgrade(upgrade_headers)
      expect(status).to eq(101)
      Lich::WebUI::WebSocket.read_frame(socket, require_mask: false) # hello

      socket.write(Lich::WebUI::WebSocket.encode_client_frame('{"type":"subscribe","page":"demo/hunt"}'))
      message = Timeout.timeout(2) { received_messages.pop }
      expect(message).to eq(type: 'subscribe', page: 'demo/hunt')

      # unknown types are dropped, not delivered
      socket.write(Lich::WebUI::WebSocket.encode_client_frame('{"type":"evil"}'))
      socket.write(Lich::WebUI::WebSocket.encode_client_frame('{"type":"unsubscribe","page":"demo/hunt"}'))
      message = Timeout.timeout(2) { received_messages.pop }
      expect(message[:type]).to eq('unsubscribe')
      socket.close
    end

    it 'answers ping frames with pongs' do
      socket, status, = start_upgrade(upgrade_headers)
      expect(status).to eq(101)
      Lich::WebUI::WebSocket.read_frame(socket, require_mask: false) # hello

      socket.write(Lich::WebUI::WebSocket.encode_client_frame('hb', opcode: Lich::WebUI::WebSocket::OPCODE_PING))
      frame = Lich::WebUI::WebSocket.read_frame(socket, require_mask: false)
      expect(frame).to be_pong
      expect(frame.payload).to eq('hb')
      socket.close
    end

    it 'rejects upgrades without the auth cookie' do
      _, status, = start_upgrade(upgrade_headers(cookie: false))
      expect(status).to eq(403)
    end

    it 'rejects upgrades with a foreign Origin' do
      _, status, = start_upgrade(upgrade_headers(origin: 'http://evil.example.com'))
      expect(status).to eq(403)
    end

    it 'broadcasts to connected clients' do
      socket, status, = start_upgrade(upgrade_headers)
      expect(status).to eq(101)
      Lich::WebUI::WebSocket.read_frame(socket, require_mask: false) # hello

      server.broadcast(Lich::WebUI::Protocol.notice('hello everyone'))
      frame = Lich::WebUI::WebSocket.read_frame(socket, require_mask: false)
      notice = JSON.parse(frame.payload, symbolize_names: true)
      expect(notice).to eq(type: 'notice', level: 'info', text: 'hello everyone')
      socket.close
    end
  end

  describe 'lifecycle' do
    it 'binds an ephemeral port and reports running' do
      expect(server.port).to be > 0
      expect(server).to be_running
    end

    it 'stops cleanly and closes live websocket connections' do
      socket, status, = start_upgrade_for_lifecycle
      expect(status).to eq(101)
      server.stop
      expect(server).not_to be_running
      # the connection is closed server-side; reads reach EOF quickly
      Timeout.timeout(2) do
        loop do
          frame = Lich::WebUI::WebSocket.read_frame(socket, require_mask: false)
          break if frame.nil? || frame.close?
        end
      end
      socket.close rescue nil
    end

    def start_upgrade_for_lifecycle
      socket = open_socket
      socket.write(
        "GET /ws HTTP/1.1\r\nHost: 127.0.0.1:#{server.port}\r\n" \
        "Upgrade: websocket\r\nConnection: Upgrade\r\n" \
        "Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==\r\n" \
        "Origin: http://127.0.0.1:#{server.port}\r\n" \
        "Cookie: lich_webui=#{token}\r\n\r\n"
      )
      head = +''
      head << socket.read(1) until head.end_with?("\r\n\r\n")
      [socket, *parse_response(head)]
    end
  end
end
