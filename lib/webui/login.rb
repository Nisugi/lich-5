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

      # Window watchdog: closing the login window must exit Lich just like
      # closing the GTK launcher window - otherwise an invisible rubyw
      # process waits on the queue forever. The server marks a closed
      # browser's connection dead within one read-poll; the grace period
      # only needs to cover reloads and reconnects.
      WATCHDOG_POLL = 5            # seconds between checks
      WATCHDOG_GRACE = 15          # window gone this long => quit
      WATCHDOG_NEVER_OPENED = 600  # no browser ever connected => quit

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

      ENCRYPTION_MODE_LABELS = {
        :plaintext => 'Plaintext',
        :standard  => 'Standard (account-derived key)',
        :enhanced  => 'Enhanced (master password)'
      }.freeze

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
        @confirm_remove = nil

        page = WebUI.register_core_page('login', title: "Lich #{defined?(LICH_VERSION) ? LICH_VERSION : ''}".strip, bare: true, size: [560, 580]) { |ui| render(ui) }
        return :fallback unless page

        login_url = WebUI.auth_url_for('lich/login')
        if WebUI.open_page('lich/login', app: true, size: [560, 580])
          Lich.log("info: WebUI login window opened (#{login_url})") if defined?(Lich) && Lich.respond_to?(:log)
        else
          # rubyw has no console, so the log is the only visible place
          Lich.log("warning: WebUI login: browser did NOT open automatically - open this link manually: #{login_url}") if defined?(Lich) && Lich.respond_to?(:log)
          puts "Lich WebUI login: #{login_url}" rescue nil
        end

        watchdog = start_window_watchdog(page)
        result = @queue.pop
        watchdog&.kill
        # One character per launch: tell the browser window to close itself
        # before the page disappears from the registry.
        WebUI.notify_page_close('lich/login')
        Registry.remove('lich/login')
        result
      end

      private

      # GTK parity for closing the launcher window: once a browser has
      # connected and then stays gone past the grace period (or never
      # connects at all), quit as if the player closed the GTK window.
      def start_window_watchdog(page)
        Thread.new do
          connected_once = false
          gone_since = nil
          started = Time.now
          loop do
            sleep WATCHDOG_POLL
            if page.live_subscribers?
              connected_once = true
              gone_since = nil
            elsif connected_once
              gone_since ||= Time.now
              if Time.now - gone_since > WATCHDOG_GRACE
                Lich.log('info: WebUI login window closed; exiting like the GTK launcher') if defined?(Lich) && Lich.respond_to?(:log)
                @queue << nil
                break
              end
            elsif Time.now - started > WATCHDOG_NEVER_OPENED
              Lich.log('info: WebUI login never opened in a browser; giving up') if defined?(Lich) && Lich.respond_to?(:log)
              @queue << nil
              break
            end
          end
        end
      end

      def default_entries
        require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
        if @unlocked_master && keychain_master.nil?
          load_entries_with_master(@unlocked_master)
        else
          Lich::Common::Authentication::EntryStore.load_saved_entries(@data_dir, autosort?) || []
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

        locked = saved_locked?
        saved = locked ? [] : (@entries_loader.call || []).select { |entry| entry.is_a?(Hash) && entry[:char_name] }

        # Mirror the GTK launcher: Saved Entry / Manual Entry / Account
        # Management tabs. key: keeps the tabs' cid stable even as the
        # busy/error text nodes above come and go - without it the browser
        # sees a "new" tabs component on every busy transition and resets
        # to the first tab.
        ui.tabs(['Saved Entry', 'Manual Entry', 'Account Management'], key: :main) do |saved_tab, manual_tab, mgmt_tab|
          if locked
            render_master_gate(saved_tab)
            mgmt_tab.text 'Unlock your saved logins on the Saved Entry tab first.'
          else
            render_saved_entries(saved_tab, saved)
            render_account_management(mgmt_tab, saved)
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
            render_manual_options(manual_tab, ui)
            manual_tab.button('Play', key: :list_play) { play_from_list(ui.state) }
          else
            manual_tab.markdown '*Connect to pick from your characters, or log in directly:*'
            manual_tab.select('Game', options: GAME_CODES.keys, value: ui.state[:game] || 'GS4 Prime', key: :game) { |v| ui.state[:game] = v }
            manual_tab.text_input('Character', value: ui.state[:character], key: :character) { |v| ui.state[:character] = v.strip }
            manual_tab.select('Frontend', options: FRONTENDS, value: ui.state[:frontend] || 'wrayth', key: :frontend) { |v| ui.state[:frontend] = v }
            render_manual_options(manual_tab, ui)
            manual_tab.button('Play', key: :manual_play) { play_manual(ui.state) }
          end
        end
      end

      # The GTK manual tab's option checkboxes, shared by both Play flows:
      # custom launch command, save-for-next-time, mark as favorite.
      def render_manual_options(manual_tab, ui)
        manual_tab.checkbox('Custom launch command', checked: !!ui.state[:custom_enabled], key: :custom_enabled) { |v| ui.state[:custom_enabled] = v }
        if ui.state[:custom_enabled]
          manual_tab.text_input('Launch command', value: ui.state[:custom_launch],
                                placeholder: 'e.g. C:\\frontend\\wrayth.exe %port%', key: :custom_launch) { |v| ui.state[:custom_launch] = v }
          manual_tab.text_input('Working directory', value: ui.state[:custom_launch_dir], key: :custom_launch_dir) { |v| ui.state[:custom_launch_dir] = v }
        end
        manual_tab.checkbox('Save this entry', checked: !!ui.state[:save_entry], key: :save_entry) { |v| ui.state[:save_entry] = v }
        manual_tab.checkbox('Mark as favorite', checked: !!ui.state[:mark_favorite], key: :mark_favorite) { |v| ui.state[:mark_favorite] = v }
      end

      # @return [Array(String|nil, String|nil)] custom launch command and
      #   working directory when enabled and non-blank
      def manual_custom_launch(state)
        return [nil, nil] unless state[:custom_enabled]

        command = state[:custom_launch].to_s.strip
        directory = state[:custom_launch_dir].to_s.strip
        [command.empty? ? nil : command, directory.empty? ? nil : directory]
      end

      # The Saved Entry tab body: entries as a flat grouped list or (Tab
      # Layout) per-account tabs, then the GUI Settings row and Refresh.
      def render_saved_entries(saved_tab, saved)
        render_legacy_banner(saved_tab) if legacy_pending?
        saved_tab.text 'No saved characters yet - use Manual Entry.' if saved.empty?
        if tab_layout? && !saved.empty?
          render_account_tabs(saved_tab, saved)
        else
          render_account_list(saved_tab, saved)
        end
        render_settings(saved_tab)
        saved_tab.button('Refresh Entries', key: :refresh) { nil } # rerender reloads from disk
      end

      # Flat layout: entries grouped under "Account:" headers.
      def render_account_list(tab, saved)
        saved.group_by { |entry| (entry[:username] || entry[:user_id]).to_s }.each do |account, chars|
          tab.markdown "**Account: #{account.downcase}**"
          chars.each { |entry| render_entry_row(tab, entry, account) }
        end
      end

      # Tab Layout (the GTK sidebar mode): a Favorites tab when any exist,
      # then one tab per account, each listing only that account's entries.
      def render_account_tabs(tab, saved)
        groups = saved.group_by { |entry| (entry[:username] || entry[:user_id]).to_s }
        favorites = saved.select { |entry| entry[:is_favorite] }
        names = favorites.empty? ? [] : ['* Favorites']
        names.concat(groups.keys.map(&:downcase))
        tab.tabs(names, vertical: true, key: :accounts) do |*account_tabs|
          offset = 0
          unless favorites.empty?
            favorites.each { |entry| render_entry_row(account_tabs[0], entry, 'favorites') }
            offset = 1
          end
          groups.each_with_index do |(account, chars), index|
            chars.each { |entry| render_entry_row(account_tabs[offset + index], entry, account) }
          end
        end
      end

      def render_entry_row(tab, entry, account)
        frontend_label = entry[:frontend].to_s.empty? ? '' : ", #{entry[:frontend].to_s.capitalize}"
        row_key = "#{entry[:char_name]}_#{entry[:game_code]}_#{account}"
        tab.columns(2, key: "row_#{row_key}") do |main, actions|
          main.text "#{entry[:is_favorite] ? '* ' : ''}#{entry[:char_name]} (#{entry[:game_name] || entry[:game_code]}#{frontend_label})"
          actions.columns(3, compact: true, key: "act_#{row_key}") do |c_fav, c_play, c_remove|
            c_fav.button(entry[:is_favorite] ? 'Unfav' : 'Fav', key: "fav_#{row_key}") { toggle_favorite(entry) }
            c_play.button('Play', key: "play_#{row_key}") { play_saved(entry) }
            c_remove.button('X', variant: :danger, key: "rm_#{row_key}") { remove_entry(entry) }
          end
        end
      end

      # The Account Management tab (GTK parity, browser-sized): one sidebar
      # tab per account with its characters, change-password, fetch-and-add
      # missing characters, and a two-step account removal. Adding a whole
      # new account lives in Manual Entry (Connect + Save this entry);
      # encryption-mode changes stay in the GTK launcher.
      def render_account_management(tab, saved)
        groups = saved.group_by { |entry| (entry[:username] || entry[:user_id]).to_s }
        if groups.empty?
          tab.text 'No saved accounts yet - add one via Manual Entry (Connect, then Save this entry).'
          return
        end

        tab.tabs(groups.keys.map(&:downcase), vertical: true, key: :mgmt_accounts) do |*account_tabs|
          groups.each_with_index do |(account, chars), index|
            acct_tab = account_tabs[index]
            rows = chars.map { |entry|
              [entry[:char_name].to_s, (entry[:game_name] || entry[:game_code]).to_s,
               entry[:frontend].to_s, entry[:is_favorite] ? '*' : '']
            }
            acct_tab.table(rows, headings: %w[Character Game Frontend Fav], key: "chars_#{account}")
            acct_tab.button('Fetch & Add Missing Characters', key: "fetch_#{account}") { fetch_account_characters(account, chars) }
            acct_tab.password_input('New password', key: "np_#{account}") { |v| acct_tab.state["np_#{account}"] = v }
            acct_tab.columns(2, compact: true, key: "acts_#{account}") do |c_pass, c_remove|
              c_pass.button('Change Password', key: "cp_#{account}") { change_account_password(account, acct_tab.state) }
              if @confirm_remove == account
                c_remove.button('Confirm Remove', variant: :danger, key: "ra_#{account}") { remove_account_entries(account) }
              else
                c_remove.button('Remove Account', variant: :danger, key: "ra_#{account}") { @confirm_remove = account }
              end
            end
          end
        end
        render_encryption_section(tab)
      end

      # Encryption Management (GTK parity): change how saved passwords are
      # stored. EntryStore.change_encryption_mode does the heavy lifting -
      # backup, decrypt-all, re-encrypt-all, keychain store/delete, and
      # rollback from backup on any failure.
      def render_encryption_section(tab)
        current = entry_meta[:mode]
        tab.expander('Encryption', key: :encryption) do |section|
          section.text "Current mode: #{ENCRYPTION_MODE_LABELS[current] || current}"
          selected = section.state[:enc_mode] || ENCRYPTION_MODE_LABELS[current] || 'Plaintext'
          section.select('New mode', options: ENCRYPTION_MODE_LABELS.values, value: selected, key: :enc_mode) { |v| section.state[:enc_mode] = v }
          if ENCRYPTION_MODE_LABELS.key(selected) == :enhanced
            section.text 'If you forget the master password, your saved passwords are unrecoverable.'
            section.password_input('New master password', key: :enc_mp1) { |v| section.state[:enc_mp1] = v }
            section.password_input('Confirm master password', key: :enc_mp2) { |v| section.state[:enc_mp2] = v }
          end
          section.button('Apply Encryption Mode', key: :enc_apply) { change_encryption(section.state) }
        end
      end

      def change_encryption(state)
        target = ENCRYPTION_MODE_LABELS.key(state[:enc_mode].to_s) || entry_meta[:mode]
        current = entry_meta[:mode]
        if target == current
          @status = "Already using #{ENCRYPTION_MODE_LABELS[current]}."
          return
        end

        new_master = nil
        if target == :enhanced
          first = state[:enc_mp1].to_s
          second = state[:enc_mp2].to_s
          state[:enc_mp1] = nil
          state[:enc_mp2] = nil
          return fail_login('Enter the new master password twice.') if first.empty? || second.empty?
          return fail_login('Master passwords do not match.') unless first == second
          return fail_login('No system keychain available - Enhanced mode needs one to store the master password.') unless keychain_available?

          new_master = first
        end
        # Leaving enhanced needs the master password in the keychain; if we
        # unlocked from memory this session, heal it first.
        heal_keychain(@unlocked_master) if current == :enhanced && @unlocked_master

        set_busy('Re-encrypting saved entries...')
        Thread.new do
          begin
            require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
            ok = Lich::Common::Authentication::EntryStore.change_encryption_mode(@data_dir, target, new_master)
            @busy = nil
            if ok
              @unlocked_master = nil # keychain (or plaintext) now covers loads
              @error = nil
              @status = "Encryption mode changed to #{ENCRYPTION_MODE_LABELS[target]}."
            else
              @error = 'Encryption mode change failed - entries restored from backup (see the Lich log).'
            end
          rescue ScriptError, StandardError => e
            @busy = nil
            @error = "Encryption mode change failed: #{e.message}"
          end
          Registry.find('lich/login')&.request_render
        end
      end

      def keychain_available?
        require File.join(LIB_DIR, 'common', 'gui', 'master_password_manager') unless defined?(Lich::Common::GUI::MasterPasswordManager)
        Lich::Common::GUI::MasterPasswordManager.keychain_available?
      rescue ScriptError, StandardError
        false
      end

      # Updates the stored (re-encrypted per the file mode) password for one
      # account - the GTK Change Password action.
      def change_account_password(account, state)
        key = "np_#{account}"
        new_password = state[key].to_s
        state[key] = nil
        return fail_login('Enter the new password first.') if new_password.empty?

        require File.join(LIB_DIR, 'common', 'gui', 'account_manager') unless defined?(Lich::Common::GUI::AccountManager)
        if Lich::Common::GUI::AccountManager.change_password(@data_dir, account, new_password)
          @error = nil
          @status = "Password updated for #{account.downcase}."
        else
          @error = "Password change failed for #{account.downcase}."
        end
      rescue ScriptError, StandardError => e
        fail_login("Password change failed: #{e.message}")
      end

      # Second click of the two-step Remove Account button.
      def remove_account_entries(account)
        @confirm_remove = nil
        require File.join(LIB_DIR, 'common', 'gui', 'account_manager') unless defined?(Lich::Common::GUI::AccountManager)
        if Lich::Common::GUI::AccountManager.remove_account(@data_dir, account)
          @error = nil
          @status = "Removed account #{account.downcase} and its characters."
        else
          @error = "Could not remove account #{account.downcase}."
        end
      rescue ScriptError, StandardError => e
        fail_login("Account removal failed: #{e.message}")
      end

      # The GTK Add Character flow, automated: EAccess-list the account with
      # its stored password and save any characters not in the store yet
      # (frontend defaults to wrayth; change per entry via Manual Entry).
      def fetch_account_characters(account, chars)
        stored_password = chars.first && chars.first[:password].to_s
        return fail_login('No stored password for this account.') if stored_password.nil? || stored_password.empty?

        set_busy("Fetching characters for #{account.downcase}...")
        Thread.new do
          begin
            list = @account_lister.call(account: account, password: stored_password)
            list = list.is_a?(Array) ? list : []
            known = chars.map { |entry| [entry[:char_name].to_s.capitalize, entry[:game_code]] }
            fresh = list.reject { |char| known.include?([char[:char_name].to_s.capitalize, char[:game_code]]) }
            @busy = nil
            if fresh.empty?
              @status = "No new characters found for #{account.downcase}."
            else
              require File.join(LIB_DIR, 'common', 'gui', 'account_manager') unless defined?(Lich::Common::GUI::AccountManager)
              added = fresh.count { |char|
                Lich::Common::GUI::AccountManager.add_character(
                  @data_dir, account,
                  { char_name: char[:char_name], game_code: char[:game_code],
                    game_name: char[:game_name], frontend: 'wrayth',
                    custom_launch: nil, custom_launch_dir: nil }
                )[:success]
              }
              @status = "Added #{added} character(s) to #{account.downcase}."
            end
          rescue ScriptError, StandardError => e
            @busy = nil
            @error = "Character fetch failed: #{e.message}"
          end
          Registry.find('lich/login')&.request_render
        end
      end

      # The GTK launcher's GUI Settings row: every toggle reads and writes
      # the same persisted lich_settings the GTK launcher uses, so the two
      # launchers stay in sync. Dark Theme applies to GTK windows and is
      # passed to Multi-Launch children; the browser page itself follows the
      # browser theme.
      def render_settings(tab)
        tab.expander('GUI Settings', key: :settings) do |section|
          section.checkbox('Dark Theme (GTK and child sessions)',
                           checked: lich_setting?(:track_dark_mode), key: :dark_theme) { |v| set_lich_setting(:track_dark_mode, v) }
          section.checkbox('Tab Layout (one tab per account)',
                           checked: tab_layout?, key: :tab_layout) { |v| set_lich_setting(:track_layout_state, v) }
          section.checkbox('AutoSort (favorites first)',
                           checked: autosort?, key: :autosort) { |v| set_lich_setting(:track_autosort_state, v) }
          # Multi-Launch: saved-entry Play spawns a detached child Lich
          # session and this launcher stays open.
          section.checkbox('Multi-Launch (spawn sessions, keep this launcher open)',
                           checked: multi_launch?, key: :multi_launch) { |v| self.multi_launch = v }
        end
      end

      # @return [Boolean] whether a legacy entry.dat exists with no
      #   entry.yaml yet (the first-run conversion GTK used to prompt for)
      def legacy_pending?
        require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
        !File.exist?(Lich::Common::Authentication::EntryStore.yaml_file_path(@data_dir)) &&
          File.exist?(File.join(@data_dir, 'entry.dat'))
      rescue ScriptError, StandardError
        false
      end

      # First-run conversion from the legacy Marshal entry.dat (the GTK
      # ConversionUI flow, browser-sized). The legacy list still renders and
      # plays without converting; converting enables saving, favorites, and
      # account management. Enhanced mode is deliberately not offered here -
      # its master-password creation lives in the Encryption section, one
      # mode change away, keeping this flow prompt-free.
      def render_legacy_banner(saved_tab)
        saved_tab.markdown '**Legacy saved-login file detected (entry.dat).**'
        saved_tab.text 'Convert it to the current format to enable saving, favorites, and account management.'
        choice = saved_tab.state[:mig_mode] || 'Plaintext'
        saved_tab.select('Store passwords as', options: [ENCRYPTION_MODE_LABELS[:plaintext], ENCRYPTION_MODE_LABELS[:standard]],
                         value: choice, key: :mig_mode) { |v| saved_tab.state[:mig_mode] = v }
        saved_tab.button('Convert Saved Logins', key: :mig_convert) { migrate_legacy(saved_tab.state) }
        saved_tab.divider
      end

      def migrate_legacy(state)
        mode = ENCRYPTION_MODE_LABELS.key(state[:mig_mode].to_s) || :plaintext
        require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
        if Lich::Common::Authentication::EntryStore.migrate_from_legacy(@data_dir, encryption_mode: mode)
          @error = nil
          @status = "Converted entry.dat to entry.yaml (#{ENCRYPTION_MODE_LABELS[mode]}). Enhanced mode is available under Account Management > Encryption."
        else
          @error = 'Conversion failed - entry.dat is unchanged (see the Lich log).'
        end
      rescue ScriptError, StandardError => e
        fail_login("Conversion failed: #{e.message}")
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
        custom_launch, custom_launch_dir = manual_custom_launch(state)
        Thread.new do
          authenticate_and_finish(
            account: state[:account].to_s, password: state[:password].to_s,
            character: entry[:char_name], game_code: entry[:game_code],
            frontend: (state[:frontend] || 'wrayth'),
            custom_launch: custom_launch, custom_launch_dir: custom_launch_dir,
            game_name: entry[:game_name], save: !!state[:save_entry], favorite: !!state[:mark_favorite]
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
        custom_launch, custom_launch_dir = manual_custom_launch(state)
        Thread.new do
          authenticate_and_finish(
            account: account, password: password, character: character,
            game_code: game_code, frontend: (state[:frontend] || 'wrayth'),
            custom_launch: custom_launch, custom_launch_dir: custom_launch_dir,
            game_name: state[:game] || 'GS4 Prime', save: !!state[:save_entry], favorite: !!state[:mark_favorite]
          )
        end
      end

      def authenticate_and_finish(account:, password:, character:, game_code:, frontend:, custom_launch:, custom_launch_dir:, game_name: nil, save: false, favorite: false, multi: false)
        auth = @authenticator.call(account: account, password: password, character: character, game_code: game_code)
        launch_data = @launch_preparer.call(auth, frontend, custom_launch, custom_launch_dir)
        return fail_login('Authentication succeeded but no launch data was produced.') unless launch_data.is_a?(Array) && launch_data.any?

        if save
          save_entry(account: account, password: password, char_name: character, game_code: game_code,
                     game_name: game_name, frontend: frontend,
                     custom_launch: custom_launch, custom_launch_dir: custom_launch_dir)
        end
        mark_favorite(account, character, game_code, frontend) if favorite
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

      # Shared launcher preferences (lich_settings): the same persisted
      # toggles the GTK launcher reads, so both launchers stay in sync.
      def lich_setting?(name)
        defined?(Lich) && Lich.respond_to?(name) && Lich.public_send(name) == true
      rescue StandardError
        false
      end

      def set_lich_setting(name, value)
        Lich.public_send("#{name}=", value) if defined?(Lich) && Lich.respond_to?("#{name}=")
      rescue StandardError
        nil
      end

      def multi_launch?
        lich_setting?(:track_persistent_launcher_mode)
      end

      def multi_launch=(value)
        set_lich_setting(:track_persistent_launcher_mode, value)
      end

      def tab_layout?
        lich_setting?(:track_layout_state)
      end

      def autosort?
        lich_setting?(:track_autosort_state)
      end

      # Persists a successful manual login the way the GTK launcher's "save
      # this entry" checkbox does: same uniqueness key (character + game +
      # account + frontend), same field names, and save_entries re-encrypts
      # per the file's existing encryption_mode (entries in memory hold
      # plaintext passwords).
      def save_entry(account:, password:, char_name:, game_code:, game_name:, frontend:, custom_launch: nil, custom_launch_dir: nil)
        require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
        store = Lich::Common::Authentication::EntryStore
        entries = store.load_saved_entries(@data_dir, false) || []
        normalized_account = account.to_s.upcase
        normalized_character = char_name.to_s.capitalize
        existing = entries.find { |candidate|
          candidate[:char_name].to_s.capitalize == normalized_character &&
            candidate[:game_code] == game_code &&
            candidate[:user_id].to_s.upcase == normalized_account &&
            candidate[:frontend] == frontend &&
            candidate[:custom_launch] == custom_launch
        }
        if existing
          existing[:game_name] = game_name
          existing[:password] = password
          existing[:custom_launch_dir] = custom_launch_dir
        else
          entries.push(
            :char_name => normalized_character, :game_code => game_code, :game_name => game_name,
            :user_id => normalized_account, :password => password, :frontend => frontend,
            :custom_launch => custom_launch, :custom_launch_dir => custom_launch_dir,
            :encryption_mode => (entries.first&.[](:encryption_mode) || :plaintext)
          )
        end
        store.save_entries(@data_dir, entries)
      rescue StandardError => e
        Lich.log("warning: WebUI login: could not save entry: #{e.class}: #{e.message}") if defined?(Lich) && Lich.respond_to?(:log)
      end

      # Mark as favorite after a manual Play (effective when the entry is
      # saved - favorites live on saved entries, as in GTK).
      def mark_favorite(account, char_name, game_code, frontend)
        require File.join(LIB_DIR, 'common', 'gui', 'favorites_manager') unless defined?(Lich::Common::GUI::FavoritesManager)
        Lich::Common::GUI::FavoritesManager.add_favorite(
          @data_dir, account.to_s.upcase, char_name.to_s.capitalize, game_code, frontend
        )
      rescue ScriptError, StandardError => e
        Lich.log("warning: WebUI login: could not mark favorite: #{e.class}: #{e.message}") if defined?(Lich) && Lich.respond_to?(:log)
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
