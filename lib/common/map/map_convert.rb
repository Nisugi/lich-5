# frozen_string_literal: true

# Recognizer library: converts mapdb StringProc bodies into MapEngine
# schema. This is the single implementation behind the offline converter
# CLI (tools/mapdb_convert.rb), the cartographer pipeline, and the in-game
# Map.convert_string / Map.convert_edge helpers - shipping it inside lich-5
# keeps the recognizers in lockstep with the engine vocabulary they emit.

require_relative "map_engine"

module Lich
  module Common
    class MapConvert
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
        if (r = convert_day_pass_timeto(body))
          return r
        end
        convert_timeto_char_gates(body) || convert_timeto_var_gates(body) || convert_timeto_dr(body)
      end

      # DragonRealms cost gates: DRSkill/DRStats, premium portals, helper-script
      # availability, and legacy raw UserVars.
      def convert_timeto_dr(body)
        if (m = body.match(/\Aunless\s+DRSkill\.getmodrank\(#{QUOTED}\)\s*(>=?)\s*(\d+)\s+then\s+nil\s+else\s+(#{NUM})\s+end;?\z/))
          return Result.new('drskill_gate',
                            { 'cost' => numeric(m[5]), 'requires' => ["drskill:#{m[1] || m[2]}#{m[3]}#{m[4]}"] })
        end
        if (m = body.match(/\Aunless\s+DRSkill\.getmodrank\(#{QUOTED}\)\s*(>=?)\s*(\d+)\s*&&\s*
                            Script\.exists\?\(#{QUOTED}\)\s+then\s+nil\s+else\s+(#{NUM})\s+end;?\z/x))
          return Result.new('drskill_gate',
                            { 'cost'     => numeric(m[7]),
                              'requires' => ["drskill:#{m[1] || m[2]}#{m[3]}#{m[4]}", "script_exists:#{m[5] || m[6]}"] })
        end
        if (m = body.match(/\A\(DRStats\.guild\s*==\s*#{QUOTED}\s*&&\s*DRStats\.circle\s*(>=?)\s*(\d+)\)\s*\?\s*(#{NUM})\s*:\s*nil;?\z/))
          return Result.new('guild_gate',
                            { 'cost' => numeric(m[5]), 'requires' => ["guild:#{m[1] || m[2]}", "circle:#{m[3]}#{m[4]}"] })
        end
        if (m = body.match(/\A\(DRStats\.guild\s*==\s*#{QUOTED}\s*&&\s*DRSkill\.getmodrank\(#{QUOTED}\)\s*(>=?)\s*(\d+)\)\s*\?\s*(#{NUM})\s*:\s*nil;?\z/))
          return Result.new('guild_gate',
                            { 'cost'     => numeric(m[7]),
                              'requires' => ["guild:#{m[1] || m[2]}", "drskill:#{m[3] || m[4]}#{m[5]}#{m[6]}"] })
        end
        if (m = body.match(/\Aif\s+\(DRStats\.guild\s*==\s*#{QUOTED}\s*&&\s*DRSpells\.known_spells\[#{QUOTED}\]\)\s+then\s+(#{NUM})\s+else\s+nil\s+end;?\z/))
          return Result.new('guild_gate',
                            { 'cost'     => numeric(m[5]),
                              'requires' => ["guild:#{m[1] || m[2]}", "dr_spell_known:#{m[3] || m[4]}"] })
        end
        if (m = body.match(/\A(?:Scripting::)?DRStats\.circle\s*(>=?)\s*(\d+)\s*\?\s*(#{NUM})\s*:\s*nil(?:\s+rescue\s+nil)?;?\z/))
          return Result.new('guild_gate', { 'cost' => numeric(m[3]), 'requires' => ["circle:#{m[1]}#{m[2]}"] })
        end
        if (m = body.match(/\Aunless\s+\(Account\.subscription\s*==\s*'PREMIUM'\s*\|\|\s*UserVars\.premium\s*\|\|\s*
                            \[#{QUOTED}(?:,\s*#{QUOTED})*\]\.include\?\(XMLData\.game\)\)\s+then\s+nil\s+else\s+(#{NUM})\s+end;?\z/xi))
          games = body.scan(/'(DR\w*)'/).flatten.uniq
          return Result.new('premium_gate', { 'cost' => numeric(m[-1]), 'requires' => ["premium:#{games.join(',')}"] })
        end
        if (m = body.match(/\Aunless\s+UserVars\.(\w+)\s*==\s*#{QUOTED}\s+then\s+nil\s+else\s+(#{NUM})\s+end;?\z/))
          return Result.new('var_raw_gate',
                            { 'cost' => numeric(m[4]), 'requires' => ["var_raw:#{m[1]}=#{m[2] || m[3]}"] })
        end
        if (m = body.match(/\Aunless\s+UserVars\.(\w+)\s+then\s+nil\s+else\s+(#{NUM})\s+end;?\z/))
          return Result.new('var_raw_gate', { 'cost' => numeric(m[2]), 'requires' => ["var_raw:#{m[1]}"] })
        end
        if (m = body.match(/\Aif\s+UserVars\.(\w+)\s*==\s*(true|#{QUOTED})\s+then\s+(#{NUM})\s+else\s+nil\s+end;?\z/))
          expected = m[2] == 'true' ? 'true' : (m[3] || m[4])
          return Result.new('var_raw_gate',
                            { 'cost' => numeric(m[5]), 'requires' => ["var_raw:#{m[1]}=#{expected}"] })
        end
        if (m = body.match(/\Aif\s+Script\.exists\?\(#{QUOTED}\)\s*&&\s*UserVars\.citizenship\s*==\s*#{QUOTED}\s+then\s+(#{NUM})\s+else\s+nil\s+end;?\z/))
          return Result.new('dr_citizenship_gate',
                            { 'cost'     => numeric(m[5]),
                              'requires' => ["script_exists:#{m[1] || m[2]}", "var_raw:citizenship=#{m[3] || m[4]}"] })
        end
        if (m = body.match(/\Aif\s+Script\.exists\?\(#{QUOTED}\)\s+then\s+(#{NUM})\s+else\s+nil\s+end;?\z/))
          return Result.new('script_gate', { 'cost' => numeric(m[3]), 'requires' => ["script_exists:#{m[1] || m[2]}"] })
        end
        if (m = body.match(/\AXMLData\.game\s*==\s*#{QUOTED}\s*\?\s*(#{NUM})\s*:\s*nil;?\z/))
          return Result.new('game_gate', { 'cost' => numeric(m[3]), 'requires' => ["game:#{m[1] || m[2]}"] })
        end
        if (m = body.match(/\AXMLData\.game\s*==\s*#{QUOTED}\s*\?\s*nil\s*:\s*(#{NUM});?\z/))
          return Result.new('game_gate',
                            { 'cost' => nil, 'requires' => ["game:#{m[1] || m[2]}"], 'else' => { 'cost' => numeric(m[3]) } })
        end
        if (m = body.match(/\Aunless\s+get_settings\.(\w+)\s+then\s+nil\s+else\s+(#{NUM})\s+end;?\z/))
          return Result.new('dr_setting_gate', { 'cost' => numeric(m[2]), 'requires' => ["dr_setting:#{m[1]}"] })
        end
        if (m = body.match(/\Aif\s+invisible\?\s+then\s+nil\s+else\s+(#{NUM})\s+end;?\z/))
          return Result.new('invisible_block',
                            { 'cost' => nil, 'requires' => ['is:invisible'], 'else' => { 'cost' => numeric(m[1]) } })
        end
        nil
      end

      # The day-pass timeto procs install the pass monitor and scan the sack
      # during cost evaluation; under the schema the monitor/scan belong to the
      # crossing strategy, and only the pure cost gate is converted.
      def convert_day_pass_timeto(body)
        return nil unless body.include?('mapdb_day_pass_monitor')

        towns = nil
        if (m = body.match(/h\[:towns\]\.include\?\((['"])(.+?)\1\)\s+and\s+h\[:towns\]\.include\?\((['"])(.+?)\3\)/))
          towns = [m[2], m[4]]
        end
        live_cost = body[/\}\s*\n\s*(#{NUM})\s*\n\s*elsif UserVars\.mapdb_buy_day_pass/m, 1]
        buy_token = body[/mapdb_buy_day_pass\.to_s\s*=~\s*\/\^\(yes\|true\)\$\|\\b([a-z,]+)\\b\/i/, 1]
        buy_cost = body[/\n\s*(#{NUM})\s*\n\s*else\s*\n\s*nil\s*\n/m, 1]
        return nil unless towns && live_cost && buy_token && buy_cost

        Result.new('day_pass_gate',
                   { 'cost'     => numeric(live_cost),
                     'requires' => ['setting:day_pass', "pass:#{towns[0]}+#{towns[1]}"],
                     'else'     => { 'cost'     => numeric(buy_cost),
                                     'requires' => ['setting:day_pass', "pass_buyable:#{buy_token}"] } })
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
        if (m = body.match(/\Aif\s+Society\.status\s*==\s*'([^']+)'\s+and\s+Society\.rank\s*==\s*(\d+)\s+and\s+
                            \$go2_use_seeking;\s*(#{NUM});\s*else;\s*nil;\s*end;?\z/x))
          return Result.new('society_gate',
                            { 'cost' => numeric(m[3]), 'requires' => ["society:#{m[1]}+#{m[2]}", 'seeking_enabled'] })
        end
        if (m = body.match(/\Achecksitting\s*&&\s*Room\.current\.climate\s*==\s*'([^']+)'\s*\?\s*nil\s*:\s*(#{NUM});?\z/))
          return Result.new('climate_block_gate',
                            { 'cost' => nil, 'requires' => ['is:sitting', "climate:#{m[1]}"],
                              'else' => { 'cost' => numeric(m[2]) } })
        end
        if (m = body.match(%r{\Aif\s+Spell\['Haste'\]\.active\?;\s*\((#{NUM})\s*\*\s*\[\(\(80\s*-\s*
                              \(\[Spells\.majorelemental,Stats\.level\]\.min/5\)\s*-\s*
                              \(Skills\.elair/5\)\)\s*/\s*100\.0\),\s*0\.4\]\.max\)\.floor\s*\+\s*0\.2;\s*
                              else;\s*(#{NUM});\s*end;?\z}x))
          return Result.new('haste_formula',
                            { 'formula' => 'haste_scaled', 'base' => numeric(m[1]), 'else' => numeric(m[2]) })
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
        # Virtual pass-through edge (phantom waypoint room): a no-op crossing.
        return Result.new('virtual', []) if body == 'true'

        if (m = body.match(TABLE_JOIN))
          return Result.new('table_join', { 'strategy' => 'table_join', 'table' => m[1] })
        end
        if (r = convert_multifput_waitfor(body))
          return r
        end
        if (r = convert_wayto_strategy(body))
          return r
        end
        if (r = convert_wayto_conditionals(body))
          return r
        end
        if (r = convert_wayto_loops(body))
          return r
        end
        if (r = convert_wayto_dr(body))
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
      NILINT_LIST = /\[\s*(?:\d+|nil)(?:\s*,\s*(?:\d+|nil))*\s*\]/

      # Stateful service families that reference strategy classes.
      def convert_wayto_strategy(body)
        if (m = body.match(/\A\$mapdb_confluence_target\s*=\s*(?:(\d+)|'tranquility');\s*Room\[23282\]\.wayto\['23282'\]\.call\z/))
          target = m[1] ? m[1].to_i : 'tranquility'
          return Result.new('confluence', { 'strategy' => 'confluence_explorer', 'target' => target })
        end
        if (m = body.match(/\A\$mapdb_seeking_destination\s*=\s*(\d+);\s*Map\[3600\]\.wayto\['3600'\]\.call;?\z/))
          return Result.new('voln_seeking', { 'strategy' => 'voln_seeking', 'target' => m[1].to_i })
        end
        if (r = convert_day_pass_wayto(body))
          return r
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
        if (m = body.match(/\Aempty_hand\s+if\s+(#{INT_LIST})\.include\?\(Room\.current\.id\);\s*
                            swim_dir\s*=\s*\{([^}]+)\};\s*
                            child\s*=\s*\(bounty\?\s*=~\s*\/\^You\ have\ made\ contact\ with\ the\ child\/\)\s*&&\s*
                            GameObj\.npcs\.find\s*\{\s*\|npc\|\s*npc\.noun\s*==\s*'child'\s*\};\s*
                            while\s+\(Room\.current\.id\s*!=\s*(\d+)\);?\s*
                            if\s+swim_dir\[Room\.current\.id\];\s*put\s+"swim\ \#\{swim_dir\[Room\.current\.id\]\}";\s*
                            else;\s*echo\s+#{QUOTED};\s*put\s+"swim\ \#\{checkpaths\[rand\(checkpaths\.length\)\]\}";\s*end;\s*
                            sleep\ 1;\s*waitrt\?;\s*
                            50\.times\s*\{\s*break\ if\ GameObj\.npcs\.any\?\s*\{\s*\|npc\|\s*npc\.id\s*==\s*child\.id\s*\};\s*
                            sleep\ 0\.1\s*\}\s+if\ child;\s*end;\s*fill_hand\z/x))
          dirs = m[2].scan(/(\d+)\s*=>\s*'([^']+)'/).to_h
          return Result.new('guided_route',
                            { 'strategy' => 'guided_route', 'target' => m[3].to_i, 'verb' => 'swim',
                              'dirs' => dirs, 'hands_free_in' => m[1].scan(/\d+/).map(&:to_i),
                              'escort_wait' => 'bounty_child' })
        end
        if (m = body.match(/\Aresolve=Spell\['Sigil\ of\ Resolve'\]\s+haste=Spell\['Haste'\]\s+
                            if\s+UserVars\.mapdb_ice_mode\s*==\s*'wait'\s*\|\|\s*Skills\.survival\s*<\s*50\s*\|\|\s*
                            XMLData\.encumbrance_value\s*>=\s*50\s+
                            echo\s+#{QUOTED};\s*sleep\s+6\s+
                            elsif\s+resolve\.known\?.*?resolve\.cast\s+end\s+
                            result\s*=\s*fput\s+#{QUOTED}\s+
                            if\s+result\s*=~\s*\/\^Rushing\ heedlessly\/.*\z/xm))
          return Result.new('ice_slope', { 'strategy' => 'ice_slope', 'cmd' => m[3] || m[4] })
        end
        if (m = body.match(/\Astart_room\s*=\s*(#{NILINT_LIST});\s*dirs\s*=\s*\[([^\]]+)\];\s*
                            if\s+index\s*=\s*start_room\.index\(Room\.current\.id\);\s*
                            until\s+(checkloot\.include\?\('\w+'\)(?:\s+or\s+checkloot\.include\?\('\w+'\))*);\s*
                            move\s+dirs\[index\];\s*index\s*\+=\s*1;\s*index\s*=\s*0\s+if\s+index\s*>=\s*dirs\.length;\s*end;\s*
                            (.*?);?;?\s*
                            else;\s*echo\s+#{QUOTED};\s*end;?\s*\$go2_restart\s*=\s*true\z/xm))
          enter = patrol_enter_steps(m[4], m[3])
          return nil if enter.nil?

          schema = { 'strategy' => 'patrol_search',
                     'rooms'    => m[1].scan(/\d+|nil/).map { |t| t == 'nil' ? nil : t.to_i },
                     'dirs'     => m[2].scan(/'([^']+)'/).flatten,
                     'objects'  => m[3].scan(/checkloot\.include\?\('(\w+)'\)/).flatten }
          schema['enter'] = enter unless enter == :default
          return Result.new('patrol_search', schema)
        end
        nil
      end

      # The patrol loop's entry tail is a small command program of its own.
      # Returns :default when the tail is exactly the strategy's built-in
      # go-<found> behavior, a step list when the sequence tokens cover it, or
      # nil (whole proc stays residue) when neither applies.
      def patrol_enter_steps(tail, until_cond)
        objects = until_cond.scan(/checkloot\.include\?\('(\w+)'\)/).flatten
        if tail =~ /\Aif\s+checkloot.*?end\z/m
          branches = tail.scan(/checkloot\.include\?\('(\w+)'\);\s*move\s+'go\ (\w+)'/)
          return nil unless branches.any? && branches.all? { |o, target| o == target && objects.include?(o) }
          return :default
        end
        if (m = tail.match(FISSURE_TAIL))
          return [{ 'do' => 'repeat', 'times' => m[1].to_i,
                    'steps' => STAND_UNLESS_STEPS +
                               [{ 'do' => 'await', 'cmd' => m[2] || m[3], 'for' => m[5],
                                  'timeout' => m[4].to_i,
                                  'if_match' => { 'pattern' => m[6], 'steps' => [{ 'do' => 'break' }] } }] +
                               STAND_UNLESS_STEPS },
                  { 'do' => 'move', 'cmd' => m[7] || m[8] }]
        end
        convert_command_sequence(tail)
      end

      # The six Chronomage day-pass programs share one body parameterized by
      # booth. Rather than one giant regex, extract each parameter with its own
      # anchor and emit only when every extraction succeeds.
      def convert_day_pass_wayto(body)
        return nil unless body.include?('$mapdb_day_passes') && body =~ /raise\s+\#\#?\{pass_id\}/

        towns = body.match(/pass_route\s*=\s*\[\s*"([^"]+)"\s*,\s*"([^"]+)"\s*,?\s*\]/)&.captures
        if towns.nil? && (m = body.match(/\[:towns\]\.include\?\((['"])(.+?)\1\)\s+and\s+
                                          \$mapdb_day_passes\[id\]\[:towns\]\.include\?\((['"])(.+?)\3\)/x))
          towns = [m[2], m[4]]
        end
        buy_token = body[/mapdb_buy_day_pass\.to_s\s*=~\s*\/\^\(yes\|true\)\$\|\\b([a-z,]+)\\b\/i/, 1]
        enter = body[/elsif\s+UserVars\.mapdb_buy_day_pass.*?\n\s*move '([^']+)'/m, 1]
        npc, ask = body.match(/ask (\w+) for (\w+)/)&.captures
        exits = body[/fput "look \#\#\{pass_id\}"\s*\n\s*move '([^']+)'/m, 1]
        walks = body.scan(/\[\s*((?:'[^']+',?\s*)+)\]\.each\s*\{\s*\|dir\|\s*move dir\s*\}/).map { |w| w[0].scan(/'([^']+)'/).flatten }
        withdraw = body[/withdraw (\d+)/, 1]
        return nil unless towns && buy_token && enter && npc && ask && exits && walks.length == 2 && withdraw

        Result.new('chronomage_day_pass',
                   { 'strategy' => 'chronomage_day_pass', 'towns' => towns,
                     'buy_token' => buy_token, 'npc' => npc, 'ask' => ask,
                     'enter' => enter, 'exit' => exits,
                     'bank_to' => walks[0], 'bank_from' => walks[1],
                     'withdraw' => withdraw.to_i })
      end

      ICE_GATE = /\Aif\s+\(UserVars\.mapdb_ice_mode\s*==\s*'wait'\)\s+or\s+
                  \(\(UserVars\.mapdb_ice_mode\s*!=\s*'run'\)\s+and\s+
                  \(\(XMLData\.encumbrance_value\s*>\s*50\)\s+or\s+
                  \(\(Skills\.survival\s*<\s*50\)\s+and\s+not\s+Spell\['Haste'\]\.active\?\)\)\);\s*
                  sleep\s+0\.2;\s*echo\s+#{QUOTED};\s*sleep\s+4;\s*end;\s*move\s+#{QUOTED}\z/x

      CAST_BUFF = /if\s+\w+\s*=\s*Spell\[(\d+)\]\s+and\s+\w+\.known\?\s+and\s+\w+\.affordable\?\s+and\s+not\s+\w+\.active\?;\s*\w+\.cast;\s*end;\s*/

      STAND_UNLESS = /waitrt\?;\s*fput\s+'stand'\s+unless\s+standing\?;\s*waitrt\?/
      FISSURE_TAIL = /\A(\d+)\.times\s*\{\s*#{STAND_UNLESS};\s*
                      result\s*=\s*dothistimeout\s+#{QUOTED},\s*(\d+),\s*\/(.+?)\/;\s*#{STAND_UNLESS};\s*
                      break\ if\ result\s*=~\s*\/(.+?)\/\s*\};\s*move\s+#{QUOTED}\z/x

      STAND_UNLESS_STEPS = [
        { 'do' => 'wait_rt' },
        { 'do' => 'if', 'when' => 'not:status:standing', 'then' => [{ 'do' => 'send', 'cmd' => 'stand' }] },
        { 'do' => 'wait_rt' }
      ].freeze

      # Loop-and-branch families that need the repeat/break vocabulary.
      def convert_wayto_loops(body)
        if (m = body.match(/\Aloop\s*\{\s*wait_until\s*\{\s*Spell\[(\d+)\]\.affordable\?\s*\};\s*
                            result\s*=\s*cast\((\d+),\s*#{QUOTED}\);\s*
                            break\ unless\ result\s*=~\s*\/Spell\ Hindrance\/\s*\};?\z/x))
          return Result.new('cast_loop', [{ 'do' => 'cast', 'spell' => m[2].to_i, 'target' => m[3] || m[4] }])
        end
        if (m = body.match(/\Adoor=#{QUOTED};key=GameObj\.inv\.find\{\|k\|\ k\.name==#{QUOTED};?\};\s*
                            if\s+!key\.nil\?\s+then\s+multifput\s+(#{QUOTED}(?:\s*,\s*#{QUOTED})*);\s*end;?\z/x))
          door = m[1] || m[2]
          key_name = m[3] || m[4]
          # Substitute the bound door name now; the key's object id is a runtime
          # value and becomes an {item_id:...} token expanded at crossing time.
          sends = m[5].scan(QUOTED).map do |a, b|
            cmd = (a || b).gsub('#{door}', door) # rubocop:disable Lint/InterpolationCheck -- literal proc source
                  .gsub('##{key.id}', "{item_id:#{key_name}}") # rubocop:disable Lint/InterpolationCheck
            { 'do' => 'send', 'cmd' => cmd }
          end
          return Result.new('key_door', [{ 'do' => 'if', 'when' => "has_item:#{key_name}", 'then' => sends }])
        end
        if (m = body.match(/\Aunless\s+\(?move\s+#{QUOTED}\)?;\s*echo\s+#{QUOTED};\s*
                            waitfor\s+#{QUOTED};\s*move\s+#{QUOTED};\s*end;?\z/x))
          return Result.new('move_fallback',
                            [{ 'do' => 'try_move', 'cmd' => m[1] || m[2], 'check' => 'move_result',
                               'fallback' => [{ 'do' => 'echo', 'msg' => m[3] || m[4] },
                                              { 'do' => 'await', 'for' => Regexp.escape(m[5] || m[6]), 'timeout' => 1800, 'on_timeout' => 'fail' },
                                              { 'do' => 'move', 'cmd' => m[7] || m[8] }] }])
        end
        if (m = body.match(/\A(?:cur_stance|save_stance)\s*=\s*XMLData\.stance_text;\s*(empty_hands;)?\s*
                            fput\s*\(?'stance\ (\w+)'\)?\s+if\s+\w+\s*!=\s*'\w+';\s*
                            move\s*\(?#{QUOTED}\)?;\s*(fill_hands;)?\s*
                            fput\s*\(?'stance\ '\s*\+\s*\w+\)?\s+if\s+\w+\s*!=\s*(?:'\w+'|XMLData\.stance_text);;?\s*
                            (\$go2_restart\s*=\s*true)?;?\z/x))
          inner = [{ 'do' => 'move', 'cmd' => m[3] || m[4] }]
          inner = [{ 'do' => 'empty_hands' }] + inner + [{ 'do' => 'fill_hands' }] if m[1] && m[5]
          steps = [{ 'do' => 'preserve_stance', 'stance' => m[2], 'steps' => inner }]
          steps << { 'do' => 'replan' } if m[6]
          return Result.new('stance_move', steps)
        end
        if (m = body.match(/\Awhile\s+checkpaths\s*==\s*\[([^\]]+)\];\s*move\s+\[([^\]]+)\]\[rand\(\d+\)\];\s*end;?\s*(.*)\z/m)) ||
           (m = body.match(/\Amove\s+\[([^\]]+)\]\[rand\(\d+\)\]\s+while\s+checkpaths\s*==\s*\[([^\]]+)\];?\s*(.*)\z/m))
          all_paths = (body.start_with?('while') ? m[1] : m[2]).scan(/'([^']+)'/).flatten
          among = (body.start_with?('while') ? m[2] : m[1]).scan(/'([^']+)'/).flatten
          steps = [{ 'do' => 'repeat', 'until' => "not:paths_are:#{all_paths.join(',')}",
                     'steps' => [{ 'do' => 'move_random', 'among' => among }] }]
          tail = m[3].to_s.strip
          unless tail.empty?
            tail_result = convert_wayto_conditionals(tail) || (s = convert_command_sequence(tail)) && Result.new('seq', s)
            tail_result ||= convert_wayto_special(tail)
            return nil unless tail_result
            steps.concat(tail_result.schema)
          end
          return Result.new('random_wander', steps)
        end
        if (m = body.match(/\Aloop\s*\{\s*move\s+#{QUOTED};\s*break\ if\ Room\.current\.id\s*!=\s*(\d+);\s*
                            move\s+#{QUOTED};\s*break\ if\ Room\.current\.id\s*!=\s*\3;\s*\};?\z/x))
          return Result.new('alternate_moves',
                            [{ 'do' => 'repeat', 'until_room_change' => true,
                               'steps' => [{ 'do' => 'move', 'cmd' => m[1] || m[2] },
                                           { 'do' => 'break_if_moved' },
                                           { 'do' => 'move', 'cmd' => m[4] || m[5] }] }])
        end
        if (m = body.match(/\A(?:begin\s+fput\s+#{QUOTED}\s+waitrt\?\s+end|begin;?\s*fput\s+#{QUOTED};\s*waitrt\?;?\s*end)\s+
                            until\s+Room\.current\.id\s*==\s*(\d+);?\z/x))
          return Result.new('send_until_room',
                            [{ 'do' => 'repeat', 'until_room' => m[5].to_i,
                               'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] || m[3] || m[4] },
                                           { 'do' => 'wait_rt' }] }])
        end
        if (m = body.match(/\Awhile\s+Room\.current\.id\s*==\s*\d+;\s*fput\s+#{QUOTED};\s*waitrt\?;\s*end;?\z/))
          return Result.new('send_until_moved',
                            [{ 'do' => 'repeat', 'until_room_change' => true,
                               'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }, { 'do' => 'wait_rt' }] }])
        end
        if (m = body.match(/\Amove\s+#{QUOTED}\s+until\s+Room\.current\.id\s*==\s*(\d+);?\z/))
          return Result.new('move_until_room',
                            [{ 'do' => 'repeat', 'until_room' => m[3].to_i,
                               'steps' => [{ 'do' => 'move', 'cmd' => m[1] || m[2] }] }])
        end
        if (m = body.match(/\Ax\s*=\s*XMLData\.room_count;\s*fput\s+#{QUOTED}\s+until\s+XMLData\.room_count\s*>\s*x;?\z/))
          return Result.new('send_until_moved',
                            [{ 'do' => 'repeat', 'until_room_change' => true,
                               'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }] }])
        end
        if (m = body.match(/\Abegin;\s*fput\s+#{QUOTED};\s*search_result\s*=\s*waitfor\s+(#{QUOTED}(?:\s*,\s*#{QUOTED})*);\s*
                            waitrt\?;\s*end\s+until\s+search_result\s*=~\s*\/([^\/]+)\/;\s*move\s+#{QUOTED}\z/x))
          targets = m[3].scan(QUOTED).map { |a, b| Regexp.escape(a || b) }
          return Result.new('search_until',
                            [{ 'do'    => 'repeat',
                               'times' => 50,
                               'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] },
                                           { 'do' => 'await', 'for' => targets.join('|'), 'timeout' => 30,
                                             'if_match' => { 'pattern' => m[-3], 'steps' => [{ 'do' => 'break' }] } },
                                           { 'do' => 'wait_rt' }] },
                             { 'do' => 'move', 'cmd' => m[-2] || m[-1] }])
        end
        if (m = body.match(/\Amove\s+checkpaths\[rand\(checkpaths\.length\)\]\s+until\s+checkpaths\.include\?\(#{QUOTED}\);?\z/))
          return Result.new('random_wander',
                            [{ 'do' => 'repeat', 'until' => "path:#{m[1] || m[2]}",
                               'steps' => [{ 'do' => 'move_random' }] }])
        end
        nil
      end

      RUN_SCRIPT = /start_script\s*\(\s*#{QUOTED}\s*(?:,\s*\[\s*(#{QUOTED}(?:\s*,\s*#{QUOTED})*)\s*\]\s*)?\)\s*;?\s*
                    wait_while\s*\{\s*running\?\s*\(?\s*#{QUOTED}\s*\)?\s*\}\s*;?/x

      def run_script_step(match_str)
        m = match_str.match(RUN_SCRIPT)
        step = { 'do' => 'run_script', 'script' => m[1] || m[2] }
        step['args'] = m[3].scan(QUOTED).map { |a, b| a || b } if m[3]
        step
      end

      # DragonRealms crossing families: helper-script delegation, stamina waits,
      # premium portal bookkeeping, and password doors.
      def convert_wayto_dr(body)
        if (body.match(/\A(?:#{QUOTED}\s*;\s*)?(?:echo\s+#{QUOTED}\s*;\s*)?#{RUN_SCRIPT}\z/))
          return Result.new('run_script', [run_script_step(body)])
        end
        if (m = body.match(/\Aif\s+Script\.exists\?\(#{QUOTED}\)\s*(?:;|\s+then\s+)\s*(#{RUN_SCRIPT})\s*;?\s*
                            (?:else;?\s*(.*?))?\s*;?\s*end;?\z/xm))
          then_steps = [run_script_step(m[3])]
          else_src = m[-1].to_s.strip
          else_steps = []
          unless else_src.empty?
            if (e = else_src.match(/\Aecho\s+#{QUOTED}\s*;\s*/))
              else_steps << { 'do' => 'echo', 'msg' => e[1] || e[2] }
              else_src = else_src.sub(e[0], '')
            end
            if else_src =~ /\A#{RUN_SCRIPT}\z/
              else_steps << run_script_step(else_src)
            elsif !else_src.empty?
              return nil # unrecognized else tail: whole proc stays residue
            end
          end
          step = { 'do' => 'if', 'when' => "script_exists:#{m[1] || m[2]}", 'then' => then_steps }
          step['else'] = else_steps unless else_steps.empty?
          return Result.new('run_script_branch', [step])
        end
        if (m = body.match(/\Await_until\s*\{\s*stamina\s*>\s*(\d+)\s*\};\s*fput\s+#{QUOTED};\s*waitfor\s+#{QUOTED}\z/))
          return Result.new('stamina_climb',
                            [{ 'do' => 'wait_until', 'when' => "stamina:>#{m[1]}" },
                             { 'do' => 'send', 'cmd' => m[2] || m[3] },
                             { 'do' => 'await', 'for' => Regexp.escape(m[4] || m[5]), 'timeout' => 1800, 'on_timeout' => 'fail' }])
        end
        if (m = body.match(/\AUserVars\.(\w+)\s*=\s*(nil|#{QUOTED})\s*;\s*move\s+#{QUOTED}\z/))
          value = m[2] == 'nil' ? nil : (m[3] || m[4])
          return Result.new('portal_set',
                            [{ 'do' => 'set', 'var' => m[1], 'raw' => true, 'value' => value },
                             { 'do' => 'move', 'cmd' => m[5] || m[6] }])
        end
        if (m = body.match(/\Aunless\s+UserVars\.(\w+)\s+then\s+echo\(#{QUOTED}\)\s*&&\s*nil\s+else\s+
                            fput\(#{QUOTED}\);\s*pause\s+(\d+);\s*fput\(#{QUOTED}\);\s*pause\s+(\d+);\s*
                            fput\("whisper\ (\w+)\ \#\{UserVars\.(\w+)\}"\)\s+end;?\z/x))
          return Result.new('password_door',
                            [{ 'do' => 'if', 'when' => "var_raw:#{m[1]}",
                               'then' => [{ 'do' => 'send', 'cmd' => m[4] || m[5] },
                                          { 'do' => 'sleep', 'seconds' => m[6].to_i },
                                          { 'do' => 'send', 'cmd' => m[7] || m[8] },
                                          { 'do' => 'sleep', 'seconds' => m[9].to_i },
                                          { 'do' => 'send', 'cmd' => "whisper #{m[10]} {uservar:#{m[11]}}" }],
                               'else' => [{ 'do' => 'echo', 'msg' => m[2] || m[3] }] }])
        end
        if (m = body.match(/\A\(move\(#{QUOTED}\);\s*waitrt\?\)\s+until\s+Map\.current\.id\s*==\s*(\d+);?\z/))
          return Result.new('move_until_room',
                            [{ 'do' => 'repeat', 'until_room' => m[3].to_i,
                               'steps' => [{ 'do' => 'move', 'cmd' => m[1] || m[2] }, { 'do' => 'wait_rt' }] }])
        end
        if (m = body.match(/\Afput\s+#{QUOTED};\s*pause\s+(#{NUM})\s+until\s+Room\.current\.id\s*==\s*(\d+);?\z/))
          return Result.new('move_until_room',
                            [{ 'do' => 'repeat', 'until_room' => m[4].to_i,
                               'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] },
                                           { 'do' => 'sleep', 'seconds' => m[3].to_f }] }])
        end
        if (m = body.match(/\Amove\s+#{QUOTED}\s+if\s+Room\.current\.id\s*==\s*(\d+)\s+
                            echo\s+#{QUOTED}\s+fput\s+#{QUOTED}\s+end\s+
                            waitfor\s+#{QUOTED}\s+move\s+#{QUOTED}\z/xm))
          return Result.new('dr_ferry',
                            [{ 'do' => 'move', 'cmd' => m[1] || m[2] },
                             { 'do' => 'if', 'when' => "in_room:#{m[3]}",
                               'then' => [{ 'do' => 'echo', 'msg' => m[4] || m[5] },
                                          { 'do' => 'send', 'cmd' => m[6] || m[7] }] },
                             { 'do' => 'await', 'for' => Regexp.escape(m[8] || m[9]), 'timeout' => 1800, 'on_timeout' => 'fail' },
                             { 'do' => 'move', 'cmd' => m[10] || m[11] }])
        end
        if (m = body.match(/\Awaitrt\?;pause;(\d+)\.times\{fput\s+#{QUOTED};pause;waitcastrt\?;pause;fput\s+#{QUOTED}\};move\s+#{QUOTED}\z/))
          return Result.new('dr_cast_door',
                            [{ 'do' => 'wait_rt' }, { 'do' => 'sleep', 'seconds' => 1 },
                             { 'do' => 'repeat', 'times' => m[1].to_i,
                               'steps' => [{ 'do' => 'send', 'cmd' => m[2] || m[3] }, { 'do' => 'sleep', 'seconds' => 1 },
                                           { 'do' => 'wait_castrt' }, { 'do' => 'sleep', 'seconds' => 1 },
                                           { 'do' => 'send', 'cmd' => m[4] || m[5] }] },
                             { 'do' => 'move', 'cmd' => m[6] || m[7] }])
        end
        if (m = body.match(/\Afput\(#{QUOTED}\);\s*pause;\s*unless\s+checkstanding\s+then\s+fput\(#{QUOTED}\);\s*move\(#{QUOTED}\);\s*end;?\z/))
          return Result.new('dr_posture',
                            [{ 'do' => 'send', 'cmd' => m[1] || m[2] }, { 'do' => 'sleep', 'seconds' => 1 },
                             { 'do' => 'if', 'when' => 'not:status:standing',
                               'then' => [{ 'do' => 'send', 'cmd' => m[3] || m[4] },
                                          { 'do' => 'move', 'cmd' => m[5] || m[6] }] }])
        end
        nil
      end

      # Conditional-wait, buff-cast, delegation, and posture families.
      def convert_wayto_conditionals(body)
        if (m = body.match(ICE_GATE))
          return Result.new('ice_gate',
                            [{ 'do' => 'if', 'when' => 'ice_caution',
                               'then' => [{ 'do' => 'sleep', 'seconds' => 0.2 },
                                          { 'do' => 'echo', 'msg' => m[1] || m[2] },
                                          { 'do' => 'sleep', 'seconds' => 4 }] },
                             { 'do' => 'move', 'cmd' => m[3] || m[4] }])
        end
        if (m = body.match(/\Aif\s+checksitting;\s*while\s+Room\.current\.id\s*==\s*\d+;\s*
                            fput\(#{QUOTED}\);\s*waitrt\?;\s*end;\s*else;\s*move\(#{QUOTED}\);\s*end;?\z/x))
          return Result.new('sitting_branch',
                            [{ 'do' => 'if', 'when' => 'status:sitting',
                               'then' => [{ 'do' => 'repeat', 'until_room_change' => true,
                                            'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] },
                                                        { 'do' => 'wait_rt' }] }],
                               'else' => [{ 'do' => 'move', 'cmd' => m[3] || m[4] }] }])
        end
        if (m = body.match(/\Afput\s+#{QUOTED}\s+unless\s+kneeling\?\s+or\s+
                            \(Stats\.race\s*=~\s*\/([^\/]+)\/\);\s*move\s+#{QUOTED}\z/x))
          return Result.new('posture_branch',
                            [{ 'do' => 'if', 'when_all' => ['not:status:kneeling', "not:race_match:#{m[3]}"],
                               'then' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }] },
                             { 'do' => 'move', 'cmd' => m[4] || m[5] }])
        end
        # NOTE: CAST_BUFF carries one capture group of its own, so groups after
        # the (?:...)+ wrapper start at m[3], not m[2] (live regression: edges
        # moved to '9704').
        if (m = body.match(/\A((?:#{CAST_BUFF})+)move\s+#{QUOTED};\s*waitrt\?;?\z/))
          spells = m[1].scan(CAST_BUFF).flatten.map(&:to_i)
          steps = spells.map { |s| { 'do' => 'cast_buff', 'spell' => s } }
          steps << { 'do' => 'move', 'cmd' => m[3] || m[4] }
          steps << { 'do' => 'wait_rt' }
          return Result.new('cast_buff_move', steps)
        end
        if (m = body.match(/\A((?:#{CAST_BUFF})+)fput\s+\(Spell\[(\d+)\]\.active\?\s*\?\s*#{QUOTED}\s*:\s*#{QUOTED}\);?\z/))
          spells = m[1].scan(CAST_BUFF).flatten.map(&:to_i)
          steps = spells.map { |s| { 'do' => 'cast_buff', 'spell' => s } }
          steps << { 'do' => 'if', 'when' => "spell:#{m[3]}",
                     'then' => [{ 'do' => 'send', 'cmd' => m[4] || m[5] }],
                     'else' => [{ 'do' => 'send', 'cmd' => m[6] || m[7] }] }
          return Result.new('cast_buff_branch', steps)
        end
        if (m = body.match(/\Agroup_members\s*=\s*nil;\s*clear\.reverse\.each\s*\{.*?followed.*?\};\s*
                            move\s+#{QUOTED};\s*if\s+group_members;\s*echo\s+#{QUOTED};\s*
                            begin;\s*if\s+get\s*=~.*?end\s+while\s+group_members\.length\s*>\s*0;\s*end;\s*waitrt\?;?\z/xm))
          return Result.new('group_move', [{ 'do' => 'move_with_group', 'cmd' => m[1] || m[2] }])
        end
        if (m = body.match(/\Aroom\s*=\s*Room\.current\.id;\s*fput\s+#{QUOTED};\s*
                            if\s+\(\s*room\s*==\s*Room\.current\.id\s*\);\s*
                            fput\s+#{QUOTED};\s*move\s+#{QUOTED};\s*end
                            (;\s*\$go2_restart\s*=\s*true)?\z/x))
          steps = [{ 'do' => 'try_move', 'cmd' => m[1] || m[2],
                     'fallback' => [{ 'do' => 'send', 'cmd' => m[3] || m[4] },
                                    { 'do' => 'move', 'cmd' => m[5] || m[6] }] }]
          steps << { 'do' => 'replan' } if m[7]
          return Result.new('try_move', steps)
        end
        if (m = body.match(/\Amove\s+#{QUOTED}\s+while\s+checkpaths\.include\?\(#{QUOTED}\);?\z/))
          return Result.new('path_loop',
                            [{ 'do' => 'repeat', 'until' => "not:path:#{m[3] || m[4]}",
                               'steps' => [{ 'do' => 'move', 'cmd' => m[1] || m[2] }] }])
        end
        if (m = body.match(/\Amove\s+#{QUOTED};\s*move\s+#{QUOTED}\s+(unless|if)\s+checkpaths\.include\?\(#{QUOTED}\);?\z/))
          cond = "path:#{m[6] || m[7]}"
          cond = "not:#{cond}" if m[5] == 'unless'
          return Result.new('path_branch',
                            [{ 'do' => 'move', 'cmd' => m[1] || m[2] },
                             { 'do' => 'if', 'when' => cond,
                               'then' => [{ 'do' => 'move', 'cmd' => m[3] || m[4] }] }])
        end
        if (m = body.match(/\Aid\s*=\s*Room\.current\.id;\s*move\s+#{QUOTED}\s+until\s+Room\.current\.id\s*!=\s*id
                            (;\s*\$go2_restart\s*=\s*true)?;?\z/x))
          steps = [{ 'do' => 'repeat', 'until_room_change' => true,
                     'steps' => [{ 'do' => 'move', 'cmd' => m[1] || m[2] }] }]
          steps << { 'do' => 'replan' } if m[3]
          return Result.new('move_until_changed', steps)
        end
        if body.match(/\Await_until\s*\{\s*Map\.current\.id\s*!=\s*\d+\s*\};?\z/)
          return Result.new('carried_wait', [{ 'do' => 'wait_room_change' }])
        end
        if (m = body.match(/\Awaitrt\?;\s*(\d+)\.times\s*\{\s*if\s+standing\?;\s*break;\s*else;\s*fput\s+'stand';\s*
                            sleep\s+0\.2;\s*waitrt\?;\s*end\s*\};\s*move\s+#{QUOTED};\s*sleep\s+0\.2;\s*waitrt\?;\s*
                            \1\.times\s*\{\s*if\s+standing\?;\s*break;\s*else;\s*fput\s+'stand';\s*
                            sleep\s+0\.2;\s*waitrt\?;\s*end\s*\};\s*waitrt\?;?\z/x))
          stand_up = { 'do' => 'repeat', 'times' => m[1].to_i, 'until' => 'status:standing',
                       'steps' => [{ 'do' => 'send', 'cmd' => 'stand' },
                                   { 'do' => 'sleep', 'seconds' => 0.2 },
                                   { 'do' => 'wait_rt' }] }
          return Result.new('stand_retry_move',
                            [{ 'do' => 'wait_rt' }, stand_up,
                             { 'do' => 'move', 'cmd' => m[2] || m[3] },
                             { 'do' => 'sleep', 'seconds' => 0.2 }, { 'do' => 'wait_rt' },
                             stand_up, { 'do' => 'wait_rt' }])
        end
        if (m = body.match(/\AMap\[(\d+)\]\.wayto\[#{QUOTED}\]\.call;?\s*(?:#.*)?\z/))
          return Result.new('cross_delegation', [{ 'do' => 'cross', 'room' => m[1].to_i, 'dest' => m[2] || m[3] }])
        end
        if (m = body.match(/\Afput\s*\(?#{QUOTED}\)?[;\s]+waitfor\s*\(?#{QUOTED}\)?;?\z/m))
          return Result.new('send_waitfor',
                            [{ 'do' => 'await', 'cmd' => m[1] || m[2],
                               'for' => Regexp.escape(m[3] || m[4]), 'timeout' => 1800, 'on_timeout' => 'fail' }])
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
          # The proc binds a local (direction='west') and interpolates it into the
          # command; substitute it now so no #{...} reaches the map data.
          cmd = (m[3] || m[4]).gsub('#{direction}', m[1] || m[2]) # rubocop:disable Lint/InterpolationCheck -- literal proc source
          return Result.new('await_until_moved',
                            [{ 'do' => 'repeat', 'until_room_change' => true,
                               'steps' => [{ 'do' => 'await', 'cmd' => cmd, 'for' => pattern,
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
        # Each command is sent exactly once (multifput semantics); the wait is
        # passive - an await with cmd would re-send, and confirm-style commands
        # (portmaster travel) are not idempotent once aboard.
        steps = cmds.map { |c| { 'do' => 'send', 'cmd' => c } }
        steps << { 'do' => 'await', 'for' => Regexp.escape(target), 'timeout' => 1800, 'on_timeout' => 'fail' }
        Result.new('multifput_waitfor', steps)
      end

      # Sequences built only from fput/put/move/waitrt?/sleep, ';'-separated.
      SEQ_TOKENS = {
        /\A(?:fput|put)\s+#{QUOTED}\z/                                                                                                                                => ->(m) { { 'do' => 'send', 'cmd' => m[1] || m[2] } },
        /\Amove\s+#{QUOTED}\z/                                                                                                                                        => ->(m) { { 'do' => 'move', 'cmd' => m[1] || m[2] } },
        /\Amove\(#{QUOTED}\)\z/                                                                                                                                       => ->(m) { { 'do' => 'move', 'cmd' => m[1] || m[2] } },
        /\Awaitrt\?\z/                                                                                                                                                => ->(_) { { 'do' => 'wait_rt' } },
        /\Asleep\s+(\d+(?:\.\d+)?)\z/                                                                                                                                 => ->(m) { { 'do' => 'sleep', 'seconds' => m[1].to_f } },
        /\Apause\s+(\d+(?:\.\d+)?)\z/                                                                                                                                 => ->(m) { { 'do' => 'sleep', 'seconds' => m[1].to_f } },
        /\Aempty_hands\z/                                                                                                                                             => ->(_) { { 'do' => 'empty_hands' } },
        /\Afill_hands\z/                                                                                                                                              => ->(_) { { 'do' => 'fill_hands' } },
        /\A\$go2_restart\s*=\s*true\z/                                                                                                                                => ->(_) { { 'do' => 'replan' } },
        /\AUserVars\.mapdb_(\w+)\s*=\s*(\d+|nil)\z/                                                                                                                   => lambda { |m|
          { 'do' => 'set', 'var' => m[1], 'value' => m[2] == 'nil' ? nil : m[2].to_i }
        },
        /\A(\d+)\.times\s*\{\s*fput\s+#{QUOTED}\s*\}\z/                                                                                                               => lambda { |m|
          { 'do' => 'repeat', 'times' => m[1].to_i, 'steps' => [{ 'do' => 'send', 'cmd' => m[2] || m[3] }] }
        },
        /\Awaitrt\z/                                                                                                                                                  => ->(_) { { 'do' => 'wait_rt' } },
        /\Aempty_hand\z/                                                                                                                                              => ->(_) { { 'do' => 'empty_hand' } },
        /\Afill_hand\z/                                                                                                                                               => ->(_) { { 'do' => 'fill_hand' } },
        /\Amove\s+\(#{QUOTED}\)\z/                                                                                                                                    => ->(m) { { 'do' => 'move', 'cmd' => m[1] || m[2] } },
        /\Amultifput\s+(#{QUOTED}(?:\s*,\s*#{QUOTED})*)\z/                                                                                                            => lambda { |m|
          m[1].scan(QUOTED).map { |a, b| { 'do' => 'send', 'cmd' => a || b } }
        },
        /\Awaitfor\s+(#{QUOTED}(?:\s*,\s*#{QUOTED})*)\z/                                                                                                              => lambda { |m|
          targets = m[1].scan(QUOTED).map { |a, b| Regexp.escape(a || b) }
          { 'do' => 'await', 'for' => targets.join('|'), 'timeout' => 1800, 'on_timeout' => 'fail' }
        },
        /\A(?:fput|put)\s+#{QUOTED}\s+if\s+(?:invisible|hidden)\?\z/                                                                                                  => lambda { |m|
          { 'do' => 'if', 'when' => 'status:invisible', 'then' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }] }
        },
        /\A(?:fput|put)\s+#{QUOTED}\s+unless\s+standing\?\z/                                                                                                          => lambda { |m|
          { 'do' => 'if', 'when' => 'not:status:standing', 'then' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }] }
        },
        /\A(?:fput|put)\s+#{QUOTED}\s+until\s+standing\?\z/                                                                                                           => lambda { |m|
          { 'do' => 'repeat', 'until' => 'status:standing', 'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }] }
        },
        /\Await_while\s*\{\s*Room\.current\.id\s*==\s*\d+\s*\}\z/                                                                                                     => ->(_) { { 'do' => 'wait_room_change' } },
        /\Await_until\s*\{\s*(?:Map|Room)\.current\.id\s*!=\s*\d+\s*\}\z/                                                                                             => ->(_) { { 'do' => 'wait_room_change' } },
        /\A\$SILVERWOOD_TOWN\s*=\s*nil\z/                                                                                                                             => ->(_) { { 'do' => 'set_global', 'var' => 'SILVERWOOD_TOWN', 'value' => nil } },
        /\AUserVars\.mapdb_(\w+)\s*=\s*#{QUOTED}\z/                                                                                                                   => lambda { |m|
          { 'do' => 'set', 'var' => m[1], 'value' => m[2] || m[3] }
        },
        /\Aif\s+(?:\w+\s*=\s*)?Spell\[(\d+)\]\s+and\s+\w+\.known\?\s+and\s+\w+\.affordable\?\s+and\s+not\s+\w+\.active\?\s*(?:;\s*|\s+)\w+\.cast\s*(?:;\s*|\s+)end\z/ => lambda { |m|
          { 'do' => 'cast_buff', 'spell' => m[1].to_i }
        },
        /\A(?:fput|put)\s*\(\s*#{QUOTED}\s*\)\z/                                                                                                                      => ->(m) { { 'do' => 'send', 'cmd' => m[1] || m[2] } },
        /\Apause\z/                                                                                                                                                   => ->(_) { { 'do' => 'sleep', 'seconds' => 1 } },
        /\Await(?:cast)?rt\?\z/                                                                                                                                       => ->(_) { { 'do' => 'wait_rt' } },
        /\Aecho\s*\(?#{QUOTED}\)?\z/                                                                                                                                  => ->(m) { { 'do' => 'echo', 'msg' => m[1] || m[2] } },
        /\Amultifput\s*\(\s*(#{QUOTED}(?:\s*,\s*#{QUOTED})*)\s*\)\z/                                                                                                  => lambda { |m|
          m[1].scan(QUOTED).map { |a, b| { 'do' => 'send', 'cmd' => a || b } }
        },
        /\Await(?:for)?\s*\(\s*(#{QUOTED}(?:\s*,\s*#{QUOTED})*)\s*\)\z/                                                                                               => lambda { |m|
          targets = m[1].scan(QUOTED).map { |a, b| Regexp.escape(a || b) }
          { 'do' => 'await', 'for' => targets.join('|'), 'timeout' => 1800, 'on_timeout' => 'fail' }
        },
        /\Amultimove\s+(#{QUOTED}(?:\s*,\s*#{QUOTED})*)\z/                                                                                                            => lambda { |m|
          m[1].scan(QUOTED).map { |a, b| { 'do' => 'move', 'cmd' => a || b } }
        },
        /\A(\d+)\.times\s*\{\s*fput\s+#{QUOTED};\s*pause;\s*waitcastrt\?;\s*pause;\s*fput\s+#{QUOTED}\s*\}\z/                                                         => lambda { |m|
          { 'do' => 'repeat', 'times' => m[1].to_i,
            'steps' => [{ 'do' => 'send', 'cmd' => m[2] || m[3] }, { 'do' => 'sleep', 'seconds' => 1 },
                        { 'do' => 'wait_castrt' }, { 'do' => 'sleep', 'seconds' => 1 },
                        { 'do' => 'send', 'cmd' => m[4] || m[5] }] }
        }
      }.freeze

      def convert_command_sequence(body)
        tokens = body.split(/;|\n/).map(&:strip).reject(&:empty?)
        return nil if tokens.empty?

        steps = tokens.flat_map do |token|
          pattern, builder = SEQ_TOKENS.find { |p, _| token.match?(p) }
          return nil unless builder
          built = builder.call(token.match(pattern))
          built.is_a?(Array) ? built : [built]
        end
        steps
      end

      # --- manual conversions ---------------------------------------------------

      # Hand-curated conversions for one-off procs no recognizer covers:
      #   { "wayto":  { "ROOM:DEST": <schema>, ... },
      #     "timeto": { "ROOM:DEST": <schema>, ... } }
      # Each entry applies only when the edge still holds a StringProc, and is
      # validated exactly like recognizer output.
      def load_manual(path)
        @manual = JSON.parse(File.read(path))
      end

      def manual_for(field, room_id, dest)
        @manual&.dig(field, "#{room_id}:#{dest}")
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
          unless value.is_a?(String) && value.start_with?(';e ')
            # Manual entries are authoritative over any edge type: a hand-authored
            # fix can also repair a plain edge the upstream map got wrong (e.g.
            # locker rooms whose exit needs `close locker` first).
            if (schema = manual_for(field, room['id'], dest)) && schema != value
              schema = guard_trailing_replan(schema, dest) if field == 'wayto'
              if validate(field, schema).empty?
                room[field][dest] = schema
                @stats["#{field}:manual"] += 1
              end
            end
            next
          end

          body = value[3..]
          result = yield(body)
          if result.nil? && (schema = manual_for(field, room['id'], dest))
            result = Result.new('manual', schema)
          end
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
          schema = result.schema
          schema = guard_trailing_replan(schema, dest) if field == 'wayto'
          errors = validate(field, schema)
          unless errors.empty?
            @stats["#{field}:invalid_emit"] += 1
            warn "BUG: emitted invalid schema for room #{room['id']} -> #{dest}: #{errors.join('; ')}"
            @residue[field][cluster_key(body)] << [room['id'], dest]
            next
          end
          room[field][dest] = schema
          @stats["#{field}:#{result.idiom}"] += 1
        end
      end

      # Procs end crossings with $go2_restart because outcomes vary (a jump can
      # land anywhere) - but a restart is pure waste when the crossing landed
      # exactly where the edge says it goes, and go2's restart path errors when
      # that room was the final destination. Guard every trailing replan: it
      # fires only when the crossing landed somewhere other than the edge's
      # mapped destination.
      def guard_trailing_replan(schema, dest)
        return schema unless schema.is_a?(Array) && schema.last == { 'do' => 'replan' }

        schema[0..-2] + [{ 'do' => 'if', 'when' => "not:in_room:#{dest}",
                           'then' => [{ 'do' => 'replan' }] }]
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
  end
end
