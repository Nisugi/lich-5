# frozen_string_literal: true

require_relative 'page'

module Lich
  module WebUI
    # Global registry of live script pages, keyed by full id
    # ("scriptname/pagename").
    #
    # Ownership follows the HookRegistry pattern: each page records its
    # owning script's object_id, and a ScriptDeath handler removes a dying
    # script's pages automatically - script authors never clean up UI
    # registration by hand. The death hook installs lazily on first
    # registration because this file loads before script.rb defines
    # ScriptDeath.
    module Registry
      @pages = {}
      @mutex = Mutex.new
      @death_hook_installed = false

      # Registers (or replaces) a page and announces the change to connected
      # browsers.
      #
      # @param page [Page]
      # @return [Page]
      def self.register(page)
        install_death_hook
        replaced = nil
        @mutex.synchronize do
          replaced = @pages[page.id]
          @pages[page.id] = page
        end
        replaced&.closed("page #{page.id} was re-registered")
        WebUI.notify_pages_changed
        page
      end

      # @param id [String]
      # @return [Page, nil]
      def self.find(id)
        @mutex.synchronize { @pages[id.to_s] }
      end

      # Removes one page by id. Standalone windows showing the page close
      # themselves (the close broadcast); replace via register does NOT
      # close windows - the re-registered page keeps them.
      #
      # @param id [String]
      # @return [Page, nil] the removed page
      def self.remove(id)
        removed = @mutex.synchronize { @pages.delete(id.to_s) }
        if removed
          removed.closed("page #{removed.id} was removed")
          WebUI.notify_page_close(removed.id)
          WebUI.notify_pages_changed
        end
        removed
      end

      # Removes every page owned by a dying script. Wired into
      # ScriptDeath so it runs from Script#kill cleanup - killing ;map
      # closes the map window.
      #
      # @param script [Script]
      # @return [void]
      def self.cleanup_for(script)
        owner_id = script.object_id
        removed = []
        @mutex.synchronize do
          @pages.each_value { |page| removed << page if page.owner_id == owner_id }
          removed.each { |page| @pages.delete(page.id) }
        end
        return if removed.empty?

        removed.each { |page|
          page.closed("script #{page.script_name} exited")
          WebUI.notify_page_close(page.id)
        }
        WebUI.notify_pages_changed
      end

      # @return [Array<Hash>] page descriptors for the hello/pages envelopes
      def self.pages_snapshot
        @mutex.synchronize { @pages.values.map(&:descriptor) }
      end

      # Empties the registry without notifications (specs, shutdown).
      #
      # @return [void]
      def self.clear!
        @mutex.synchronize { @pages.clear }
      end

      # Registers the ScriptDeath cleanup handler once. Lazy because
      # ScriptDeath (lib/common/script_death.rb) loads after this file in
      # the lich.rbw require order; by the time any script registers a page,
      # it exists.
      #
      # @return [void]
      def self.install_death_hook
        @mutex.synchronize do
          return if @death_hook_installed
          return unless defined?(Lich::Common::ScriptDeath)

          Lich::Common::ScriptDeath.on_death { |script| Registry.cleanup_for(script) }
          @death_hook_installed = true
        end
      end
    end
  end
end
