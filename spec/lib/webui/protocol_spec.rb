# frozen_string_literal: true

require 'json'

require_relative '../../spec_helper'
require_relative '../../../lib/webui/protocol'

RSpec.describe Lich::WebUI::Protocol do
  describe 'server envelopes' do
    it 'builds a hello with schema version, session, pages, and siblings' do
      json = described_class.hello(
        session: { name: 'Nisugi', game: 'GSIV' },
        pages: [{ id: 'demo/hunt', title: 'Hunt', script: 'demo' }],
        siblings: [{ name: 'Alt', game: 'GSIV', port: 51_423 }]
      )
      message = JSON.parse(json, symbolize_names: true)
      expect(message[:type]).to eq('hello')
      expect(message[:schema_version]).to eq(described_class::SCHEMA_VERSION)
      expect(message[:session]).to eq(name: 'Nisugi', game: 'GSIV')
      expect(message[:pages].first[:id]).to eq('demo/hunt')
      expect(message[:siblings].first[:port]).to eq(51_423)
    end

    it 'builds pages, render, and notice envelopes' do
      expect(JSON.parse(described_class.pages([]), symbolize_names: true)).to eq(type: 'pages', pages: [])

      render = JSON.parse(described_class.render(page: 'demo/hunt', seq: 3, tree: { t: 'page' }), symbolize_names: true)
      expect(render).to eq(type: 'render', page: 'demo/hunt', seq: 3, tree: { t: 'page' })

      notice = JSON.parse(described_class.notice('script exited', level: 'warn'), symbolize_names: true)
      expect(notice).to eq(type: 'notice', level: 'warn', text: 'script exited')
    end

    it 'builds close and notify envelopes' do
      expect(JSON.parse(described_class.close('map/map'), symbolize_names: true)).to eq(type: 'close', page: 'map/map')

      notify = JSON.parse(described_class.notify_user('favor complete', title: 'Nisugi'), symbolize_names: true)
      expect(notify).to eq(type: 'notify', title: 'Nisugi', text: 'favor complete')
    end
  end

  describe '.parse_client_message' do
    it 'parses known message types' do
      message = described_class.parse_client_message('{"type":"subscribe","page":"demo/hunt"}')
      expect(message).to eq(type: 'subscribe', page: 'demo/hunt')
    end

    it 'returns nil for unknown types, malformed JSON, and non-objects' do
      expect(described_class.parse_client_message('{"type":"evil"}')).to be_nil
      expect(described_class.parse_client_message('{not json')).to be_nil
      expect(described_class.parse_client_message('"just a string"')).to be_nil
      expect(described_class.parse_client_message(nil)).to be_nil
    end
  end

  describe '.secure_compare' do
    it 'accepts equal strings and rejects unequal or missing values' do
      expect(described_class.secure_compare('abc123', 'abc123')).to be(true)
      expect(described_class.secure_compare('abc123', 'abc124')).to be(false)
      expect(described_class.secure_compare('abc123', 'abc12')).to be(false)
      expect(described_class.secure_compare('abc123', nil)).to be(false)
      expect(described_class.secure_compare('abc123', '')).to be(false)
    end
  end
end
