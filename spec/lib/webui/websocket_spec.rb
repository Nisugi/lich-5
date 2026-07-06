# frozen_string_literal: true

require 'stringio'

require_relative '../../spec_helper'
require_relative '../../../lib/webui/websocket'

RSpec.describe Lich::WebUI::WebSocket do
  describe '.accept_key' do
    it 'matches the RFC 6455 worked example' do
      # RFC 6455 section 1.3 handshake example
      expect(described_class.accept_key('dGhlIHNhbXBsZSBub25jZQ==')).to eq('s3pPLMBiTxaQ9kYGzzhZRbK+xOo=')
    end
  end

  describe 'frame round trips' do
    def round_trip(payload, opcode: described_class::OPCODE_TEXT)
      bytes = described_class.encode_client_frame(payload, opcode: opcode, mask_key: "\x01\x02\x03\x04")
      described_class.read_frame(StringIO.new(bytes))
    end

    it 'round-trips a small masked text frame' do
      frame = round_trip('{"type":"subscribe"}')
      expect(frame).to be_text
      expect(frame.payload).to eq('{"type":"subscribe"}')
    end

    it 'round-trips a payload requiring the 2-byte extended length' do
      payload = 'x' * 1_000
      frame = round_trip(payload)
      expect(frame.payload.bytesize).to eq(1_000)
      expect(frame.payload).to eq(payload)
    end

    it 'round-trips a payload requiring the 8-byte extended length' do
      payload = 'y' * 70_000
      frame = round_trip(payload)
      expect(frame.payload.bytesize).to eq(70_000)
    end

    it 'round-trips close, ping, and pong opcodes' do
      expect(round_trip('', opcode: described_class::OPCODE_CLOSE)).to be_close
      expect(round_trip('hb', opcode: described_class::OPCODE_PING)).to be_ping
      expect(round_trip('hb', opcode: described_class::OPCODE_PONG)).to be_pong
    end

    it 'reads unmasked server frames when require_mask is false' do
      bytes = described_class.encode_frame('hello browser')
      frame = described_class.read_frame(StringIO.new(bytes), require_mask: false)
      expect(frame.payload).to eq('hello browser')
    end
  end

  describe 'server frame encoding' do
    it 'emits FIN + opcode and the raw length for small payloads' do
      bytes = described_class.encode_frame('abc')
      expect(bytes.bytes[0]).to eq(0x81) # FIN | text
      expect(bytes.bytes[1]).to eq(3)    # unmasked, length 3
      expect(bytes.byteslice(2, 3)).to eq('abc')
    end
  end

  describe 'protocol violations' do
    it 'rejects unmasked client frames' do
      bytes = described_class.encode_frame('sneaky') # unmasked
      expect { described_class.read_frame(StringIO.new(bytes)) }
        .to raise_error(described_class::ProtocolError, /masked/)
    end

    it 'rejects fragmented frames' do
      bytes = described_class.encode_client_frame('frag', mask_key: 'abcd')
      bytes.setbyte(0, bytes.bytes[0] & 0x7F) # clear FIN
      expect { described_class.read_frame(StringIO.new(bytes)) }
        .to raise_error(described_class::ProtocolError, /fragmented/)
    end

    it 'rejects frames larger than MAX_PAYLOAD_BYTES' do
      oversize = described_class::MAX_PAYLOAD_BYTES + 1
      header = [0x81, 0x80 | 127, oversize].pack('CCQ>')
      expect { described_class.read_frame(StringIO.new(header + 'abcd')) }
        .to raise_error(described_class::ProtocolError, /too large/)
    end

    it 'rejects frames with reserved bits set' do
      bytes = described_class.encode_client_frame('rsv', mask_key: 'abcd')
      bytes.setbyte(0, bytes.bytes[0] | 0x40)
      expect { described_class.read_frame(StringIO.new(bytes)) }
        .to raise_error(described_class::ProtocolError, /reserved/)
    end

    it 'raises when the stream ends mid-frame' do
      bytes = described_class.encode_client_frame('truncated payload', mask_key: 'abcd')
      expect { described_class.read_frame(StringIO.new(bytes.byteslice(0, 8))) }
        .to raise_error(described_class::ProtocolError, /mid-frame/)
    end

    it 'returns nil at a clean end of stream' do
      expect(described_class.read_frame(StringIO.new(''))).to be_nil
    end
  end
end
