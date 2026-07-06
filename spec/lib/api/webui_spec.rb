# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/webui/webui'
require_relative '../../../lib/api/webui'

RSpec.describe UI do
  let(:fake_script) { Struct.new(:name).new('huntbuddy') }

  after do
    Lich::WebUI::Registry.clear!
    Script.current = nil
  end

  context 'when the feature is disabled' do
    before do
      allow(Lich::WebUI).to receive(:enabled?).and_return(false)
    end

    it 'is inert without raising' do
      expect(described_class.available?).to be(false)
      expect(described_class.page('hunt') { |ui| ui.text 'x' }).to be_nil
      expect(described_class.state('hunt')).to be_nil
      expect(described_class.refresh('hunt')).to be_nil
      expect(described_class.remove('hunt')).to be_nil
    end
  end

  context 'when the feature is enabled' do
    before do
      allow(Lich::WebUI).to receive(:enabled?).and_return(true)
      allow(Lich::WebUI).to receive(:ensure_service!).and_return(true)
      Script.current = fake_script
    end

    it 'registers a page namespaced to the calling script' do
      page = described_class.page('hunt', title: 'Hunt Panel') { |ui| ui.text 'x' }
      expect(page).to be_a(Lich::WebUI::Page)
      expect(page.id).to eq('huntbuddy/hunt')
      expect(page.title).to eq('Hunt Panel')
      expect(Lich::WebUI::Registry.find('huntbuddy/hunt')).to be(page)
    end

    it 'requires a block' do
      expect { described_class.page('hunt') }.to raise_error(ArgumentError, /block/)
    end

    it 'returns nil when called outside a script context' do
      Script.current = nil
      expect(described_class.page('hunt') { |ui| ui.text 'x' }).to be_nil
    end

    it 'resolves state and refresh against the calling script' do
      page = described_class.page('hunt') { |ui| ui.text 'x' }
      described_class.state('hunt')[:kills] = 3
      expect(page.state[:kills]).to eq(3)

      expect(page).to receive(:request_render)
      described_class.refresh('hunt')
    end

    it 'resolves full script/page ids from any context' do
      page = described_class.page('hunt') { |ui| ui.text 'x' }
      Script.current = nil
      expect(described_class.state('huntbuddy/hunt')).to be(page.state)
    end

    it 'removes pages' do
      described_class.page('hunt') { |ui| ui.text 'x' }
      described_class.remove('hunt')
      expect(Lich::WebUI::Registry.find('huntbuddy/hunt')).to be_nil
    end
  end
end
