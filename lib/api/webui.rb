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
  def self.page(name, title: nil, every: nil, &block)
    return nil unless available?
    raise ArgumentError, 'UI.page requires a block' unless block

    Lich::WebUI.register_page(name, title: title, every: every, &block)
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
