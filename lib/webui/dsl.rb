# frozen_string_literal: true

module Lich
  module WebUI
    # Declarative component builder yielded to a page block on every render.
    #
    # Script authors call emitter methods (button, text, table, ...) in order;
    # the builder collects a JSON-ready node array plus a callback map keyed
    # by component id. The page swaps both in atomically after each render
    # pass, so callbacks always belong to the tree the browser is showing.
    #
    # Component ids are positional ("button:3" = fourth component, a button).
    # A component that appears conditionally can pass key: to keep its id
    # stable across renders regardless of position.
    #
    # Authors should treat the block as a pure view of state: read
    # ui.state / game data and emit components. Side effects (put, echo,
    # Settings writes) belong in callbacks, which run on the owning script's
    # threads.
    class Builder
      # Node types the user can interact with. A tab/section containing none
      # of these (only headers/dividers/markdown/text/image) is inert and can
      # crash some frontend tab renderers - see #tabs.
      INTERACTIVE_TYPES = %w[
        checkbox text_input password_input number_input slider select radio
        button columns tabs table image_map log
      ].freeze

      # True if +nodes+ or any descendant is an interactive component.
      def self.interactive_nodes?(nodes)
        Array(nodes).any? do |n|
          INTERACTIVE_TYPES.include?(n[:t] || n['t']) ||
            interactive_nodes?(n[:children] || n['children'])
        end
      end

      # @return [Array<Hash>] JSON-ready component nodes, in emission order
      attr_reader :nodes
      # @return [Hash{String => Proc}] event callbacks keyed by component id
      attr_reader :callbacks
      # @return [PageState] the owning page's state store
      attr_reader :state

      # @param state [PageState]
      # @param callbacks [Hash] shared across nested builders so every
      #   callback in the tree lands in one per-render map
      # @param prefix [String] cid prefix for components inside containers
      #   (e.g. "expander:5.")
      def initialize(state, callbacks: {}, prefix: '')
        @state = state
        @nodes = []
        @callbacks = callbacks
        @prefix = prefix
        @index = 0
      end

      # @param text [#to_s]
      # @return [void]
      def header(text)
        emit('header', text: text.to_s)
      end

      # @param text [#to_s]
      # @return [void]
      def text(text)
        emit('text', text: text.to_s)
      end

      # Markdown limited to a safe inline subset the browser renders as DOM
      # nodes (bold, italic, code, http/https links) - never raw HTML.
      # Colored spans use {{color:text}} with a fixed palette (red, green,
      # blue, yellow, orange, cyan, magenta, gray); unknown colors render
      # as plain text.
      #
      #   ui.markdown "{{red:**HURT**}} vs {{green:fine}}"
      #
      # @param text [#to_s]
      # @return [void]
      def markdown(text)
        emit('markdown', text: text.to_s)
      end

      # @return [void]
      def divider
        emit('divider')
      end

      # @param label [#to_s]
      # @param variant [Symbol] :default or :danger
      # @param disabled [Boolean]
      # @param confirm [#to_s, nil] two-step confirmation: the first click
      #   swaps the label to this text, only a second click (within a few
      #   seconds) fires the handler - for destructive actions
      # @param key [String, Symbol, nil] stable id override
      # @yield click handler, run in the owning script's context
      # @return [void]
      def button(label, variant: :default, disabled: false, confirm: nil, key: nil, &block)
        attrs = { label: label.to_s, variant: variant.to_s, disabled: !!disabled }
        attrs[:confirm] = confirm.to_s if confirm
        emit('button', key: key, **attrs, &block)
      end

      # @param label [#to_s]
      # @param value [#to_s, nil] current value shown in the field
      # @param placeholder [#to_s, nil]
      # @yieldparam value [String] the submitted text
      # @return [void]
      def text_input(label, value: nil, placeholder: nil, key: nil, &block)
        emit('text_input', key: key, label: label.to_s, value: value&.to_s, placeholder: placeholder&.to_s, &block)
      end

      # Multi-line text field (GTK GtkTextView equivalent), for notes, regex
      # lists, eval expressions - anything that spans several lines. Same
      # event contract as #text_input: the callback fires with the full
      # (multi-line) string on edit.
      #
      # @param label [#to_s]
      # @param value [#to_s, nil] current text (may contain newlines)
      # @param placeholder [#to_s, nil]
      # @param rows [Integer] visible row height hint (default 4)
      # @param key [Object, nil]
      # @yieldparam value [String] the edited text
      # @return [void]
      def textarea(label, value: nil, placeholder: nil, rows: 4, key: nil, &block)
        emit('textarea', key: key, label: label.to_s, value: value&.to_s,
                         placeholder: placeholder&.to_s, rows: [rows.to_i, 1].max, &block)
      end

      # Masked input for credentials. The value is NEVER echoed back into
      # the render tree - it exists only in the browser field and the single
      # change event your block receives. Do not log it.
      #
      # @param label [#to_s]
      # @param placeholder [#to_s, nil]
      # @yieldparam value [String]
      # @return [void]
      def password_input(label, placeholder: nil, key: nil, &block)
        emit('password_input', key: key, label: label.to_s, placeholder: placeholder&.to_s, &block)
      end

      # @param label [#to_s]
      # @param options [Array<#to_s>]
      # @param value [#to_s, nil] currently selected option
      # @yieldparam value [String] the chosen option
      # @return [void]
      def select(label, options:, value: nil, key: nil, &block)
        emit('select', key: key, label: label.to_s, options: options.map(&:to_s), value: value&.to_s, &block)
      end

      # @param label [#to_s]
      # @param checked [Boolean]
      # @yieldparam value [Boolean]
      # @return [void]
      def checkbox(label, checked: false, key: nil, &block)
        emit('checkbox', key: key, label: label.to_s, checked: !!checked, &block)
      end

      # @param label [#to_s]
      # @param min [Numeric]
      # @param max [Numeric]
      # @param step [Numeric]
      # @param value [Numeric, nil]
      # @yieldparam value [Numeric]
      # @return [void]
      def slider(label, min:, max:, step: 1, value: nil, key: nil, &block)
        emit('slider', key: key, label: label.to_s, min: min, max: max, step: step, value: value || min, &block)
      end

      # Numeric entry field (spinner).
      #
      # @param label [#to_s]
      # @param min [Numeric, nil]
      # @param max [Numeric, nil]
      # @param step [Numeric]
      # @param value [Numeric, nil]
      # @yieldparam value [Numeric]
      # @return [void]
      def number_input(label, min: nil, max: nil, step: 1, value: nil, key: nil, &block)
        # Always emit a concrete value: a nil value drops the field entirely,
        # and a frontend that assumes a numeric value (e.g. toFixed) can choke
        # on the missing key. Fall back to min, else 0 - mirrors #slider.
        resolved = value.nil? ? (min || 0) : value
        emit('number_input', key: key, label: label.to_s, min: min, max: max, step: step, value: resolved, &block)
      end

      # Radio group: one choice from a small set, all options visible.
      #
      # @param label [#to_s]
      # @param options [Array<#to_s>]
      # @param value [#to_s, nil] currently selected option
      # @yieldparam value [String] the chosen option
      # @return [void]
      def radio(label, options:, value: nil, key: nil, &block)
        emit('radio', key: key, label: label.to_s, options: options.map(&:to_s), value: value&.to_s, &block)
      end

      # Scrolling text log for streams (kill feeds, loot, activity). Pass
      # the whole backlog each render (keep it in ui.state and cap it
      # yourself); the browser sticks to the newest line unless the player
      # has scrolled up to read. Lines render with the same safe inline
      # markdown as +markdown+, including {{color:...}} spans.
      #
      #   ui.state[:feed] = (ui.state[:feed] || []).last(200)
      #   ui.log(ui.state[:feed], max_height: 220)
      #
      # @param lines [Array<#to_s>]
      # @param max_height [Integer] pixel height of the scroll region
      # @return [void]
      def log(lines, max_height: 200, key: nil)
        emit('log', key: key, max_height: max_height.to_i, lines: Array(lines).map(&:to_s))
      end

      # @param value [Float] 0.0..1.0
      # @param label [#to_s, nil]
      # @return [void]
      def progress(value, label: nil)
        emit('progress', value: value.to_f.clamp(0.0, 1.0), label: label&.to_s)
      end

      # Data table. Read-only by default; pass sortable: true for
      # client-side column sorting, and a block to make rows clickable -
      # it receives the clicked row's index into +rows+ (stable regardless
      # of the browser's current sort order). Use selected: to highlight
      # the row your state considers chosen. max_height: (pixels) caps the
      # table's height and scrolls the rows inside it - headings stay
      # pinned - so a large table never stretches the whole page.
      #
      #   ui.table(rows, headings: %w[Script Author], sortable: true,
      #            selected: ui.state[:pick], max_height: 400) { |i| ui.state[:pick] = i }
      #
      # @param rows [Array<Array<#to_s>>]
      # @param headings [Array<#to_s>, nil]
      # @param sortable [Boolean]
      # @param selected [Integer, nil] row index to highlight
      # @param max_height [Integer, nil] pixel cap; rows scroll within it
      # @yieldparam index [Integer] clicked row index
      # @return [void]
      def table(rows, headings: nil, sortable: false, selected: nil, max_height: nil, key: nil, &block)
        node_attrs = {
          headings: headings&.map(&:to_s),
          rows: rows.map { |row| Array(row).map(&:to_s) }
        }
        node_attrs[:sortable] = true if sortable
        node_attrs[:clickable] = true if block
        node_attrs[:selected] = selected.to_i if selected
        node_attrs[:max_height] = max_height.to_i if max_height
        emit('table', key: key, **node_attrs, &block)
      end

      # Collapsible section; the block receives a nested builder.
      #
      #   ui.expander("Settings") { |e| e.checkbox("Loot") { |v| ... } }
      #
      # @param label [#to_s]
      # @param open [Boolean] expanded by default
      # @yieldparam section [Builder]
      # @return [void]
      def expander(label, open: false, key: nil)
        cid = claim_cid('expander', key)
        child = child_builder(cid)
        yield child
        @nodes << { t: 'expander', cid: cid, label: label.to_s, open: !!open, children: child.nodes }
      end

      # Side-by-side columns; the block receives one nested builder per
      # column.
      #
      #   ui.columns(2) { |left, right| left.text "a"; right.text "b" }
      #
      # compact: true sizes each column to its content instead of equal
      # widths - use it for small button groups (row actions).
      # weights: gives columns proportional widths instead of equal ones -
      # weights: [7, 3] is a 70/30 split (master list next to a detail
      # panel). Ignored when compact.
      #
      # @param count [Integer]
      # @param compact [Boolean]
      # @param weights [Array<Numeric>, nil] one relative width per column
      # @yieldparam columns [Builder] one argument per column
      # @return [void]
      def columns(count = 2, compact: false, weights: nil, key: nil)
        cid = claim_cid('columns', key)
        builders = Array.new(count) { |i| child_builder("#{cid}.c#{i}") }
        yield(*builders)
        # Drop trailing empty columns: a caller that slices an odd-length list
        # into fixed-width rows (each_slice(2) -> columns(2)) leaves the last
        # cell empty on the short row, and an empty column can crash some
        # frontend grid renderers. Emitting fewer columns is harmless.
        builders.pop while builders.length > 1 && builders.last.nodes.empty?
        emitted = builders.length
        node = {
          t: 'columns', cid: cid,
          children: builders.each_with_index.map do |column, i|
            { t: 'col', cid: "#{cid}.c#{i}", children: column.nodes }
          end
        }
        node[:compact] = true if compact
        node[:weights] = weights.first(emitted).map(&:to_f) if !compact && weights.is_a?(Array)
        @nodes << node
      end

      # A uniform aligned grid (CSS grid), for matrices where every column
      # must line up across rows - unlike #columns, whose per-row widths do
      # not align. Cells hold arbitrary child nodes (labels, checkboxes,
      # dropdowns). Pass the total number of columns; the block is yielded a
      # cell builder per cell, filled row-major left-to-right, top-to-bottom.
      # Empty cells are permitted (they render as spacers), so a ragged
      # matrix stays aligned.
      #
      #   ui.grid(cols: 3, cells: rows * 3) do |cell, index|
      #     # fill cell #index
      #   end
      #
      # Or drive it from data:
      #   ui.grid(cols: towns.size + 1, cells: (towns.size + 1) * (towns.size + 1)) { |cell, i| ... }
      #
      # @param cols [Integer] number of columns
      # @param cells [Integer] total cell count (rows = ceil(cells/cols))
      # @param compact [Boolean] tighter cell padding
      # @param key [Object, nil]
      # @yieldparam cell [Builder] the cell's builder
      # @yieldparam index [Integer] 0-based cell index (row-major)
      # @return [void]
      def grid(cols:, cells:, compact: false, key: nil)
        cols = [cols.to_i, 1].max
        cells = [cells.to_i, 0].max
        cid = claim_cid('grid', key)
        cell_builders = Array.new(cells) { |i| child_builder("#{cid}.g#{i}") }
        cell_builders.each_with_index { |cell, i| yield(cell, i) }
        node = {
          t: 'grid', cid: cid, cols: cols,
          children: cell_builders.each_with_index.map do |cell, i|
            { t: 'cell', cid: "#{cid}.g#{i}", children: cell.nodes }
          end
        }
        node[:compact] = true if compact
        @nodes << node
      end

      # Tabbed sections; the block receives one nested builder per tab, in
      # the order of +names+. Tab switching is purely client-side.
      # vertical: true renders the tab bar as a left sidebar (accounts in
      # the login launcher) instead of a horizontal strip.
      #
      #   ui.tabs(%w[Loot Stats]) { |loot, stats| loot.table(...) }
      #
      # @param names [Array<#to_s>]
      # @param vertical [Boolean]
      # @yieldparam tabs [Builder] one argument per tab
      # @return [void]
      def tabs(names, vertical: false, key: nil)
        cid = claim_cid('tabs', key)
        children = Array.new(names.length) { |i| child_builder("#{cid}.t#{i}") }
        yield(*children)
        node = {
          t: 'tabs', cid: cid,
          children: names.each_with_index.map do |name, i|
            kids = children[i].nodes
            # A tab whose interactive widgets were all conditional (e.g.
            # spell-gated checkboxes a low-level character doesn't have) can
            # render down to nothing but headers/dividers/markdown. Some
            # frontend tab renderers choke on a tab with no interactive
            # content, so append a placeholder note keeping the tab inert but
            # renderable. Checks descendants, since widgets may sit in nested
            # columns.
            kids += [{ t: 'text', cid: "#{cid}.t#{i}.empty", text: '(nothing to configure here for this character)' }] unless self.class.interactive_nodes?(kids)
            { t: 'tab', cid: "#{cid}.t#{i}", label: name.to_s, children: kids }
          end
        }
        node[:vertical] = true if vertical
        @nodes << node
      end

      # Displays an image from an http(s) URL, data: URI, or a /files/ path
      # registered via UI.serve. Raw local file paths are not supported.
      #
      # @param source [String]
      # @param alt [#to_s, nil]
      # @return [void]
      def image(source, alt: nil, key: nil)
        source = source.to_s
        return unless source =~ %r{\Ahttps?://|\Adata:image/|\A/files/}

        emit('image', key: key, src: source, alt: alt&.to_s)
      end

      # Interactive image with positioned overlays (the map component).
      #
      # The image renders at natural size * scale inside a scrollable
      # container. Markers are boxes in UNSCALED image-pixel coordinates.
      # The block receives every click as a symbol-keyed Hash: :x/:y
      # (unscaled image coords), :shift/:ctrl booleans, and :marker (the id
      # of the clicked marker, or nil) - hit-testing against your own data
      # (rooms) stays in your script. scroll_to: centers the container on
      # the named marker whenever its value changes.
      #
      #   ui.image_map("/files/maps/map1.png", scale: 1.5,
      #                markers: [{ id: 'current', x1: 10, y1: 20, x2: 30, y2: 40, kind: 'current' }],
      #                scroll_to: 'current') { |click| ... }
      #
      # popup: names a page ("script/page") that right-click opens as a
      # small supplemental browser window (popup_size: [w, h]) - the natural
      # home for a display's settings. Without popup:, right-clicks arrive
      # in the block with :right => true.
      #
      # @param src [String] http(s), data:, or /files/ source
      # @param scale [Numeric] display zoom factor
      # @param markers [Array<Hash>] {id:, x1:, y1:, x2:, y2:, kind:, label:}
      #   kinds: 'current' | 'marker' | 'pin'
      # @param scroll_to [String, nil] marker id to center on change
      # @param popup [String, nil] page id right-click opens in a popup
      # @param popup_size [Array(Integer, Integer), nil]
      # @yieldparam click [Hash]
      # @return [void]
      def image_map(src, scale: 1.0, markers: [], scroll_to: nil, popup: nil, popup_size: nil, key: nil, &block)
        src = src.to_s
        return unless src =~ %r{\Ahttps?://|\Adata:image/|\A/files/}

        emit('image_map', key: key,
                          src: src,
                          scale: scale.to_f,
                          scroll_to: scroll_to&.to_s,
                          popup: popup&.to_s,
                          popup_size: (popup_size.is_a?(Array) ? popup_size.first(2).map(&:to_i) : nil),
                          markers: markers.map { |marker|
                            node = {
                              id: marker[:id].to_s,
                              x1: marker[:x1].to_i, y1: marker[:y1].to_i,
                              x2: marker[:x2].to_i, y2: marker[:y2].to_i,
                              kind: (marker[:kind] || 'marker').to_s
                            }
                            node[:label] = marker[:label].to_s if marker[:label]
                            node
                          }, &block)
      end

      private

      # Reserves a positional/keyed cid without emitting a node yet (used by
      # containers, whose node is appended after the block runs).
      def claim_cid(type, key)
        cid = key ? "#{@prefix}#{type}:#{key}" : "#{@prefix}#{type}:#{@index}"
        @index += 1
        cid
      end

      # @param parent_cid [String]
      # @return [Builder] sharing state and the callback map
      def child_builder(parent_cid)
        Builder.new(@state, callbacks: @callbacks, prefix: "#{parent_cid}.")
      end

      # Appends one component node, assigning its positional (or keyed) id
      # and capturing its callback when given.
      #
      # @param type [String]
      # @param key [String, Symbol, nil]
      # @param attrs [Hash]
      # @return [void]
      def emit(type, key: nil, **attrs, &block)
        cid = claim_cid(type, key)
        @callbacks[cid] = block if block
        node = { t: type, cid: cid }
        attrs.each { |name, value| node[name] = value unless value.nil? }
        @nodes << node
      end
    end
  end
end
