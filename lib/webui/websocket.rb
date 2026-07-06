# frozen_string_literal: true

require 'base64'
require 'digest/sha1'

module Lich
  module WebUI
    # Minimal RFC 6455 WebSocket framing and handshake primitives.
    #
    # This module is intentionally pure: every method operates on its
    # arguments (strings or an IO) and returns values without touching any
    # shared state, which keeps the wire format fully unit-testable without
    # sockets or browsers.
    #
    # Scope is limited to what the WebUI server needs: server-side framing
    # (unmasked writes, masked reads), text/close/ping/pong opcodes, and the
    # upgrade accept key. Fragmented messages and extensions are rejected.
    module WebSocket
      # Fixed GUID appended to the client key when computing the accept key,
      # as mandated by RFC 6455 section 4.2.2.
      HANDSHAKE_GUID = '258EAFA5-E914-47DA-95CA-C5AB0DC85B11'

      # Refuse frames larger than this to bound memory use per connection.
      MAX_PAYLOAD_BYTES = 1_048_576

      OPCODE_CONTINUATION = 0x0
      OPCODE_TEXT         = 0x1
      OPCODE_BINARY       = 0x2
      OPCODE_CLOSE        = 0x8
      OPCODE_PING         = 0x9
      OPCODE_PONG         = 0xA

      # Raised when a peer violates the framing rules this module enforces.
      class ProtocolError < StandardError; end

      # A single decoded WebSocket frame.
      Frame = Struct.new(:opcode, :payload) do
        def text?
          opcode == OPCODE_TEXT
        end

        def close?
          opcode == OPCODE_CLOSE
        end

        def ping?
          opcode == OPCODE_PING
        end

        def pong?
          opcode == OPCODE_PONG
        end
      end

      # Computes the Sec-WebSocket-Accept value for an upgrade response.
      #
      # @param client_key [String] the Sec-WebSocket-Key header value
      # @return [String] the base64 accept token
      def self.accept_key(client_key)
        Base64.strict_encode64(Digest::SHA1.digest(client_key.to_s.strip + HANDSHAKE_GUID))
      end

      # Encodes a single unmasked, unfragmented frame for a server->client write.
      #
      # @param payload [String]
      # @param opcode [Integer] one of the OPCODE_* constants
      # @return [String] binary frame bytes
      def self.encode_frame(payload, opcode: OPCODE_TEXT)
        data = payload.to_s.dup.force_encoding(Encoding::BINARY)
        head = [0x80 | (opcode & 0x0F)].pack('C')
        length = data.bytesize
        head << if length < 126
                  [length].pack('C')
                elsif length <= 0xFFFF
                  [126, length].pack('Cn')
                else
                  [127, length].pack('CQ>')
                end
        head << data
      end

      # Reads and decodes one frame from an IO, unmasking the payload.
      #
      # Client->server frames MUST be masked per RFC 6455; unmasked or
      # fragmented frames raise {ProtocolError} so the caller can close the
      # connection. Pass require_mask: false to read server->client frames
      # (used by specs and any future in-process client).
      #
      # @param io [IO, #read]
      # @param require_mask [Boolean]
      # @return [Frame, nil] nil when the peer closed the stream
      # @raise [ProtocolError]
      def self.read_frame(io, require_mask: true)
        head = read_exact(io, 2)
        return nil if head.nil?

        byte1, byte2 = head.unpack('CC')
        fin    = (byte1 & 0x80) != 0
        rsv    = byte1 & 0x70
        opcode = byte1 & 0x0F
        masked = (byte2 & 0x80) != 0
        length = byte2 & 0x7F

        raise ProtocolError, 'reserved bits set (extensions unsupported)' unless rsv.zero?
        raise ProtocolError, 'fragmented frames unsupported' if !fin || opcode == OPCODE_CONTINUATION
        raise ProtocolError, 'client frames must be masked' if require_mask && !masked

        if length == 126
          length = read_exact!(io, 2).unpack1('n')
        elsif length == 127
          length = read_exact!(io, 8).unpack1('Q>')
        end
        raise ProtocolError, "frame too large (#{length} bytes)" if length > MAX_PAYLOAD_BYTES

        if masked
          mask_key = read_exact!(io, 4)
          payload = length.zero? ? +'' : read_exact!(io, length)
          Frame.new(opcode, unmask(payload, mask_key))
        else
          payload = length.zero? ? +'' : read_exact!(io, length)
          Frame.new(opcode, payload)
        end
      end

      # Applies (or removes) an XOR mask; masking is symmetric.
      #
      # @param payload [String]
      # @param mask_key [String] 4 mask bytes
      # @return [String]
      def self.unmask(payload, mask_key)
        mask = mask_key.bytes
        payload.bytes.each_with_index.map { |byte, i| byte ^ mask[i % 4] }.pack('C*')
      end

      # Encodes a masked client->server frame. The server never sends masked
      # frames; this exists so specs (and any future in-process client) can
      # produce RFC-compliant client traffic.
      #
      # @param payload [String]
      # @param opcode [Integer]
      # @param mask_key [String] exactly 4 bytes
      # @return [String]
      def self.encode_client_frame(payload, opcode: OPCODE_TEXT, mask_key: [rand(256), rand(256), rand(256), rand(256)].pack('C*'))
        raise ArgumentError, 'mask_key must be 4 bytes' unless mask_key.bytesize == 4

        data = payload.to_s.dup.force_encoding(Encoding::BINARY)
        head = [0x80 | (opcode & 0x0F)].pack('C')
        length = data.bytesize
        head << if length < 126
                  [0x80 | length].pack('C')
                elsif length <= 0xFFFF
                  [0x80 | 126, length].pack('Cn')
                else
                  [0x80 | 127, length].pack('CQ>')
                end
        head << mask_key << unmask(data, mask_key)
      end

      # Reads exactly +count+ bytes, tolerating short reads.
      #
      # @param io [IO, #read]
      # @param count [Integer]
      # @return [String, nil] nil on EOF before any byte arrives
      def self.read_exact(io, count)
        buffer = +''
        while buffer.bytesize < count
          chunk = io.read(count - buffer.bytesize)
          return buffer.empty? ? nil : raise(ProtocolError, 'stream ended mid-frame') if chunk.nil? || chunk.empty?

          buffer << chunk
        end
        buffer
      end
      private_class_method :read_exact

      # As {read_exact} but EOF anywhere is a protocol error (used once the
      # frame header has committed us to reading a full frame).
      def self.read_exact!(io, count)
        read_exact(io, count) or raise(ProtocolError, 'stream ended mid-frame')
      end
      private_class_method :read_exact!
    end
  end
end
