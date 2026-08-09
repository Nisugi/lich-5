# frozen_string_literal: true

# Offline mapdb StringProc -> MapEngine schema converter (thin CLI).
# The recognizer implementation lives in lib/common/map/map_convert.rb and
# ships with lich-5, so this tool, the cartographer pipeline, and the
# in-game Map.convert_* helpers always agree.
#
#   ruby tools/mapdb_convert.rb --in map-123.json                # dry run: stats only
#   ruby tools/mapdb_convert.rb --in map-123.json --out new.json --report residue.txt
#                               [--manual tools/mapdb_manual_conversions.json]

require "json"
require "optparse"

lib_dir = File.expand_path("../lib", __dir__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

module Lich; module Common; end; end
require "common/map/map_engine"
require "common/map/map_strategies"
crossings = File.expand_path("../lib/common/map/map_crossings.rb", __dir__)
require crossings if File.exist?(crossings)
require "common/map/map_convert"

MapdbConverter = Lich::Common::MapConvert

if $PROGRAM_NAME == __FILE__
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'Usage: ruby tools/mapdb_convert.rb --in MAP.json [--out NEW.json] [--report FILE]'
    opts.on('--in FILE', 'map JSON to read (required)') { |v| options[:in] = v }
    opts.on('--out FILE', 'write converted map JSON (omit for dry run)') { |v| options[:out] = v }
    opts.on('--report FILE', 'write residue report (default: stdout)') { |v| options[:report] = v }
    opts.on('--manual FILE', 'hand-curated conversions for one-off procs') { |v| options[:manual] = v }
  end.parse!
  abort 'missing --in' unless options[:in]

  rooms = JSON.parse(File.read(options[:in]))
  converter = MapdbConverter.new
  converter.load_manual(options[:manual]) if options[:manual]
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
