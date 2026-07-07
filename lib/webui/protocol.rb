# frozen_string_literal: true

require 'json'

module Lich
  module WebUI
    # Message envelopes and small pure helpers shared by the WebUI server and
    # (in later milestones) the page/registry layer.
    #
    # All server->browser and browser->server WebSocket payloads are JSON
    # objects with a +type+ field. Building and parsing them lives here so the
    # wire format has a single owner and can be tested without sockets.
    module Protocol
      # Bumped whenever the component tree or envelope shapes change in a way
      # the browser bundle must know about.
      SCHEMA_VERSION = 1

      # Browser->server message types the server accepts.
      CLIENT_MESSAGE_TYPES = %w[subscribe unsubscribe event geometry].freeze

      # Builds the first message sent on every accepted WebSocket connection.
      #
      # @param session [Hash] +{name:, game:}+ for the current Lich session
      # @param pages [Array<Hash>] registered page descriptors
      # @param siblings [Array<Hash>] other local Lich sessions' WebUI endpoints
      # @return [String] JSON
      def self.hello(session:, pages: [], siblings: [])
        JSON.generate(
          type: 'hello',
          schema_version: SCHEMA_VERSION,
          session: session,
          pages: pages,
          siblings: siblings
        )
      end

      # Builds the page-list update broadcast when pages register/unregister.
      #
      # @param pages [Array<Hash>]
      # @return [String] JSON
      def self.pages(pages)
        JSON.generate(type: 'pages', pages: pages)
      end

      # Builds a render push for one page's full component tree.
      #
      # @param page [String] page id ("script/page")
      # @param seq [Integer] monotonically increasing per-page render sequence
      # @param tree [Hash] the component tree
      # @return [String] JSON
      def self.render(page:, seq:, tree:)
        JSON.generate(type: 'render', page: page, seq: seq, tree: tree)
      end

      # Tells any browser showing +page+ that it is finished; bare app
      # windows respond by closing themselves (the login window after Play).
      #
      # @param page [String] page id ("script/page")
      # @return [String] JSON
      def self.close(page)
        JSON.generate(type: 'close', page: page)
      end

      # Builds a user-facing notice (script exited, dispatch timed out, ...).
      #
      # @param text [String]
      # @param level [String] "info" | "warn" | "error"
      # @return [String] JSON
      def self.notice(text, level: 'info')
        JSON.generate(type: 'notice', level: level, text: text)
      end

      # Parses one browser->server message, returning nil for anything that is
      # not a well-formed known message (the server drops those silently).
      #
      # @param raw [String]
      # @return [Hash, nil] symbolized message hash with :type as a String
      def self.parse_client_message(raw)
        message = JSON.parse(raw.to_s, symbolize_names: true)
        return nil unless message.is_a?(Hash)
        return nil unless CLIENT_MESSAGE_TYPES.include?(message[:type])

        message
      rescue JSON::ParserError
        nil
      end

      # Constant-time string comparison for auth tokens.
      #
      # Rejects immediately on length mismatch (length is not secret here -
      # the token is always 64 hex chars), then XOR-folds every byte so timing
      # does not reveal how many leading characters matched.
      #
      # @param expected [String]
      # @param actual [String, nil]
      # @return [Boolean]
      def self.secure_compare(expected, actual)
        expected = expected.to_s
        actual = actual.to_s
        return false unless expected.bytesize == actual.bytesize

        result = 0
        expected.bytes.zip(actual.bytes) { |a, b| result |= a ^ b }
        result.zero?
      end
    end
  end
end
