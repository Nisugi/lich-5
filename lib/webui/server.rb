# frozen_string_literal: true

require 'json'
require 'socket'
require 'digest/sha1'

require_relative 'websocket'
require_relative 'protocol'
require_relative File.join('..', 'common', 'reusable_tcp_server')

module Lich
  module WebUI
    # Local-only HTTP + WebSocket server for browser-based script UIs.
    #
    # The HTTP surface is deliberately tiny and GET-only: an /auth endpoint
    # that exchanges the one-time URL token for a cookie, a whitelist of
    # static assets, and the /ws WebSocket upgrade. Everything dynamic flows
    # over the WebSocket as JSON (see {Protocol}).
    #
    # Security posture (see docs/webui.md): loopback bind only, per-process
    # token, constant-time comparison, Host allowlist on every request and
    # Origin allowlist on the upgrade. A valid token grants script-level
    # power by design - the browser tab is the player.
    #
    # Threading mirrors Lich::InternalAPI::ActiveSessions::Server: one accept
    # thread, one thread per connection (WebSocket connections keep theirs for
    # their lifetime), all tracked for clean shutdown, with injectable
    # factories so specs can intercept every thread and socket.
    class Server
      # Abandon an HTTP client that has not completed its request headers.
      READ_TIMEOUT = 5
      # Refuse request heads larger than this (headers + request line).
      MAX_HEADER_BYTES = 8_192
      # Interval between WebSocket keepalive pings.
      PING_INTERVAL = 30

      COOKIE_NAME = 'lich_webui'

      attr_reader :host, :port

      # @param auth_token [String] per-process secret; see WebUI.auth_token
      # @param assets_dir [String] directory containing index.html/app.js/app.css
      # @param session_info [#call] -> Hash for the hello envelope
      # @param pages_provider [#call] -> Array<Hash> of registered pages
      # @param siblings_provider [#call] -> Array<Hash> of other sessions
      # @param message_handler [#call, nil] (connection, message_hash) called
      #   for each parsed browser message; nil drops them (M1 default)
      # @param file_resolver [#call, nil] (alias, relpath) -> [path, type]
      #   for /files/<alias>/<relpath>; nil disables the route
      def initialize(auth_token:, assets_dir:, host: '127.0.0.1', port: 0,
                     session_info: -> { {} }, pages_provider: -> { [] },
                     siblings_provider: -> { [] }, message_handler: nil,
                     file_resolver: nil,
                     server_factory: nil, accept_thread_factory: nil,
                     client_thread_factory: nil)
        @host = host
        @port = port
        @auth_token = auth_token
        @assets_dir = assets_dir
        @session_info = session_info
        @pages_provider = pages_provider
        @siblings_provider = siblings_provider
        @message_handler = message_handler
        @file_resolver = file_resolver
        # SO_REUSEADDR must be set BEFORE bind (a plain TCPServer.new binds
        # during construction, so a later setsockopt is too late). Without it,
        # a fixed port (LICH_WEBUI_PORT) left in TIME_WAIT by a just-stopped
        # process fails to rebind and the service silently falls back to an
        # unreachable ephemeral port. ReusableTCPServer returns a bound,
        # listening Socket (NOT a TCPServer) - the port and accept helpers
        # below handle either object shape.
        @server_factory = server_factory || lambda do |bind_host, bind_port|
          Lich::Common::ReusableTCPServer.create(bind_host, bind_port, backlog: 16)
        end
        @accept_thread_factory = accept_thread_factory || ->(&block) { Thread.new(&block) }
        @client_thread_factory = client_thread_factory || ->(socket, &block) { Thread.new(socket, &block) }
        @server = nil
        @thread = nil
        @ping_thread = nil
        @mutex = Mutex.new
        @client_threads = []
        @connections = []
        @stopping = false
      end

      # Starts the listener, accept loop, and keepalive pinger.
      #
      # @return [Boolean] true when the server is accepting connections
      def start
        @mutex.synchronize do
          return true if running?

          @stopping = false
          @server = @server_factory.call(@host, @port)
          # ReusableTCPServer already set SO_REUSEADDR before bind; the spec
          # factory injects a plain TCPServer, so this is harmless there.
          @server.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1) rescue nil
          # Resolve the bound port from either a Socket (#local_address) or a
          # TCPServer (#addr) - the injected spec factory uses the latter.
          @port = @server.respond_to?(:local_address) ? @server.local_address.ip_port : @server.addr[1]
          @thread = @accept_thread_factory.call do
            log("info: WebUI accept thread started pid=#{Process.pid} port=#{@port}")
            accept_loop
          end
          @ping_thread = Thread.new { ping_loop }
        end
        true
      rescue StandardError => e
        log("error: WebUI server failed to start: #{e.class}: #{e.message}")
        stop
        false
      end

      # Stops the server, closes every connection, and joins worker threads.
      #
      # @return [void]
      def stop
        thread = nil
        ping_thread = nil
        server = nil
        client_threads = []
        connections = []
        @mutex.synchronize do
          thread = @thread
          ping_thread = @ping_thread
          server = @server
          client_threads = @client_threads.dup
          connections = @connections.dup
          @client_threads.clear
          @connections.clear
          @stopping = true
          @thread = nil
          @ping_thread = nil
          @server = nil
        end

        connections.each(&:close)
        server&.close rescue nil
        ping_thread&.kill
        if thread&.alive?
          thread.join(0.1)
          thread.kill if thread.alive?
        end
        client_threads.each do |client_thread|
          next unless client_thread.respond_to?(:join)

          client_thread.join(0.25)
          client_thread.kill if client_thread.respond_to?(:alive?) && client_thread.alive?
        end
      end

      # @return [Boolean]
      def running?
        @thread&.alive? || false
      end

      # Sends a JSON payload to every live WebSocket connection.
      #
      # @param json [String]
      # @return [void]
      def broadcast(json)
        each_connection { |conn| conn.send_text(json) }
      end

      # One live, upgraded WebSocket connection. Writes are mutex-serialized
      # because the pinger, broadcasts, and the reader thread's replies can
      # interleave; a failed write marks the connection dead for pruning.
      class Connection
        attr_reader :socket

        def initialize(socket)
          @socket = socket
          @write_mutex = Mutex.new
          @alive = true
        end

        def alive?
          @alive
        end

        def send_text(payload)
          write_frame(WebSocket.encode_frame(payload, opcode: WebSocket::OPCODE_TEXT))
        end

        def send_ping
          write_frame(WebSocket.encode_frame('', opcode: WebSocket::OPCODE_PING))
        end

        def send_pong(payload)
          write_frame(WebSocket.encode_frame(payload, opcode: WebSocket::OPCODE_PONG))
        end

        def send_close
          write_frame(WebSocket.encode_frame('', opcode: WebSocket::OPCODE_CLOSE))
        end

        # Marks the connection dead and shuts the socket down, but leaves the
        # actual IO#close to the reader thread that owns the socket. Closing
        # from another thread deadlocks on Windows: IO#close waits for the
        # reader to release the descriptor, and neither close nor shutdown
        # reliably interrupts a thread blocked in a raw read there. The
        # reader polls with IO.select (see #websocket_read_loop), notices
        # dead? within one poll interval, and closes the socket itself.
        def close
          send_close if alive?
          @alive = false
          @socket.shutdown rescue nil
        end

        private

        def write_frame(bytes)
          return false unless @alive

          @write_mutex.synchronize { @socket.write(bytes) }
          true
        rescue StandardError
          @alive = false
          false
        end
      end

      private

      def accept_loop
        loop do
          server = @server
          break unless server

          socket = nil
          begin
            accepted = server.accept
            socket = accepted.is_a?(Array) ? accepted.first : accepted
            client_thread = @client_thread_factory.call(socket) { |client| handle_tracked_client(client) }
            track_client_thread(client_thread)
          rescue IOError, Errno::EBADF => e
            log("warning: WebUI accept_loop closed: #{e.class}") unless stopping?
            break
          rescue StandardError => e
            socket&.close rescue nil
            log("warning: WebUI accept_loop error (continuing): #{e.class}: #{e.message}")
          end
        end
      rescue StandardError => e
        log("error: WebUI accept_loop fatal: #{e.class}: #{e.message}\n\t#{e.backtrace&.first(5)&.join("\n\t")}")
      end

      def handle_tracked_client(socket)
        handle_client(socket)
      ensure
        untrack_current_thread
      end

      # Serves exactly one HTTP exchange per connection (Connection: close),
      # except /ws which upgrades and keeps the socket for its lifetime.
      def handle_client(socket)
        request = read_request(socket)
        return unless request

        unless host_allowed?(request)
          log('warning: WebUI request rejected: bad Host header')
          return respond_error(socket, 403, 'Forbidden')
        end

        case request[:path]
        when '/auth'         then handle_auth(socket, request)
        when '/ws'           then return handle_websocket(socket, request)
        when '/', '/assets/app.js', '/assets/app.css' then handle_asset(socket, request)
        when %r{\A/files/([A-Za-z0-9_\-]+)/(.+)\z}
          handle_file(socket, request, Regexp.last_match(1), Regexp.last_match(2))
        else
          respond_error(socket, 404, 'Not Found')
        end
      rescue StandardError => e
        log("warning: WebUI client error: #{e.class}: #{e.message}")
        respond_error(socket, 500, 'Internal Server Error') rescue nil
      ensure
        socket.close rescue nil
      end

      # Reads the request head (request line + headers) with a deadline so a
      # stalled peer cannot pin the handler thread.
      #
      # @return [Hash, nil] {method:, path:, query:, headers: {downcased => value}}
      def read_request(socket)
        deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + READ_TIMEOUT
        buffer = +''

        until buffer.include?("\r\n\r\n")
          remaining = deadline - Process.clock_gettime(Process::CLOCK_MONOTONIC)
          return nil if remaining <= 0 || buffer.bytesize > MAX_HEADER_BYTES
          return nil unless IO.select([socket], nil, nil, remaining)

          chunk = socket.read_nonblock(4096, exception: false)
          case chunk
          when :wait_readable then next
          when nil then return nil
          else buffer << chunk
          end
        end

        parse_request_head(buffer)
      rescue IO::WaitReadable
        nil
      end

      def parse_request_head(raw)
        head, = raw.split("\r\n\r\n", 2)
        lines = head.split("\r\n")
        request_line = lines.shift.to_s
        method, target, = request_line.split(' ', 3)
        return nil unless method && target

        path, query = target.split('?', 2)
        headers = {}
        lines.each do |line|
          name, value = line.split(':', 2)
          next unless name && value

          headers[name.strip.downcase] = value.strip
        end
        { method: method.upcase, path: path, query: query, headers: headers }
      end

      def host_allowed?(request)
        host = request[:headers]['host'].to_s
        allowed_hosts.include?(host)
      end

      def allowed_hosts
        hosts = ["127.0.0.1:#{@port}", "localhost:#{@port}"]
        # Container access comes in under the published host/IP; accept the
        # operator-declared names too (comma-separated, no port).
        ENV['LICH_WEBUI_ALLOWED_HOSTS'].to_s.split(',').map(&:strip).reject(&:empty?).each do |name|
          hosts << "#{name}:#{@port}"
        end
        hosts
      end

      def origin_allowed?(request)
        origin = request[:headers]['origin'].to_s
        allowed_hosts.any? { |h| origin == "http://#{h}" }
      end

      def authorized?(request)
        Protocol.secure_compare(@auth_token, cookie_token(request))
      end

      def cookie_token(request)
        cookies = request[:headers]['cookie'].to_s
        cookies.split(';').each do |pair|
          name, value = pair.split('=', 2)
          return value.to_s.strip if name.to_s.strip == COOKIE_NAME
        end
        nil
      end

      def query_params(request)
        params = {}
        request[:query].to_s.split('&').each do |pair|
          name, value = pair.split('=', 2)
          params[name] = value if name
        end
        params
      end

      # GET /auth?token=... - the only unauthenticated route. Exchanges the
      # URL token for an HttpOnly cookie and redirects so the token leaves
      # the address bar and browser history.
      def handle_auth(socket, request)
        return respond_error(socket, 405, 'Method Not Allowed') unless request[:method] == 'GET'

        token = query_params(request)['token']
        unless Protocol.secure_compare(@auth_token, token)
          log('warning: WebUI /auth rejected: bad token')
          return respond_error(socket, 403, 'Forbidden')
        end

        # `to` allows deep-linking straight to a page after the cookie is
        # set; only local absolute paths are honored (no scheme-relative
        # //host, no full URLs, no header injection - no open redirect).
        target = percent_decode(query_params(request)['to'].to_s)
        target = '/' unless target.start_with?('/') && !target.start_with?('//') && !target.match?(/[\r\n]/)

        headers = [
          "Location: #{target}",
          "Set-Cookie: #{COOKIE_NAME}=#{@auth_token}; HttpOnly; SameSite=Strict; Path=/"
        ]
        respond(socket, 302, 'Found', '', extra_headers: headers)
      end

      def percent_decode(raw)
        raw.gsub(/%([0-9A-Fa-f]{2})/) { [Regexp.last_match(1)].pack('H2') }
      end

      # Serves the static bundle from a fixed whitelist - no path is ever
      # derived from the URL, so traversal is structurally impossible.
      ASSET_ROUTES = {
        '/'               => ['index.html', 'text/html; charset=utf-8'],
        '/assets/app.js'  => ['app.js', 'text/javascript; charset=utf-8'],
        '/assets/app.css' => ['app.css', 'text/css; charset=utf-8']
      }.freeze

      def handle_asset(socket, request)
        return respond_error(socket, 405, 'Method Not Allowed') unless request[:method] == 'GET'
        return respond_unauthorized_page(socket) unless authorized?(request)

        filename, content_type = ASSET_ROUTES.fetch(request[:path])
        path = File.join(@assets_dir, filename)
        return respond_error(socket, 404, 'Not Found') unless File.file?(path)

        body = File.binread(path)
        etag = %("#{Digest::SHA1.hexdigest(body)}")
        if request[:headers]['if-none-match'] == etag
          respond(socket, 304, 'Not Modified', '', extra_headers: ["ETag: #{etag}"])
        else
          respond(socket, 200, 'OK', body, content_type: content_type, extra_headers: ["ETag: #{etag}"])
        end
      end

      # GET /files/<alias>/<relpath> - script-registered image directories.
      # All path validation (containment, extension whitelist) lives in the
      # injected resolver (FileRoutes); this route only handles HTTP.
      def handle_file(socket, request, alias_name, relpath)
        return respond_error(socket, 405, 'Method Not Allowed') unless request[:method] == 'GET'
        return respond_unauthorized_page(socket) unless authorized?(request)
        return respond_error(socket, 404, 'Not Found') unless @file_resolver

        resolved = @file_resolver.call(alias_name, relpath)
        return respond_error(socket, 404, 'Not Found') unless resolved

        path, content_type = resolved
        body = File.binread(path)
        etag = %("#{Digest::SHA1.hexdigest(body)}")
        if request[:headers]['if-none-match'] == etag
          respond(socket, 304, 'Not Modified', '', extra_headers: ["ETag: #{etag}"])
        else
          respond(socket, 200, 'OK', body, content_type: content_type,
                                           cache_control: 'private, max-age=60',
                                           extra_headers: ["ETag: #{etag}"])
        end
      rescue StandardError => e
        log("warning: WebUI /files error: #{e.class}: #{e.message}")
        respond_error(socket, 404, 'Not Found')
      end

      # GET /ws - validates cookie + Origin, completes the RFC 6455 upgrade,
      # sends the hello envelope, then reads frames for the connection's
      # lifetime on this thread.
      def handle_websocket(socket, request)
        unless authorized?(request) && origin_allowed?(request)
          log('warning: WebUI /ws upgrade rejected (auth or origin)')
          respond_error(socket, 403, 'Forbidden')
          socket.close rescue nil
          return
        end

        key = request[:headers]['sec-websocket-key']
        unless request[:headers]['upgrade'].to_s.casecmp('websocket').zero? && key && !key.empty?
          respond_error(socket, 400, 'Bad Request')
          socket.close rescue nil
          return
        end

        socket.write(
          "HTTP/1.1 101 Switching Protocols\r\n" \
          "Upgrade: websocket\r\n" \
          "Connection: Upgrade\r\n" \
          "Sec-WebSocket-Accept: #{WebSocket.accept_key(key)}\r\n\r\n"
        )

        connection = Connection.new(socket)
        track_connection(connection)
        connection.send_text(Protocol.hello(session: @session_info.call,
                                            pages: @pages_provider.call,
                                            siblings: @siblings_provider.call))
        websocket_read_loop(connection)
      ensure
        untrack_connection(connection) if connection
        # mark the connection dead, not just untracked: pages hold it in
        # their subscriber lists and only prune lazily on a failed send -
        # live_subscribers? (window watchdogs: login quit, ;map exit) must
        # see the browser's departure immediately, not on the next render
        begin
          connection&.close
        rescue StandardError
          nil
        end
        socket.close rescue nil
      end

      # Poll interval for the WebSocket reader. The reader must never sit in
      # a raw blocking read: on Windows a blocked read cannot be interrupted
      # by another thread's close/shutdown, which would wedge Server#stop.
      # Instead it selects with this timeout and rechecks connection health.
      WS_POLL_INTERVAL = 0.25

      def websocket_read_loop(connection)
        socket = connection.socket
        while connection.alive?
          next unless IO.select([socket], nil, nil, WS_POLL_INTERVAL)

          frame = WebSocket.read_frame(socket)
          break if frame.nil? || frame.close?

          if frame.ping?
            connection.send_pong(frame.payload)
          elsif frame.text?
            message = Protocol.parse_client_message(frame.payload)
            @message_handler&.call(connection, message) if message
          end
        end
      rescue WebSocket::ProtocolError => e
        log("warning: WebUI websocket protocol error: #{e.message}")
      rescue IOError, SystemCallError
        # peer went away; nothing to do
      end

      def ping_loop
        loop do
          sleep PING_INTERVAL
          each_connection do |conn|
            untrack_connection(conn) unless conn.send_ping
          end
        end
      rescue StandardError
        nil
      end

      def each_connection(&block)
        connections = @mutex.synchronize { @connections.dup }
        connections.each do |conn|
          block.call(conn)
        rescue StandardError
          nil
        end
      end

      def respond(socket, status, reason, body, content_type: 'text/plain; charset=utf-8', cache_control: 'no-store', extra_headers: [])
        head = ["HTTP/1.1 #{status} #{reason}"]
        head << "Content-Type: #{content_type}" unless body.empty?
        head << "Content-Length: #{body.bytesize}"
        head << 'Connection: close'
        head << "Cache-Control: #{cache_control}" unless status == 304
        head.concat(extra_headers)
        socket.write(head.join("\r\n") + "\r\n\r\n" + body)
      end

      def respond_error(socket, status, reason)
        respond(socket, status, reason, reason)
      end

      UNAUTHORIZED_PAGE = <<~HTML
        <!doctype html>
        <html><head><meta charset="utf-8"><title>Lich WebUI</title></head>
        <body style="font-family: sans-serif; margin: 4em auto; max-width: 30em; text-align: center;">
        <h2>Not authorized</h2>
        <p>This page requires a session link. In the game, type:</p>
        <p><code style="font-size: 1.3em;">;ui</code></p>
        </body></html>
      HTML

      def respond_unauthorized_page(socket)
        respond(socket, 403, 'Forbidden', UNAUTHORIZED_PAGE, content_type: 'text/html; charset=utf-8')
      end

      def track_connection(connection)
        @mutex.synchronize { @connections << connection }
      end

      def untrack_connection(connection)
        @mutex.synchronize { @connections.delete(connection) }
      end

      def track_client_thread(thread)
        return unless thread

        @mutex.synchronize { @client_threads << thread }
      end

      def untrack_current_thread
        @mutex.synchronize { @client_threads.delete(Thread.current) }
      end

      def stopping?
        return @stopping if @mutex.owned?

        @mutex.synchronize { @stopping }
      end

      def log(message)
        Lich.log(message) if defined?(Lich) && Lich.respond_to?(:log)
      end
    end
  end
end
