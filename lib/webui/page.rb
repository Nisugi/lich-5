# frozen_string_literal: true

require_relative 'dsl'
require_relative 'protocol'

module Lich
  module WebUI
    # Mutex-wrapped key/value store for a page's UI state.
    #
    # Shared between the script (callbacks, watchfor handlers) and render
    # passes. Individual reads/writes are atomic; read-modify-write sequences
    # are not, which is fine for UI state owned by a single script.
    class PageState
      def initialize
        @mutex = Mutex.new
        @data = {}
      end

      def [](key)
        @mutex.synchronize { @data[key] }
      end

      def []=(key, value)
        @mutex.synchronize { @data[key] = value }
      end

      def fetch(key, default = nil)
        @mutex.synchronize { @data.fetch(key, default) }
      end

      def key?(key)
        @mutex.synchronize { @data.key?(key) }
      end

      def delete(key)
        @mutex.synchronize { @data.delete(key) }
      end

      def update(hash)
        @mutex.synchronize { @data.update(hash) }
      end

      def to_h
        @mutex.synchronize { @data.dup }
      end

      def clear
        @mutex.synchronize { @data.clear }
      end
    end

    # One registered script page: its render block, state, event callbacks,
    # and browser subscribers.
    #
    # Threading model: the render block and event callbacks always execute on
    # a thread inside the owning script's ThreadGroup (the same recipe
    # Script.new_downstream uses for watchfor), so Script.current,
    # Settings[], echo, and put all resolve to the owning script. Server
    # threads never block waiting for script work - dispatch is
    # fire-and-forget with a deadline on entering the script's context.
    class Page
      # Seconds to wait for the dispatch thread to join the script's
      # ThreadGroup before giving up and telling the browser the script is
      # unavailable. Membership is normally established in well under a
      # millisecond; the deadline exists so a dying script cannot leak
      # spinning threads (upstream watchfor's unbounded poll is a known
      # hazard we deliberately do not copy).
      DISPATCH_TIMEOUT = 2

      # Runs +work+ inside the owner script's thread context. Calls
      # +on_timeout+ instead if the context cannot be entered by the
      # deadline. Threads already in the script's group run inline.
      DEFAULT_DISPATCHER = lambda do |script, timeout, on_timeout, work|
        if script.respond_to?(:has_thread?) && script.has_thread?(Thread.current)
          work.call
        elsif script.respond_to?(:thread_group) && script.thread_group
          worker = Thread.new do
            deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + timeout
            until script.has_thread?(Thread.current)
              if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline
                on_timeout&.call
                Thread.exit
              end
              sleep 0.011
            end
            begin
              work.call
            rescue StandardError => e
              Lich.log("error: WebUI dispatch: #{e.class}: #{e.message}") if defined?(Lich) && Lich.respond_to?(:log)
            end
          end
          script.thread_group.add(worker)
        else
          on_timeout&.call
        end
      end

      attr_reader :id, :title, :script_name, :owner_id, :state

      # @param id [String] full page id, "scriptname/pagename"
      # @param title [String]
      # @param script [Script] the owning script (thread dispatch + cleanup)
      # @param block [Proc] render block, yielded a Builder
      # @param every [Numeric, nil] optional polling interval in seconds -
      #   the page re-renders on this cadence while browsers are subscribed
      # @param dispatcher [#call, nil] injectable for specs; see
      #   DEFAULT_DISPATCHER for the (script, timeout, on_timeout, work)
      #   contract
      def initialize(id:, title:, script:, block:, every: nil, bare: false, dispatcher: nil)
        @id = id
        @title = title
        @script = script
        @script_name = script.respond_to?(:name) ? script.name.to_s : 'lich'
        @owner_id = script.object_id
        @block = block
        @every = every&.to_f
        @bare = !!bare
        @dispatcher = dispatcher || DEFAULT_DISPATCHER
        @state = PageState.new
        @callbacks = {}
        @subscribers = []
        @mutex = Mutex.new
        @rendering = false
        @dirty = false
        @seq = 0
        @last_render_json = nil
        @closed = false
        @poll_thread = nil
      end

      # @return [Hash] descriptor for the hello/pages envelopes
      def descriptor
        { id: @id, title: @title, script: @script_name }
      end

      # Adds a browser connection and immediately sends the current tree
      # (or triggers a first render when none exists yet).
      #
      # @param connection [Server::Connection]
      # @return [void]
      def subscribe(connection)
        @mutex.synchronize { @subscribers << connection unless @subscribers.include?(connection) }
        cached = @mutex.synchronize { @last_render_json }
        if cached
          connection.send_text(cached)
        else
          request_render
        end
        ensure_polling
      end

      # @param connection [Server::Connection]
      # @return [void]
      def unsubscribe(connection)
        @mutex.synchronize { @subscribers.delete(connection) }
      end

      # Routes one browser event to its component callback in the owning
      # script's context, then re-renders. Events for component ids not in
      # the current tree generation are dropped silently (stale clicks
      # racing a re-render).
      #
      # @param cid [String]
      # @param value [Object] parsed JSON value from the browser
      # @return [void]
      def handle_event(cid, value)
        callback = @mutex.synchronize { @callbacks[cid.to_s] }
        return unless callback

        @dispatcher.call(@script, DISPATCH_TIMEOUT, method(:dispatch_timed_out), proc {
          begin
            callback.arity.zero? ? callback.call : callback.call(value)
          rescue StandardError => e
            log("error: WebUI callback #{@id}/#{cid}: #{e.class}: #{e.message}")
          end
          request_render
        })
      end

      # Schedules a render pass in the owning script's context. Multiple
      # requests while a render is in flight coalesce into one trailing
      # pass (the dirty flag), so bursty refreshes cannot queue up.
      #
      # @return [void]
      def request_render
        @mutex.synchronize do
          if @rendering
            @dirty = true
            return
          end
          @rendering = true
        end
        @dispatcher.call(@script, DISPATCH_TIMEOUT, method(:render_timed_out), method(:render_loop))
      end

      # Records the browser window's outer geometry, reported by the client
      # for bare pages. Exposed to the script as state[:_window_geometry]
      # ({w:, h:, x:, y:}) so it can persist via Settings and pass size:/
      # position: back to UI.open next launch. No re-render.
      #
      # @param value [Hash]
      # @return [void]
      def record_geometry(value)
        return unless value.is_a?(Hash)

        geometry = {
          w: value[:w].to_i, h: value[:h].to_i,
          x: value[:x].to_i, y: value[:y].to_i
        }
        @state[:_window_geometry] = geometry if geometry[:w].positive? && geometry[:h].positive?
      end

      # Notifies subscribers the page is gone (script exited or page
      # replaced/removed) and drops them.
      #
      # @param reason [String]
      # @return [void]
      def closed(reason)
        broadcast(Protocol.notice(reason, level: 'warn'))
        @mutex.synchronize do
          @subscribers.clear
          @closed = true
        end
      end

      private

      # Starts the every: poller on first subscribe. The thread re-renders
      # on the configured cadence while subscribers exist and exits within
      # one interval of the page closing or emptying out; a fresh subscribe
      # restarts it.
      def ensure_polling
        return unless @every && @every.positive?

        @mutex.synchronize do
          return if @closed
          return if @poll_thread&.alive?

          @poll_thread = Thread.new do
            loop do
              sleep @every
              stop = @mutex.synchronize { @closed || @subscribers.empty? }
              break if stop

              request_render
            end
          end
        end
      end

      # Runs on a thread inside the script's group. Loops while refresh
      # requests arrived during the pass; subsequent passes run inline since
      # we are already in context.
      def render_loop
        loop do
          builder = Builder.new(@state)
          begin
            @block.call(builder)
          rescue StandardError => e
            log("error: WebUI render #{@id}: #{e.class}: #{e.message}")
            builder.text("page error: #{e.class}: #{e.message}")
          end

          json = nil
          @mutex.synchronize do
            @callbacks = builder.callbacks
            @seq += 1
            tree = { t: 'page', title: @title, children: builder.nodes }
            tree[:bare] = true if @bare
            json = Protocol.render(page: @id, seq: @seq, tree: tree)
            @last_render_json = json
          end
          broadcast(json)

          continue = @mutex.synchronize do
            if @dirty
              @dirty = false
              true
            else
              @rendering = false
              false
            end
          end
          break unless continue
        end
      end

      def render_timed_out
        @mutex.synchronize do
          @rendering = false
          @dirty = false
        end
        dispatch_timed_out
      end

      def dispatch_timed_out
        log("warning: WebUI could not reach script #{@script_name} for page #{@id}")
        broadcast(Protocol.notice("script #{@script_name} is not responding; page not updated", level: 'warn'))
      end

      # Sends a payload to every subscriber, pruning connections whose
      # writes fail (closed tabs).
      def broadcast(json)
        subscribers = @mutex.synchronize { @subscribers.dup }
        subscribers.each do |connection|
          @mutex.synchronize { @subscribers.delete(connection) } unless connection.send_text(json)
        end
      end

      def log(message)
        Lich.log(message) if defined?(Lich) && Lich.respond_to?(:log)
      end
    end
  end
end
