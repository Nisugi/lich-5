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
  opts.banner = 'Usage: ruby tools/mapdb_validate.rb (--in MAP.json | --rooms DIR) ' \
                '[--forbid-procs] [--lint-commands [ALLOWLIST.json]]'
  opts.on('--in FILE', 'full mapdb JSON to validate') { |v| options[:in] = v }
  opts.on('--rooms DIR', 'directory of per-room room.json files') { |v| options[:rooms] = v }
  opts.on('--forbid-procs', 'treat any ;e StringProc as an error') { options[:forbid_procs] = true }
  opts.on('--lint-commands [FILE]',
          'flag risk-verb commands (give/put/drop/...) not in the allowlist JSON ' \
          '(default: tools/mapdb_command_allowlist.json)') do |v|
    options[:lint] = v || File.expand_path('mapdb_command_allowlist.json', __dir__)
  end
end.parse!
abort 'need --in or --rooms' unless options[:in] || options[:rooms]

# Commands that can move wealth or items when aimed at the wrong target.
# Banning them outright is impossible - tolls, donations, and prop puzzles
# use them legitimately - so any command STARTING with one of these verbs
# must be on the reviewed allowlist ("room:dest" keys) or the lint fails.
RISK_COMMAND = /\A\s*(?:give|put|drop|_drag|trade|accept|sell|deposit|withdraw)\b/i

# Keys whose string values reach the game as commands. Patterns (for/
# if_match) and messages are prose and exempt.
COMMAND_KEYS = %w[cmd verb prefix].freeze

def risk_commands_in(value, found = [])
  case value
  when Hash
    value.each do |k, v|
      if COMMAND_KEYS.include?(k) && v.is_a?(String)
        found << v if v =~ RISK_COMMAND
      elsif k == 'dirs' && v.is_a?(Hash)
        v.each_value { |dir| found << dir if dir.is_a?(String) && dir =~ RISK_COMMAND }
      elsif !%w[for pattern msg].include?(k)
        risk_commands_in(v, found)
      end
    end
  when Array then value.each { |v| risk_commands_in(v, found) }
  end
  found
end

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
      next unless options[:lint] && field == 'wayto'

      allowlist ||= File.exist?(options[:lint]) ? JSON.parse(File.read(options[:lint])) : []
      cmds = risk_commands_in(value)
      if cmds.any? && !allowlist.include?("#{room['id']}:#{dest}")
        errors << "#{room['id']} -> #{dest} (wayto): risk command not allowlisted: #{cmds.join(' | ')}"
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
