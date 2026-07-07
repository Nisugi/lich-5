# frozen_string_literal: true

# Public script-facing API for the browser-based WebUI.
#
# Scripts register declarative pages; Lich renders them in the player's
# browser and routes interactions back into the owning script's context.
# See docs/webui.md for the author guide.
#
#   UI.page("hunt", title: "Hunt Panel") do |ui|
#     ui.text "Kills: #{ui.state[:kills] || 0}"
#     ui.button("Start") { put "hunt" }
#   end
#   UI.refresh("hunt")   # push an update after game events
#
# Every method is an inert no-op while the :webui feature flag is off
# (`;ui on` enables it), so scripts can call UI.* unconditionally.
module UI
  # Registers (or replaces) a page for the calling script and starts the
  # WebUI service on first use.
  #
  # @param name [String] page name, unique within the calling script
  # @param title [String, nil] browser-facing title (defaults to the name)
  # @param every [Numeric, nil] optional polling interval in seconds; the
  #   page re-renders on this cadence while a browser is viewing it
  # @yieldparam ui [Lich::WebUI::Builder] emit components on each render
  # @return [Lich::WebUI::Page, nil] nil when disabled or not in a script
  def self.page(name, title: nil, every: nil, bare: false, size: nil, &block)
    return nil unless available?
    raise ArgumentError, 'UI.page requires a block' unless block

    Lich::WebUI.register_page(name, title: title, every: every, bare: bare, size: size, &block)
  end

  # Opens the player's browser directly on one of the calling script's
  # pages (no landing-page detour). app: true requests a chromeless
  # floating window (Edge/Chrome app mode) - the right choice for bare
  # pages like a map; falls back to a normal tab.
  #
  # size: [w, h] and position: [x, y] set the app window's initial outer
  # geometry. Bare pages report their live geometry back into
  # state[:_window_geometry] ({w:, h:, x:, y:}) so a script can persist it
  # (Settings) and reopen the window exactly where the player left it.
  #
  # @param name [String] page name or full "script/page" id
  # @param app [Boolean]
  # @param size [Array(Integer, Integer), nil]
  # @param position [Array(Integer, Integer), nil]
  # @return [Boolean]
  def self.open(name, app: false, size: nil, position: nil)
    return false unless available?

    page = find(name)
    return false unless page

    Lich::WebUI.open_page(page.id, app: app, size: size, position: position)
  end

  # Schedules a re-render push to any browsers viewing the page. Callable
  # from anywhere in the owning script (watchfor handlers, loops).
  #
  # @param name [String] page name or full "script/page" id
  # @return [void]
  def self.refresh(name)
    find(name)&.request_render
    nil
  end

  # The page's thread-safe state store (also reachable as ui.state inside
  # the page block).
  #
  # @param name [String]
  # @return [Lich::WebUI::PageState, nil]
  def self.state(name)
    find(name)&.state
  end

  # Unregisters a page.
  #
  # @param name [String]
  # @return [void]
  def self.remove(name)
    page = find(name)
    Lich::WebUI::Registry.remove(page.id) if page
    nil
  end

  # Serves a local directory of images at /files/<alias>/... for use with
  # ui.image and ui.image_map. Owned by the calling script and removed
  # automatically when it exits. Only image extensions are servable, and
  # requests cannot escape the directory.
  #
  #   UI.serve('maps', MAP_DIR)
  #   ui.image_map("/files/maps/#{room.image}", ...)
  #
  # @param alias_name [String] letters/digits/underscore/hyphen
  # @param directory [String]
  # @return [Boolean]
  def self.serve(alias_name, directory)
    return false unless available?

    script = Script.current if defined?(Script) && Script.respond_to?(:current)
    Lich::WebUI.ensure_service!
    Lich::WebUI::FileRoutes.register(alias_name, directory, owner: script)
  end

  # Removes a served directory registered with UI.serve.
  #
  # @param alias_name [String]
  # @return [void]
  def self.unserve(alias_name)
    Lich::WebUI::FileRoutes.unregister(alias_name) if defined?(Lich::WebUI::FileRoutes)
    nil
  end

  # @return [String, nil] the landing page URL when the service is running
  def self.url
    return nil unless defined?(Lich::WebUI)

    Lich::WebUI.url
  end

  # @return [Boolean] whether the WebUI feature is enabled
  def self.available?
    defined?(Lich::WebUI) ? Lich::WebUI.enabled? : false
  end

  # Resolves a bare page name against the calling script, or a full
  # "script/page" id against the registry directly.
  #
  # @param name [String]
  # @return [Lich::WebUI::Page, nil]
  def self.find(name)
    return nil unless defined?(Lich::WebUI::Registry)

    name = name.to_s
    return Lich::WebUI::Registry.find(name) if name.include?('/')

    script = Script.current if defined?(Script) && Script.respond_to?(:current)
    return nil unless script

    Lich::WebUI::Registry.find("#{script.name}/#{name}")
  end
  private_class_method :find
end
