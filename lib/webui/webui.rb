# frozen_string_literal: true

require 'json'
require 'securerandom'
require 'tmpdir'
require 'fileutils'

require_relative 'server'

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
  # (`;webui on`). Mirrors the ownership shape of
  # Lich::InternalAPI::ActiveSessions.
  module WebUI
    FEATURE_FLAG = :webui

    HOST = '127.0.0.1'

    # Sibling-session discovery files live here; they contain no secrets
    # (name, game, port, pid only) - each browser tab must still be blessed
    # by its own session's `;webui`.
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
    # running. Safe to call repeatedly; used by `;webui` and (in M2) by the
    # first UI.page registration.
    #
    # @return [Boolean] true when the service is available
    def self.ensure_service!
      return false unless enabled?

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
          message_handler: nil
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

    # Opens a URL in the player's default browser, falling back silently -
    # callers should always print the URL too.
    #
    # @param target [String]
    # @return [Boolean] true when a launcher was invoked
    def self.open_browser(target)
      return false if target.nil? || target.empty?

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

    # Registered page descriptors for the hello/pages envelopes. M1 has no
    # page registry yet; M2 replaces this with Registry.pages_snapshot.
    #
    # @return [Array<Hash>]
    def self.pages_snapshot
      []
    end

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
