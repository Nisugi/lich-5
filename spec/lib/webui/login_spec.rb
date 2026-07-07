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

    def run_login(authenticator:, entries_loader: -> { entries }, session_launcher: nil, launch_preparer: nil)
      allow(Lich::WebUI).to receive(:open_page).and_return(true)
      result = nil
      runner = Thread.new do
        result = described_class.run(
          data_dir: Dir.tmpdir,
          entries_loader: entries_loader,
          authenticator: authenticator,
          launch_preparer: launch_preparer || ->(auth, _fe, _cl, _dir) { auth },
          session_launcher: session_launcher
        )
      end
      sleep 0.05 until Lich::WebUI::Registry.find('lich/login') || !runner.alive?
      page = Lich::WebUI::Registry.find('lich/login')
      yield page
      Timeout.timeout(5) { runner.join }
      result
    end

    it 'authenticates a saved entry and returns launch data' do
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

    it 'Multi-Launch spawns a child session and keeps the launcher open' do
      allow(Lich).to receive(:track_persistent_launcher_mode).and_return(true)
      launched = []
      session_launcher = lambda { |launch_data, launch_context:|
        launched << [launch_data, launch_context]
        { ok: true, pid: 4242 }
      }
      authenticator = ->(**_) { ['GAMECODE=GS3', 'GAMEHOST=host', 'GAMEPORT=1', 'GAME=STORM'] }

      result = run_login(authenticator: authenticator, session_launcher: session_launcher) do |page|
        fake_conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
        page.subscribe(fake_conn)
        play_cid = fake_conn.sent.last[/"cid":"([^"]*button:play_[^"]+)"/, 1]
        page.handle_event(play_cid, nil)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('Launched Nisugi (pid 4242)') } }
        quit_cid = fake_conn.sent.last[/"cid":"([^"]*button:quit)"/, 1]
        page.handle_event(quit_cid, nil)
      end
      expect(result).to be_nil # launcher stayed open until Quit
      expect(launched.length).to eq(1)
      expect(launched.first[0]).to include('GAMECODE=GS3')
      expect(launched.first[1]).to include(char_name: 'Nisugi', game_code: 'GS3', frontend: 'wrayth')
    end

    it 'gates saved entries behind the master password in enhanced mode' do
      allow(described_class).to receive(:entry_meta).and_return({ mode: :enhanced, validation: { 'validation_salt' => 'x' } })
      allow(described_class).to receive(:keychain_master).and_return(nil)
      allow(described_class).to receive(:heal_keychain).and_return(true)
      allow(described_class).to receive(:master_password_valid?) { |entered, _validation| entered == 'open-sesame' }

      loads = 0
      entries_loader = -> { loads += 1; entries }
      authenticator = ->(**_) { raise 'auth should not be reached' }

      result = run_login(authenticator: authenticator, entries_loader: entries_loader) do |page|
        fake_conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
        page.subscribe(fake_conn)
        expect(fake_conn.sent.last).to include('Master Password')
        expect(fake_conn.sent.last).not_to include('Nisugi')
        expect(loads).to eq(0) # the gate must never touch the entry loader

        pw_cid = fake_conn.sent.last[/"cid":"([^"]*password_input:master_password)"/, 1]
        unlock_cid = fake_conn.sent.last[/"cid":"([^"]*button:unlock)"/, 1]
        page.handle_event(pw_cid, 'wrong')
        page.handle_event(unlock_cid, nil)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('Master password incorrect') } }

        page.handle_event(pw_cid, 'open-sesame')
        page.handle_event(unlock_cid, nil)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('Nisugi') } }

        quit_cid = fake_conn.sent.last[/"cid":"([^"]*button:quit)"/, 1]
        page.handle_event(quit_cid, nil)
      end
      expect(result).to be_nil
      expect(loads).to be >= 1 # unlocked renders load entries again
    end

    it 'renders per-account tabs when Tab Layout is on and still plays' do
      allow(Lich).to receive(:track_layout_state).and_return(true)
      authenticator = lambda { |account:, password:, character:, game_code:|
        expect([account, password, character, game_code]).to eq(%w[account1 sekrit Nisugi GS3])
        ['GAMECODE=GS3', 'GAMEHOST=host', 'GAMEPORT=1', 'GAME=STORM']
      }

      result = run_login(authenticator: authenticator) do |page|
        fake_conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
        page.subscribe(fake_conn)
        expect(fake_conn.sent.last).to include('"tabs:main.t0.tabs:accounts"')
        expect(fake_conn.sent.last).to include('"label":"account1"')
        play_cid = fake_conn.sent.last[/"cid":"([^"]*button:play_[^"]+)"/, 1]
        page.handle_event(play_cid, nil)
      end
      expect(result).to eq(['GAMECODE=GS3', 'GAMEHOST=host', 'GAMEPORT=1', 'GAME=STORM'])
    end

    it 'manual Play honors custom launch, save, and favorite options' do
      saves = []
      favorites = []
      allow(described_class).to receive(:save_entry) { |**kw| saves << kw }
      allow(described_class).to receive(:mark_favorite) { |*args| favorites << args }
      prepared = []
      launch_preparer = ->(auth, fe, cl, dir) { prepared << [fe, cl, dir]; auth }
      authenticator = ->(**_) { ['GAMECODE=GS3', 'GAMEHOST=host', 'GAMEPORT=1', 'GAME=STORM'] }

      result = run_login(authenticator: authenticator, launch_preparer: launch_preparer) do |page|
        fake_conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
        page.subscribe(fake_conn)
        tree = fake_conn.sent.last
        page.handle_event(tree[/"cid":"([^"]*text_input:account)"/, 1], 'account1')
        page.handle_event(tree[/"cid":"([^"]*password_input:password)"/, 1], 'sekrit')
        page.handle_event(tree[/"cid":"([^"]*text_input:character)"/, 1], 'Nisugi')
        page.handle_event(tree[/"cid":"([^"]*checkbox:custom_enabled)"/, 1], true)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('text_input:custom_launch') } }
        tree = fake_conn.sent.last
        page.handle_event(tree[/"cid":"([^"]*text_input:custom_launch)"/, 1], 'C:\\wrayth\\wrayth.exe %port%')
        page.handle_event(tree[/"cid":"([^"]*text_input:custom_launch_dir)"/, 1], 'C:\\wrayth')
        page.handle_event(tree[/"cid":"([^"]*checkbox:save_entry)"/, 1], true)
        page.handle_event(tree[/"cid":"([^"]*checkbox:mark_favorite)"/, 1], true)
        page.handle_event(tree[/"cid":"([^"]*button:manual_play)"/, 1], nil)
      end
      expect(result).to eq(['GAMECODE=GS3', 'GAMEHOST=host', 'GAMEPORT=1', 'GAME=STORM'])
      expect(prepared.last).to eq(['wrayth', 'C:\\wrayth\\wrayth.exe %port%', 'C:\\wrayth'])
      expect(saves.last).to include(char_name: 'Nisugi', game_code: 'GS3',
                                    custom_launch: 'C:\\wrayth\\wrayth.exe %port%', custom_launch_dir: 'C:\\wrayth')
      expect(favorites.last).to eq(['account1', 'Nisugi', 'GS3', 'wrayth'])
    end

    it 'account management changes passwords and removes accounts with confirm' do
      account_manager = double('AccountManager', change_password: true, remove_account: true)
      stub_const('Lich::Common::GUI::AccountManager', account_manager)
      authenticator = ->(**_) { raise 'auth should not be reached' }

      result = run_login(authenticator: authenticator) do |page|
        fake_conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
        page.subscribe(fake_conn)
        tree = fake_conn.sent.last
        expect(tree).to include('"label":"Account Management"')

        page.handle_event(tree[/"cid":"([^"]*password_input:np_account1)"/, 1], 'newpass')
        page.handle_event(tree[/"cid":"([^"]*button:cp_account1)"/, 1], nil)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('Password updated for account1') } }
        expect(account_manager).to have_received(:change_password).with(Dir.tmpdir, 'account1', 'newpass')

        page.handle_event(tree[/"cid":"([^"]*button:ra_account1)"/, 1], nil)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('Confirm Remove') } }
        page.handle_event(tree[/"cid":"([^"]*button:ra_account1)"/, 1], nil)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('Removed account account1') } }
        expect(account_manager).to have_received(:remove_account).with(Dir.tmpdir, 'account1')

        page.handle_event(fake_conn.sent.last[/"cid":"([^"]*button:quit)"/, 1], nil)
      end
      expect(result).to be_nil
    end

    it 'changes the encryption mode from the browser' do
      allow(described_class).to receive(:entry_meta).and_return({ mode: :plaintext, validation: nil })
      allow(described_class).to receive(:keychain_available?).and_return(true)
      entry_store = double('EntryStore', change_encryption_mode: true,
                                         yaml_file_path: File.join(Dir.tmpdir, 'no-such-entry.yaml'))
      stub_const('Lich::Common::Authentication::EntryStore', entry_store)
      authenticator = ->(**_) { raise 'auth should not be reached' }

      result = run_login(authenticator: authenticator) do |page|
        fake_conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
        page.subscribe(fake_conn)
        tree = fake_conn.sent.last
        expect(tree).to include('Current mode: Plaintext')

        page.handle_event(tree[/"cid":"([^"]*select:enc_mode)"/, 1], 'Enhanced (master password)')
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('password_input:enc_mp1') } }
        tree = fake_conn.sent.last

        # mismatched confirmation is rejected before any re-encryption
        page.handle_event(tree[/"cid":"([^"]*password_input:enc_mp1)"/, 1], 'hunter2')
        page.handle_event(tree[/"cid":"([^"]*password_input:enc_mp2)"/, 1], 'different')
        page.handle_event(tree[/"cid":"([^"]*button:enc_apply)"/, 1], nil)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('Master passwords do not match') } }
        expect(entry_store).not_to have_received(:change_encryption_mode)

        page.handle_event(tree[/"cid":"([^"]*password_input:enc_mp1)"/, 1], 'hunter2')
        page.handle_event(tree[/"cid":"([^"]*password_input:enc_mp2)"/, 1], 'hunter2')
        page.handle_event(tree[/"cid":"([^"]*button:enc_apply)"/, 1], nil)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('Encryption mode changed to Enhanced') } }
        expect(entry_store).to have_received(:change_encryption_mode).with(Dir.tmpdir, :enhanced, 'hunter2')

        page.handle_event(fake_conn.sent.last[/"cid":"([^"]*button:quit)"/, 1], nil)
      end
      expect(result).to be_nil
    end

    it 'offers legacy entry.dat conversion and converts with the chosen mode' do
      allow(described_class).to receive(:legacy_pending?).and_return(true)
      entry_store = double('EntryStore', migrate_from_legacy: true,
                                         yaml_file_path: File.join(Dir.tmpdir, 'no-such-entry.yaml'))
      stub_const('Lich::Common::Authentication::EntryStore', entry_store)
      authenticator = ->(**_) { raise 'auth should not be reached' }

      result = run_login(authenticator: authenticator) do |page|
        fake_conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
        page.subscribe(fake_conn)
        tree = fake_conn.sent.last
        expect(tree).to include('Legacy saved-login file detected')

        page.handle_event(tree[/"cid":"([^"]*select:mig_mode)"/, 1], 'Standard (account-derived key)')
        page.handle_event(tree[/"cid":"([^"]*button:mig_convert)"/, 1], nil)
        Timeout.timeout(3) { sleep 0.05 until fake_conn.sent.any? { |m| m.include?('Converted entry.dat to entry.yaml') } }
        expect(entry_store).to have_received(:migrate_from_legacy).with(Dir.tmpdir, encryption_mode: :standard)

        page.handle_event(fake_conn.sent.last[/"cid":"([^"]*button:quit)"/, 1], nil)
      end
      expect(result).to be_nil
    end

    it 'wires the Fav button to the favorites toggle' do
      toggled = []
      allow(described_class).to receive(:toggle_favorite) { |entry| toggled << entry[:char_name] }
      authenticator = ->(**_) { raise 'auth should not be reached' }

      result = run_login(authenticator: authenticator) do |page|
        fake_conn = Struct.new(:sent) { def send_text(json) = (sent << json) }.new([])
        page.subscribe(fake_conn)
        fav_cid = fake_conn.sent.last[/"cid":"([^"]*button:fav_[^"]+)"/, 1]
        page.handle_event(fav_cid, nil)
        quit_cid = fake_conn.sent.last[/"cid":"([^"]*button:quit)"/, 1]
        page.handle_event(quit_cid, nil)
      end
      expect(result).to be_nil
      expect(toggled).to eq(['Nisugi'])
    end

    it 'reports auth failures inline and keeps waiting; Quit returns nil' do
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
