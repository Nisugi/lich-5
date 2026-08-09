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
      expect(r.schema).to eq({ 'cost' => 0.1,
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

    it 'leaves unrecognized bodies alone' do
      expect(timeto("key=GameObj.inv.find{|k| k.name=='ruby'}; key ? 1 : nil")).to be_nil
    end
  end

  describe 'wayto recognizers' do
    it 'classifies virtual edges without converting' do
      r = wayto('true')
      expect(r.idiom).to eq('virtual')
      expect(r.schema).to be_nil
    end

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

    it 'converts bounded walk loops to repeat' do
      r = wayto("30.times { move 'north'; break if Room.current.id == 13183 }")
      expect(r.schema).to eq([{ 'do' => 'repeat', 'times' => 30, 'until_room' => 13183,
                                'steps' => [{ 'do' => 'move', 'cmd' => 'north' }] }])
    end

    it 'leaves stateful services alone' do
      expect(wayto("$mapdb_confluence_target = 23329; Room[23282].wayto['23282'].call")).to be_nil
    end
  end

  describe '#convert_map!' do
    it 'rewrites recognized procs, skips the rest, and every emit validates' do
      rooms = [{ 'id' => 1,
                 'wayto' => { '2' => ';e true', '3' => ";e fput 'open gate'; move 'go gate'", '4' => ';e mystery_code' },
                 'timeto' => { '2' => 0.2, '3' => ";e Map[7].timeto['30714'].call;" } }]
      converter.convert_map!(rooms)
      expect(rooms[0]['wayto']['2']).to eq(';e true') # virtual: classified, unchanged
      expect(rooms[0]['wayto']['3']).to be_an(Array)
      expect(rooms[0]['wayto']['4']).to eq(';e mystery_code')
      expect(rooms[0]['timeto']['3']).to eq({ 'same_as' => '7:30714' })
      expect(converter.stats['wayto:unconverted']).to eq(1)
      expect(converter.stats['timeto:delegation']).to eq(1)
    end
  end
end
