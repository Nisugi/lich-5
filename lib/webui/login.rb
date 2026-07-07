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
      # @return [Array<String>, :fallback, nil] launch_data; :fallback when
      #   the server could not start; nil when the player quit
      def run(data_dir:, entries_loader: nil, authenticator: nil, launch_preparer: nil)
        @entries_loader = entries_loader || method(:default_entries)
        @authenticator = authenticator || lambda { |account:, password:, character:, game_code:|
          Lich::Common::Authentication.authenticate(account: account, password: password, character: character, game_code: game_code)
        }
        @launch_preparer = launch_preparer || lambda { |auth, frontend, custom_launch, dir|
          Lich::Common::Authentication::LaunchData.prepare(auth, frontend, custom_launch, dir)
        }
        @data_dir = data_dir
        @queue = Queue.new
        @error = nil
        @busy = nil

        page = WebUI.register_core_page('login', title: "Lich #{defined?(LICH_VERSION) ? LICH_VERSION : ''}".strip, bare: true) { |ui| render(ui) }
        return :fallback unless page

        unless WebUI.open_page('lich/login', app: true, size: [480, 640])
          puts "Lich WebUI login: #{WebUI.auth_url}" rescue nil
        end
        Lich.log("info: WebUI login waiting at #{WebUI.auth_url}") if defined?(Lich) && Lich.respond_to?(:log)

        result = @queue.pop
        Registry.remove('lich/login')
        result
      end

      private

      def default_entries
        require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
        Lich::Common::Authentication::EntryStore.load_saved_entries(@data_dir, true) || []
      rescue StandardError => e
        @error = "Could not load saved logins: #{e.message}"
        []
      end

      def render(ui)
        ui.columns(2, compact: true, key: :head) do |left, right|
          left.header "Lich #{defined?(LICH_VERSION) ? LICH_VERSION : ''}".strip
          right.button('Quit', variant: :danger, key: :quit) { @queue << nil }
        end
        ui.text @busy if @busy
        ui.text "!! #{@error}" if @error

        entries = @entries_loader.call
        saved = entries.select { |entry| entry.is_a?(Hash) && entry[:char_name] }
        unless saved.empty?
          ui.header 'Saved characters'
          saved.each do |entry|
            label = "#{entry[:char_name]} - #{entry[:game_name] || entry[:game_code]} (#{entry[:user_id] || entry[:username]})"
            ui.columns(2, key: "row_#{entry[:char_name]}_#{entry[:game_code]}_#{entry[:username]}") do |main, actions|
              main.text label
              actions.button('Play', key: "play_#{entry[:char_name]}_#{entry[:game_code]}_#{entry[:username]}") { play_saved(entry) }
            end
          end
        end

        ui.divider
        ui.expander('Manual login', open: saved.empty?) do |form|
          form.text_input('Account', value: ui.state[:account], key: :account) { |v| ui.state[:account] = v.strip }
          form.password_input('Password', key: :password) { |v| ui.state[:password] = v }
          form.select('Game', options: GAME_CODES.keys, value: ui.state[:game] || 'GS4 Prime', key: :game) { |v| ui.state[:game] = v }
          form.text_input('Character', value: ui.state[:character], key: :character) { |v| ui.state[:character] = v.strip }
          form.select('Frontend', options: FRONTENDS, value: ui.state[:frontend] || 'wrayth', key: :frontend) { |v| ui.state[:frontend] = v }
          form.button('Log in', key: :manual_play) { play_manual(ui.state) }
        end
      end

      # Saved-entry Play: decrypt with the stored mode, authenticate, hand
      # launch_data to the waiting boot thread. Auth runs on its own thread
      # so the page stays responsive.
      def play_saved(entry)
        set_busy("Authenticating #{entry[:char_name]}...")
        Thread.new do
          password = decrypt_password(entry)
          if password.nil?
            fail_login('Could not decrypt the saved password (master-password mode is not supported in the browser login yet - use --gtk-login).')
          else
            authenticate_and_finish(
              account: entry[:username], password: password,
              character: entry[:char_name], game_code: entry[:game_code],
              frontend: entry[:frontend], custom_launch: entry[:custom_launch],
              custom_launch_dir: entry[:custom_launch_dir]
            )
          end
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
            custom_launch: nil, custom_launch_dir: nil
          )
        end
      end

      def authenticate_and_finish(account:, password:, character:, game_code:, frontend:, custom_launch:, custom_launch_dir:)
        auth = @authenticator.call(account: account, password: password, character: character, game_code: game_code)
        launch_data = @launch_preparer.call(auth, frontend, custom_launch, custom_launch_dir)
        if launch_data.is_a?(Array) && launch_data.any?
          @queue << launch_data
        else
          fail_login('Authentication succeeded but no launch data was produced.')
        end
      rescue StandardError => e
        fail_login("Login failed: #{e.message}")
      end

      def decrypt_password(entry)
        require File.join(LIB_DIR, 'common', 'authentication', 'entry_store') unless defined?(Lich::Common::Authentication::EntryStore)
        store = Lich::Common::Authentication::EntryStore
        yaml = YAML.safe_load_file(store.yaml_file_path(@data_dir), permitted_classes: [Symbol]) rescue {}
        mode = ((yaml && yaml['encryption_mode']) || 'plaintext').to_sym
        return nil if mode == :master_password

        store.decrypt_password(entry[:password], mode: mode, account_name: entry[:username])
      rescue StandardError
        nil
      end

      def set_busy(message)
        @busy = message
        @error = nil
        Registry.find('lich/login')&.request_render
      end

      def fail_login(message)
        @busy = nil
        @error = message
        Lich.log("warning: WebUI login: #{message}") if defined?(Lich) && Lich.respond_to?(:log)
        Registry.find('lich/login')&.request_render
      end
    end
  end
end
