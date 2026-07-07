# frozen_string_literal: true

module Lich
  module WebUI
    # Whitelisted local-file serving for script pages (map images etc.).
    #
    # Scripts register a directory under a short alias (UI.serve); the server
    # exposes GET /files/<alias>/<relpath>. This is the only WebUI route that
    # touches the real filesystem from a URL, so resolution is deliberately
    # paranoid:
    #
    #   - the registered root is stored symlink-resolved (File.realpath);
    #   - the requested path is percent-decoded, then resolved with
    #     File.realpath so symlinks cannot smuggle a file in from outside;
    #   - the resolved path must sit strictly inside the root (prefix test
    #     against the resolved root + separator);
    #   - only a fixed set of image extensions is servable - this is an
    #     image route, not a general file server.
    #
    # Ownership mirrors the page Registry: routes registered from a script
    # are removed when that script dies.
    module FileRoutes
      EXTENSIONS = {
        '.png'  => 'image/png',
        '.jpg'  => 'image/jpeg',
        '.jpeg' => 'image/jpeg',
        '.gif'  => 'image/gif',
        '.webp' => 'image/webp'
      }.freeze

      ALIAS_PATTERN = /\A[A-Za-z0-9_\-]+\z/

      @routes = {}
      @mutex = Mutex.new
      @death_hook_installed = false

      # Registers (or replaces) a served directory.
      #
      # @param alias_name [String] short name used in /files/<alias>/ URLs
      # @param directory [String] existing directory to serve images from
      # @param owner [Object, nil] owning script (nil = core, never auto-removed)
      # @return [Boolean]
      def self.register(alias_name, directory, owner: nil)
        alias_name = alias_name.to_s
        return false unless alias_name.match?(ALIAS_PATTERN)

        root = begin
          File.realpath(directory.to_s)
        rescue StandardError
          nil
        end
        return false unless root && File.directory?(root)

        install_death_hook
        @mutex.synchronize do
          @routes[alias_name] = { root: root, owner_id: owner&.object_id }
        end
        true
      end

      # @param alias_name [String]
      # @return [Boolean] whether a route was removed
      def self.unregister(alias_name)
        @mutex.synchronize { !@routes.delete(alias_name.to_s).nil? }
      end

      # Removes every route owned by a dying script (ScriptDeath handler).
      #
      # @param script [Script]
      # @return [void]
      def self.cleanup_for(script)
        owner_id = script.object_id
        @mutex.synchronize { @routes.delete_if { |_, entry| entry[:owner_id] == owner_id } }
      end

      # @return [void]
      def self.clear!
        @mutex.synchronize { @routes.clear }
      end

      # Resolves one request to a servable file.
      #
      # @param alias_name [String]
      # @param raw_relpath [String] the URL path remainder, still percent-encoded
      # @return [Array(String, String), nil] [absolute_path, content_type], or
      #   nil for anything unknown, escaping, or non-image
      def self.resolve(alias_name, raw_relpath)
        entry = @mutex.synchronize { @routes[alias_name.to_s] }
        return nil unless entry

        relpath = percent_decode(raw_relpath.to_s)
        return nil if relpath.empty? || relpath.include?("\0")

        content_type = EXTENSIONS[File.extname(relpath).downcase]
        return nil unless content_type

        candidate = begin
          File.realpath(File.expand_path(relpath, entry[:root]))
        rescue StandardError
          return nil
        end
        return nil unless candidate.start_with?(entry[:root] + File::SEPARATOR)
        return nil unless File.file?(candidate)

        [candidate, content_type]
      end

      # @param raw [String]
      # @return [String]
      def self.percent_decode(raw)
        raw.gsub(/%([0-9A-Fa-f]{2})/) { [Regexp.last_match(1)].pack('H2') }
      end
      private_class_method :percent_decode

      # Lazily wires ScriptDeath cleanup (ScriptDeath loads after this file in
      # boot order; by the time a script registers a route, it exists).
      #
      # @return [void]
      def self.install_death_hook
        @mutex.synchronize do
          return if @death_hook_installed
          return unless defined?(Lich::Common::ScriptDeath)

          Lich::Common::ScriptDeath.on_death { |script| FileRoutes.cleanup_for(script) }
          @death_hook_installed = true
        end
      end
    end
  end
end
