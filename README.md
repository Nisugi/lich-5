  ## Summary
  This PR introduces a comprehensive creature combat tracking system for Lich5, providing detailed monitoring
  and analysis capabilities for Gemstone IV combat encounters.

  ### Core Features
  - **Creature Registration & Tracking**: New `Creature` class automatically registers NPCs during combat and
  tracks their state throughout encounters
  - **Combat Event Processing**: Enhanced combat processor that monitors damage, critical hits, status
  effects, and creature lifecycle events
  - **HP Analysis System**: Damage reporting functionality to analyze creature HP pools and combat
  effectiveness
  - **Status Effect Monitoring**: Comprehensive status effect detection with pattern matching for
  buffs/debuffs/conditions

  ### Key Components Added
  1. **lib/gemstone/creature.rb**: Core creature management with automatic registration, damage tracking, and
  statistical analysis
  2. **lib/gemstone/combat/tracker.rb**: Combat event coordination and creature lifecycle management
  3. **lib/gemstone/combat/processor.rb**: Real-time combat log parsing and event detection
  4. **lib/gemstone/combat/defs/**: Pattern definitions for damage, criticals, and status effects
  5. **Integration with xmlparser.rb**: Automatic NPC registration from game data streams

  ### Technical Implementation
  - **Thread-safe design**: Uses concurrent data structures for multi-script safety
  - **Memory management**: Automatic cleanup of old creature instances to prevent memory leaks
  - **Fatal crit tracking**: Distinguishes between HP death and fatal critical hit deaths
  - **Enhanced status patterns**: Updated regex patterns for more accurate status effect detection
  - **Debug capabilities**: Extensive debugging output for troubleshooting and development

  ### Status Effect Improvements
  - Added new status effects: `roundtime`, `sounds`, `calm`, `natures_decay`, `tangleweed`
  - Refined existing patterns for `blind`, `immobilized`, `sunburst` with more accurate removal detection
  - Better pattern matching for complex status interactions

  ### Usage Examples
  ```ruby
  # Get damage analysis for HP estimation
  Creature.print_damage_report(sort_by: :max_damage, min_samples: 3)

  # Check specific creature status
  creature = Creature[35642323]
  puts creature.status_effects  # [:stunned, :prone]
  puts creature.injured_locations  # [:leftArm, :chest]
  puts creature.fatal_crit?  # true if killed by fatal crit vs HP loss

  Benefits

  - Script Authors: Better combat decision making with real-time creature state data
  - Hunters: HP pool analysis for optimal spell/weapon selection (fatal crits excluded from max HP)

  ### Available Commands & Configuration

  #### Basic Control Commands
  # Enable/disable combat tracking
  Lich::Gemstone::Combat::Tracker.enable!
  Lich::Gemstone::Combat::Tracker.disable!

  # Debug control
  Lich::Gemstone::Combat::Tracker.enable_debug!
  Lich::Gemstone::Combat::Tracker.disable_debug!

  # Set fallback HP for unknown creatures
  Lich::Gemstone::Combat::Tracker.set_fallback_hp(400)

  Configuration Options

  # Configure multiple settings at once
  Lich::Gemstone::Combat::Tracker.configure({
    enabled: true,              # Master enable/disable
    track_damage: true,         # Track damage values and HP loss
    track_wounds: true,         # Track wound locations and severity
    track_flares: false,        # Track weapon/armor flares (performance impact)
    track_statuses: true,       # Track status effects (stuns, webs, etc.)
    track_sequences: false,     # Track attack sequences (heavy processing)
    max_threads: 2,             # Number of processing threads (1 = synchronous)
    debug: false,               # Enable debug output
    buffer_size: 200,           # Max lines buffered before processing
    fallback_max_hp: 350        # Default max HP for unknown creatures
  })

  Status & Reporting Commands

  # Check current status
  Lich::Gemstone::Combat::Tracker.stats
  # => { enabled: true, buffer_size: 15, settings: {...}, active: 1, total: 45 }

  # Damage analysis reports
  Creature.print_damage_report(
    sort_by: :max_damage,       # :name, :max_damage, :avg_damage
    min_samples: 3,             # Minimum kills required to show creature
    include_fatal: false        # Include fatal crit deaths in HP analysis
  )

  # Get raw damage data
  Creature.damage_report(min_samples: 2, sort_by: :name)

  # Creature lookup
  creature = Creature[4326765]
  creature.status_effects        # [:stunned, :prone]
  creature.injured_locations     # [:leftArm, :chest]
  creature.injuries              # {leftArm: 3, chest: 2}
  creature.fatal_crit?           # true if killed by fatal crit

  Creature Lookup & Analysis

  # Lookup by exist ID (primary method)
  creature = Creature[12345]

  # Get all tracked creatures
  all_creatures = Creature.all

  # Filter by name (manual search)
  goblins = Creature.all.select { |c| c.name.downcase.include?("goblin") }

  Performance Tuning

  - max_threads: 1 - Synchronous processing (lowest resource usage)
  - max_threads: 2 - Async processing (balanced performance/resources)
  - buffer_size: 100-500 - Adjust based on combat intensity and memory constraints

  Memory Management

  # Cleanup old creature instances
  Creature.cleanup_old(max_age_seconds: 3600)  # Remove creatures older than 1 hour
  Creature.cleanup_old(max_instances: 500)     # Keep only 500 most recent creatures
