# frozen_string_literal: true

# Offline mapdb StringProc -> MapEngine schema converter.
#
# Reads a map JSON file, recognizes the proven StringProc idiom families, and
# rewrites their ";e ..." edge values as declarative schema entries. Every
# emitted entry is checked against MapEngine::Validator before it replaces the
# proc; anything the converter cannot prove is left untouched and listed in
# the residue report.
#
#   ruby tools/mapdb_convert.rb --in map-123.json                # dry run: stats only
#   ruby tools/mapdb_convert.rb --in map-123.json --out new.json --report residue.txt
#
# The converter is deliberately conservative: a recognizer matches an exact
# idiom (whitespace-tolerant) or it does not fire at all. Behavioral review
# happens per idiom, not per proc.

require 'json'
require 'optparse'

lib_dir = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

module Lich; module Common; end; end
require 'common/map/map_engine'
require 'common/map/map_strategies'

class MapdbConverter
  Result = Struct.new(:idiom, :schema)

  QUOTED = /(?:'((?:[^'\\]|\\.)*)'|"((?:[^"\\]|\\.)*)")/

  attr_reader :stats, :residue

  def initialize
    @stats = Hash.new(0)
    @residue = { 'wayto'  => Hash.new { |h, k| h[k] = [] },
                 'timeto' => Hash.new { |h, k| h[k] = [] } }
  end

  # --- timeto recognizers ---------------------------------------------------

  def convert_timeto(body)
    body = body.strip
    if (m = body.match(/\AMap\[(\d+)\]\.timeto\[['"](\d+)['"]\]\.call;?\z/))
      return Result.new('delegation', { 'same_as' => "#{m[1]}:#{m[2]}" })
    end
    if (m = body.match(/\A\$mapdb_instability_timeto\[(\d+)\]\z/))
      return Result.new('event_instability', { 'event' => 'instability', 'key' => m[1].to_i })
    end
    if (m = body.match(/\AUserVars\.mapdb_use_(\w+)\s*==\s*true\s*\?\s*(\d+(?:\.\d+)?)\s*:\s*nil;?\z/))
      return Result.new('setting_gate', { 'cost' => numeric(m[2]), 'requires' => ["setting:#{m[1]}"] })
    end
    if (m = body.match(/\AUserVars\.mapdb_use_(\w+)\s*==\s*true\s+and\s+
                        !UserVars\.mapdb_(\w+)\.nil\?\s+and\s+
                        Time\.now\.to_i\s*<\s*UserVars\.mapdb_\2\s+and\s+
                        !hidden\?\s+and\s+!invisible\?\s*\?\s*(\d+(?:\.\d+)?)\s*:\s*nil;?\z/x))
      return Result.new('timed_grant_gate',
                        { 'cost'     => numeric(m[3]),
                          'requires' => ["setting:#{m[1]}", "grant:#{m[2]}", 'not:hidden', 'not:invisible'] })
    end
    convert_timeto_char_gates(body) || convert_timeto_var_gates(body)
  end

  NUM = /\d+(?:\.\d+)?/

  # Character-identity gates: profession, race, gender, spell, climate+sitting.
  def convert_timeto_char_gates(body)
    if (m = body.match(/\AStats\.(prof|race|gender)\s*==\s*'([^']+)'\s*\?\s*(#{NUM})\s*:\s*nil;?\z/)) ||
       (m = body.match(/\A\(\(!defined\?\(Stats\.(prof|race|gender)\)\s+or\s+
                        Stats\.\1\s*==\s*'([^']+)'\)\s*\?\s*(#{NUM})\s*:\s*nil\);?\z/x)) ||
       (m = body.match(/\A\(!defined\?\(Stats\.(prof|race|gender)\)\s+or\s+
                        Stats\.\1\s*==\s*'([^']+)'\)\s*\?\s*(#{NUM})\s*:\s*nil;?\z/x)) ||
       (m = body.match(/\Aif\s+Stats\.(prof|race|gender)\s*==\s*'([^']+)';\s*(#{NUM});\s*else;\s*nil;\s*end;?\z/))
      return Result.new("#{m[1]}_gate", { 'cost' => numeric(m[3]), 'requires' => ["#{m[1]}:#{m[2]}"] })
    end
    if (m = body.match(/\AUserVars\.mapdb_premium\.nil\?\s*\?\s*(#{NUM})\s*:\s*(#{NUM});?\z/))
      return Result.new('var_flag_gate',
                        { 'cost' => numeric(m[2]), 'requires' => ['var:premium'],
                          'else' => { 'cost' => numeric(m[1]) } })
    end
    if (m = body.match(/\Acheckspell\((\d+)\)\s*\?\s*(#{NUM})\s*:\s*(#{NUM});?\z/))
      return Result.new('spell_gate',
                        { 'cost' => numeric(m[2]), 'requires' => ["spell:#{m[1]}"],
                          'else' => { 'cost' => numeric(m[3]) } })
    end
    if (m = body.match(/\Achecksitting\s*&&\s*Room\.current\.climate\s*==\s*'([^']+)'\s*\?\s*(#{NUM})\s*:\s*(#{NUM});?\z/))
      return Result.new('climate_gate',
                        { 'cost' => numeric(m[2]), 'requires' => ['is:sitting', "climate:#{m[1]}"],
                          'else' => { 'cost' => numeric(m[3]) } })
    end
    if (m = body.match(/\ATime\.now\.month\s*==\s*(\d+)\s*\?\s*(#{NUM})\s*:\s*nil;?\z/))
      return Result.new('month_gate', { 'cost' => numeric(m[2]), 'requires' => ["month:#{m[1]}"] })
    end
    nil
  end

  # UserVars gates: event-origin equality and boolean flags.
  def convert_timeto_var_gates(body)
    if (m = body.match(/\A\(?!UserVars\.mapdb_(\w+)\.nil\?\s+and\s+UserVars\.mapdb_\1\s*==\s*(\d+)\)?\s*\?\s*(#{NUM})\s*:\s*nil;?\z/)) ||
       (m = body.match(/\A\(UserVars\.mapdb_(\w+)\s*==\s*(\d+)\s*\?\s*(#{NUM})\s*:\s*nil\);?\z/))
      return Result.new('var_eq_gate',
                        { 'cost' => numeric(m[3]), 'requires' => ["var:#{m[1]}=#{m[2]}"] })
    end
    if (m = body.match(/\AUserVars\.mapdb_(\w+)\s*\?\s*(#{NUM})\s*:\s*nil;?\z/)) ||
       (m = body.match(/\Aif\s+UserVars\.mapdb_(\w+)\s*==\s*true;\s*(#{NUM});\s*else;\s*nil;\s*end;?\z/))
      return Result.new('var_flag_gate', { 'cost' => numeric(m[2]), 'requires' => ["var:#{m[1]}"] })
    end
    nil
  end

  # --- wayto recognizers ----------------------------------------------------

  TABLE_JOIN = /\Atable\s*=\s*"([^"]+)";\s*
                fput\s+"go\ \#\{table\}\ table"\s+if\s+
                dothistimeout\("go\ \#\{table\}\ table",\s*25,\s*
                \/You\ \(\?:and\ your\ group\ \)\?head\ over\ to\|waves\.\*you\.\*\(\?:invites\|inviting\)\ you
                \(\?:\ and\ your\ group\)\?\ to\ \(\?:join\|come\ sit\ at\)\/\)\s*
                =~\s*\/inviting\ you\|invites\ you\/\z/x

  def convert_wayto(body)
    body = body.strip
    return Result.new('virtual', nil) if body == 'true'

    if (m = body.match(TABLE_JOIN))
      return Result.new('table_join', { 'strategy' => 'table_join', 'table' => m[1] })
    end
    if (r = convert_multifput_waitfor(body))
      return r
    end
    if (r = convert_wayto_strategy(body))
      return r
    end
    if (r = convert_wayto_special(body))
      return r
    end
    if (steps = convert_command_sequence(body))
      # A lone move is expressible as the plain string edge it always was.
      return Result.new('plain_move', steps.first['cmd']) if steps.length == 1 && steps.first['do'] == 'move'
      return Result.new('command_sequence', steps)
    end
    nil
  end

  INT_LIST = /\[\s*\d+(?:\s*,\s*\d+)*\s*\]/

  # Stateful service families that reference strategy classes.
  def convert_wayto_strategy(body)
    if (m = body.match(/\A\$mapdb_confluence_target\s*=\s*(?:(\d+)|'tranquility');\s*Room\[23282\]\.wayto\['23282'\]\.call\z/))
      target = m[1] ? m[1].to_i : 'tranquility'
      return Result.new('confluence', { 'strategy' => 'confluence_explorer', 'target' => target })
    end
    if (m = body.match(/\Atarget_room_id\s*=\s*(\d+);\s*maze_rooms\s*=\s*(#{INT_LIST});\s*
                        \$minotaur_maze_dirs\s*\|\|=\s*Hash\.new;\s*loop\s*\{.*\}\z/xm))
      return Result.new('shifting_maze',
                        { 'strategy' => 'shifting_maze', 'target' => m[1].to_i,
                          'rooms' => m[2].scan(/\d+/).map(&:to_i) })
    end
    if (m = body.match(/\Aempty_hand\s+if\s+(#{INT_LIST})\.include\?\(Room\.current\.id\);\s*
                        swim_dir\s*=\s*\{([^}]+)\};\s*
                        while\s+Room\.current\.id\s*!=\s*(\d+);?\s*
                        if\s+swim_dir\[Room\.current\.id\];\s*put\s+"swim\ \#\{swim_dir\[Room\.current\.id\]\}";\s*
                        else;\s*echo\s+#{QUOTED};\s*put\s+"swim\ \#\{checkpaths\[rand\(checkpaths\.length\)\]\}";\s*end;\s*
                        sleep\ 1;\s*waitrt\?;\s*end;\s*fill_hand\z/x))
      dirs = m[2].scan(/(\d+)\s*=>\s*'([^']+)'/).to_h
      return Result.new('guided_route',
                        { 'strategy' => 'guided_route', 'target' => m[3].to_i, 'verb' => 'swim',
                          'dirs' => dirs, 'hands_free_in' => m[1].scan(/\d+/).map(&:to_i) })
    end
    if (m = body.match(/\Astart_room\s*=\s*(#{INT_LIST});\s*dirs\s*=\s*\[([^\]]+)\];\s*
                        if\s+index\s*=\s*start_room\.index\(Room\.current\.id\);\s*
                        until\s+(checkloot\.include\?\('\w+'\)(?:\s+or\s+checkloot\.include\?\('\w+'\))*);\s*
                        move\s+dirs\[index\];\s*index\s*\+=\s*1;\s*index\s*=\s*0\s+if\s+index\s*>=\s*dirs\.length;\s*end;\s*
                        (if\s+checkloot.*?end);;?\s*
                        else;\s*echo\s+#{QUOTED};\s*end;?\s*\$go2_restart\s*=\s*true\z/xm))
      objects = m[3].scan(/checkloot\.include\?\('(\w+)'\)/).flatten
      return Result.new('patrol_search',
                        { 'strategy' => 'patrol_search',
                          'rooms'    => m[1].scan(/\d+/).map(&:to_i),
                          'dirs'     => m[2].scan(/'([^']+)'/).flatten,
                          'objects'  => objects })
    end
    nil
  end

  # Spell-conditional branches, await loops, and bounded walk loops.
  def convert_wayto_special(body)
    if (m = body.match(/\Aif\s+checkspell\((\d+)\)\s+then\s+move\s+#{QUOTED}\s+else\s+move\s+#{QUOTED}\s+end(;\s*waitrt\?)?;?\z/)) ||
       (m = body.match(/\Aif\s+Spell\[(\d+)\]\.active\?;\s*move\s+#{QUOTED};\s*else;\s*move\s+#{QUOTED};\s*end(;\s*waitrt\?)?;?\z/))
      steps = [{ 'do' => 'if', 'when' => "spell:#{m[1]}",
                 'then' => [{ 'do' => 'move', 'cmd' => m[2] || m[3] }],
                 'else' => [{ 'do' => 'move', 'cmd' => m[4] || m[5] }] }]
      steps << { 'do' => 'wait_rt' } if m[6]
      return Result.new('spell_branch', steps)
    end
    if (m = body.match(%r{\Adothistimeout\s+#{QUOTED},\s*(\d+),\s*/(.+)/(i)?\s*;\s*waitrt\?;?\z}))
      pattern = m[5] ? "(?i)#{m[4]}" : m[4]
      return Result.new('await_waitrt',
                        [{ 'do' => 'await', 'cmd' => m[1] || m[2], 'for' => pattern, 'timeout' => m[3].to_i },
                         { 'do' => 'wait_rt' }])
    end
    if (m = body.match(/\A(\d+)\.times\s*\{\s*move\s+#{QUOTED};\s*break\s+if\s+Room\.current\.id\s*==\s*(\d+)\s*\};?\z/))
      return Result.new('bounded_walk',
                        [{ 'do' => 'repeat', 'times' => m[1].to_i, 'until_room' => m[4].to_i,
                           'steps' => [{ 'do' => 'move', 'cmd' => m[2] || m[3] }] }])
    end
    if (m = body.match(%r{\Adirection\s*=\s*#{QUOTED};\s*start\s*=\s*Room\.current\.id;\s*
                          dothistimeout\s+#{QUOTED},\s*(\d+),\s*/(.+)/(i)?\s+
                          while\s+Room\.current\.id\s*==\s*start;?\z}x))
      pattern = m[7] ? "(?i)#{m[6]}" : m[6]
      return Result.new('await_until_moved',
                        [{ 'do' => 'repeat', 'until_room_change' => true,
                           'steps' => [{ 'do' => 'await', 'cmd' => m[3] || m[4], 'for' => pattern,
                                         'timeout' => m[5].to_i }] }])
    end
    if (m = body.match(/\Amultifput\s+(#{QUOTED}(?:\s*,\s*#{QUOTED})*);?\z/))
      cmds = m[1].scan(QUOTED).map { |a, b| a || b }
      return Result.new('multifput', cmds.map { |c| { 'do' => 'send', 'cmd' => c } })
    end
    nil
  end

  # multifput 'a','b'; waitfor 'line'  ->  sends + await (await re-sends the
  # final command, preserving multifput's last-command-then-wait behavior only
  # when the waitfor follows immediately).
  def convert_multifput_waitfor(body)
    m = body.match(/\Amultifput\s+(#{QUOTED}(?:\s*,\s*#{QUOTED})*)\s*;\s*waitfor\s+#{QUOTED};?\z/)
    return nil unless m

    cmds = m[1].scan(QUOTED).map { |a, b| a || b }
    target = m[-2] || m[-1]
    steps = cmds[0..-2].map { |c| { 'do' => 'send', 'cmd' => c } }
    steps << { 'do' => 'send', 'cmd' => cmds.last }
    steps << { 'do' => 'await', 'cmd' => cmds.last, 'for' => Regexp.escape(target), 'timeout' => 30 }
    Result.new('multifput_waitfor', steps)
  end

  # Sequences built only from fput/put/move/waitrt?/sleep, ';'-separated.
  SEQ_TOKENS = {
    /\A(?:fput|put)\s+#{QUOTED}\z/ => ->(m) { { 'do' => 'send', 'cmd' => m[1] || m[2] } },
    /\Amove\s+#{QUOTED}\z/         => ->(m) { { 'do' => 'move', 'cmd' => m[1] || m[2] } },
    /\Amove\(#{QUOTED}\)\z/        => ->(m) { { 'do' => 'move', 'cmd' => m[1] || m[2] } },
    /\Awaitrt\?\z/                 => ->(_) { { 'do' => 'wait_rt' } },
    /\Asleep\s+(\d+(?:\.\d+)?)\z/  => ->(m) { { 'do' => 'sleep', 'seconds' => m[1].to_f } },
    /\Apause\s+(\d+(?:\.\d+)?)\z/  => ->(m) { { 'do' => 'sleep', 'seconds' => m[1].to_f } }
  }.freeze

  def convert_command_sequence(body)
    tokens = body.split(/;|\n/).map(&:strip).reject(&:empty?)
    return nil if tokens.empty?

    steps = tokens.map do |token|
      _, builder = SEQ_TOKENS.find { |pattern, _| token.match?(pattern) }
      return nil unless builder
      builder.call(token.match(SEQ_TOKENS.keys.find { |p| token.match?(p) }))
    end
    steps
  end

  # --- driver ---------------------------------------------------------------

  def convert_map!(rooms)
    rooms.each do |room|
      convert_edges!(room, 'wayto') { |body| convert_wayto(body) }
      convert_edges!(room, 'timeto') { |body| convert_timeto(body) }
    end
    rooms
  end

  def convert_edges!(room, field)
    (room[field] || {}).each do |dest, value|
      next unless value.is_a?(String) && value.start_with?(';e ')

      body = value[3..]
      result = yield(body)
      if result.nil?
        @stats["#{field}:unconverted"] += 1
        @residue[field][cluster_key(body)] << [room['id'], dest]
        next
      end
      if result.schema.nil? # classified but intentionally not converted (virtual)
        @stats["#{field}:#{result.idiom}"] += 1
        next
      end
      if result.schema.is_a?(String) # degenerate proc -> plain string edge
        room[field][dest] = result.schema
        @stats["#{field}:#{result.idiom}"] += 1
        next
      end
      errors = validate(field, result.schema)
      unless errors.empty?
        @stats["#{field}:invalid_emit"] += 1
        warn "BUG: emitted invalid schema for room #{room['id']} -> #{dest}: #{errors.join('; ')}"
        @residue[field][cluster_key(body)] << [room['id'], dest]
        next
      end
      room[field][dest] = result.schema
      @stats["#{field}:#{result.idiom}"] += 1
    end
  end

  def validate(field, schema)
    if field == 'timeto'
      Lich::Common::MapEngine::Validator.errors_for_timeto(schema)
    else
      Lich::Common::MapEngine::Validator.errors_for_wayto(schema)
    end
  end

  # Residue clusters: procs identical after whitespace normalization and
  # number/string masking group together, so the report shows idiom families
  # rather than thousands of lines.
  def cluster_key(body)
    body.gsub(/\s+/, ' ').gsub(/\d+/, 'N').gsub(QUOTED, "'S'").strip[0, 160]
  end

  def numeric(str)
    str.include?('.') ? str.to_f : str.to_i
  end

  def report
    out = +"== Conversion stats ==\n"
    @stats.sort.each { |k, v| out << format("%8d  %s\n", v, k) }
    %w[timeto wayto].each do |field|
      clusters = @residue[field].sort_by { |_, edges| -edges.length }
      next if clusters.empty?

      out << "\n== #{field} residue (#{clusters.sum { |_, e| e.length }} edges, #{clusters.length} clusters) ==\n"
      clusters.each do |key, edges|
        sample = edges.first
        out << format("%6dx  (e.g. %s -> %s)  %s\n", edges.length, sample[0], sample[1], key)
      end
    end
    out
  end
end

if $PROGRAM_NAME == __FILE__
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'Usage: ruby tools/mapdb_convert.rb --in MAP.json [--out NEW.json] [--report FILE]'
    opts.on('--in FILE', 'map JSON to read (required)') { |v| options[:in] = v }
    opts.on('--out FILE', 'write converted map JSON (omit for dry run)') { |v| options[:out] = v }
    opts.on('--report FILE', 'write residue report (default: stdout)') { |v| options[:report] = v }
  end.parse!
  abort 'missing --in' unless options[:in]

  rooms = JSON.parse(File.read(options[:in]))
  converter = MapdbConverter.new
  converter.convert_map!(rooms)

  if options[:out]
    File.write(options[:out], JSON.pretty_generate(rooms))
    puts "wrote #{options[:out]}"
  else
    puts '(dry run: no --out given, map not written)'
  end

  if options[:report]
    File.write(options[:report], converter.report)
    puts "wrote #{options[:report]}"
  else
    puts converter.report
  end
end
