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

  it 'supports sortable, clickable tables with selection and a row callback' do
    received = nil
    builder.table([%w[a 1], %w[b 2]], headings: %w[Name N], sortable: true, selected: 1) { |index| received = index }
    node = builder.nodes.last
    expect(node[:sortable]).to be(true)
    expect(node[:clickable]).to be(true)
    expect(node[:selected]).to eq(1)
    builder.callbacks.fetch(node[:cid]).call(0)
    expect(received).to eq(0)

    builder.table([['plain']])
    expect(builder.nodes.last.keys).not_to include(:sortable, :clickable, :selected)
  end

  it 'never carries a value on password inputs' do
    builder.password_input('Password', placeholder: 'hunter2') { |v| v }
    node = builder.nodes.last
    expect(node[:t]).to eq('password_input')
    expect(node.keys).not_to include(:value)
    expect(builder.callbacks).to have_key(node[:cid])
  end

  it 'exposes the page state to the block' do
    state[:kills] = 7
    expect(builder.state[:kills]).to eq(7)
  end

  describe 'containers' do
    it 'nests expander children with prefixed cids and hoists their callbacks' do
      builder.text 'before'
      builder.expander('Settings', open: true) do |section|
        section.checkbox('Loot') { |v| v }
        section.text 'inside'
      end

      node = builder.nodes.last
      expect(node[:t]).to eq('expander')
      expect(node[:cid]).to eq('expander:1')
      expect(node[:open]).to be(true)
      expect(node[:children].map { |child| child[:cid] }).to eq(['expander:1.checkbox:0', 'expander:1.text:1'])
      expect(builder.callbacks).to have_key('expander:1.checkbox:0')
    end

    it 'yields one builder per column' do
      builder.columns(2) do |left, right|
        left.text 'L'
        right.button('R') { :r }
      end

      node = builder.nodes.last
      expect(node[:t]).to eq('columns')
      expect(node[:children].length).to eq(2)
      expect(node[:children][0][:children].first[:text]).to eq('L')
      expect(node[:children][1][:children].first[:cid]).to eq('columns:0.c1.button:0')
      expect(builder.callbacks).to have_key('columns:0.c1.button:0')
      expect(node).not_to have_key(:compact)
    end

    it 'marks compact columns for content-sized layout' do
      builder.columns(3, compact: true) { |a, b, c| a.button('U') {}; b.button('D') {}; c.button('X') {} }
      expect(builder.nodes.last[:compact]).to be(true)
    end

    it 'yields one builder per tab with labels' do
      builder.tabs(%w[Loot Stats]) do |loot, stats|
        loot.text 'loot here'
        stats.text 'stats here'
      end

      node = builder.nodes.last
      expect(node[:t]).to eq('tabs')
      expect(node[:children].map { |tab| tab[:label] }).to eq(%w[Loot Stats])
      expect(node[:children][1][:children].first[:text]).to eq('stats here')
      expect(node).not_to have_key(:vertical)
    end

    it 'flags vertical tabs for the sidebar layout' do
      builder.tabs(%w[A B], vertical: true) { |a, b| a.text 'a'; b.text 'b' }
      expect(builder.nodes.last[:vertical]).to be(true)
    end

    it 'accepts http(s), data, and /files sources for images' do
      builder.image('https://example.com/map.png', alt: 'map')
      builder.image('data:image/png;base64,AAAA')
      builder.image('/files/maps/map1.png')
      builder.image('file:///etc/passwd')
      builder.image('C:/secrets.png')

      images = builder.nodes.select { |node| node[:t] == 'image' }
      expect(images.length).to eq(3)
      expect(images.first).to include(src: 'https://example.com/map.png', alt: 'map')
    end

    it 'builds image_map nodes with normalized markers and a click callback' do
      received = nil
      builder.image_map('/files/maps/map1.png', scale: 1.5, scroll_to: 'current',
                        markers: [{ id: :current, x1: 10.9, y1: 20, x2: 30, y2: 40, kind: :current, label: 'You are here' },
                                  { id: 'bank', x1: 1, y1: 2, x2: 3, y2: 4 }]) { |click| received = click }

      node = builder.nodes.last
      expect(node[:t]).to eq('image_map')
      expect(node[:scale]).to eq(1.5)
      expect(node[:scroll_to]).to eq('current')
      expect(node[:markers][0]).to eq(id: 'current', x1: 10, y1: 20, x2: 30, y2: 40, kind: 'current', label: 'You are here')
      expect(node[:markers][1]).to eq(id: 'bank', x1: 1, y1: 2, x2: 3, y2: 4, kind: 'marker')

      builder.callbacks.fetch(node[:cid]).call(x: 5, y: 6, marker: nil)
      expect(received).to eq(x: 5, y: 6, marker: nil)

      builder.image_map('C:/secrets.png') { |c| c }
      expect(builder.nodes.last[:t]).to eq('image_map') # unchanged - rejected source emits nothing
      expect(builder.nodes.count { |n| n[:t] == 'image_map' }).to eq(1)
    end

    it 'carries popup wiring on image_map' do
      builder.image_map('/files/maps/a.png', popup: 'map/settings', popup_size: [430, 460]) { |c| c }
      node = builder.nodes.last
      expect(node[:popup]).to eq('map/settings')
      expect(node[:popup_size]).to eq([430, 460])
    end
  end
end
