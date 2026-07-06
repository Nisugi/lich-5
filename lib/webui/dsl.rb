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
      def initialize(state)
        @state = state
        @nodes = []
        @callbacks = {}
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

      # Read-only data table.
      #
      # @param rows [Array<Array<#to_s>>]
      # @param headings [Array<#to_s>, nil]
      # @return [void]
      def table(rows, headings: nil)
        emit('table',
             headings: headings&.map(&:to_s),
             rows: rows.map { |row| Array(row).map(&:to_s) })
      end

      private

      # Appends one component node, assigning its positional (or keyed) id
      # and capturing its callback when given.
      #
      # @param type [String]
      # @param key [String, Symbol, nil]
      # @param attrs [Hash]
      # @return [void]
      def emit(type, key: nil, **attrs, &block)
        cid = key ? "#{type}:#{key}" : "#{type}:#{@index}"
        @index += 1
        @callbacks[cid] = block if block
        node = { t: type, cid: cid }
        attrs.each { |name, value| node[name] = value unless value.nil? }
        @nodes << node
      end
    end
  end
end
