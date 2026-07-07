# frozen_string_literal: true

require 'json'

module Lich
  module WebUI
    # Renders WebUI pages inside closed frontends (Wrayth/Stormfront) as
    # dialogData windows - the integration tier for FEs that cannot embed a
    # webview. The bridge subscribes to a page IN-PROCESS, exactly like a
    # browser does (it is just another subscriber receiving render JSON),
    # translates a reduced widget set to dialogData XML, and maps link
    # clicks back into the page's callbacks through an UpstreamHook.
    #
    # Reduced by design: labels, progress bars, and links (buttons,
    # checkbox toggles, select/radio cycling). Text entry, images, sliders,
    # and tables' row-clicks stay browser-only; the dialog notes how many
    # widgets it skipped. Right for glanceable panels (status bars, feeds),
    # not for settings pages.
    #
    # Player surface: ;ui bridge <page> [off]
    module Bridge
      extend self

      WIDTH = 250          # dialog content width in FE pixels
      ROW = 16             # vertical stride per widget row
      MAX_ROWS = 40        # dialogData windows are small; cap and say so
      TABLE_ROWS = 6       # table/log preview depth
      HOOK_NAME = 'webui-dialog-bridge'
      COMMAND_PREFIX = '_webui-bridge'

      @attached = {}
      @hook_installed = false
      @sender = nil

      # @param callable [#call, nil] injectable XML sender (specs); nil
      #   restores the default (raw send to the connected client)
      def sender=(callable)
        @sender = callable
      end

      # @return [Array<String>] bridged page ids
      def attached
        @attached.keys
      end

      # Bridges a page into a dialog window. Idempotent.
      #
      # @param page_id [String] full "script/page" id
      # @return [Boolean] false when the page does not exist
      def attach(page_id)
        page_id = page_id.to_s
        return true if @attached.key?(page_id)

        page = Registry.find(page_id)
        return false unless page

        install_hook
        dialog_id = dialog_id_for(page_id)
        connection = Connection.new(page_id, dialog_id, method(:emit))
        @attached[page_id] = connection
        emit(open_dialog(dialog_id, page.descriptor[:title] || page_id))
        page.subscribe(connection) # sends the current tree immediately
        true
      end

      # Removes a bridge and closes its dialog window.
      #
      # @param page_id [String]
      # @return [Boolean] whether a bridge existed
      def detach(page_id)
        connection = @attached.delete(page_id.to_s)
        return false unless connection

        connection.kill!
        Registry.find(page_id.to_s)&.unsubscribe(connection)
        emit("<closeDialog id='#{dialog_id_for(page_id.to_s)}'/>")
        uninstall_hook if @attached.empty?
        true
      end

      # Called by WebUI.notify_page_close when a page is removed (script
      # killed, UI.remove) so the dialog window closes with it.
      #
      # @param page_id [String]
      # @return [void]
      def page_closed(page_id)
        detach(page_id) if @attached.key?(page_id.to_s)
      end

      # UpstreamHook: swallow bridge link commands and dispatch the event
      # into the page's callback; pass every other client line through.
      #
      # @param client_string [String]
      # @return [String, nil]
      def handle_command(client_string)
        return client_string unless client_string =~ /^(?:<c>)?#{COMMAND_PREFIX}\s+(.+?)\s*$/

        page_id, cid, raw = ::Regexp.last_match(1).split('|', 3)
        page = Registry.find(page_id.to_s)
        page&.handle_event(cid.to_s, decode_value(raw))
        nil
      end

      # Translates one render tree into a full dialogData replacement.
      # Public and pure for specs.
      #
      # @param dialog_id [String]
      # @param tree [Hash] symbol-keyed render tree
      # @param page_id [String]
      # @return [String] dialogData XML
      def dialog_update(dialog_id, tree, page_id)
        state = { rows: [], skipped: 0, overflow: false, page_id: page_id }
        walk(tree[:children] || [], state)
        if state[:overflow]
          state[:rows][MAX_ROWS - 1] = label_row('... more in the browser (;ui)')
        elsif state[:skipped].positive? && state[:rows].length < MAX_ROWS
          state[:rows] << label_row("(#{state[:skipped]} browser-only widget#{'s' if state[:skipped] > 1} not shown)")
        end
        widgets = state[:rows].each_with_index.map { |row, index| row.call(index * ROW) }.join
        "<dialogData id='#{dialog_id}' clear='t'>#{widgets}</dialogData>"
      end

      private

      # Fake browser connection: Page pushes render JSON at it, the bridge
      # redraws the dialog. Quacks like Server::Connection (alive?,
      # send_text -> bool) so subscriber pruning works unchanged.
      class Connection
        def initialize(page_id, dialog_id, emitter)
          @page_id = page_id
          @dialog_id = dialog_id
          @emitter = emitter
          @alive = true
        end

        def alive?
          @alive
        end

        def kill!
          @alive = false
        end

        def send_text(json)
          return false unless @alive

          message = begin
            JSON.parse(json, symbolize_names: true)
          rescue JSON::ParserError
            nil
          end
          return true unless message.is_a?(Hash) && message[:type] == 'render'

          @emitter.call(Bridge.dialog_update(@dialog_id, message[:tree] || {}, @page_id))
          true
        end
      end

      def emit(xml)
        if @sender
          @sender.call(xml)
        elsif respond_to?(:_respond, true) && defined?($frontend) && $frontend.to_s =~ /^(?:stormfront|wrayth|profanity|frostbite)$/
          _respond(xml)
        end
      end

      def open_dialog(dialog_id, title)
        "<openDialog type='dynamic' id='#{dialog_id}' title='#{escape(title)}' location='main' resident='true' width='#{WIDTH + 10}' height='300'><dialogData id='#{dialog_id}'></dialogData></openDialog>"
      end

      def dialog_id_for(page_id)
        "webui_#{page_id.gsub(/\W/, '_')}"
      end

      def install_hook
        return if @hook_installed
        return unless defined?(Lich::Common::UpstreamHook)

        Lich::Common::UpstreamHook.add(HOOK_NAME, proc { |line| Bridge.handle_command(line) }, persist: true)
        @hook_installed = true
      end

      def uninstall_hook
        return unless @hook_installed

        Lich::Common::UpstreamHook.remove(HOOK_NAME) if defined?(Lich::Common::UpstreamHook)
        @hook_installed = false
      end

      def decode_value(raw)
        case raw
        when nil, '', 'nil' then nil
        when 'true' then true
        when 'false' then false
        else raw
        end
      end

      # ---- tree -> rows ---------------------------------------------------

      def walk(nodes, state)
        Array(nodes).each do |node|
          if state[:rows].length >= MAX_ROWS
            state[:overflow] = true
            break
          end
          translate(node, state)
        end
      end

      def translate(node, state)
        case node[:t]
        when 'header' then state[:rows] << label_row(plain(node[:text]).upcase)
        when 'text' then state[:rows] << label_row(plain(node[:text]))
        when 'markdown' then state[:rows] << label_row(plain(node[:text]))
        when 'divider' then state[:rows] << label_row('-' * 40)
        when 'progress' then state[:rows] << progress_row(node)
        when 'button' then state[:rows] << button_row(node, state[:page_id])
        when 'checkbox' then state[:rows] << checkbox_row(node, state[:page_id])
        when 'select', 'radio' then state[:rows] << cycle_row(node, state[:page_id])
        when 'slider', 'number_input' then state[:rows] << label_row("#{node[:label]}: #{node[:value]}")
        when 'table' then table_rows(node, state)
        when 'log' then log_rows(node, state)
        when 'tabs' then (node[:children] || []).each { |tab| state[:rows] << label_row(plain(tab[:label]).upcase); walk(tab[:children], state) }
        when 'columns' then (node[:children] || []).each { |col| walk(col[:children], state) }
        when 'expander' then state[:rows] << label_row(plain(node[:label]).upcase); walk(node[:children], state)
        else state[:skipped] += 1
        end
      end

      def label_row(text)
        value = escape(text.to_s)
        ->(top) { "<label id='r#{top}' value='#{value}' top='#{top}' left='0' width='#{WIDTH}' height='15'/>" }
      end

      def progress_row(node)
        percent = (node[:value].to_f * 100).round.clamp(0, 100)
        text = escape(node[:label].to_s.empty? ? "#{percent}%" : node[:label].to_s)
        ->(top) { "<progressBar id='r#{top}' value='#{percent}' text='#{text}' top='#{top}' left='0' width='#{WIDTH}' height='15'/>" }
      end

      def button_row(node, page_id)
        return label_row("( #{node[:label]} )") if node[:disabled]

        value = escape("[#{node[:label]}]")
        cmd = command(page_id, node[:cid], nil)
        ->(top) { "<link id='r#{top}' value='#{value}' cmd='#{cmd}' echo='' top='#{top}' left='0' width='#{WIDTH}' height='15'/>" }
      end

      def checkbox_row(node, page_id)
        value = escape("[#{node[:checked] ? 'x' : ' '}] #{node[:label]}")
        cmd = command(page_id, node[:cid], (!node[:checked]).to_s)
        ->(top) { "<link id='r#{top}' value='#{value}' cmd='#{cmd}' echo='' top='#{top}' left='0' width='#{WIDTH}' height='15'/>" }
      end

      # Selects and radios render as "Label: current" plus a cycle link that
      # advances to the next option - full pickers stay browser-only.
      def cycle_row(node, page_id)
        options = node[:options] || []
        current = node[:value] || options.first
        next_option = options[((options.index(current) || 0) + 1) % [options.length, 1].max]
        text = escape("#{node[:label]}: #{current}")
        cmd = command(page_id, node[:cid], next_option.to_s)
        lambda { |top|
          "<label id='r#{top}' value='#{text}' top='#{top}' left='0' width='#{WIDTH - 60}' height='15'/>" \
            "<link id='r#{top}n' value='[next]' cmd='#{cmd}' echo='' top='#{top}' left='#{WIDTH - 55}' width='55' height='15'/>"
        }
      end

      def table_rows(node, state)
        state[:rows] << label_row(Array(node[:headings]).join('  ')) if node[:headings]
        Array(node[:rows]).first(TABLE_ROWS).each { |row| state[:rows] << label_row(Array(row).join('  ')) }
        state[:rows] << label_row("... #{node[:rows].length - TABLE_ROWS} more rows in the browser") if Array(node[:rows]).length > TABLE_ROWS
      end

      def log_rows(node, state)
        Array(node[:lines]).last(TABLE_ROWS).each { |line| state[:rows] << label_row(plain(line)) }
      end

      def command(page_id, cid, value)
        escape("#{COMMAND_PREFIX} #{page_id}|#{cid}|#{value.nil? ? 'nil' : value}")
      end

      # Strips the safe-markdown syntax down to plain text for labels.
      def plain(text)
        text.to_s
            .gsub(/\{\{[a-z]+:([^{}]*)\}\}/, '\1')
            .gsub(/\*\*([^*]+)\*\*/, '\1')
            .gsub(/\*([^*]+)\*/, '\1')
            .gsub(/`([^`]+)`/, '\1')
            .gsub(/\[([^\]]+)\]\([^)]*\)/, '\1')
      end

      def escape(text)
        text.to_s.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;').gsub("'", '&apos;').gsub('"', '&quot;')
      end
    end
  end
end
