# frozen_string_literal: true

require 'json'
require 'timeout'

require_relative '../../spec_helper'
require_relative '../../../lib/webui/page'

RSpec.describe Lich::WebUI::Page do
  # Records everything sent; can be flipped dead to exercise pruning.
  let(:fake_connection_class) do
    Class.new do
      attr_reader :sent

      def initialize
        @sent = []
        @alive = true
      end

      def send_text(payload)
        return false unless @alive

        @sent << payload
        true
      end

      def kill!
        @alive = false
      end

      def renders
        @sent.map { |raw| JSON.parse(raw, symbolize_names: true) }.select { |m| m[:type] == 'render' }
      end

      def notices
        @sent.map { |raw| JSON.parse(raw, symbolize_names: true) }.select { |m| m[:type] == 'notice' }
      end
    end
  end

  let(:fake_script) { Struct.new(:name).new('demo') }
  let(:inline_dispatcher) { ->(_script, _timeout, _on_timeout, work) { work.call } }
  let(:connection) { fake_connection_class.new }

  def build_page(dispatcher: inline_dispatcher, &block)
    described_class.new(
      id: 'demo/hunt',
      title: 'Hunt',
      script: fake_script,
      block: block,
      dispatcher: dispatcher
    )
  end

  it 'renders on first subscribe and reuses the cached tree for later subscribers' do
    renders = 0
    page = build_page do |ui|
      renders += 1
      ui.text "pass #{renders}"
    end

    page.subscribe(connection)
    expect(renders).to eq(1)
    expect(connection.renders.first[:tree][:children].first[:text]).to eq('pass 1')

    second = fake_connection_class.new
    page.subscribe(second)
    expect(renders).to eq(1) # cached tree, no re-render
    expect(second.renders.first[:seq]).to eq(1)
  end

  it 'dispatches events to the current generation callback and re-renders' do
    page = build_page do |ui|
      ui.button('Bump') { ui.state[:count] = (ui.state[:count] || 0) + 1 }
      ui.text "count: #{ui.state[:count] || 0}"
    end
    page.subscribe(connection)

    page.handle_event('button:0', nil)
    expect(page.state[:count]).to eq(1)
    expect(connection.renders.last[:tree][:children].last[:text]).to eq('count: 1')
    expect(connection.renders.last[:seq]).to eq(2)
  end

  it 'passes the event value to callbacks that accept one' do
    received = nil
    page = build_page do |ui|
      ui.text_input('Target') { |value| received = value }
    end
    page.subscribe(connection)

    page.handle_event('text_input:0', 'kobold')
    expect(received).to eq('kobold')
  end

  it 'drops events for stale component ids without dispatching' do
    dispatched = 0
    spy = ->(_s, _t, _o, work) { dispatched += 1; work.call }
    page = build_page(dispatcher: spy) { |ui| ui.text 'no controls' }
    page.subscribe(connection)
    baseline = dispatched

    page.handle_event('button:99', nil)
    expect(dispatched).to eq(baseline)
  end

  it 'coalesces refresh requests that arrive mid-render into one trailing pass' do
    passes = 0
    page = nil
    page = build_page do |ui|
      passes += 1
      if passes == 1
        # simulate a game event requesting a refresh while rendering
        page.request_render
        page.request_render
      end
      ui.text "pass #{passes}"
    end

    page.subscribe(connection)
    expect(passes).to eq(2) # burst of 2 requests -> exactly one trailing pass
    expect(connection.renders.last[:seq]).to eq(2)
  end

  it 'renders an error node when the page block raises' do
    page = build_page { |_ui| raise 'boom' }
    page.subscribe(connection)
    text = connection.renders.first[:tree][:children].first[:text]
    expect(text).to include('page error')
    expect(text).to include('boom')
  end

  it 'notifies subscribers and resets render state when dispatch times out' do
    timeout_dispatcher = ->(_s, _t, on_timeout, _work) { on_timeout.call }
    page = build_page(dispatcher: timeout_dispatcher) { |ui| ui.text 'never' }
    page.subscribe(connection)

    expect(connection.notices.first[:text]).to include('not responding')

    # rendering flag was reset: a later request dispatches again
    notices_before = connection.notices.length
    page.request_render
    expect(connection.notices.length).to eq(notices_before + 1)
  end

  it 'prunes subscribers whose sends fail' do
    page = build_page { |ui| ui.text 'x' }
    page.subscribe(connection)
    connection.kill!
    page.request_render

    survivor = fake_connection_class.new
    page.subscribe(survivor)
    sent_before = connection.sent.length
    page.request_render
    expect(connection.sent.length).to eq(sent_before) # dead conn no longer receives
    expect(survivor.renders).not_to be_empty
  end

  it 'announces closure and drops subscribers' do
    page = build_page { |ui| ui.text 'x' }
    page.subscribe(connection)
    page.closed('script demo exited')

    expect(connection.notices.last[:text]).to eq('script demo exited')
    sent_before = connection.sent.length
    page.request_render
    expect(connection.sent.length).to eq(sent_before)
  end

  describe Lich::WebUI::PageState do
    it 'behaves as a small thread-safe hash' do
      state = described_class.new
      state[:a] = 1
      state.update(b: 2)
      expect(state[:a]).to eq(1)
      expect(state.fetch(:missing, 'default')).to eq('default')
      expect(state.key?(:b)).to be(true)
      expect(state.to_h).to eq(a: 1, b: 2)
      state.delete(:a)
      state.clear
      expect(state.to_h).to eq({})
    end
  end

  describe 'DEFAULT_DISPATCHER' do
    it 'runs work inline when the current thread already belongs to the script' do
      script = Struct.new(:name) do
        def has_thread?(_thread)
          true
        end
      end.new('demo')

      ran_on = nil
      described_class::DEFAULT_DISPATCHER.call(script, 1, nil, -> { ran_on = Thread.current })
      expect(ran_on).to eq(Thread.current)
    end

    it 'runs work on a thread added to the script thread group' do
      group = ThreadGroup.new
      script = Struct.new(:name, :thread_group) do
        def has_thread?(thread)
          thread_group.list.include?(thread)
        end
      end.new('demo', group)

      done = Queue.new
      described_class::DEFAULT_DISPATCHER.call(script, 2, nil, -> { done << Thread.current })
      worker = Timeout.timeout(2) { done.pop }
      expect(worker).not_to eq(Thread.current)
    end

    it 'calls on_timeout when the script context is unreachable' do
      script = Struct.new(:name, :thread_group) do
        def has_thread?(_thread)
          false # membership never resolves
        end
      end.new('demo', ThreadGroup.new)

      timed_out = Queue.new
      described_class::DEFAULT_DISPATCHER.call(script, 0.1, -> { timed_out << true }, -> { raise 'must not run' })
      expect(Timeout.timeout(2) { timed_out.pop }).to be(true)
    end
  end
end
