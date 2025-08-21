# frozen_string_literal: true

=begin
  Creature Display - Multi-target health bars

  Features:
  - One progress bar per creature in room (from GameObj.targets)
  - Health percentage fills the bar
  - Text overlay: "Name (curr/max) [SIW]"
  - Status indicators: S=stunned, I=immobilized, W=webbed, etc.

  Usage: ;creature_display
=end

require 'gtk3'
require 'yaml'
require 'cgi'

module CreatureDisplay
  VERSION = '1.0.0' unless defined?(VERSION)

  CONFIG_DIR = File.join(DATA_DIR, 'creature_display') unless defined?(CONFIG_DIR)
  CONFIG_FILE = File.join(CONFIG_DIR, 'config.yaml') unless defined?(CONFIG_FILE)

  DEFAULT_CONFIG = {
    'position'        => { 'x' => 100, 'y' => 100 },
    'window'          => {
      'width'         => 350,
      'height'        => 200,
      'decorated'     => false,
      'always_on_top' => true,
      'transparent'   => true
    },
    'dark_mode'       => false,
    'bar_height'      => 17,
    'bar_width'       => 350, # Bar width in pixels
    'bar_spacing'     => 2,
    'update_interval' => 500, # ms
    'max_name_length' => 20, # Max characters for creature name
    'font_size'       => 12, # Font size in px
    'colors'          => {
      'font'             => '#FFFFFF', # Font color
      'progress_healthy' => '#367f39', # Green for healthy HP (DEPRECATED - use hp_colors)
      'progress_damaged' => '#FF5722', # Red for damaged HP (DEPRECATED - use hp_colors)
      'background_dark'  => 'rgba(20, 40, 20, 0.9)', # Dark mode progress background
      'background_light' => 'rgba(60, 20, 20, 0.9)' # Light mode progress background
    },
    'hp_ranges'       => {
      'low'  => { 'min' => 0, 'max' => 33 },
      'mid'  => { 'min' => 34, 'max' => 66 },
      'high' => { 'min' => 67, 'max' => 100 }
    },
    'hp_colors'       => {
      'low'  => '#FF4444', # Bright red for low HP
      'mid'  => '#FFB000', # Dark yellow/orange for mid HP
      'high' => '#2E7D32'  # Dark green for high HP
    }
  }.freeze unless defined?(DEFAULT_CONFIG)

  @@window = nil
  @@config = nil
  @@save_timer = nil
  @@update_timer = nil
  @@target_bars = {} # target_id => progress_bar
  @@main_box = nil
  @@user_resized = false # Track if user manually resized window

  # Status effect abbreviations
  STATUS_ABBREV = {
    'stunned'     => 'S',
    'immobilized' => 'I',
    'webbed'      => 'W',
    'prone'       => 'P',
    'blind'       => 'B',
    'sunburst'    => 'U',
    'sleeping'    => 'Z',
    'poisoned'    => 'T'
  }.freeze unless defined?(STATUS_ABBREV)

  # Status effect colors
  STATUS_COLORS = {
    'stunned'     => '#FFD700', # Gold
    'immobilized' => '#FF69B4', # Hot Pink
    'webbed'      => '#C0C0C0', # Silver
    'prone'       => '#FFA500', # Orange
    'blind'       => '#8B4513', # Saddle Brown
    'sunburst'    => '#FFFF00', # Yellow
    'sleeping'    => '#9370DB', # Medium Purple
    'poisoned'    => '#32CD32'  # Lime Green
  }.freeze unless defined?(STATUS_COLORS)

  class << self
    def load_config
      @@config = DEFAULT_CONFIG.dup

      if File.exist?(CONFIG_FILE)
        begin
          saved_config = YAML.load_file(CONFIG_FILE)
          @@config.merge!(saved_config) if saved_config.is_a?(Hash)
        rescue => e
          puts "[CreatureDisplay] Error loading config: #{e.message}"
        end
      end
    end

    def save_config
      require 'fileutils'
      FileUtils.mkdir_p(CONFIG_DIR) unless Dir.exist?(CONFIG_DIR)
      File.write(CONFIG_FILE, @@config.to_yaml)
    rescue => e
      puts "[CreatureDisplay] Error saving config: #{e.message}"
    end

    def save_window_settings_debounced
      @@save_timer.kill if @@save_timer

      # Mark as user resized when settings are being saved
      @@user_resized = true

      @@save_timer = Thread.new do
        sleep 1
        save_window_settings
        @@save_timer = nil
      end
    end

    def save_window_settings
      return unless @@window

      x, y = @@window.position
      @@config['position']['x'] = x
      @@config['position']['y'] = y

      w, h = @@window.size
      @@config['window']['width'] = w
      @@config['window']['height'] = h
      @@config['window']['decorated'] = @@window.decorated?

      save_config
    end

    def apply_css
      provider = Gtk::CssProvider.new
      dark = @@config['dark_mode']
      transparent = @@config['window']['transparent']

      # Get configurable values
      bar_height = @@config['bar_height'] || 17
      font_size = @@config['font_size'] || 12
      colors = @@config['colors'] || DEFAULT_CONFIG['colors']

      font_color = colors['font'] || '#FFFFFF'
      progress_color = colors['progress_healthy'] || '#4CAF50'
      bg_color = dark ? (colors['background_dark'] || 'rgba(20, 40, 20, 0.9)') :
                        (colors['background_light'] || 'rgba(60, 20, 20, 0.9)')

      css = if dark
              <<~CSS
          window {
            background-color: rgba(46, 46, 46, #{transparent ? '0.9' : '1.0'});
            color: #DDDDDD;
          }
          progressbar {
            min-height: #{bar_height}px;
            border-radius: 3px;
            border: 1px solid rgba(80, 80, 80, 0.8);
          }
          progressbar trough {
            background-color: #{bg_color};
            border-radius: 3px;
            min-height: #{bar_height}px;
          }
          progressbar progress {
            background-color: #{progress_color};
            border-radius: 3px;
            min-height: #{bar_height}px;
          }
          label {
            color: #{font_color};
            font-size: #{font_size}px;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.9);
          }
        CSS
            else
              <<~CSS
          window {
            background-color: rgba(255, 255, 255, #{transparent ? '0.9' : '1.0'});
            color: #000000;
          }
          progressbar {
            min-height: #{bar_height}px;
            border-radius: 3px;
            border: 1px solid rgba(150, 150, 150, 0.8);
          }
          progressbar trough {
            background-color: #{bg_color};
            border-radius: 3px;
            min-height: #{bar_height}px;
          }
          progressbar progress {
            background-color: #{progress_color};
            border-radius: 3px;
            min-height: #{bar_height}px;
          }
          label {
            color: #{font_color};
            font-size: #{font_size}px;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.9);
          }
        CSS
            end

      provider.load(data: css)
      Gtk::StyleContext.add_provider_for_screen(
        Gdk::Screen.default,
        provider,
        Gtk::StyleProvider::PRIORITY_APPLICATION
      )
    end

    def create_window
      @@window = Gtk::Window.new('Creature Display')
      @@window.set_app_paintable(true)
      @@window.accept_focus = false
      @@window.focus_on_map = false

      # Transparency support
      if @@config['window']['transparent']
        @@window.override_background_color(:normal, Gdk::RGBA.parse("rgba(0,0,0,0)"))
      end

      # Window properties
      @@window.set_default_size(@@config['window']['width'], @@config['window']['height'])
      @@window.decorated = @@config['window']['decorated']
      @@window.set_keep_above(@@config['window']['always_on_top'])

      # Position
      if @@config['position']['x'] && @@config['position']['y']
        @@window.move(@@config['position']['x'], @@config['position']['y'])
      end

      setup_menu
      setup_content
      setup_signals

      # Reset user resize flag when creating new window
      @@user_resized = false

      @@window.show_all
    end

    def setup_menu
      menu = Gtk::Menu.new

      # Toggle title bar
      border_item = Gtk::MenuItem.new(label: 'Toggle Title Bar')
      border_item.signal_connect('activate') { toggle_decorations }
      menu.append(border_item)

      # Always on top
      top_item = Gtk::CheckMenuItem.new(label: 'Always on Top')
      top_item.active = @@config['window']['always_on_top']
      top_item.signal_connect('toggled') do
        @@config['window']['always_on_top'] = top_item.active?
        @@window.set_keep_above(top_item.active?)
        save_config
      end
      menu.append(top_item)

      # Dark mode
      dark_item = Gtk::CheckMenuItem.new(label: 'Dark Mode')
      dark_item.active = @@config['dark_mode']
      dark_item.signal_connect('toggled') do
        @@config['dark_mode'] = dark_item.active?
        save_config
        apply_css
      end
      menu.append(dark_item)

      # Transparency
      trans_item = Gtk::CheckMenuItem.new(label: 'Transparent')
      trans_item.active = @@config['window']['transparent']
      trans_item.signal_connect('toggled') do
        @@config['window']['transparent'] = trans_item.active?
        save_config
        recreate_window
      end
      menu.append(trans_item)

      # Reset auto-resize
      reset_item = Gtk::MenuItem.new(label: 'Reset Auto-Resize')
      reset_item.signal_connect('activate') do
        @@user_resized = false
        puts "[CreatureDisplay] Auto-resize re-enabled"
      end
      menu.append(reset_item)

      # Configure max name length
      name_item = Gtk::MenuItem.new(label: 'Max Name Length...')
      name_item.signal_connect('activate') do
        configure_max_name_length
      end
      menu.append(name_item)

      # Configure appearance
      appearance_item = Gtk::MenuItem.new(label: 'Appearance...')
      appearance_item.signal_connect('activate') do
        configure_appearance
      end
      menu.append(appearance_item)

      menu.show_all

      # Right-click to show menu
      @@window.add_events(Gdk::EventMask::BUTTON_PRESS_MASK)
      @@window.signal_connect('button-press-event') do |_, event|
        if event.button == 3
          menu.popup_at_pointer(event)
          true
        else
          false
        end
      end
    end

    def setup_content
      # Scrollable container for multiple bars
      scroll = Gtk::ScrolledWindow.new
      scroll.set_policy(:never, :automatic)
      scroll.set_size_request(-1, @@config['window']['height'] - 20)

      @@main_box = Gtk::Box.new(:vertical, @@config['bar_spacing'] || 2)
      @@main_box.set_margin_top(5)
      @@main_box.set_margin_bottom(5)
      @@main_box.set_margin_left(5)
      @@main_box.set_margin_right(5)

      scroll.add(@@main_box)
      @@window.add(scroll)
    end

    def setup_signals
      @@window.signal_connect('delete-event') do
        stop
        # Kill the script when window is closed
        Script.kill('creature_display') if Script.running?('creature_display')
        true
      end

      @@window.signal_connect('configure-event') do |_w, _|
        save_window_settings_debounced
        false
      end
    end

    def toggle_decorations
      save_window_settings
      @@config['window']['decorated'] = !@@window.decorated?
      save_config
      recreate_window
    end

    def recreate_window
      stop_update_timer
      Gtk.queue do
        @@window.destroy if @@window
        create_window
        start_update_timer
      end
    end

    def configure_max_name_length
      dialog = Gtk::Dialog.new(
        title: 'Configure Max Name Length',
        parent: @@window,
        flags: [:modal, :destroy_with_parent]
      )

      dialog.add_button('Cancel', :cancel)
      dialog.add_button('OK', :ok)

      content = dialog.content_area

      label = Gtk::Label.new('Maximum characters for creature names:')
      content.pack_start(label, :expand => false, :fill => false, :padding => 10)

      current_value = @@config['max_name_length'] || 20
      spinbutton = Gtk::SpinButton.new(5, 50, 1)
      spinbutton.value = current_value
      content.pack_start(spinbutton, :expand => false, :fill => false, :padding => 10)

      note_label = Gtk::Label.new('Names longer than this will be truncated from the front,\npreserving the noun at the end.')
      note_label.set_justify(:center)
      content.pack_start(note_label, :expand => false, :fill => false, :padding => 10)

      dialog.show_all

      if dialog.run == :ok
        new_value = spinbutton.value.to_i
        @@config['max_name_length'] = new_value
        save_config
        puts "[CreatureDisplay] Max name length set to #{new_value}"
      end

      dialog.destroy
    end

    def configure_appearance
      dialog = Gtk::Dialog.new(
        title: 'Appearance Settings',
        parent: @@window,
        flags: [:modal, :destroy_with_parent]
      )

      dialog.add_button('Cancel', :cancel)
      dialog.add_button('Apply', :apply)
      dialog.add_button('OK', :ok)

      content = dialog.content_area
      content.spacing = 10

      # Create notebook for tabs
      notebook = Gtk::Notebook.new

      # == Size & Layout Tab ==
      size_box = Gtk::Box.new(:vertical, 5)
      size_box.set_margin_left(10)
      size_box.set_margin_right(10)
      size_box.set_margin_top(10)
      size_box.set_margin_bottom(10)

      # Bar height
      bar_height_label = Gtk::Label.new('Bar Height (px):')
      bar_height_label.halign = :start
      size_box.pack_start(bar_height_label, :expand => false, :fill => false, :padding => 0)

      bar_height_spin = Gtk::SpinButton.new(10, 40, 1)
      bar_height_spin.value = @@config['bar_height'] || 17
      size_box.pack_start(bar_height_spin, :expand => false, :fill => false, :padding => 0)

      # Font size
      font_size_label = Gtk::Label.new('Font Size (px):')
      font_size_label.halign = :start
      size_box.pack_start(font_size_label, :expand => false, :fill => false, :padding => 5)

      font_size_spin = Gtk::SpinButton.new(8, 24, 1)
      font_size_spin.value = @@config['font_size'] || 12
      size_box.pack_start(font_size_spin, :expand => false, :fill => false, :padding => 0)

      # Bar width
      bar_width_label = Gtk::Label.new('Bar Width (px):')
      bar_width_label.halign = :start
      size_box.pack_start(bar_width_label, :expand => false, :fill => false, :padding => 5)

      bar_width_spin = Gtk::SpinButton.new(200, 600, 10)
      bar_width_spin.value = @@config['bar_width'] || 350
      size_box.pack_start(bar_width_spin, :expand => false, :fill => false, :padding => 0)

      notebook.append_page(size_box, Gtk::Label.new('Size'))

      # == Colors Tab ==
      colors_box = Gtk::Box.new(:vertical, 5)
      colors_box.set_margin_left(10)
      colors_box.set_margin_right(10)
      colors_box.set_margin_top(10)
      colors_box.set_margin_bottom(10)

      colors = @@config['colors'] || DEFAULT_CONFIG['colors']

      # Font color
      font_color_label = Gtk::Label.new('Font Color:')
      font_color_label.halign = :start
      colors_box.pack_start(font_color_label, :expand => false, :fill => false, :padding => 0)

      font_color_entry = Gtk::Entry.new
      font_color_entry.text = colors['font'] || '#FFFFFF'
      colors_box.pack_start(font_color_entry, :expand => false, :fill => false, :padding => 0)

      # Healthy HP color
      healthy_color_label = Gtk::Label.new('Healthy HP Color:')
      healthy_color_label.halign = :start
      colors_box.pack_start(healthy_color_label, :expand => false, :fill => false, :padding => 5)

      healthy_color_entry = Gtk::Entry.new
      healthy_color_entry.text = colors['progress_healthy'] || '#4CAF50'
      colors_box.pack_start(healthy_color_entry, :expand => false, :fill => false, :padding => 0)

      # Damaged HP color
      damaged_color_label = Gtk::Label.new('Damaged HP Color:')
      damaged_color_label.halign = :start
      colors_box.pack_start(damaged_color_label, :expand => false, :fill => false, :padding => 5)

      damaged_color_entry = Gtk::Entry.new
      damaged_color_entry.text = colors['progress_damaged'] || '#FF5722'
      colors_box.pack_start(damaged_color_entry, :expand => false, :fill => false, :padding => 0)

      # Background colors
      bg_dark_label = Gtk::Label.new('Dark Mode Background:')
      bg_dark_label.halign = :start
      colors_box.pack_start(bg_dark_label, :expand => false, :fill => false, :padding => 5)

      bg_dark_entry = Gtk::Entry.new
      bg_dark_entry.text = colors['background_dark'] || 'rgba(20, 40, 20, 0.9)'
      colors_box.pack_start(bg_dark_entry, :expand => false, :fill => false, :padding => 0)

      bg_light_label = Gtk::Label.new('Light Mode Background:')
      bg_light_label.halign = :start
      colors_box.pack_start(bg_light_label, :expand => false, :fill => false, :padding => 5)

      bg_light_entry = Gtk::Entry.new
      bg_light_entry.text = colors['background_light'] || 'rgba(60, 20, 20, 0.9)'
      colors_box.pack_start(bg_light_entry, :expand => false, :fill => false, :padding => 0)

      notebook.append_page(colors_box, Gtk::Label.new('Colors'))

      # == Status Colors Tab ==
      status_box = Gtk::Box.new(:vertical, 5)
      status_box.set_margin_left(10)
      status_box.set_margin_right(10)
      status_box.set_margin_top(10)
      status_box.set_margin_bottom(10)

      status_label = Gtk::Label.new('Status Effect Colors:')
      status_label.halign = :start
      status_box.pack_start(status_label, :expand => false, :fill => false, :padding => 5)

      # Create a scrollable area for status colors
      scroll = Gtk::ScrolledWindow.new
      scroll.set_policy(:never, :automatic)
      scroll.set_size_request(-1, 200)

      status_colors_box = Gtk::Box.new(:vertical, 3)

      # Add entry for each status effect
      STATUS_COLORS.each do |status, default_color|
        row = Gtk::Box.new(:horizontal, 5)

        label = Gtk::Label.new("#{status.capitalize}:")
        label.set_size_request(100, -1)
        label.halign = :start
        row.pack_start(label, :expand => false, :fill => false, :padding => 0)

        entry = Gtk::Entry.new
        # Use saved color if available, otherwise default
        saved_color = @@config['status_colors'] && @@config['status_colors'][status]
        entry.text = saved_color || default_color
        entry.name = "status_color_#{status}" # Store status name for later
        row.pack_start(entry, :expand => true, :fill => true, :padding => 0)

        status_colors_box.pack_start(row, :expand => false, :fill => false, :padding => 2)
      end

      scroll.add(status_colors_box)
      status_box.pack_start(scroll, :expand => true, :fill => true, :padding => 0)

      notebook.append_page(status_box, Gtk::Label.new('Status Colors'))

      # == HP Ranges Tab ==
      hp_box = Gtk::Box.new(:vertical, 5)
      hp_box.set_margin_left(10)
      hp_box.set_margin_right(10)
      hp_box.set_margin_top(10)
      hp_box.set_margin_bottom(10)

      hp_ranges = @@config['hp_ranges'] || DEFAULT_CONFIG['hp_ranges']
      hp_colors = @@config['hp_colors'] || DEFAULT_CONFIG['hp_colors']

      # Low HP Range
      low_label = Gtk::Label.new('Low HP Range:')
      low_label.halign = :start
      hp_box.pack_start(low_label, :expand => false, :fill => false, :padding => 5)

      low_row = Gtk::Box.new(:horizontal, 5)
      low_min_spin = Gtk::SpinButton.new(0, 100, 1)
      low_min_spin.value = hp_ranges['low']['min']
      low_max_spin = Gtk::SpinButton.new(0, 100, 1)
      low_max_spin.value = hp_ranges['low']['max']
      low_color_entry = Gtk::Entry.new
      low_color_entry.text = hp_colors['low']
      low_color_entry.set_size_request(100, -1)

      low_row.pack_start(Gtk::Label.new('Min:'), :expand => false, :fill => false, :padding => 0)
      low_row.pack_start(low_min_spin, :expand => false, :fill => false, :padding => 0)
      low_row.pack_start(Gtk::Label.new('Max:'), :expand => false, :fill => false, :padding => 5)
      low_row.pack_start(low_max_spin, :expand => false, :fill => false, :padding => 0)
      low_row.pack_start(Gtk::Label.new('Color:'), :expand => false, :fill => false, :padding => 5)
      low_row.pack_start(low_color_entry, :expand => false, :fill => false, :padding => 0)
      hp_box.pack_start(low_row, :expand => false, :fill => false, :padding => 0)

      # Mid HP Range
      mid_label = Gtk::Label.new('Mid HP Range:')
      mid_label.halign = :start
      hp_box.pack_start(mid_label, :expand => false, :fill => false, :padding => 5)

      mid_row = Gtk::Box.new(:horizontal, 5)
      mid_min_spin = Gtk::SpinButton.new(0, 100, 1)
      mid_min_spin.value = hp_ranges['mid']['min']
      mid_max_spin = Gtk::SpinButton.new(0, 100, 1)
      mid_max_spin.value = hp_ranges['mid']['max']
      mid_color_entry = Gtk::Entry.new
      mid_color_entry.text = hp_colors['mid']
      mid_color_entry.set_size_request(100, -1)

      mid_row.pack_start(Gtk::Label.new('Min:'), :expand => false, :fill => false, :padding => 0)
      mid_row.pack_start(mid_min_spin, :expand => false, :fill => false, :padding => 0)
      mid_row.pack_start(Gtk::Label.new('Max:'), :expand => false, :fill => false, :padding => 5)
      mid_row.pack_start(mid_max_spin, :expand => false, :fill => false, :padding => 0)
      mid_row.pack_start(Gtk::Label.new('Color:'), :expand => false, :fill => false, :padding => 5)
      mid_row.pack_start(mid_color_entry, :expand => false, :fill => false, :padding => 0)
      hp_box.pack_start(mid_row, :expand => false, :fill => false, :padding => 0)

      # High HP Range
      high_label = Gtk::Label.new('High HP Range:')
      high_label.halign = :start
      hp_box.pack_start(high_label, :expand => false, :fill => false, :padding => 5)

      high_row = Gtk::Box.new(:horizontal, 5)
      high_min_spin = Gtk::SpinButton.new(0, 100, 1)
      high_min_spin.value = hp_ranges['high']['min']
      high_max_spin = Gtk::SpinButton.new(0, 100, 1)
      high_max_spin.value = hp_ranges['high']['max']
      high_color_entry = Gtk::Entry.new
      high_color_entry.text = hp_colors['high']
      high_color_entry.set_size_request(100, -1)

      high_row.pack_start(Gtk::Label.new('Min:'), :expand => false, :fill => false, :padding => 0)
      high_row.pack_start(high_min_spin, :expand => false, :fill => false, :padding => 0)
      high_row.pack_start(Gtk::Label.new('Max:'), :expand => false, :fill => false, :padding => 5)
      high_row.pack_start(high_max_spin, :expand => false, :fill => false, :padding => 0)
      high_row.pack_start(Gtk::Label.new('Color:'), :expand => false, :fill => false, :padding => 5)
      high_row.pack_start(high_color_entry, :expand => false, :fill => false, :padding => 0)
      hp_box.pack_start(high_row, :expand => false, :fill => false, :padding => 0)

      notebook.append_page(hp_box, Gtk::Label.new('HP Ranges'))

      content.pack_start(notebook, :expand => true, :fill => true, :padding => 0)

      dialog.set_size_request(400, 500)
      dialog.show_all

      # Handle dialog responses
      loop do
        response = dialog.run

        case response
        when :apply, :ok
          # Apply settings
          @@config['bar_height'] = bar_height_spin.value.to_i
          @@config['font_size'] = font_size_spin.value.to_i
          @@config['bar_width'] = bar_width_spin.value.to_i

          @@config['colors'] ||= {}
          @@config['colors']['font'] = font_color_entry.text
          @@config['colors']['progress_healthy'] = healthy_color_entry.text
          @@config['colors']['progress_damaged'] = damaged_color_entry.text
          @@config['colors']['background_dark'] = bg_dark_entry.text
          @@config['colors']['background_light'] = bg_light_entry.text

          # Save status colors
          @@config['status_colors'] ||= {}
          status_colors_box.children.each do |row|
            next unless row.is_a?(Gtk::Box)
            entry = row.children.find { |c| c.is_a?(Gtk::Entry) }
            next unless entry && entry.name&.start_with?('status_color_')

            status_name = entry.name.sub('status_color_', '')
            @@config['status_colors'][status_name] = entry.text
          end

          # Save HP ranges and colors
          @@config['hp_ranges'] ||= {}
          @@config['hp_ranges']['low'] = { 'min' => low_min_spin.value.to_i, 'max' => low_max_spin.value.to_i }
          @@config['hp_ranges']['mid'] = { 'min' => mid_min_spin.value.to_i, 'max' => mid_max_spin.value.to_i }
          @@config['hp_ranges']['high'] = { 'min' => high_min_spin.value.to_i, 'max' => high_max_spin.value.to_i }

          @@config['hp_colors'] ||= {}
          @@config['hp_colors']['low'] = low_color_entry.text
          @@config['hp_colors']['mid'] = mid_color_entry.text
          @@config['hp_colors']['high'] = high_color_entry.text

          save_config
          recreate_window # Recreate to apply changes
          puts "[CreatureDisplay] Appearance settings updated"

          break if response == :ok
        else
          break
        end
      end

      dialog.destroy
    end

    def start_update_timer
      @@update_timer = Thread.new do
        loop do
          sleep((@@config['update_interval'] || 500) / 1000.0)
          Gtk.queue { update_display }
          break unless @@window
        end
      end
    end

    def stop_update_timer
      if @@update_timer
        @@update_timer.kill
        @@update_timer = nil
      end
    end

    def update_display
      return unless @@window && @@main_box

      # Get current targets from GameObj
      current_targets = get_current_targets
      current_ids = current_targets.map(&:id).to_set

      # Remove bars for targets no longer present
      @@target_bars.keys.each do |target_id|
        unless current_ids.include?(target_id)
          remove_target_bar(target_id)
        end
      end

      # Add/update bars for current targets
      current_targets.each do |target|
        update_target_bar(target)
      end

      # Adjust window height based on number of targets
      adjust_window_height(current_targets.size)
    end

    def get_current_targets
      return [] unless defined?(GameObj) && GameObj.respond_to?(:targets)

      # Get all creatures from GameObj.targets
      GameObj.targets.select do |obj|
        obj.id && obj.id.to_i > 0 && obj.noun && obj.name
      end
    rescue => e
      puts "[CreatureDisplay] Error getting targets: #{e.message}" if @@config['debug']
      []
    end

    def remove_target_bar(target_id)
      if (components = @@target_bars[target_id])
        @@main_box.remove(components[:overlay])
        @@target_bars.delete(target_id)
      end
    end

    def update_target_bar(target)
      target_id = target.id.to_i

      # Clean up expired status effects (piggyback on display updates)
      creature = defined?(Creature) ? Creature[target_id] : nil
      creature&.cleanup_expired_statuses

      # Create bar if it doesn't exist
      unless @@target_bars[target_id]
        create_target_bar(target)
      end

      # Update the components
      components = @@target_bars[target_id]
      bar = components[:bar]
      label = components[:label]

      # Build display text with truncated name to preserve HP and status visibility
      name = target.name || "Unknown"
      max_name_length = @@config['max_name_length'] || 20
      truncated_name = truncate_name(name, max_name_length)
      hp_text = build_hp_text(target, creature)
      status_text = build_status_text(creature) # This now returns markup with colors

      # Escape only the name and HP parts, not the status text which has markup
      escaped_name = CGI.escape_html(truncated_name)
      escaped_hp = CGI.escape_html(hp_text)

      # Use center alignment with truncated names and configurable font color
      font_color = (@@config['colors'] && @@config['colors']['font']) || '#FFFFFF'
      label.set_markup("<span color='#{font_color}' weight='bold'>#{escaped_name} #{escaped_hp}</span>#{status_text}")
      label.halign = :center

      # Set progress based on HP percentage
      if creature && creature.max_hp && creature.max_hp > 0
        current_hp = [creature.current_hp || 0, 0].max
        fraction = current_hp.to_f / creature.max_hp
        bar.fraction = fraction

        # Color based on health
        update_bar_color(bar, fraction)
      else
        bar.fraction = 1.0 # Unknown HP = full bar
      end
    end

    def create_target_bar(target)
      target_id = target.id.to_i
      bar_height = @@config['bar_height'] || 17

      # Create an overlay container
      overlay = Gtk::Overlay.new
      overlay.set_size_request(-1, bar_height)

      # Create the progress bar (no text)
      bar_width = @@config['bar_width'] || 350
      bar = Gtk::ProgressBar.new
      bar.set_size_request(bar_width, bar_height)
      bar.show_text = false # Disable built-in text
      bar.fraction = 1.0

      # Create a label for the text overlay
      label = Gtk::Label.new(target.name || "Unknown")
      font_color = (@@config['colors'] && @@config['colors']['font']) || '#FFFFFF'
      label.set_markup("<span color='#{font_color}' weight='bold'>#{target.name || 'Unknown'}</span>")
      label.halign = :center # Center alignment with truncated names
      label.valign = :center

      # Add progress bar as base, label as overlay
      overlay.add(bar)
      overlay.add_overlay(label)

      @@main_box.pack_start(overlay, :expand => false, :fill => false, :padding => 0)

      # Store both components
      @@target_bars[target_id] = { overlay: overlay, bar: bar, label: label }

      overlay.show_all
    end

    def build_hp_text(_target, creature)
      if creature && creature.max_hp && creature.max_hp > 0
        current_hp = [creature.current_hp || 0, 0].max
        "(#{current_hp}/#{creature.max_hp})"
      else
        "(--/--)"
      end
    end

    def build_status_text(creature)
      return "" unless creature && creature.status && !creature.status.empty?

      # Convert status effects to colored abbreviations
      colored_abbrevs = creature.status.map do |status|
        status_key = status.to_s.downcase
        abbrev = STATUS_ABBREV[status_key] || status.to_s[0].upcase

        # Use configurable color if available, otherwise default
        color = if @@config['status_colors'] && @@config['status_colors'][status_key]
                  @@config['status_colors'][status_key]
                else
                  STATUS_COLORS[status_key] || '#FFFFFF'
                end

        "<span color='#{color}'>#{abbrev}</span>"
      end.compact

      colored_abbrevs.empty? ? "" : " [#{colored_abbrevs.join}]  " # Added padding with 2 spaces at end
    end

    def truncate_name(name, max_length)
      return name if name.length <= max_length

      # Find the last word (noun) to preserve
      words = name.split
      return name if words.length <= 1

      last_word = words.last

      # If the last word itself is too long, just truncate normally
      if last_word.length >= max_length
        return name[0, max_length]
      end

      # Keep removing words from the front until we fit
      # Always preserve the last word (noun)
      available_length = max_length - last_word.length - 3 # -3 for "..."

      if available_length <= 0
        return "...#{last_word}"
      end

      # Try to fit as much as possible from the front
      front_part = ""
      words[0..-2].each do |word|
        test_part = front_part.empty? ? word : "#{front_part} #{word}"
        if test_part.length <= available_length
          front_part = test_part
        else
          break
        end
      end

      if front_part.empty?
        "...#{last_word}"
      else
        "#{front_part}...#{last_word}"
      end
    end

    def update_bar_color(bar, fraction)
      # Get HP ranges and colors from config with full defaults
      default_ranges = DEFAULT_CONFIG['hp_ranges']
      default_colors = DEFAULT_CONFIG['hp_colors']

      hp_ranges = @@config['hp_ranges'] || {}
      hp_colors = @@config['hp_colors'] || {}

      # Ensure all range values exist with defaults
      low_min = hp_ranges.dig('low', 'min') || default_ranges['low']['min']
      low_max = hp_ranges.dig('low', 'max') || default_ranges['low']['max']
      mid_min = hp_ranges.dig('mid', 'min') || default_ranges['mid']['min']
      mid_max = hp_ranges.dig('mid', 'max') || default_ranges['mid']['max']
      high_min = hp_ranges.dig('high', 'min') || default_ranges['high']['min']
      high_max = hp_ranges.dig('high', 'max') || default_ranges['high']['max']

      # Ensure all color values exist with defaults
      low_color = hp_colors['low'] || default_colors['low']
      mid_color = hp_colors['mid'] || default_colors['mid']
      high_color = hp_colors['high'] || default_colors['high']

      # Convert fraction to percentage
      percentage = (fraction * 100).to_i

      # Determine which range the HP falls into
      color = if percentage >= low_min && percentage <= low_max
                low_color
              elsif percentage >= mid_min && percentage <= mid_max
                mid_color
              elsif percentage >= high_min && percentage <= high_max
                high_color
              else
                # Fallback to mid color if ranges don't cover all percentages
                mid_color
              end

      # Apply CSS style to this specific progress bar
      provider = Gtk::CssProvider.new
      css = <<~CSS
        progressbar progress {
          background-color: #{color};
        }
      CSS

      provider.load(data: css)
      style_context = bar.style_context
      style_context.add_provider(provider, Gtk::StyleProvider::PRIORITY_APPLICATION + 1)
    end

    def adjust_window_height(target_count)
      # Don't auto-resize if user has manually resized the window
      return if @@user_resized

      if target_count == 0
        desired_height = 50 # Minimum height
      else
        bar_height = @@config['bar_height'] || 17
        spacing = @@config['bar_spacing'] || 2
        margin = 20
        desired_height = (bar_height * target_count) + (spacing * (target_count - 1)) + margin
      end

      current_w, current_h = @@window.size
      if (current_h - desired_height).abs > 10 # Only resize if significant difference
        @@window.resize(current_w, desired_height)
      end
    end

    def run
      puts "Starting Creature Display..."

      Gtk.queue do
        load_config
        apply_css
        create_window
        start_update_timer
        puts "Creature Display running. Right-click for options."
      end
    end

    def stop
      return unless @@window # Already stopped

      puts "Stopping Creature Display..."

      stop_update_timer
      @@save_timer.kill if @@save_timer

      # Ensure window cleanup happens
      if @@window
        begin
          Gtk.queue do
            save_window_settings if @@window
            @@window.destroy if @@window && !@@window.destroyed?
            @@window = nil
            @@target_bars.clear
          end
        rescue
          # Force cleanup even if GTK queue fails
          begin
            @@window.destroy if @@window && !@@window.destroyed?
          rescue
            # Window already destroyed
          end
          @@window = nil
          @@target_bars.clear
        end
      end

      # Kill the script when stop is called (but not if called from before_dying)
      unless caller.any? { |line| line.include?('before_dying') }
        Thread.new do
          sleep 0.1 # Give GTK time to clean up
          Script.kill('creature_display') if Script.running?('creature_display')
        end
      end
    end
  end
end

# Script execution
if Script.current.name == 'creature_display'
  begin
    require 'gtk3'
  rescue LoadError
    echo "Error: GTK3 gem not found. Install with: gem install gtk3"
    exit
  end

  # Ensure cleanup happens on script termination
  before_dying do
    CreatureDisplay.stop
  end

  # Also handle interrupts
  Signal.trap("INT") { CreatureDisplay.stop }
  Signal.trap("TERM") { CreatureDisplay.stop }

  CreatureDisplay.run

  # Keep script alive
  loop do
    sleep 1
    break unless Script.running?('creature_display')
  end

  CreatureDisplay.stop
end
