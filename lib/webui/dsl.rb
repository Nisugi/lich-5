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
      # @param key [String, Symbol, nil] stable id override
      # @yield click handler, run in the owning script's context
      # @return [void]
      def button(label, variant: :default, disabled: false, key: nil, &block)
        emit('button', key: key, label: label.to_s, variant: variant.to_s, disabled: !!disabled, &block)
      end

      # @param label [#to_s]
      # @param value [#to_s, nil] current value shown in the field
      # @param placeholder [#to_s, nil]
      # @yieldparam value [String] the submitted text
      # @return [void]
      def text_input(label, value: nil, placeholder: nil, key: nil, &block)
        emit('text_input', key: key, label: label.to_s, value: value&.to_s, placeholder: placeholder&.to_s, &block)
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
      # the row your state considers chosen.
      #
      #   ui.table(rows, headings: %w[Script Author], sortable: true,
      #            selected: ui.state[:pick]) { |i| ui.state[:pick] = i }
      #
      # @param rows [Array<Array<#to_s>>]
      # @param headings [Array<#to_s>, nil]
      # @param sortable [Boolean]
      # @param selected [Integer, nil] row index to highlight
      # @yieldparam index [Integer] clicked row index
      # @return [void]
      def table(rows, headings: nil, sortable: false, selected: nil, key: nil, &block)
        node_attrs = {
          headings: headings&.map(&:to_s),
          rows: rows.map { |row| Array(row).map(&:to_s) }
        }
        node_attrs[:sortable] = true if sortable
        node_attrs[:clickable] = true if block
        node_attrs[:selected] = selected.to_i if selected
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
      #
      # @param count [Integer]
      # @param compact [Boolean]
      # @yieldparam columns [Builder] one argument per column
      # @return [void]
      def columns(count = 2, compact: false, key: nil)
        cid = claim_cid('columns', key)
        children = Array.new(count) { |i| child_builder("#{cid}.c#{i}") }
        yield(*children)
        node = {
          t: 'columns', cid: cid,
          children: children.each_with_index.map do |column, i|
            { t: 'col', cid: "#{cid}.c#{i}", children: column.nodes }
          end
        }
        node[:compact] = true if compact
        @nodes << node
      end

      # Tabbed sections; the block receives one nested builder per tab, in
      # the order of +names+. Tab switching is purely client-side.
      #
      #   ui.tabs(%w[Loot Stats]) { |loot, stats| loot.table(...) }
      #
      # @param names [Array<#to_s>]
      # @yieldparam tabs [Builder] one argument per tab
      # @return [void]
      def tabs(names, key: nil)
        cid = claim_cid('tabs', key)
        children = Array.new(names.length) { |i| child_builder("#{cid}.t#{i}") }
        yield(*children)
        @nodes << {
          t: 'tabs', cid: cid,
          children: names.each_with_index.map do |name, i|
            { t: 'tab', cid: "#{cid}.t#{i}", label: name.to_s, children: children[i].nodes }
          end
        }
      end

      # Displays an image from an http(s) URL or data: URI. Local file paths
      # are not supported - the browser, not Lich, fetches the source.
      #
      # @param source [String]
      # @param alt [#to_s, nil]
      # @return [void]
      def image(source, alt: nil, key: nil)
        source = source.to_s
        return unless source =~ %r{\Ahttps?://|\Adata:image/}

        emit('image', key: key, src: source, alt: alt&.to_s)
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
