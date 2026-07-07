# frozen_string_literal: true

require 'json'
require 'securerandom'
require 'tmpdir'
require 'fileutils'

require_relative 'server'
require_relative 'registry'
require_relative 'file_routes'

module Lich
  # Browser-based script UI service ("WebUI").
  #
  # Lich hosts a loopback-only HTTP/WebSocket server; scripts register
  # declarative pages (M2) that render in the player's browser. This module
  # owns service lifecycle: the per-process auth token, lazy server startup,
  # the discovery file that lets sibling sessions link to each other, and the
  # cross-platform browser opener.
  #
  # The whole feature is dormant unless the :webui feature flag is enabled
  # (`;ui on`). Mirrors the ownership shape of
  # Lich::InternalAPI::ActiveSessions.
  module WebUI
    FEATURE_FLAG = :webui

    HOST = '127.0.0.1'

    # Sibling-session discovery files live here; they contain no secrets
    # (name, game, port, pid only) - each browser tab must still be blessed
    # by its own session's `;ui`.
    DISCOVERY_DIR = File.join(Dir.tmpdir, 'simutronics', 'webui')

    @server = nil
    @auth_token = nil
    @mutex = Mutex.new

    # @return [Boolean] whether the :webui feature flag is on
    def self.enabled?
      return false unless defined?(Lich::Common::FeatureFlags)

      Lich::Common::FeatureFlags.enabled?(FEATURE_FLAG)
    end

    # @return [Boolean] whether the server is currently accepting connections
    def self.running?
      @server&.running? || false
    end

    # @return [Integer, nil] the bound port when running
    def self.port
      @server&.port if running?
    end

    # Starts the server if the feature is enabled and it is not already
    # running. Safe to call repeatedly; used by `;ui` and (in M2) by the
    # first UI.page registration.
    #
    # force: true starts the server even when the :webui flag is off - used
    # by the pre-login launcher, whose own :webui_login flag is the opt-in.
    #
    # @return [Boolean] true when the service is available
    def self.ensure_service!(force: false)
      return false unless force || enabled?

      @mutex.synchronize do
        return true if @server&.running?

        @auth_token ||= SecureRandom.hex(32)
        @server = Server.new(
          auth_token: @auth_token,
          assets_dir: File.join(__dir__, 'assets'),
          host: HOST,
          session_info: -> { session_info },
          pages_provider: -> { pages_snapshot },
          siblings_provider: -> { sibling_sessions },
          message_handler: method(:handle_client_message),
          file_resolver: FileRoutes.method(:resolve)
        )
        unless @server.start
          @server = nil
          return false
        end

        write_discovery_file
        true
      end
    end

    # Stops the server and removes this session's discovery file. Called from
    # the main.rb shutdown sequence; safe when never started.
    #
    # @return [void]
    def self.stop_service!
      server = nil
      @mutex.synchronize do
        server = @server
        @server = nil
      end
      server&.stop
      Registry.clear!
      FileRoutes.clear!
      delete_discovery_file
    end

    # The tokenized bootstrap URL. Opening it once sets the auth cookie and
    # redirects to the landing page.
    #
    # @return [String, nil] nil when the server is not running
    def self.auth_url
      return nil unless running?

      "http://#{HOST}:#{port}/auth?token=#{@auth_token}"
    end

    # The plain (already-authorized) landing URL, for display.
    #
    # @return [String, nil]
    def self.url
      return nil unless running?

      "http://#{HOST}:#{port}/"
    end

    # Opens a URL in the player's browser, falling back silently - callers
    # should always print the URL too.
    #
    # app: true asks for a chromeless "app mode" window (no tabs/URL bar -
    # a floating, draggable, resizable window) via Edge or Chrome; when
    # neither launches, falls back to the default browser.
    #
    # @param target [String]
    # @param app [Boolean]
    # @return [Boolean] true when a launcher was invoked
    def self.open_browser(target, app: false, size: nil, position: nil)
      return false if target.nil? || target.empty?
      return true if app && open_app_window(target, size: size, position: position)

      if defined?(Win32) && Win32.respond_to?(:ShellExecute)
        Win32.ShellExecute(:lpOperation => 'open', :lpFile => target)
        true
      elsif RUBY_PLATFORM =~ /darwin/i
        system('open', target)
      elsif RUBY_PLATFORM =~ /mingw|win32/i
        system('start', '', target)
      else
        system('xdg-open', target)
      end
    rescue StandardError => e
      Lich.log("warning: WebUI open_browser failed: #{e.class}: #{e.message}") if defined?(Lich) && Lich.respond_to?(:log)
      false
    end

    # Attempts a chromeless app-mode window. Returns false when no known
    # chromium-family browser could be started.
    #
    # @param target [String]
    # @return [Boolean]
    def self.open_app_window(target, size: nil, position: nil)
      flags = "--app=#{target}"
      flags += " --window-size=#{size[0].to_i},#{size[1].to_i}" if size.is_a?(Array) && size.length == 2
      flags += " --window-position=#{position[0].to_i},#{position[1].to_i}" if position.is_a?(Array) && position.length == 2

      if defined?(Win32) && Win32.respond_to?(:ShellExecute)
        # ShellExecute resolves msedge/chrome via the App Paths registry.
        %w[msedge.exe chrome.exe].each do |exe|
          result = Win32.ShellExecute(:lpOperation => 'open', :lpFile => exe, :lpParameters => flags)
          return true if result.to_i > 32 # per ShellExecute docs, >32 = success
        end
        false
      elsif RUBY_PLATFORM =~ /darwin/i
        system('open', '-na', 'Google Chrome', '--args', *flags.split(' ')) ||
          system('open', '-na', 'Microsoft Edge', '--args', *flags.split(' '))
      else
        args = flags.split(' ').map { |arg| shell_quote(arg) }.join(' ')
        %w[google-chrome chromium chromium-browser microsoft-edge].any? do |exe|
          system("#{exe} #{args} >/dev/null 2>&1 &")
        end
      end
    rescue StandardError
      false
    end

    # @param value [String]
    # @return [String]
    def self.shell_quote(value)
      "'#{value.gsub("'", "'\\\\''")}'"
    end
    private_class_method :shell_quote

    # Opens the browser straight to a page (or the landing page), riding the
    # /auth redirect so the tab is authorized on arrival. app: true requests
    # a chromeless floating window - right for bare pages like the map.
    #
    # @param page_id [String, nil] full "script/page" id
    # @param app [Boolean]
    # @return [Boolean]
    def self.open_page(page_id = nil, app: false, size: nil, position: nil)
      return false unless ensure_service!

      # Launch with the caller's default flags only. Stored geometry is NOT
      # forced onto the browser command line: passing --window-position (or
      # an oversized --window-size) to an already-running Edge/Chrome makes
      # it drop the --app window request, so nothing opens. The remembered
      # geometry is applied client-side instead (resizeTo/moveTo), driven by
      # the page's size/position in its render tree.
      target = auth_url
      target += "&to=#{encode_component("/#/#{page_id}")}" if page_id
      open_browser(target, app: app, size: size, position: position)
    end

    # Minimal percent-encoder for the auth redirect target.
    #
    # @param value [String]
    # @return [String]
    def self.encode_component(value)
      value.gsub(%r{[^A-Za-z0-9\-_.~/]}) { |char| format('%%%02X', char.ord) }
    end
    private_class_method :encode_component

    # @return [Array<Hash>] registered page descriptors for the hello/pages
    #   envelopes
    def self.pages_snapshot
      Registry.pages_snapshot
    end

    # Registers a page for the calling script, starting the service on
    # first use. Called via the public UI facade (lib/api/webui.rb).
    #
    # @param name [String] page name, unique within the calling script
    # @param title [String, nil]
    # @param every [Numeric, nil] optional re-render polling interval
    # @param bare [Boolean] chromeless page (no topbar/nav/padding) - for
    #   floating displays like the map
    # @yieldparam ui [Builder]
    # @return [Page, nil] nil when disabled or called outside a script
    def self.register_page(name, title: nil, every: nil, bare: false, size: nil, &block)
      return nil unless ensure_service!

      script = Script.current if defined?(Script) && Script.respond_to?(:current)
      unless script
        Lich.log("warning: WebUI page #{name.inspect} registered outside a script; ignored") if defined?(Lich) && Lich.respond_to?(:log)
        return nil
      end

      page_id = "#{script.name}/#{name}"
      size, position = geometry_defaults(page_id, size)
      page = Page.new(
        id: page_id,
        title: title ? title.to_s : name.to_s,
        script: script,
        block: block,
        every: every,
        bare: bare,
        size: size,
        position: position
      )
      Registry.register(page)
    end

    # Remembered geometry (engine store) beats the author's default size.
    # A size-only stored hash (off-screen position dropped) contributes its
    # size but no position.
    #
    # @return [Array(Array|nil, Array|nil)] [size, position]
    def self.geometry_defaults(page_id, size)
      stored = window_geometry(page_id)
      return [size, nil] unless stored

      resolved_size = stored['w'] && stored['h'] ? [stored['w'], stored['h']] : size
      resolved_position = stored['x'] && stored['y'] ? [stored['x'], stored['y']] : nil
      [resolved_size, resolved_position]
    end
    private_class_method :geometry_defaults

    # Registers a page owned by core Lich rather than a script (login,
    # launcher). Core pages dispatch inline, survive ScriptDeath cleanup,
    # and are removed explicitly. Not exposed on the UI facade - scripts
    # must not create immortal pages.
    #
    # @param name [String]
    # @return [Page, nil]
    def self.register_core_page(name, title: nil, bare: false, size: nil, every: nil, &block)
      return nil unless ensure_service!(force: true)

      page_id = "lich/#{name}"
      size, position = geometry_defaults(page_id, size)
      page = Page.new(
        id: page_id,
        title: title ? title.to_s : name.to_s,
        script: nil,
        block: block,
        every: every,
        bare: bare,
        size: size,
        position: position
      )
      Registry.register(page)
    end

    # Broadcasts the current page list to every connected browser. Called
    # by the Registry whenever pages register/unregister.
    #
    # @return [void]
    def self.notify_pages_changed
      @server&.broadcast(Protocol.pages(pages_snapshot))
    end

    # Tells browsers showing +page_id+ that the page is done; a bare app
    # window closes itself, a regular tab returns to the landing page. Used
    # by one-shot pages like the login launcher after Play.
    #
    # @param page_id [String]
    # @return [void]
    def self.notify_page_close(page_id)
      @server&.broadcast(Protocol.close(page_id))
    end

    # Re-broadcasts the hello envelope (session identity + pages) to every
    # connected browser - call after login completes so a pre-login tab
    # picks up the character name without a reload. Also rewrites the
    # discovery file: it was first written pre-login with an empty name,
    # and sibling session lists read the name from there.
    #
    # @return [void]
    def self.refresh_hello
      return unless running?

      write_discovery_file
      @server&.broadcast(Protocol.hello(session: session_info, pages: pages_snapshot, siblings: sibling_sessions))
    end

    # Routes one parsed browser message (see Protocol::CLIENT_MESSAGE_TYPES)
    # to its page. Unknown pages are ignored - the browser may race a page
    # removal.
    #
    # @param connection [Server::Connection]
    # @param message [Hash]
    # @return [void]
    def self.handle_client_message(connection, message)
      page = Registry.find(message[:page].to_s)
      return unless page

      case message[:type]
      when 'subscribe'   then page.subscribe(connection)
      when 'unsubscribe' then page.unsubscribe(connection)
      when 'event'       then page.handle_event(message[:cid].to_s, message[:value])
      when 'geometry'
        page.record_geometry(message[:value])
        remember_window_geometry(message[:page].to_s, message[:value])
      end
    end

    # ---- floating-window geometry memory -----------------------------
    # Every bare/app window reports its outer geometry; the engine keeps
    # the last known geometry per page id in lich_settings so windows
    # reopen exactly where they were closed - no per-script code needed.

    GEOMETRY_SETTING = 'webui_window_geometry'

    # Coordinates at or beyond this magnitude are never a real window
    # placement: Windows reports a minimized window's position as
    # -32000,-32000, and no monitor arrangement legitimately puts a window
    # this far out. Restoring such a position opens the window off-screen
    # ("nothing happened" on double-click), so we reject it on both write
    # and read - while still allowing ordinary negative coords for monitors
    # arranged left of / above the primary.
    OFFSCREEN_LIMIT = 30_000

    # @param page_id [String]
    # @return [Hash{String=>Integer}, nil] {'w','h','x','y'} or nil.
    #   Drops a stored off-screen position defensively (old poisoned data),
    #   keeping the size so the window still opens at a sane size.
    def self.window_geometry(page_id)
      geometry = geometry_store[page_id.to_s]
      return nil unless geometry.is_a?(Hash)
      return geometry if onscreen?(geometry['x'], geometry['y'])

      { 'w' => geometry['w'], 'h' => geometry['h'] }
    end

    # @param page_id [String]
    # @param geo [Hash] {w:, h:, x:, y:} from the browser
    # @return [void]
    def self.remember_window_geometry(page_id, geo)
      return unless geo.is_a?(Hash)

      width = (geo[:w] || geo['w']).to_i
      height = (geo[:h] || geo['h']).to_i
      x = (geo[:x] || geo['x']).to_i
      y = (geo[:y] || geo['y']).to_i
      return unless width.positive? && height.positive?
      # A minimized window reports -32000,-32000; don't overwrite the last
      # good geometry with it - keep where the window really was.
      return unless onscreen?(x, y)

      geometry_store[page_id.to_s] = { 'w' => width, 'h' => height, 'x' => x, 'y' => y }
      persist_geometry_store
    end

    # @return [Boolean] whether (x, y) is a plausible on-screen placement
    def self.onscreen?(x, y)
      x.to_i.abs < OFFSCREEN_LIMIT && y.to_i.abs < OFFSCREEN_LIMIT
    end
    private_class_method :onscreen?

    # @return [Hash] in-memory store, loaded from lich_settings once
    def self.geometry_store
      @geometry_store ||= begin
        raw = Lich.db.get_first_value('SELECT value FROM lich_settings WHERE name=?;', [GEOMETRY_SETTING]) if defined?(Lich) && Lich.respond_to?(:db) && Lich.db
        parsed = raw ? JSON.parse(raw) : {}
        parsed.is_a?(Hash) ? parsed : {}
      rescue StandardError
        {}
      end
    end
    private_class_method :geometry_store

    # @return [void]
    def self.persist_geometry_store
      return unless defined?(Lich) && Lich.respond_to?(:db) && Lich.db

      Lich.db.execute('INSERT OR REPLACE INTO lich_settings(name,value) values(?,?);',
                      [GEOMETRY_SETTING, JSON.generate(@geometry_store)])
    rescue StandardError => e
      Lich.log("warning: WebUI geometry persist failed: #{e.class}: #{e.message}") if defined?(Lich) && Lich.respond_to?(:log)
    end
    private_class_method :persist_geometry_store

    # @return [Hash] session identity for the hello envelope
    def self.session_info
      name = (defined?(XMLData) && XMLData.respond_to?(:name) ? XMLData.name.to_s : '')
      game = (defined?(XMLData) && XMLData.respond_to?(:game) ? XMLData.game.to_s : '')
      { name: name, game: game }
    end

    # Other live Lich sessions' WebUI endpoints, from their discovery files.
    # Stale files (dead pids) are pruned as a side effect.
    #
    # @return [Array<Hash>] [{name:, game:, port:}]
    def self.sibling_sessions
      return [] unless File.directory?(DISCOVERY_DIR)

      Dir.glob(File.join(DISCOVERY_DIR, '*.json')).map do |file|
        entry = JSON.parse(File.read(file), symbolize_names: true)
        next if entry[:pid] == Process.pid
        next prune_stale_discovery(file) unless pid_alive?(entry[:pid])

        { name: entry[:name], game: entry[:game], port: entry[:port] }
      rescue StandardError
        nil
      end.compact
    end

    # @param pid [Integer, nil]
    # @return [Boolean]
    def self.pid_alive?(pid)
      return false unless pid.is_a?(Integer) && pid.positive?

      Process.kill(0, pid)
      true
    rescue Errno::ESRCH
      false
    rescue StandardError
      true # EPERM etc. - process exists but isn't ours
    end
    private_class_method :pid_alive?

    # @param file [String]
    # @return [nil]
    def self.prune_stale_discovery(file)
      File.delete(file) rescue nil
      nil
    end
    private_class_method :prune_stale_discovery

    # Writes this session's discovery entry atomically (temp file + rename),
    # mode 0o600, mirroring the active_sessions discovery-file pattern.
    #
    # @return [void]
    def self.write_discovery_file
      FileUtils.mkdir_p(DISCOVERY_DIR)
      payload = JSON.generate(
        session_info.merge(port: port, pid: Process.pid, started_at: Time.now.to_i)
      )
      temp_path = discovery_path + ".tmp#{Process.pid}"
      File.open(temp_path, File::WRONLY | File::CREAT | File::TRUNC, 0o600) { |f| f.write(payload) }
      File.rename(temp_path, discovery_path)
    rescue StandardError => e
      Lich.log("warning: WebUI discovery file write failed: #{e.class}: #{e.message}") if defined?(Lich) && Lich.respond_to?(:log)
    end
    private_class_method :write_discovery_file

    # @return [void]
    def self.delete_discovery_file
      File.delete(discovery_path) rescue nil
    end
    private_class_method :delete_discovery_file

    # @return [String]
    def self.discovery_path
      File.join(DISCOVERY_DIR, "#{Process.pid}.json")
    end
    private_class_method :discovery_path
  end
end
