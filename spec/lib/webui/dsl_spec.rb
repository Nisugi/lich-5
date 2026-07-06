# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/webui/page'

RSpec.describe Lich::WebUI::Builder do
  let(:state) { Lich::WebUI::PageState.new }
  let(:builder) { described_class.new(state) }

  it 'assigns positional component ids in emission order' do
    builder.header 'Title'
    builder.text 'hello'
    builder.button('Go') { :clicked }
    expect(builder.nodes.map { |node| node[:cid] }).to eq(['header:0', 'text:1', 'button:2'])
  end

  it 'lets key: pin an id across conditional layouts' do
    builder.text 'always'
    builder.button('Start', key: :start) { :started }
    node = builder.nodes.last
    expect(node[:cid]).to eq('button:start')
    expect(builder.callbacks).to have_key('button:start')
  end

  it 'captures callbacks only for components given a block' do
    builder.button('NoOp')
    builder.button('Op') { :op }
    expect(builder.callbacks.keys).to eq(['button:1'])
  end

  it 'emits the documented node shapes' do
    builder.markdown '**bold**'
    builder.divider
    builder.text_input('Target', value: 'rat', placeholder: 'creature') { |v| v }
    builder.select('Stance', options: [:offensive, :defensive], value: 'defensive') { |v| v }
    builder.checkbox('Loot', checked: true) { |v| v }
    builder.slider('Retreat', min: 10, max: 90, value: 40) { |v| v }
    builder.progress(0.5, label: 'HP')
    builder.table([[1, 'rat']], headings: ['#', 'Name'])

    nodes = builder.nodes
    expect(nodes[0]).to eq(t: 'markdown', cid: 'markdown:0', text: '**bold**')
    expect(nodes[1]).to eq(t: 'divider', cid: 'divider:1')
    expect(nodes[2]).to include(t: 'text_input', label: 'Target', value: 'rat', placeholder: 'creature')
    expect(nodes[3]).to include(t: 'select', options: %w[offensive defensive], value: 'defensive')
    expect(nodes[4]).to include(t: 'checkbox', checked: true)
    expect(nodes[5]).to include(t: 'slider', min: 10, max: 90, step: 1, value: 40)
    expect(nodes[6]).to include(t: 'progress', value: 0.5, label: 'HP')
    expect(nodes[7]).to eq(t: 'table', cid: 'table:7', headings: ['#', 'Name'], rows: [%w[1 rat]])
  end

  it 'clamps progress into 0..1 and stringifies table cells' do
    builder.progress(3.7)
    builder.table([[nil, 42]])
    expect(builder.nodes[0][:value]).to eq(1.0)
    expect(builder.nodes[1][:rows]).to eq([['', '42']])
  end

  it 'exposes the page state to the block' do
    state[:kills] = 7
    expect(builder.state[:kills]).to eq(7)
  end
end
