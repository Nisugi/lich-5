# frozen_string_literal: true

require 'json'

require_relative '../../spec_helper'
require_relative '../../../lib/webui/webui'

RSpec.describe Lich::WebUI::Bridge do
  let(:fake_script) { Struct.new(:name).new('demo') }
  let(:inline_dispatcher) { ->(_s, _t, _o, work) { work.call } }
  let(:sent) { [] }

  before do
    described_class.sender = ->(xml) { sent << xml }
  end

  after do
    described_class.attached.each { |id| described_class.detach(id) }
    described_class.sender = nil
    Lich::WebUI::Registry.clear!
  end

  def register_page(&block)
    page = Lich::WebUI::Page.new(
      id: 'demo/hunt', title: 'Hunt', script: fake_script,
      block: block, dispatcher: inline_dispatcher
    )
    Lich::WebUI::Registry.register(page)
  end

  it 'opens a dialog, renders the reduced widget set, and routes clicks back' do
    clicks = 0
    register_page do |ui|
      ui.header 'Hunt Panel'
      ui.text "kills: #{clicks}"
      ui.progress(0.42, label: 'health')
      ui.button('Attack', key: :attack) { clicks += 1 }
      ui.checkbox('Loot', checked: clicks.odd?, key: :loot) { |_v| nil }
    end

    expect(described_class.attach('demo/hunt')).to be(true)
    expect(sent.first).to include("<openDialog type='dynamic' id='webui_demo_hunt' title='Hunt'")

    dialog = sent.last
    expect(dialog).to include("<dialogData id='webui_demo_hunt' clear='t'>")
    expect(dialog).to include("value='HUNT PANEL'")
    expect(dialog).to include("value='kills: 0'")
    expect(dialog).to include("<progressBar id='r32' value='42' text='health'")
    expect(dialog).to include("value='[Attack]'")
    expect(dialog).to include("cmd='_webui-bridge demo/hunt|button:attack|nil'")
    expect(dialog).to include("value='[ ] Loot'")
    expect(dialog).to include("cmd='_webui-bridge demo/hunt|checkbox:loot|true'")

    # a click comes back from the FE as a swallowed upstream command
    result = described_class.handle_command('<c>_webui-bridge demo/hunt|button:attack|nil')
    expect(result).to be_nil
    expect(clicks).to eq(1)
    expect(sent.last).to include("value='kills: 1'")
    expect(sent.last).to include("value='[x] Loot'") # checkbox reflects state

    expect(described_class.handle_command('<c>look')).to eq('<c>look') # passthrough
  end

  it 'cycles selects, previews tables and logs, and counts browser-only widgets' do
    picked = nil
    register_page do |ui|
      ui.select('Stance', options: %w[offensive guarded defensive], value: picked || 'offensive', key: :stance) { |v| picked = v }
      ui.table([%w[a 1], %w[b 2]], headings: %w[Name N])
      ui.log(%w[one two three])
      ui.text_input('Name') { |_v| nil } # browser-only
      ui.image('/files/maps/x.png')      # browser-only
    end

    described_class.attach('demo/hunt')
    dialog = sent.last
    expect(dialog).to include('Stance: offensive')
    expect(dialog).to include("cmd='_webui-bridge demo/hunt|select:stance|guarded'")
    expect(dialog).to include("value='Name  N'")
    expect(dialog).to include("value='a  1'")
    expect(dialog).to include("value='three'")
    expect(dialog).to include('(2 browser-only widgets not shown)')

    described_class.handle_command('_webui-bridge demo/hunt|select:stance|guarded')
    expect(picked).to eq('guarded')
    expect(sent.last).to include('Stance: guarded')
    expect(sent.last).to include("|select:stance|defensive'") # cycle advanced
  end

  it 'caps giant pages with an overflow note' do
    register_page do |ui|
      60.times { |i| ui.text "line #{i}" }
    end
    described_class.attach('demo/hunt')
    dialog = sent.last
    expect(dialog).to include('more in the browser')
    expect(dialog.scan(/<label /).length).to be <= described_class::MAX_ROWS
  end

  it 'closes the dialog on detach and on page removal' do
    register_page { |ui| ui.text 'x' }
    described_class.attach('demo/hunt')
    expect(described_class.attached).to eq(['demo/hunt'])

    described_class.detach('demo/hunt')
    expect(sent.last).to eq("<closeDialog id='webui_demo_hunt'/>")
    expect(described_class.attached).to be_empty
    expect(described_class.detach('demo/hunt')).to be(false)

    # page removal path (script killed): notify_page_close closes the dialog
    described_class.attach('demo/hunt')
    Lich::WebUI::Registry.remove('demo/hunt')
    expect(sent.last).to eq("<closeDialog id='webui_demo_hunt'/>")
    expect(described_class.attached).to be_empty
  end

  it 'escapes XML-hostile script strings' do
    register_page { |ui| ui.text %(<b>&"squeal'</b>) }
    described_class.attach('demo/hunt')
    expect(sent.last).to include('&lt;b&gt;&amp;&quot;squeal&apos;&lt;/b&gt;')
    expect(sent.last).not_to include('<b>')
  end

  it 'returns false for unknown pages' do
    expect(described_class.attach('nope/nothing')).to be(false)
  end
end
