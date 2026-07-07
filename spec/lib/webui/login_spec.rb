# frozen_string_literal: true

require 'timeout'
require 'tmpdir'

require_relative '../../spec_helper'
require_relative '../../../lib/common/feature_flags'
require_relative '../../../lib/webui/login'

RSpec.describe Lich::WebUI::Login do
  after do
    Lich::WebUI::Registry.clear!
    Lich::WebUI.stop_service!
  end

  describe '.wanted?' do
    it 'follows the flag and CLI overrides' do
      stub_const('ARGV', [])
      allow(Lich::Common::FeatureFlags).to receive(:enabled?).with(described_class::FEATURE_FLAG).and_return(true)
      expect(described_class.wanted?).to be(true)

      allow(Lich::Common::FeatureFlags).to receive(:enabled?).with(described_class::FEATURE_FLAG).and_return(false)
      expect(described_class.wanted?).to be(false)

      stub_const('ARGV', ['--webui-login'])
      expect(described_class.wanted?).to be(true)

      stub_const('ARGV', ['--webui-login', '--gtk-login'])
      expect(described_class.wanted?).to be(false)
    end
  end

  describe '.run' do
    let(:entries) do
      [{ char_name: 'Nisugi', game_code: 'GS3', game_name: 'GS4 Prime',
         username: 'account1', password: 'sekrit', frontend: 'wrayth',
         custom_launch: nil, custom_launch_dir: nil }]
    end

    def run_login(authenticator:, entries_loader: -> { entries })
      allow(Lich::WebUI).to receive(:open_page).and_return(true)
      result = nil
      runner = Thread.new do
        result = described_class.run(
          data_dir: Dir.tmpdir,
          entries_loader: entries_loader,
          authenticator: authenticator,
          launch_preparer: ->(auth, _fe, _cl, _dir) { auth }
        )
      end
      sleep 0.05 until Lich::WebUI::Registry.find('lich/login') || !runner.alive?
      page = Lich::WebUI::Registry.find('lich/login')
      yield page
      Timeout.timeout(5) { runner.join }
      result
    end

    it 'authenticates a saved entry and returns launch data' do
      allow(described_class).to receive(:decrypt_password).and_return('sekrit')
      authenticator = lambda { |account:, password:, character:, game_code:|
        expect([account, password, character, game_code]).to eq(%w[account1 sekrit Nisugi GS3])
        ['GAMECODE=GS3', 'GAMEHOST=host', 'GAMEPORT=1', 'GAME=STORM']
      }

      result = run_login(authenticator: authenticator) do |page|
        fake_conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
        page.subscribe(fake_conn)
        play_cid = fake_conn.sent.last[/"cid":"([^"]*button:play_[^"]+)"/, 1]
        page.handle_event(play_cid, nil)
      end
      expect(result).to eq(['GAMECODE=GS3', 'GAMEHOST=host', 'GAMEPORT=1', 'GAME=STORM'])
    end

    it 'reports auth failures inline and keeps waiting; Quit returns nil' do
      allow(described_class).to receive(:decrypt_password).and_return('sekrit')
      authenticator = ->(**_) { raise 'REJECT' }

      result = run_login(authenticator: authenticator) do |page|
        fake_conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
        page.subscribe(fake_conn)
        play_cid = fake_conn.sent.last[/"cid":"([^"]*button:play_[^"]+)"/, 1]
        page.handle_event(play_cid, nil)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('Login failed') } }
        quit_cid = fake_conn.sent.last[/"cid":"([^"]*button:quit)"/, 1]
        page.handle_event(quit_cid, nil)
      end
      expect(result).to be_nil
    end
  end
end
