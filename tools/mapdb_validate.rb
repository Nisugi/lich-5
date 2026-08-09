# frozen_string_literal: true

# Standalone mapdb schema validator for submission CI (cartographer et al).
#
#   ruby tools/mapdb_validate.rb --in MAP.json [--forbid-procs]
#   ruby tools/mapdb_validate.rb --rooms DIR   [--forbid-procs]
#
# --in            a full mapdb JSON array
# --rooms         a directory tree of per-room room.json files (cartographer
#                 git layout: rooms/{id}/room.json)
# --forbid-procs  any ";e " StringProc string is an error, not a pass-through
#                 (the post-migration submission gate)
#
# Exits non-zero when any schema entry fails MapEngine::Validator or, with
# --forbid-procs, when any StringProc remains. No game connection required.

require 'json'
require 'optparse'

lib_dir = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

module Lich; module Common; end; end
require 'common/map/map_engine'
require 'common/map/map_strategies'
crossings = File.expand_path('../lib/common/map/map_crossings.rb', __dir__)
require crossings if File.exist?(crossings)

options = { forbid_procs: false }
OptionParser.new do |opts|
  opts.banner = 'Usage: ruby tools/mapdb_validate.rb (--in MAP.json | --rooms DIR) [--forbid-procs]'
  opts.on('--in FILE', 'full mapdb JSON to validate') { |v| options[:in] = v }
  opts.on('--rooms DIR', 'directory of per-room room.json files') { |v| options[:rooms] = v }
  opts.on('--forbid-procs', 'treat any ;e StringProc as an error') { options[:forbid_procs] = true }
end.parse!
abort 'need --in or --rooms' unless options[:in] || options[:rooms]

rooms =
  if options[:in]
    JSON.parse(File.read(options[:in]))
  else
    Dir.glob(File.join(options[:rooms], '**', 'room.json')).sort.map do |file|
      data = JSON.parse(File.read(file))
      data.key?('room') ? data['room'] : data # cartographer wraps rooms in a checksum envelope
    end
  end

validator = Lich::Common::MapEngine::Validator
errors = []
procs = 0
schema_entries = 0

rooms.each do |room|
  { 'wayto' => :errors_for_wayto, 'timeto' => :errors_for_timeto }.each do |field, check|
    (room[field] || {}).each do |dest, value|
      if value.is_a?(String) && value.start_with?(';e ')
        procs += 1
        errors << "#{room['id']} -> #{dest} (#{field}): StringProc forbidden" if options[:forbid_procs]
        next
      end
      next unless value.is_a?(Hash) || value.is_a?(Array)

      schema_entries += 1
      validator.send(check, value).each do |err|
        errors << "#{room['id']} -> #{dest} (#{field}): #{err}"
      end
    end
  end
end

puts "#{rooms.size} rooms, #{schema_entries} schema entries, #{procs} StringProcs"
if errors.any?
  errors.first(50).each { |e| warn "ERROR: #{e}" }
  warn "... and #{errors.size - 50} more" if errors.size > 50
  abort "#{errors.size} validation errors"
end
puts 'OK'
