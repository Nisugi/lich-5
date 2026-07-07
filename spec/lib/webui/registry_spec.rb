# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/webui/webui'

RSpec.describe Lich::WebUI::Registry do
  let(:script_a) { Struct.new(:name).new('scripta') }
  let(:script_b) { Struct.new(:name).new('scriptb') }
  let(:inline_dispatcher) { ->(_s, _t, _o, work) { work.call } }

  def build_page(id, script)
    Lich::WebUI::Page.new(
      id: id,
      title: id,
      script: script,
      block: proc { |ui| ui.text 'x' },
      dispatcher: inline_dispatcher
    )
  end

  after do
    described_class.clear!
  end

  it 'registers, finds, and snapshots pages' do
    page = described_class.register(build_page('scripta/main', script_a))
    expect(described_class.find('scripta/main')).to be(page)
    expect(described_class.pages_snapshot).to eq([{ id: 'scripta/main', title: 'scripta/main', script: 'scripta' }])
  end

  it 'replacing a page closes the old registration' do
    old_page = described_class.register(build_page('scripta/main', script_a))
    expect(old_page).to receive(:closed).with(/re-registered/)
    described_class.register(build_page('scripta/main', script_a))
  end

  it 'removes pages and notifies them' do
    page = described_class.register(build_page('scripta/main', script_a))
    expect(page).to receive(:closed).with(/removed/)
    expect(described_class.remove('scripta/main')).to be(page)
    expect(described_class.find('scripta/main')).to be_nil
  end

  it 'cleans up only the dying script pages' do
    page_a1 = described_class.register(build_page('scripta/one', script_a))
    page_a2 = described_class.register(build_page('scripta/two', script_a))
    page_b = described_class.register(build_page('scriptb/one', script_b))

    expect(page_a1).to receive(:closed).with(/exited/)
    expect(page_a2).to receive(:closed).with(/exited/)
    expect(page_b).not_to receive(:closed)

    described_class.cleanup_for(script_a)
    expect(described_class.pages_snapshot.map { |d| d[:id] }).to eq(['scriptb/one'])
  end

  it 'announces page-list changes to connected browsers' do
    expect(Lich::WebUI).to receive(:notify_pages_changed).twice
    described_class.register(build_page('scripta/main', script_a))
    described_class.remove('scripta/main')
  end

  it 'tells windows to close on remove and script death, but never on replace' do
    allow(Lich::WebUI).to receive(:notify_pages_changed)
    allow(Lich::WebUI).to receive(:notify_page_close)

    described_class.register(build_page('scripta/main', script_a))
    described_class.register(build_page('scripta/main', script_a)) # replace
    expect(Lich::WebUI).not_to have_received(:notify_page_close)

    described_class.remove('scripta/main')
    expect(Lich::WebUI).to have_received(:notify_page_close).with('scripta/main').once

    described_class.register(build_page('scripta/one', script_a))
    described_class.register(build_page('scripta/two', script_a))
    described_class.cleanup_for(script_a)
    expect(Lich::WebUI).to have_received(:notify_page_close).with('scripta/one').once
    expect(Lich::WebUI).to have_received(:notify_page_close).with('scripta/two').once
  end
end
