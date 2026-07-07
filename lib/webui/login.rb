# frozen_string_literal: true

require_relative 'webui'

module Lich
  module WebUI
    # Browser-based login launcher: when enabled, double-clicking lich.exe
    # opens a login page in a floating browser window instead of the GTK
    # launcher. Produces the same launch_data array every other login
    # frontend hands to main.rb; everything downstream is untouched.
    #
    # Trust model: account passwords transit loopback HTTP once, token-gated,
    # into the same process that handles them today - equivalent exposure to
    # typing them into the GTK window. Passwords are never echoed back into
    # render JSON (password_input) and never logged.
    module Login
      extend self

      FEATURE_FLAG = :webui_login

      GAME_CODES = {
        'GS4 Prime'     => 'GS3',
        'GS4 Platinum'  => 'GSX',
        'GS4 Shattered' => 'GSF',
        'GS4 Test'      => 'GST',
        'DR Prime'      => 'DR',
        'DR Platinum'   => 'DRX',
        'DR Fallen'     => 'DRF',
        'DR Test'       => 'DRT'
      }.freeze

      FRONTENDS = %w[wrayth stormfront profanity wizard avalon].freeze

      # Should boot use the web login instead of GTK?
      # --gtk-login always wins; --webui-login forces web; otherwise a bare
      # double-click (empty ARGV) honors the :webui_login feature flag.
      #
      # @return [Boolean]
      def wanted?
        return false if ARGV.include?('--gtk-login')
        return true if ARGV.include?('--webui-login')

        ARGV.empty? && defined?(Lich::Common::FeatureFlags) && Lich::Common::FeatureFlags.enabled?(FEATURE_FLAG)
      end

      # Runs the login page and blocks until the player picks a character,
      # exactly like gui_login blocks on the GTK window.
      #
      # @param data_dir [String]
      # @param entries_loader [#call] injectable for specs
      # @param authenticator [#call] (account:, password:, character:, game_code:) -> auth data
      # @param launch_preparer [#call] (auth_data, frontend, custom_launch, dir) -> Array
      # @param session_launcher [#call] (launch_data, launch_context:) -> {ok:, pid:|error:}
      # @return [Array<String>, :fallback, nil] launch_data; :fallback when
      #   the server could not start; nil when the player quit
      def run(data_dir:, entries_loader: nil, authenticator: nil, launch_preparer: nil, account_lister: nil, session_launcher: nil)
        @account_lister = account_lister || lambda { |account:, password:|
          Lich::Common::Authentication.authenticate(account: account, password: password, legacy: true)
        }
        @char_list = nil
        @entries_loader = entries_loader || method(:default_entries)
        @authenticator = authenticator || lambda { |account:, password:, character:, game_code:|
          Lich::Common::Authentication.authenticate(account: account, password: password, character: character, game_code: game_code)
        }
        @launch_preparer = launch_preparer || lambda { |auth, frontend, custom_launch, dir|
          Lich::Common::Authentication::LaunchData.prepare(auth, frontend, custom_launch, dir)
        }
        @session_launcher = session_launcher || lambda { |launch_data, launch_context:|
          require File.join(LIB_DIR, 'common', 'session_launcher') unless defined?(Lich::Common::SessionLauncher)
          Lich::Common::SessionLauncher.launch(launch_data, launch_context: launch_context)
        }
        @data_dir = data_dir
        @queue = Queue.new
        @error = nil
        @busy = nil
        @status = nil
        @unlocked_master = nil

        page = WebUI.register_core_page('login', title: "Lich #{defined?(LICH_VERSION) ? LICH_VERSION : ''}".strip, bare: true, size: [560, 580]) { |ui| render(ui) }
        return :fallback unless page

        unless WebUI.open_page('lich/login', app: true, size: [560, 580])
          puts "Lich WebUI login: #{WebUI.auth_url}" rescue nil
        end
        Lich.log("info: WebUI login waiting at #{WebUI.auth_url}") if defined?(Lich) && Lich.respond_to?(:log)

        result = @queue.pop
        # One character per launch: tell the browser window to close itself
        # before the page disappears from the registry.
        WebUI.notify_page_close('lich/login')
        Registry.remove('lich/login')
        result
      end

      private

      def default_entries
        require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
        if @unlocked_master && keychain_master.nil?
          load_entries_with_master(@unlocked_master)
        else
          Lich::Common::Authentication::EntryStore.load_saved_entries(@data_dir, true) || []
        end
      rescue StandardError => e
        @error = "Could not load saved logins: #{e.message}"
        []
      end

      # Fallback loader for enhanced mode when the keychain could not be
      # healed: decrypt with the in-memory master password. EntryStore's
      # normal load path would pop GTK recovery dialogs on every render.
      def load_entries_with_master(master_password)
        store = Lich::Common::Authentication::EntryStore
        yaml = YAML.safe_load_file(store.yaml_file_path(@data_dir), permitted_classes: [Symbol])
        entries = []
        (yaml['accounts'] || {}).each do |username, account|
          next unless account['characters']

          password = store.decrypt_password(account['password'], mode: :enhanced,
                                            account_name: username, master_password: master_password)
          account['characters'].each do |character|
            entries.push(
              :user_id => username, :password => password,
              :char_name => character['char_name'], :game_code => character['game_code'],
              :game_name => character['game_name'], :frontend => character['frontend'],
              :custom_launch => character['custom_launch'], :custom_launch_dir => character['custom_launch_dir'],
              :is_favorite => character['is_favorite'] || false, :encryption_mode => :enhanced
            )
          end
        end
        entries.sort_by { |entry| [entry[:is_favorite] ? 0 : 1, entry[:char_name].to_s] }
      end

      def render(ui)
        ui.columns(2, compact: true, key: :head) do |left, right|
          left.header "Lich #{defined?(LICH_VERSION) ? LICH_VERSION : ''}".strip
          right.button('Quit', variant: :danger, key: :quit) { @queue << nil }
        end
        ui.text @busy if @busy
        ui.text "!! #{@error}" if @error
        ui.text @status if @status

        # Mirror the GTK launcher: Saved Entry / Manual Entry tabs, entries
        # grouped under centered "Account:" headers, Play per row.
        # key: keeps the tabs' cid stable even as the busy/error text nodes
        # above come and go - without it the browser sees a "new" tabs
        # component on every busy transition and resets to the first tab.
        ui.tabs(['Saved Entry', 'Manual Entry'], key: :main) do |saved_tab, manual_tab|
          if saved_locked?
            render_master_gate(saved_tab)
          else
            render_saved_entries(saved_tab)
          end

          manual_tab.text_input('User ID', value: ui.state[:account], key: :account) { |v| ui.state[:account] = v.strip }
          manual_tab.password_input('Password', key: :password) { |v| ui.state[:password] = v }
          manual_tab.columns(2, compact: true, key: :connect_row) do |c_connect, c_disconnect|
            c_connect.button('Connect', key: :connect) { connect_account(ui.state) }
            if @char_list
              c_disconnect.button('Disconnect', key: :disconnect) {
                @char_list = nil
                ui.state[:sel_char] = nil
              }
            end
          end

          if @char_list
            rows = @char_list.map { |char| [char[:game_name].to_s, char[:char_name].to_s] }
            manual_tab.table(rows, headings: %w[Game Character], sortable: true,
                             selected: ui.state[:sel_char], key: :char_table) { |index| ui.state[:sel_char] = index }
            manual_tab.select('Frontend', options: FRONTENDS, value: ui.state[:frontend] || 'wrayth', key: :frontend) { |v| ui.state[:frontend] = v }
            manual_tab.checkbox('Save this entry', checked: !!ui.state[:save_entry], key: :save_entry) { |v| ui.state[:save_entry] = v }
            manual_tab.button('Play', key: :list_play) { play_from_list(ui.state) }
          else
            manual_tab.markdown '*Connect to pick from your characters, or log in directly:*'
            manual_tab.select('Game', options: GAME_CODES.keys, value: ui.state[:game] || 'GS4 Prime', key: :game) { |v| ui.state[:game] = v }
            manual_tab.text_input('Character', value: ui.state[:character], key: :character) { |v| ui.state[:character] = v.strip }
            manual_tab.select('Frontend', options: FRONTENDS, value: ui.state[:frontend] || 'wrayth', key: :frontend) { |v| ui.state[:frontend] = v }
            manual_tab.checkbox('Save this entry', checked: !!ui.state[:save_entry], key: :save_entry) { |v| ui.state[:save_entry] = v }
            manual_tab.button('Play', key: :manual_play) { play_manual(ui.state) }
          end
        end
      end

      # The Saved Entry tab body: grouped entries with Fav/Play/X per row,
      # the Multi-Launch toggle, and Refresh.
      def render_saved_entries(saved_tab)
        entries = @entries_loader.call
        saved = entries.select { |entry| entry.is_a?(Hash) && entry[:char_name] }

        saved_tab.text 'No saved characters yet - use Manual Entry.' if saved.empty?
        saved.group_by { |entry| (entry[:username] || entry[:user_id]).to_s }.each do |account, chars|
          saved_tab.markdown "**Account: #{account.downcase}**"
          chars.each do |entry|
            frontend_label = entry[:frontend].to_s.empty? ? '' : ", #{entry[:frontend].to_s.capitalize}"
            row_key = "#{entry[:char_name]}_#{entry[:game_code]}_#{account}"
            saved_tab.columns(2, key: "row_#{row_key}") do |main, actions|
              main.text "#{entry[:is_favorite] ? '* ' : ''}#{entry[:char_name]} (#{entry[:game_name] || entry[:game_code]}#{frontend_label})"
              actions.columns(3, compact: true, key: "act_#{row_key}") do |c_fav, c_play, c_remove|
                c_fav.button(entry[:is_favorite] ? 'Unfav' : 'Fav', key: "fav_#{row_key}") { toggle_favorite(entry) }
                c_play.button('Play', key: "play_#{row_key}") { play_saved(entry) }
                c_remove.button('X', variant: :danger, key: "rm_#{row_key}") { remove_entry(entry) }
              end
            end
          end
        end
        # Multi-Launch mirrors the GTK launcher's global-settings switch
        # (Lich.track_persistent_launcher_mode): saved-entry Play spawns a
        # detached child Lich session and this launcher stays open.
        saved_tab.checkbox('Multi-Launch (spawn sessions, keep this launcher open)',
                           checked: multi_launch?, key: :multi_launch) { |v| self.multi_launch = v }
        saved_tab.button('Refresh Entries', key: :refresh) { nil } # rerender reloads from disk
      end

      # Enhanced-encryption gate: shown instead of the saved list when the
      # master password is missing from the system keychain. Entering it
      # here mirrors the GTK recovery dialog - validate against the yaml's
      # validation test, then heal the keychain so every other flow
      # (including Multi-Launch children) can decrypt again.
      def render_master_gate(saved_tab)
        saved_tab.markdown '**Saved logins are protected by a master password.**'
        saved_tab.text 'It was not found in the system keychain. Enter it to unlock your saved entries.'
        saved_tab.password_input('Master Password', key: :master_password) { |v| saved_tab.state[:master_pw] = v }
        saved_tab.button('Unlock', key: :unlock) { unlock_master(saved_tab.state) }
      end

      def unlock_master(state)
        entered = state[:master_pw].to_s
        state[:master_pw] = nil
        return fail_login('Enter your master password.') if entered.empty?

        if master_password_valid?(entered, entry_meta[:validation])
          @unlocked_master = entered
          healed = heal_keychain(entered)
          @busy = nil
          @error = nil
          @status = healed ? 'Unlocked. Master password restored to the system keychain.' : 'Unlocked for this launcher session only (keychain unavailable).'
          Registry.find('lich/login')&.request_render
        else
          fail_login('Master password incorrect.')
        end
      end

      # @return [Boolean] whether the saved list must stay hidden behind the
      #   master-password gate. Never calls EntryStore.load_saved_entries -
      #   that path pops GTK recovery dialogs when the keychain is empty.
      def saved_locked?
        return false if @unlocked_master

        meta = entry_meta
        return false unless meta[:mode] == :enhanced

        keychain_master.nil?
      rescue StandardError
        false
      end

      # Cheap read of entry.yaml's encryption metadata (no decryption).
      #
      # @return [Hash] {mode: Symbol, validation: Hash|nil}
      def entry_meta
        require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
        yaml_path = Lich::Common::Authentication::EntryStore.yaml_file_path(@data_dir)
        yaml = File.exist?(yaml_path) ? YAML.safe_load_file(yaml_path, permitted_classes: [Symbol]) : nil
        return { mode: :plaintext, validation: nil } unless yaml.is_a?(Hash)

        { mode: (yaml['encryption_mode'] || 'plaintext').to_sym, validation: yaml['master_password_validation_test'] }
      rescue StandardError
        { mode: :plaintext, validation: nil }
      end

      def keychain_master
        require File.join(LIB_DIR, 'common', 'gui', 'master_password_manager') unless defined?(Lich::Common::GUI::MasterPasswordManager)
        Lich::Common::GUI::MasterPasswordManager.retrieve_master_password
      rescue ScriptError, StandardError
        nil
      end

      def master_password_valid?(entered, validation_test)
        require File.join(LIB_DIR, 'common', 'gui', 'master_password_manager') unless defined?(Lich::Common::GUI::MasterPasswordManager)
        Lich::Common::GUI::MasterPasswordManager.validate_master_password(entered, validation_test)
      rescue ScriptError, StandardError
        false
      end

      def heal_keychain(master_password)
        Lich::Common::GUI::MasterPasswordManager.store_master_password(master_password)
      rescue ScriptError, StandardError
        false
      end

      def toggle_favorite(entry)
        require File.join(LIB_DIR, 'common', 'gui', 'favorites_manager') unless defined?(Lich::Common::GUI::FavoritesManager)
        Lich::Common::GUI::FavoritesManager.toggle_favorite(
          @data_dir, (entry[:username] || entry[:user_id]).to_s,
          entry[:char_name], entry[:game_code], entry[:frontend]
        )
        @error = nil
      rescue ScriptError, StandardError => e
        @error = "Favorite toggle failed: #{e.message}"
      end

      # Deletes one saved entry (the GTK X button) and lets the rerender
      # reload the list from disk.
      def remove_entry(entry)
        require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
        store = Lich::Common::Authentication::EntryStore
        entries = store.load_saved_entries(@data_dir, false) || []
        entries.reject! { |candidate|
          candidate[:char_name] == entry[:char_name] &&
            candidate[:game_code] == entry[:game_code] &&
            candidate[:user_id] == entry[:user_id] &&
            candidate[:frontend] == entry[:frontend]
        }
        store.save_entries(@data_dir, entries)
        @error = nil
      rescue StandardError => e
        @error = "Remove failed: #{e.message}"
      end

      # Saved-entry Play: authenticate and hand launch_data to the waiting
      # boot thread. EntryStore.load_saved_entries already decrypted the
      # password (and entries carry :user_id, not :username). Auth runs on
      # its own thread so the page stays responsive.
      def play_saved(entry)
        set_busy("Authenticating #{entry[:char_name]}...")
        multi = multi_launch? # read at click time; the checkbox may change between renders
        Thread.new do
          password = entry[:password].to_s
          if password.empty?
            fail_login('Could not read the saved password for this entry (try --gtk-login if this persists).')
          else
            authenticate_and_finish(
              account: (entry[:username] || entry[:user_id]).to_s, password: password,
              character: entry[:char_name], game_code: entry[:game_code],
              frontend: entry[:frontend], custom_launch: entry[:custom_launch],
              custom_launch_dir: entry[:custom_launch_dir], multi: multi
            )
          end
        end
      end

      # Connect: account-only (legacy) EAccess auth returns every playable
      # character; render them as the GTK Manual Entry table.
      def connect_account(state)
        account = state[:account].to_s
        password = state[:password].to_s
        return fail_login('User ID and password are required to connect.') if account.empty? || password.empty?

        set_busy('Fetching character list...')
        Thread.new do
          begin
            list = @account_lister.call(account: account, password: password)
            @char_list = list.is_a?(Array) ? list : []
            @busy = nil
            @error = 'No characters found on that account.' if @char_list.empty?
          rescue StandardError => e
            @char_list = nil
            @busy = nil
            @error = "Connect failed: #{e.message}"
          end
          Registry.find('lich/login')&.request_render
        end
      end

      def play_from_list(state)
        index = state[:sel_char]
        entry = index && @char_list && @char_list[index]
        return fail_login('Pick a character from the list first.') unless entry

        set_busy("Authenticating #{entry[:char_name]}...")
        Thread.new do
          authenticate_and_finish(
            account: state[:account].to_s, password: state[:password].to_s,
            character: entry[:char_name], game_code: entry[:game_code],
            frontend: (state[:frontend] || 'wrayth'), custom_launch: nil, custom_launch_dir: nil,
            game_name: entry[:game_name], save: !!state[:save_entry]
          )
        end
      end

      def play_manual(state)
        account = state[:account].to_s
        password = state[:password].to_s
        character = state[:character].to_s
        game_code = GAME_CODES[state[:game]] || 'GS3'
        return fail_login('Account, password, and character are all required.') if account.empty? || password.empty? || character.empty?

        set_busy("Authenticating #{character}...")
        Thread.new do
          authenticate_and_finish(
            account: account, password: password, character: character,
            game_code: game_code, frontend: (state[:frontend] || 'wrayth'),
            custom_launch: nil, custom_launch_dir: nil,
            game_name: state[:game] || 'GS4 Prime', save: !!state[:save_entry]
          )
        end
      end

      def authenticate_and_finish(account:, password:, character:, game_code:, frontend:, custom_launch:, custom_launch_dir:, game_name: nil, save: false, multi: false)
        auth = @authenticator.call(account: account, password: password, character: character, game_code: game_code)
        launch_data = @launch_preparer.call(auth, frontend, custom_launch, custom_launch_dir)
        return fail_login('Authentication succeeded but no launch data was produced.') unless launch_data.is_a?(Array) && launch_data.any?

        save_entry(account: account, password: password, char_name: character, game_code: game_code, game_name: game_name, frontend: frontend) if save
        if multi
          spawn_child(launch_data, character: character, game_code: game_code, frontend: frontend, custom_launch: custom_launch)
        else
          @queue << launch_data
        end
      rescue StandardError => e
        fail_login("Login failed: #{e.message}")
      end

      # Multi-Launch Play: hand the prepared launch_data to SessionLauncher,
      # which spawns a detached child Lich process (the child re-authenticates
      # from the saved entry via --login). This launcher page stays open.
      def spawn_child(launch_data, character:, game_code:, frontend:, custom_launch:)
        context = { char_name: character, game_code: game_code, frontend: frontend, custom_launch: custom_launch }
        # Propagate the theme like the GTK launcher does for child startup.
        context[:dark_mode] = Lich.track_dark_mode if defined?(Lich) && Lich.respond_to?(:track_dark_mode)
        result = @session_launcher.call(launch_data, launch_context: context)
        @busy = nil
        if result.is_a?(Hash) && result[:ok]
          @error = nil
          @status = "Launched #{character} (pid #{result[:pid]}). Play another, or Quit when done."
        else
          @error = "Failed to launch session: #{result.is_a?(Hash) ? result[:error] : 'unknown error'}"
        end
        Registry.find('lich/login')&.request_render
      end

      # The GTK launcher's "Multi-Launch" switch, shared via lich_settings so
      # both launchers honor the same preference.
      def multi_launch?
        defined?(Lich) && Lich.respond_to?(:track_persistent_launcher_mode) && Lich.track_persistent_launcher_mode == true
      rescue StandardError
        false
      end

      def multi_launch=(value)
        Lich.track_persistent_launcher_mode = value if defined?(Lich) && Lich.respond_to?(:track_persistent_launcher_mode=)
      rescue StandardError
        nil
      end

      # Persists a successful manual login the way the GTK launcher's "save
      # this entry" checkbox does: same uniqueness key (character + game +
      # account + frontend), same field names, and save_entries re-encrypts
      # per the file's existing encryption_mode (entries in memory hold
      # plaintext passwords).
      def save_entry(account:, password:, char_name:, game_code:, game_name:, frontend:)
        require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
        store = Lich::Common::Authentication::EntryStore
        entries = store.load_saved_entries(@data_dir, false) || []
        normalized_account = account.to_s.upcase
        normalized_character = char_name.to_s.capitalize
        existing = entries.find { |candidate|
          candidate[:char_name].to_s.capitalize == normalized_character &&
            candidate[:game_code] == game_code &&
            candidate[:user_id].to_s.upcase == normalized_account &&
            candidate[:frontend] == frontend
        }
        if existing
          existing[:game_name] = game_name
          existing[:password] = password
        else
          entries.push(
            :char_name => normalized_character, :game_code => game_code, :game_name => game_name,
            :user_id => normalized_account, :password => password, :frontend => frontend,
            :custom_launch => nil, :custom_launch_dir => nil,
            :encryption_mode => (entries.first&.[](:encryption_mode) || :plaintext)
          )
        end
        store.save_entries(@data_dir, entries)
      rescue StandardError => e
        Lich.log("warning: WebUI login: could not save entry: #{e.class}: #{e.message}") if defined?(Lich) && Lich.respond_to?(:log)
      end

      def set_busy(message)
        @busy = message
        @error = nil
        @status = nil
        Registry.find('lich/login')&.request_render
      end

      def fail_login(message)
        @busy = nil
        @status = nil
        @error = message
        Lich.log("warning: WebUI login: #{message}") if defined?(Lich) && Lich.respond_to?(:log)
        Registry.find('lich/login')&.request_render
      end
    end
  end
end
