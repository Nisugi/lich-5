# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../tools/mapdb_convert'

RSpec.describe MapdbConverter do
  subject(:converter) { described_class.new }

  def timeto(body)
    converter.convert_timeto(body)
  end

  def wayto(body)
    converter.convert_wayto(body)
  end

  describe 'timeto recognizers' do
    it 'converts delegation' do
      r = timeto("Map[7].timeto['30714'].call;")
      expect(r.schema).to eq({ 'same_as' => '7:30714' })
    end

    it 'converts instability event lookups' do
      r = timeto('$mapdb_instability_timeto[2300]')
      expect(r.schema).to eq({ 'event' => 'instability', 'key' => 2300 })
    end

    it 'converts simple settings gates' do
      r = timeto('UserVars.mapdb_use_portmasters == true ? 1200 : nil')
      expect(r.schema).to eq({ 'cost' => 1200, 'requires' => ['setting:portmasters'] })
    end

    it 'converts the urchin timed-grant gate' do
      body = "UserVars.mapdb_use_urchins == true and !UserVars.mapdb_urchins_expire.nil? and " \
             "Time.now.to_i < UserVars.mapdb_urchins_expire and !hidden? and !invisible? ? 0.1 : nil;"
      r = timeto(body)
      expect(r.schema).to eq({ 'cost'     => 0.1,
                               'requires' => ['setting:urchins', 'grant:urchins_expire',
                                              'not:hidden', 'not:invisible'] })
    end

    it 'converts profession gates in both spellings' do
      expect(timeto("Stats.prof == 'Rogue' ? 0.2 : nil").schema)
        .to eq({ 'cost' => 0.2, 'requires' => ['prof:Rogue'] })
      expect(timeto("((!defined?(Stats.prof) or Stats.prof == 'Rogue') ? 0.2 : nil);").schema)
        .to eq({ 'cost' => 0.2, 'requires' => ['prof:Rogue'] })
    end

    it 'converts checkspell gates with fallback cost' do
      expect(timeto('checkspell(506) ? 0.2 : 15.2').schema)
        .to eq({ 'cost' => 0.2, 'requires' => ['spell:506'], 'else' => { 'cost' => 15.2 } })
    end

    it 'converts sitting/climate gates' do
      expect(timeto("checksitting && Room.current.climate == 'freshwater' ? 10 : 0.2").schema)
        .to eq({ 'cost' => 10, 'requires' => ['is:sitting', 'climate:freshwater'],
                 'else' => { 'cost' => 0.2 } })
    end

    it 'converts event-origin var gates' do
      expect(timeto('(!UserVars.mapdb_duskruin_origin.nil? and UserVars.mapdb_duskruin_origin == 7) ? 0.1 : nil;').schema)
        .to eq({ 'cost' => 0.1, 'requires' => ['var:duskruin_origin=7'] })
    end

    it 'converts society seeking gates' do
      body = "if Society.status == 'Order of Voln' and Society.rank == 26 and $go2_use_seeking; 2.8; else; nil; end"
      expect(timeto(body).schema)
        .to eq({ 'cost' => 2.8, 'requires' => ['society:Order of Voln+26', 'seeking_enabled'] })
    end

    it 'converts inverted climate gates to explicit null costs' do
      r = timeto("checksitting && Room.current.climate == 'freshwater' ? nil : 0.2")
      expect(r.schema).to eq({ 'cost' => nil, 'requires' => ['is:sitting', 'climate:freshwater'],
                               'else' => { 'cost' => 0.2 } })
      expect(Lich::Common::MapEngine::Validator.errors_for_timeto(r.schema)).to be_empty
    end

    it 'converts the haste travel formula' do
      body = "if Spell['Haste'].active?; (15 * [((80 - ([Spells.majorelemental,Stats.level].min/5) - " \
             '(Skills.elair/5)) / 100.0), 0.4].max).floor + 0.2; else; 15.2; end'
      expect(timeto(body).schema).to eq({ 'formula' => 'haste_scaled', 'base' => 15, 'else' => 15.2 })
    end

    it 'converts day-pass gates to pure pass requirements' do
      body = <<~PROC
        if UserVars.mapdb_use_day_pass == true
           unless DownstreamHook.list.include?('mapdb_day_pass_monitor')
           end
           if $mapdb_day_passes.any? { |id,h| h[:towns].include?("Solhaven") and h[:towns].include?("Wehnimer's Landing") and h[:expires] > (Time.now + 10) }
              0.8
           elsif UserVars.mapdb_buy_day_pass.to_s =~ /^(yes|true)$|\\bsol,wl\\b/i
              4.4
           else
              nil
           end
        else
           nil
        end
      PROC
      r = timeto(body)
      expect(r.idiom).to eq('day_pass_gate')
      expect(r.schema['requires']).to eq(['setting:day_pass', "pass:Solhaven+Wehnimer's Landing"])
      expect(r.schema['else']['requires']).to eq(['setting:day_pass', 'pass_buyable:sol,wl'])
    end

    it 'leaves unrecognized bodies alone' do
      expect(timeto("key=GameObj.inv.find{|k| k.name=='ruby'}; key ? 1 : nil")).to be_nil
    end
  end

  describe 'wayto recognizers' do
    it 'converts virtual edges to explicit no-op crossings' do
      r = wayto('true')
      expect(r.idiom).to eq('virtual')
      expect(r.schema).to eq([])
      expect(Lich::Common::MapEngine::Validator.errors_for_wayto(r.schema)).to be_empty
    end

    # rubocop:disable Lint/InterpolationCheck -- bodies are literal proc source
    it 'converts table joins to the strategy' do
      body = 'table = "Ant Hill"; fput "go #{table} table" if dothistimeout("go #{table} table", 25, ' \
             '/You (?:and your group )?head over to|waves.*you.*(?:invites|inviting) you' \
             '(?: and your group)? to (?:join|come sit at)/) =~ /inviting you|invites you/'
      expect(wayto(body).schema).to eq({ 'strategy' => 'table_join', 'table' => 'Ant Hill' })
    end

    it 'converts multifput + waitfor into sends and an await' do
      r = wayto("multifput 'ask portmaster about travel 2','ask portmaster about travel 2'; " \
                "waitfor 'A crew member escorts you off the ship.'")
      expect(r.schema.last['do']).to eq('await')
      expect(r.schema.last['for']).to eq(Regexp.escape('A crew member escorts you off the ship.'))
    end

    it 'converts command sequences' do
      r = wayto("fput 'open gate'; move 'go gate'; waitrt?")
      expect(r.schema).to eq([{ 'do' => 'send', 'cmd' => 'open gate' },
                              { 'do' => 'move', 'cmd' => 'go gate' },
                              { 'do' => 'wait_rt' }])
    end

    it 'reduces a lone move to a plain string edge' do
      r = wayto("move 'go arch'")
      expect(r.idiom).to eq('plain_move')
      expect(r.schema).to eq('go arch')
    end

    it 'converts spell-conditional branches' do
      r = wayto("if checkspell(506) then move 'swim north' else move 'north' end; waitrt?")
      expect(r.schema.first['when']).to eq('spell:506')
      expect(r.schema.first['then']).to eq([{ 'do' => 'move', 'cmd' => 'swim north' }])
      expect(r.schema.last).to eq({ 'do' => 'wait_rt' })
    end

    it 'converts buff-cast moves without capture drift' do
      r = wayto('if resolve = Spell[9704] and resolve.known? and resolve.affordable? and ' \
                "not resolve.active?; resolve.cast; end; move 'climb wall'; waitrt?")
      expect(r.schema).to eq([{ 'do' => 'cast_buff', 'spell' => 9704 },
                              { 'do' => 'move', 'cmd' => 'climb wall' },
                              { 'do' => 'wait_rt' }])
    end

    it 'converts buff-cast branches without capture drift' do
      r = wayto('if resolve = Spell[9704] and resolve.known? and resolve.affordable? and ' \
                "not resolve.active?; resolve.cast; end; fput (Spell[112].active? ? 'go out' : 'swim out')")
      expect(r.schema.last).to eq({ 'do' => 'if', 'when' => 'spell:112',
                                    'then' => [{ 'do' => 'send', 'cmd' => 'go out' }],
                                    'else' => [{ 'do' => 'send', 'cmd' => 'swim out' }] })
    end

    it 'converts bounded walk loops to repeat' do
      r = wayto("30.times { move 'north'; break if Room.current.id == 13183 }")
      expect(r.schema).to eq([{ 'do' => 'repeat', 'times' => 30, 'until_room' => 13183,
                                'steps' => [{ 'do' => 'move', 'cmd' => 'north' }] }])
    end

    it 'converts confluence dispatch edges to the explorer strategy' do
      expect(wayto("$mapdb_confluence_target = 23329; Room[23282].wayto['23282'].call").schema)
        .to eq({ 'strategy' => 'confluence_explorer', 'target' => 23329 })
      expect(wayto("$mapdb_confluence_target = 'tranquility'; Room[23282].wayto['23282'].call").schema)
        .to eq({ 'strategy' => 'confluence_explorer', 'target' => 'tranquility' })
    end

    it 'converts minotaur maze procs to shifting_maze' do
      body = 'target_room_id = 6192; maze_rooms = [6191, 6254, 6252]; ' \
             "$minotaur_maze_dirs ||= Hash.new; loop { move 'north' }"
      r = wayto(body)
      expect(r.schema).to eq({ 'strategy' => 'shifting_maze', 'target' => 6192,
                               'rooms' => [6191, 6254, 6252] })
    end

    it 'converts swim gauntlets to guided_route' do
      body = "empty_hand if [ 12662, 20786 ].include?(Room.current.id); " \
             "swim_dir = { 20786 => 'down', 12662 => 'whirlpool' }; " \
             'while Room.current.id != 12677; if swim_dir[Room.current.id]; ' \
             'put "swim #{swim_dir[Room.current.id]}"; ' \
             'else; echo "Oh crap.. I\'m lost.."; put "swim #{checkpaths[rand(checkpaths.length)]}"; end; ' \
             'sleep 1; waitrt?; end; fill_hand'
      r = wayto(body)
      expect(r.schema).to eq({ 'strategy' => 'guided_route', 'target' => 12677, 'verb' => 'swim',
                               'dirs' => { '20786' => 'down', '12662' => 'whirlpool' },
                               'hands_free_in' => [12662, 20786] })
    end

    it 'converts seeking dispatch edges to the voln_seeking strategy' do
      expect(wayto("$mapdb_seeking_destination = 12603;Map[3600].wayto['3600'].call;").schema)
        .to eq({ 'strategy' => 'voln_seeking', 'target' => 12603 })
    end

    it 'leaves unrecognized bodies alone' do
      expect(wayto('day_pass_program_of_ninety_lines(:wl, :imt)')).to be_nil
    end

    it 'converts blocked-way retries to try_move' do
      r = wayto("room = Room.current.id;fput 'go gate'; if ( room == Room.current.id ); " \
                "fput 'knock gate';move 'go gate'; end; $go2_restart = true")
      expect(r.schema.first['do']).to eq('try_move')
      expect(r.schema.first['fallback'].length).to eq(2)
      expect(r.schema.last).to eq({ 'do' => 'replan' })
    end

    it 'converts path-conditional moves' do
      expect(wayto("move 'east' while checkpaths.include?('east')").schema.first['until'])
        .to eq('not:path:east')
      r = wayto("move 'north'; move 'east' unless checkpaths.include?('north')")
      expect(r.schema.last['when']).to eq('not:path:north')
    end

    it 'converts patrol variants with arbitrary simple entry tails' do
      body = "start_room = [ 2579, 2580 ]; dirs = [ 'east', 'west' ]; " \
             'if index = start_room.index(Room.current.id); ' \
             "until checkloot.include?('maw'); move dirs[index]; index += 1; " \
             'index = 0 if index >= dirs.length; end; ' \
             "move 'go maw'; else; echo 'error: mini-script expected a different room'; end; \$go2_restart = true"
      r = wayto(body)
      expect(r.schema['objects']).to eq(['maw'])
      expect(r.schema['enter']).to eq([{ 'do' => 'move', 'cmd' => 'go maw' }])
    end

    it 'converts the ice slope descent to its strategy' do
      body = "resolve=Spell['Sigil of Resolve']\nhaste=Spell['Haste']\n" \
             "if UserVars.mapdb_ice_mode == 'wait' || Skills.survival < 50 || XMLData.encumbrance_value >= 50\n" \
             "echo 'trying not to slip...'; sleep 6\n" \
             "elsif resolve.known? && resolve.affordable? && !resolve.active?\nresolve.cast\nend\n" \
             "result = fput 'down'\n" \
             "if result =~ /^Rushing heedlessly/\n" \
             "haste.cast if haste.known? && haste.affordable? && !haste.active?\nfput 'stand'\n" \
             "$go2_restart = true\nend"
      expect(wayto(body).schema).to eq({ 'strategy' => 'ice_slope', 'cmd' => 'down' })
    end

    it 'converts the ice-caution gate to a named condition' do
      body = "if (UserVars.mapdb_ice_mode == 'wait') or ((UserVars.mapdb_ice_mode != 'run') and " \
             "((XMLData.encumbrance_value > 50) or ((Skills.survival < 50) and not Spell['Haste'].active?))); " \
             "sleep 0.2; echo 'trying not to slip...'; sleep 4; end; move 'west'"
      r = wayto(body)
      expect(r.idiom).to eq('ice_gate')
      expect(r.schema.first['when']).to eq('ice_caution')
      expect(r.schema.last).to eq({ 'do' => 'move', 'cmd' => 'west' })
    end

    it 'converts posture branches to when_all conditions' do
      r = wayto("fput 'stand' unless kneeling? or (Stats.race =~ /Dwarf|Halfling|Gnome/); move 'north'")
      expect(r.schema.first['when_all']).to eq(['not:status:kneeling', 'not:race_match:Dwarf|Halfling|Gnome'])
    end

    it 'converts sitting branches to a repeat-until-moved' do
      r = wayto("if checksitting;while Room.current.id == 13966;fput('swim north');waitrt?;end;else;move('north');end;")
      expect(r.idiom).to eq('sitting_branch')
      expect(r.schema.first['then'].first['do']).to eq('repeat')
    end

    it 'converts wayto delegation to a cross step' do
      r = wayto("Map[284].wayto['3668'].call;")
      expect(r.schema).to eq([{ 'do' => 'cross', 'room' => 284, 'dest' => '3668' }])
    end

    it 'converts uservar sets and command repeats inside sequences' do
      r = wayto("2.times{fput 'event transport duskruin'};UserVars.mapdb_duskruin_origin = 7;")
      expect(r.schema).to eq([{ 'do' => 'repeat', 'times' => 2,
                                'steps' => [{ 'do' => 'send', 'cmd' => 'event transport duskruin' }] },
                              { 'do' => 'set', 'var' => 'duskruin_origin', 'value' => 7 }])
    end

    it 'converts the climb-tail patrol variant with enter steps' do
      body = "start_room = [ 2579, nil, 2581 ]; dirs = [ 'east', 'west' ]; " \
             'if index = start_room.index(Room.current.id); ' \
             "until checkloot.include?('thread'); move dirs[index]; index += 1; " \
             'index = 0 if index >= dirs.length; end; ' \
             "move 'climb thread'; waitrt?; fput 'stand'; " \
             "else; echo 'error: mini-script expected a different room'; end; $go2_restart = true"
      r = wayto(body)
      expect(r.schema['rooms']).to eq([2579, nil, 2581])
      expect(r.schema['enter']).to eq([{ 'do' => 'move', 'cmd' => 'climb thread' },
                                       { 'do' => 'wait_rt' },
                                       { 'do' => 'send', 'cmd' => 'stand' }])
    end
    # rubocop:enable Lint/InterpolationCheck
  end

  describe 'simple movement loops' do
    def schema_for(body)
      result = converter.convert_wayto(body)
      expect(result).not_to be_nil, "no recognizer matched: #{body}"
      expect(Lich::Common::MapEngine::Validator.errors_for_wayto(result.schema)).to be_empty
      result.schema
    end

    it 'converts a counted repeat, preserving the hand juggling around it' do
      expect(schema_for("empty_hands; 3.times { move 'climb wall' }; fill_hands"))
        .to eq([{ 'do' => 'empty_hands' },
                { 'do' => 'repeat', 'times' => 3, 'steps' => [{ 'do' => 'move', 'cmd' => 'climb wall' }] },
                { 'do' => 'fill_hands' }])
    end

    it 'keeps a trailing command after the crossing' do
      expect(schema_for(%(move "knock wall"; fput"stand")))
        .to eq([{ 'do' => 'move', 'cmd' => 'knock wall' },
                { 'do' => 'send', 'cmd' => 'stand' }])
    end

    it 'converts posture-then-move into a status-gated repeat' do
      expect(schema_for("fput 'kneel' until kneeling?; move 'go opening'"))
        .to eq([{ 'do' => 'repeat', 'until' => 'status:kneeling',
                  'steps' => [{ 'do' => 'send', 'cmd' => 'kneel' }] },
                { 'do' => 'move', 'cmd' => 'go opening' }])
    end

    it 'leaves postures the engine cannot answer to relocation' do
      # prone is answerable now (checkprone); a made-up one still is not, and
      # converting it would emit an always-false gate.
      expect(schema_for("fput 'lie' until prone?; move 'go gap'").first['until'])
        .to eq('status:prone')
      expect(converter.convert_wayto("fput 'crouch' until crouching?; move 'go gap'")).to be_nil
    end

    it 'keeps a leading roundtime wait rather than dropping it' do
      expect(schema_for("waitrt?; empty_hands; 4.times { move 'climb wall' }; fill_hands").first)
        .to eq({ 'do' => 'wait_rt' })
    end

    it 'converts leave-this-room into a room-change loop' do
      # "until id != N" from room N is "until the room changes", which also
      # holds in unmapped rooms where Map.current is nil.
      expect(schema_for('fput "climb root" until Room.current.id != 24241'))
        .to eq([{ 'do' => 'repeat', 'until_room_change' => true,
                  'steps' => [{ 'do' => 'send', 'cmd' => 'climb root' }] }])
    end

    it 'converts small waits and loops' do
      expect(schema_for("move 'jump pit'; wait_while{checkstunned}"))
        .to eq([{ 'do' => 'move', 'cmd' => 'jump pit' },
                { 'do' => 'wait_until', 'when' => 'not:status:stunned', 'timeout' => 60 }])
      expect(schema_for("2.times{fput 'ask sailor about boat';}"))
        .to eq([{ 'do' => 'repeat', 'times' => 2,
                  'steps' => [{ 'do' => 'send', 'cmd' => 'ask sailor about boat' }] }])
      # room_desc is scenery; loot is what is lying on the ground.
      expect(schema_for("walk until GameObj.room_desc.find { |obj| obj.noun == 'ferns' }; move 'go ferns'"))
        .to eq([{ 'do' => 'repeat', 'until' => 'room_object:ferns',
                  'steps' => [{ 'do' => 'move_random' }] },
                { 'do' => 'move', 'cmd' => 'go ferns' }])
    end

    # rubocop:disable Lint/InterpolationCheck -- bodies are literal proc source
    it 'converts disk summoning, keeping the name check per-character' do
      body = '40.times { sleep 0.1; break if GameObj.loot.any? { |obj| obj.name =~ /#{Char.name} disk$/ } }; ' \
             'unless GameObj.loot.any? { |obj| obj.name =~ /#{Char.name} disk$/ }; ' \
             'disk = Spell[511]; wait_until { disk.affordable? }; disk.cast; end; ' \
             "move 'up'"
      schema = schema_for(body)
      # {char} stays a token so the pattern is per-character at run time.
      expect(schema[0]).to eq({ 'do' => 'wait_until', 'when' => 'loot_match:{char} disk$', 'timeout' => 4 })
      expect(schema[1]['then']).to eq([{ 'do' => 'cast_buff', 'spell' => 511 }])
      expect(schema[2]).to eq({ 'do' => 'move', 'cmd' => 'up' })
    end

    it 'converts scheduled rides with a bound that outlasts the ride' do
      body = 'sleep(0.2); _respond "#{monsterbold_start}Waiting for the cab.#{monsterbold_end} #{Time.now}"; ' \
             'waitfor "ledge comes into view"; move("out");'
      schema = schema_for(body)
      expect(schema[0]).to eq({ 'do' => 'echo', 'msg' => 'Waiting for the cab.' })
      # waitfor has no timeout of its own; the converted form must not give up
      # early on a four-minute ride, and must fail rather than walk on blind.
      expect(schema[1]).to include('timeout' => 1800, 'on_timeout' => 'fail')
      expect(schema[2]).to eq({ 'do' => 'move', 'cmd' => 'out' })
    end
    # rubocop:enable Lint/InterpolationCheck

    it 'keeps the commands that precede a long wait' do
      # Boarding the raft has to happen before waiting for the geyser.
      body = "fput \"get pile\";fput \"push raft\";fput \"go raft\";" \
             "echo \"Waiting for the geyser...\";line = get until Room.current.id != 24238"
      schema = schema_for(body)
      expect(schema.first).to eq({ 'do' => 'send', 'cmd' => 'get pile' })
      expect(schema.last).to eq({ 'do' => 'wait_room_change', 'timeout' => 1800 })
    end

    it 'converts fixed move lists' do
      body = "['west','west','northwest'].each{|d| move(d)};fput 'rub blood';move('go hatch');"
      expect(schema_for(body))
        .to eq([{ 'do' => 'move', 'cmd' => 'west' },
                { 'do' => 'move', 'cmd' => 'west' },
                { 'do' => 'move', 'cmd' => 'northwest' },
                { 'do' => 'send', 'cmd' => 'rub blood' },
                { 'do' => 'move', 'cmd' => 'go hatch' }])
    end

    it 'converts buff-then-cross' do
      body = 'if celerity = Spell[506] and celerity.known? and celerity.affordable? and ' \
             "not celerity.active?; celerity.cast; end; fput 'search'; move 'go opening'"
      expect(schema_for(body))
        .to eq([{ 'do' => 'cast_buff', 'spell' => 506 },
                { 'do' => 'send', 'cmd' => 'search' },
                { 'do' => 'move', 'cmd' => 'go opening' }])
    end

    it 'converts reveal-then-move, waiting for the exit to appear' do
      body = "if !GameObj.loot.any?{|i| i.name =~ /opening/};fput 'pull lever';" \
             "sleep 0.2 until GameObj.loot.any?{|i| i.name =~ /opening/};end;move('go opening')"
      schema = schema_for(body)
      expect(schema[0]['when']).to eq('not:loot_match:opening')
      expect(schema[0]['then'].first).to eq({ 'do' => 'send', 'cmd' => 'pull lever' })
      expect(schema[0]['then'].last).to include('do' => 'wait_until', 'when' => 'loot_match:opening')
      expect(schema[1]).to eq({ 'do' => 'move', 'cmd' => 'go opening' })
    end

    it 'refuses to set globals outside the engine whitelist' do
      expect(converter.convert_wayto("$SILVERWOOD_TOWN=:zul;move 'go door'")).not_to be_nil
      expect(converter.convert_wayto("$SOME_OTHER_GLOBAL=:x;move 'go door'")).to be_nil
    end

    it 'converts door-response branches' do
      body = "fput 'open door';while line = get;" \
             "if ['You open a large stone door.', 'That is already open.'].include?(line);" \
             "fput 'go door';break;elsif line == 'It appears to be locked.';" \
             "fput 'turn lock';fput 'go door';break;end;end"
      schema = schema_for(body)
      expect(schema[0]).to include('do' => 'await', 'cmd' => 'open door',
                                   'bind' => { 'reply' => 0 })
      expect(schema[1]['when']).to eq('capture_match:reply=You open a large stone door\.|That is already open\.')
      expect(schema[1]['then']).to eq([{ 'do' => 'send', 'cmd' => 'go door' }])
      expect(schema[2]['when']).to eq('capture_match:reply=It appears to be locked\.')
    end

    it 'refuses door branches with an else arm' do
      # await matches a pattern; it cannot express "none of the above".
      body = "fput 'open door';while line = get;if line == 'x';fput 'go door';break;" \
             "else;fput 'go door';break;end;end"
      expect(converter.convert_wayto(body)).to be_nil
    end

    it 'converts try-then-clear blocked exits' do
      # Your own open locker blocks the way out; close it and go again.
      body = "room = Room.current.id; fput 'go opening'; " \
             "if ( room == Room.current.id ); fput 'close locker'; move 'go opening'; end"
      expect(schema_for(body))
        .to eq([{ 'do' => 'try_move', 'cmd' => 'go opening',
                  'fallback' => [{ 'do' => 'send', 'cmd' => 'close locker' },
                                 { 'do' => 'move', 'cmd' => 'go opening' }] }])
    end

    it 'converts checkloot waits with loot_noun, not loot_match' do
      # checkloot compares nouns exactly; loot_match is a regex over full
      # names and would also match "pathway".
      expect(schema_for("walk until checkloot.include?('path'); move 'go path'"))
        .to eq([{ 'do' => 'repeat', 'until' => 'loot_noun:path',
                  'steps' => [{ 'do' => 'move_random' }] },
                { 'do' => 'move', 'cmd' => 'go path' }])
    end

    it 'converts random wander bounded by the full path set' do
      body = "move ['northwest','southwest'][rand(2)] while checkpaths == [ 'ne', 'se', 'sw', 'nw' ]; " \
             "move 'northwest' if checkpaths.include?('nw')"
      expect(schema_for(body))
        .to eq([{ 'do' => 'repeat', 'until' => 'not:paths_are:ne,se,sw,nw',
                  'steps' => [{ 'do' => 'move_random', 'among' => %w[northwest southwest] }] },
                { 'do' => 'if', 'when' => 'path:nw',
                  'then' => [{ 'do' => 'move', 'cmd' => 'northwest' }] }])
    end

    it 'converts guildspeak doors, restoring the language it found' do
      body = "fput 'speak'; language = /You are currently speaking (.*?)\\./.match(get).captures.first " \
             "until language;; fput('speak wizard') unless language == 'Guildspeak'; " \
             "fput('unhide') if hidden? or invisible?; move 'say ::door wizard'; " \
             "fput('speak ' + language.to_s) unless language == 'Guildspeak'"
      schema = schema_for(body)
      expect(schema[0]).to include('do' => 'await', 'cmd' => 'speak', 'bind' => { 'language' => 1 })
      expect(schema[1]).to eq({ 'do' => 'if', 'when' => 'not:capture:language=Guildspeak',
                                'then' => [{ 'do' => 'send', 'cmd' => 'speak wizard' }] })
      # one unhide covers both hidden and invisible, as the proc's `or` does
      expect(schema[2]['then']).to eq([{ 'do' => 'send', 'cmd' => 'unhide' }])
      expect(schema[2]['else'].first['when']).to eq('status:invisible')
      expect(schema[3]).to eq({ 'do' => 'move', 'cmd' => 'say ::door wizard' })
      expect(schema[4]['then']).to eq([{ 'do' => 'send', 'cmd' => 'speak {capture:language}' }])
    end

    it 'converts escort staircases into alternating escort_wait and move' do
      wait = '50.times { break if GameObj.npcs.any? { |npc| npc.id == mynpc.id }; sleep 0.1 } if mynpc'
      body = 'if ((bounty? =~ /^You have made contact with the child/)||' \
             '(Society.task =~ /You have been tasked to find and rescue an official who was captured/)); ' \
             'mynpc = GameObj.npcs.find { |npc| npc.noun =~ /child|official/ }; else;  mynpc = nil; end;  ' \
             "#{wait}; move 'southwest'; #{wait};"
      # The wait block carries a semicolon inside its braces - clause splitting
      # has to respect nesting or the body fragments.
      expect(schema_for(body))
        .to eq([{ 'do' => 'escort_wait' },
                { 'do' => 'move', 'cmd' => 'southwest' },
                { 'do' => 'escort_wait' }])
    end

    it 'converts stance save/restore into preserve_stance' do
      body = "save_stance = XMLData.stance_text;fput 'stance offensive' if save_stance != 'offensive';" \
             "move('climb wide hole');fput \"stance \#{save_stance}\" if save_stance != XMLData.stance_text;"
      expect(schema_for(body))
        .to eq([{ 'do' => 'preserve_stance', 'stance' => 'offensive',
                  'steps' => [{ 'do' => 'move', 'cmd' => 'climb wide hole' }] }])
    end

    it 'refuses stance bodies whose forced stance is not the one guarded on' do
      # preserve_stance decides the restore from (saved != wanted); if the proc
      # forced a different stance than it compared against, they disagree.
      body = "save_stance = XMLData.stance_text;fput 'stance guarded' if save_stance != 'offensive';" \
             "move('climb');fput \"stance \#{save_stance}\" if save_stance != XMLData.stance_text;"
      expect(converter.convert_wayto(body)).to be_nil
    end

    it 'converts seated-vs-standing crossings' do
      body = "if checksitting;while Room.current.id == 18823;fput('row shore');waitrt?;end;" \
             "else;move('climb shore');end;fill_hand;"
      expect(schema_for(body))
        .to eq([{ 'do' => 'if', 'when' => 'status:sitting',
                  'then' => [{ 'do' => 'repeat', 'until_room_change' => true,
                               'steps' => [{ 'do' => 'send', 'cmd' => 'row shore' },
                                           { 'do' => 'wait_rt' }] }],
                  'else' => [{ 'do' => 'move', 'cmd' => 'climb shore' }] },
                # fill_hand, not fill_hands - they are different steps
                { 'do' => 'fill_hand' }])
    end

    it 'converts path-gated move sequences' do
      expect(schema_for("move 'northeast'; move 'east' while checkpaths.include?('e')"))
        .to eq([{ 'do' => 'move', 'cmd' => 'northeast' },
                { 'do' => 'repeat', 'until' => 'not:path:e',
                  'steps' => [{ 'do' => 'move', 'cmd' => 'east' }] }])
      expect(schema_for("move 'northwest' if checkpaths.include?('nw'); move 'west' if checkpaths.include?('w')"))
        .to eq([{ 'do' => 'if', 'when' => 'path:nw', 'then' => [{ 'do' => 'move', 'cmd' => 'northwest' }] },
                { 'do' => 'if', 'when' => 'path:w', 'then' => [{ 'do' => 'move', 'cmd' => 'west' }] }])
    end

    it 'refuses to emit a partial crossing when one clause is unexpressible' do
      # Converting only the movement clauses would silently drop the guild
      # check, so the whole body stays relocated rather than half-crossing.
      expect(converter.convert_wayto(
               "move 'north' if Society.status == 'Voln'; move 'west'"
             )).to be_nil
    end

    it 'converts fog retries that clear their origin var and replan' do
      body = 'result = nil;until result =~ /Obvious paths: northwest/;fput "stand" until standing?;' \
             'result = dothistimeout "go fog", 5, /turned around|Obvious paths: northwest/;' \
             'if result =~ /turned around/;sleep 0.5;waitrt?;end;end;' \
             'UserVars.mapdb_redforest_location = nil; $go2_restart=true'
      rooms = [{ 'id' => 24_675, 'wayto' => { '7892' => ";e #{body}" }, 'timeto' => {} }]
      converter.convert_map!(rooms)
      schema = rooms[0]['wayto']['7892']
      expect(schema[0]['until']).to eq('paths_are:northwest')
      # nil clears the var, matching the proc's `= nil` rather than writing "null"
      expect(schema[1]).to eq({ 'do' => 'set', 'var' => 'redforest_location', 'value' => nil })
      # the trailing restart still picks up the arrival guard
      expect(schema[2]).to eq({ 'do' => 'if', 'when' => 'not:in_room:7892',
                                'then' => [{ 'do' => 'replan' }] })
    end

    it 'converts fog-sphere transits into a room_loaded-bounded repeat' do
      body = <<~'PROC'
        fput 'go sphere'
        loop do
          result = dothistimeout('north', 2, /ethereal fog|torn to tiny pieces/)
          break if result =~ /torn to tiny pieces/
          break unless XMLData.room_description.empty?
        end
        sleep(1) while XMLData.room_description.empty?
        fput 'stand' unless standing?
      PROC
      schema = schema_for(body)
      expect(schema[0]).to eq({ 'do' => 'send', 'cmd' => 'go sphere' })
      # Both of the proc's breaks mean "we have landed"; the bound says it once.
      expect(schema[1]['do']).to eq('repeat')
      expect(schema[1]['until']).to eq('room_loaded')
      expect(schema[1]['steps'].first).to include('do' => 'await', 'cmd' => 'north',
                                                  'on_timeout' => 'continue')
      expect(schema[2]).to eq({ 'do' => 'wait_until', 'when' => 'room_loaded', 'timeout' => 30 })
      expect(schema[3]).to eq({ 'do' => 'if', 'when' => 'not:status:standing',
                                'then' => [{ 'do' => 'send', 'cmd' => 'stand' }] })
    end

    it 'converts send-until-room into until_room, which compares mapdb ids' do
      expect(schema_for("fput 'swim downstream' until Room.current.id == 7602"))
        .to eq([{ 'do' => 'repeat', 'until_room' => 7602,
                  'steps' => [{ 'do' => 'send', 'cmd' => 'swim downstream' }] }])
    end

    it 'converts a room_count delta into that many moves' do
      # room_count + N counts rooms actually traversed; move retries until the
      # room changes, so N moves advances exactly N rooms.
      expect(schema_for('x=XMLData.room_count+2;fput "n" until XMLData.room_count == x'))
        .to eq([{ 'do' => 'repeat', 'times' => 2, 'steps' => [{ 'do' => 'move', 'cmd' => 'n' }] }])
    end
  end

  describe '#convert_map!' do
    it 'guards trailing replans behind arrival at the edge destination' do
      rooms = [{ 'id'     => 30815,
                 'wayto'  => { '30816' => ";e fput 'stand' unless standing?;move('jump'); $go2_restart=true" },
                 'timeto' => {} }]
      converter.convert_map!(rooms)
      steps = rooms[0]['wayto']['30816']
      expect(steps.last).to eq({ 'do' => 'if', 'when' => 'not:in_room:30816',
                                 'then' => [{ 'do' => 'replan' }] })
      expect(steps).not_to include({ 'do' => 'replan' })
    end


    it 'rewrites recognized procs, skips the rest, and every emit validates' do
      rooms = [{ 'id'     => 1,
                 'wayto'  => { '2' => ';e true', '3' => ";e fput 'open gate'; move 'go gate'", '4' => ';e mystery_code' },
                 'timeto' => { '2' => 0.2, '3' => ";e Map[7].timeto['30714'].call;" } }]
      converter.convert_map!(rooms)
      expect(rooms[0]['wayto']['2']).to eq([]) # virtual: explicit no-op crossing
      expect(rooms[0]['wayto']['3']).to be_an(Array)
      expect(rooms[0]['wayto']['4']).to eq(';e mystery_code')
      expect(rooms[0]['timeto']['3']).to eq({ 'same_as' => '7:30714' })
      expect(converter.stats['wayto:unconverted']).to eq(1)
      expect(converter.stats['timeto:delegation']).to eq(1)
    end
  end
end
