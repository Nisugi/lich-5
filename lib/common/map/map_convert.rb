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
        if (r = convert_wayto_keyed_door(body))
          return r
        end
        if (r = convert_wayto_retry_paths(body))
          return r
        end
        if (r = convert_wayto_captures(body))
          return r
        end
        if (r = convert_wayto_group(body))
          return r
        end
        if (r = convert_wayto_group_bracketed(body))
          return r
        end
        if (r = convert_wayto_special(body))
          return r
        end
        if (r = convert_wayto_simple_loops(body))
          return r
        end
        if (steps = convert_command_sequence(body))
          # A lone move is expressible as the plain string edge it always was.
          return Result.new('plain_move', steps.first['cmd']) if steps.length == 1 && steps.first['do'] == 'move'
          return Result.new('command_sequence', steps)
        end
        nil
      end

      # Optional roundtime wait and hand juggling wrapped around a crossing.
      HANDS = /\A(waitrt\?;\s*)?(empty_hands?;\s*)?(.*?)(;\s*fill_hands?)?;?\z/m

      # Small movement loops that earlier recognizers skip because of a
      # trailing command or a counted repeat. Each maps onto repeat/move with
      # existing vocabulary - no new engine primitives.
      def convert_wayto_simple_loops(body)
        convert_repeat_times(body) ||
          convert_posture_then_move(body) ||
          convert_send_until_room(body) ||
          convert_send_until_count(body) ||
          convert_wayto_fog_transit(body) ||
          convert_wayto_preserve_stance(body) ||
          convert_wayto_sit_branch(body) ||
          convert_wayto_escort(body) ||
          convert_wayto_small_forms(body) ||
          convert_wayto_door_branch(body) ||
          convert_wayto_wait_until_gone(body) ||
          convert_wayto_repeat_until_moved(body) ||
          convert_wayto_send_then_repeat(body) ||
          convert_wayto_try_then_clear(body) ||
          convert_wayto_speak_language(body) ||
          convert_wayto_walk_until_loot(body) ||
          convert_wayto_random_wander_gated(body) ||
          convert_wayto_gated_moves(body) ||
          convert_move_then_send(body)
      end

      # N.times { move 'CMD' }, optionally between empty_hands/fill_hands.
      def convert_repeat_times(body)
        hands = body.match(HANDS)
        core = hands[3]
        m = core.match(/\A(\d+)\.times\s*\{\s*move\s+#{QUOTED}\s*\}\z/)
        return nil unless m

        cmd = m[2] || m[3]
        steps = []
        steps << { 'do' => 'wait_rt' } if hands[1]
        steps << { 'do' => 'empty_hands' } if hands[2]
        steps << { 'do' => 'repeat', 'times' => m[1].to_i,
                   'steps' => [{ 'do' => 'move', 'cmd' => cmd }] }
        steps << { 'do' => 'fill_hands' } if hands[4]
        Result.new('repeat_move', steps)
      end

      # fput 'kneel' until kneeling?; move 'go opening'
      # Only postures the engine's status? actually answers; anything else
      # falls through to relocation rather than to an always-false condition.
      POSTURES = %w[kneeling standing sitting hidden invisible prone].freeze
      def convert_posture_then_move(body)
        m = body.match(/\Afput\s+#{QUOTED}\s+until\s+(\w+)\?;\s*move\s+#{QUOTED}\z/)
        return nil unless m && POSTURES.include?(m[3])

        Result.new('posture_then_move',
                   [{ 'do' => 'repeat', 'until' => "status:#{m[3]}",
                      'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }] },
                    { 'do' => 'move', 'cmd' => m[4] || m[5] }])
      end

      # fput 'swim downstream' until Room.current.id == 7602  (arrive at)
      # fput 'climb root'      until Room.current.id != 24241 (leave here)
      def convert_send_until_room(body)
        m = body.match(/\Afput\s+#{QUOTED}\s+until\s+
                        (?:Room\.current\.id|Map\.current\.id)\s*(==|!=)\s*(\d+)\z/x)
        return nil unless m

        send_step = [{ 'do' => 'send', 'cmd' => m[1] || m[2] }]
        loop_step =
          if m[3] == '=='
            { 'do' => 'repeat', 'until_room' => m[4].to_i, 'steps' => send_step }
          else
            # "until we are no longer in room N" - from room N that is simply
            # "until the room changes", which also works in unmapped rooms.
            { 'do' => 'repeat', 'until_room_change' => true, 'steps' => send_step }
          end
        Result.new('send_until_room', [loop_step])
      end

      # x = XMLData.room_count + N; fput "n" until XMLData.room_count == x
      # i.e. "send this until the room changes N times".
      def convert_send_until_count(body)
        m = body.match(/\A(\w+)\s*=\s*XMLData\.room_count\s*\+\s*(\d+);\s*
                        fput\s+#{QUOTED}\s+until\s+XMLData\.room_count\s*==\s*\1\z/x)
        return nil unless m

        cmd = m[3] || m[4]
        Result.new('send_until_count',
                   [{ 'do' => 'repeat', 'times' => m[2].to_i,
                      'steps' => [{ 'do' => 'move', 'cmd' => cmd }] }])
      end

      # Small waits and loops that appear once or twice each but share shapes.
      def convert_wayto_small_forms(body)
        convert_move_then_wait(body) ||
          convert_repeat_send_times(body) ||
          convert_wait_for_object(body) ||
          convert_search_until_object(body) ||
          convert_walk_until_object(body) ||
          convert_set_global_move(body) ||
          convert_fog_retry_loop(body) ||
          convert_shop_by_name(body) ||
          convert_sleep_wake(body) ||
          convert_search_branch(body) ||
          convert_repeat_until_left(body) ||
          convert_wait_for_line(body) ||
          convert_scheduled_ride(body) ||
          convert_wayto_piloted_ride(body) ||
          convert_move_unless_path(body) ||
          convert_title_loop(body) ||
          convert_summon_disk(body) ||
          convert_loot_branch(body) ||
          convert_move_list(body) ||
          convert_conditional_hands(body) ||
          convert_search_until_name(body) ||
          convert_celerity_then(body) ||
          convert_lie_search_stand(body) ||
          convert_reveal_then_move(body) ||
          convert_send_until_text(body)
      end

      # Fog retries with named success/failure patterns: stand, try, and pause
      # before going again if the attempt failed.
      def convert_fog_retry_loop(body)
        m = body.match(/\Awhile\s+Room\.current\.id\s*==\s*\d+\s*do;\s*
                        fput\s+#{QUOTED}\s+until\s+standing\?;\s*
                        success\s*=\s*\/(.+?)\/;\s*fail\s*=\s*\/(.+?)\/;\s*
                        result\s*=\s*dothistimeout\s+#{QUOTED},\s*(\d+),\s*
                        Regexp\.union\(success,\s*fail\);\s*
                        if\s+result\s*=~\s*fail;\s*sleep\s+[\d.]+;\s*waitrt\??;\s*end;?\s*end;?\s*\z/xm)
        return nil unless m

        Result.new('fog_retry_loop',
                   [{ 'do' => 'repeat', 'until_room_change' => true,
                      'steps' => [{ 'do' => 'repeat', 'until' => 'status:standing',
                                    'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }] },
                                  { 'do' => 'await', 'cmd' => m[5] || m[6],
                                    'timeout' => m[7].to_i, 'on_timeout' => 'continue',
                                    'for' => "#{m[3]}|#{m[4]}", 'bind' => { 'result' => 0 } },
                                  { 'do' => 'if', 'when' => "capture_match:result=#{m[4]}",
                                    'then' => [{ 'do' => 'sleep', 'seconds' => 0.5 },
                                               { 'do' => 'wait_rt' }] }] }])
      end

      # Find a shop by its full description and go in by id.
      def convert_shop_by_name(body)
        m = body.match(/\Aquery\s*=\s*#{QUOTED};\s*
                        shop\s*=\s*GameObj\.loot\.find\s*\{\s*\|\w+\|\s*\w+\.name\.eql\?\(query\)\s*\};\s*
                        shop\s+or\s+fail\s+"[^"]*";\s*
                        fput\s+"go\s+\#?\#\{shop\.id\}"\z/xm)
        return nil unless m

        # Room scenery, not something you own, so this is a plain command
        # against the {room_id:} token rather than a find_item.
        name = m[1] || m[2]
        Result.new('shop_by_name',
                   [{ 'do' => 'send', 'cmd' => "go {room_id:#{name}}" }])
      end

      # Lie down and sleep through a transition, waking on the far side.
      def convert_sleep_wake(body)
        m = body.match(/\Afput\s+#{QUOTED};\s*
                        dothistimeout\s+#{QUOTED},\s*(\d+),\s*\/(.+?)\/;\s*
                        wait_until\s*\{\s*stunned\?\s*\};\s*
                        (?:echo\s+#{QUOTED};\s*)?
                        wait_until\s*\{\s*!stunned\?\s*\};\s*
                        fput\s+#{QUOTED}\s+until\s+standing\?\z/xm)
        return nil unless m

        steps = [{ 'do' => 'send', 'cmd' => m[1] || m[2] },
                 { 'do' => 'await', 'cmd' => m[3] || m[4], 'timeout' => m[5].to_i,
                   'for' => m[6], 'on_timeout' => 'continue' },
                 { 'do' => 'wait_until', 'when' => 'status:stunned', 'timeout' => 60 }]
        steps << { 'do' => 'echo', 'msg' => m[7] || m[8] } if m[7] || m[8]
        steps << { 'do' => 'wait_until', 'when' => 'not:status:stunned', 'timeout' => 300 }
        steps << { 'do' => 'repeat', 'until' => 'status:standing',
                   'steps' => [{ 'do' => 'send', 'cmd' => m[9] || m[10] }] }
        Result.new('sleep_wake', steps)
      end

      # Search repeatedly, ignoring the junk you turn up, until the exit shows.
      def convert_search_branch(body)
        m = body.match(/\Aput\s+#{QUOTED};\s*while\s+line\s*=\s*get;\s*
                        if\s+line\s*=~\s*\/(.+?)\/;\s*put\s+#{QUOTED};\s*
                        elsif\s+line\s*=~\s*\/(.+?)\/;\s*put\s+#{QUOTED};\s*break;\s*end;?\s*end;?\s*\z/xm)
        return nil unless m

        Result.new('search_branch',
                   [{ 'do' => 'repeat', 'times' => 30,
                      'steps' => [{ 'do' => 'await', 'cmd' => m[1] || m[2], 'timeout' => 5,
                                    'on_timeout' => 'continue',
                                    'for' => "#{m[3]}|#{m[6]}", 'bind' => { 'found' => 0 } },
                                  { 'do' => 'if', 'when' => "capture_match:found=#{m[6]}",
                                    'then' => [{ 'do' => 'break' }] },
                                  { 'do' => 'wait_rt' }] },
                    { 'do' => 'send', 'cmd' => m[7] || m[8] }])
      end

      # Stand and try the crossing until you are out of this room. Some of
      # these confirm arrival at a specific room afterwards.
      def convert_repeat_until_left(body)
        m = body.match(/\A\(fput\s+#{QUOTED}\s+until\s+standing\?;\s*fput\s+#{QUOTED}\)\s+
                        until\s+Room\.current\.id\s*!=\s*\d+;\s*
                        (?:wait_until\s*\{\s*Room\.current\.id\s*==\s*(\d+)\s*\};?)?\s*\z/xm)
        return nil unless m

        steps = [{ 'do' => 'repeat', 'until_room_change' => true,
                   'steps' => [{ 'do' => 'repeat', 'until' => 'status:standing',
                                 'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }] },
                               { 'do' => 'send', 'cmd' => m[3] || m[4] }] }]
        if m[5]
          steps << { 'do' => 'wait_until', 'when' => "in_room:#{m[5]}", 'timeout' => 300 }
        end
        Result.new('repeat_until_left', steps)
      end

      # Announce a long wait, then block until a line arrives or the room
      # changes - currents, geysers, and the cable car.
      def convert_wait_for_line(body)
        m = body.match(/\A(.*?)(?:echo\s+#{QUOTED};\s*)?
                        line\s*=\s*get\s+until\s+
                        (?:line\s*=~\s*\/(.+?)\/|Room\.current\.id\s*!=\s*\d+)\s*;?\s*\z/xm)
        return nil unless m

        # Anything before the wait (board the raft, push off) has to convert
        # too, or the crossing would wait without doing the thing first.
        steps = m[1].to_s.strip.empty? ? [] : convert_command_sequence(m[1])
        return nil unless steps

        steps += [{ 'do' => 'echo', 'msg' => m[2] || m[3] }] if m[2] || m[3]
        steps << if m[4]
                   { 'do' => 'await', 'timeout' => 1800, 'for' => m[4], 'on_timeout' => 'fail' }
                 else
                   { 'do' => 'wait_room_change', 'timeout' => 1800 }
                 end
        Result.new('wait_for_line', steps)
      end

      # Piloted rides: a sequence of "announce what we are waiting for, wait
      # for it, then steer" - the water tunnels, where each landmark cues the
      # next lean. Every waitfor becomes a bounded await, since waitfor itself
      # has no timeout and a missed cue would otherwise hang the crossing.
      # Consume `len` characters and any separators that follow, so the next
      # token match can anchor at \A.
      def advance(text, len)
        text[len..].to_s.sub(/\A[;\s]+/, '')
      end

      def convert_wayto_piloted_ride(body)
        # Strip the timing bookkeeping, which is diagnostic only.
        text = body.gsub(/start_time\s*=\s*Time\.now\.to_i;?\s*/, '')
                   .gsub(/_respond\s+"[^"]*water tunnel time[^"]*";?\s*/, '')
        return nil unless text =~ /waitfor\s+#{QUOTED}/

        steps = []
        # These bodies are multi-line and indented; clear leading separators
        # so each token match can anchor at \A.
        rest = text.sub(/\A[;\s]+/, '')
        until rest.empty?
          if (m = rest.match(/\Aif\s*!GameObj\.loot\.find\s*\{\s*\|\w+\|\s*\w+\.name\s*==\s*#{QUOTED}\s*\};\s*(.+?);?\s*end;\s*/m))
            # "Only wait for the ride if it is not already here."
            inner = convert_wayto_piloted_ride(m[3])
            return nil unless inner

            steps << { 'do' => 'if', 'when' => "not:loot_match:#{escape_literal(m[1] || m[2])}",
                       'then' => inner.schema }
            rest = advance(rest, m[0].length)
          elsif (m = rest.match(/\Adothistimeout\s+#{QUOTED},\s*(\d+),\s*\/(.+?)\/;?\s*/m))
            steps << { 'do' => 'await', 'cmd' => m[1] || m[2], 'timeout' => m[3].to_i,
                       'on_timeout' => 'continue', 'for' => m[4] }
            rest = advance(rest, m[0].length)
          elsif (m = rest.match(/\Asleep\(?([\d.]+)\)?;?\s*/m))
            steps << { 'do' => 'sleep', 'seconds' => m[1].to_f }
            rest = advance(rest, m[0].length)
          elsif (m = rest.match(/\Awaitrt\?;?\s*/m))
            steps << { 'do' => 'wait_rt' }
            rest = advance(rest, m[0].length)
          elsif (m = rest.match(/\Amove\(?#{QUOTED}\)?;?\s*/m))
            steps << { 'do' => 'move', 'cmd' => m[1] || m[2] }
            rest = advance(rest, m[0].length)
          elsif (m = rest.match(/\A_respond\s+"[^"]*?monsterbold_start\}(.+?)\#\{monsterbold_end[^"]*";\s*/m))
            steps << { 'do' => 'echo', 'msg' => m[1].strip }
            rest = advance(rest, m[0].length)
          elsif (m = rest.match(/\Awaitfor\s+#{QUOTED};?\s*/m))
            steps << { 'do' => 'await', 'timeout' => 600, 'on_timeout' => 'fail',
                       'for' => escape_literal(m[1] || m[2]) }
            rest = advance(rest, m[0].length)
          elsif (m = rest.match(/\A(?:fput|put)\s+#{QUOTED};?\s*/m))
            steps << { 'do' => 'send', 'cmd' => m[1] || m[2] }
            rest = advance(rest, m[0].length)
          elsif (m = rest.match(/\Arefill_hands\s*=\s*false;?\s*/m))
            rest = advance(rest, m[0].length)
          elsif (m = rest.match(/\A\(refill_hands\s*=\s*true;\s*empty_hands;\s*\)\s*if\s+
                                  GameObj\.right_hand\.id\s+or\s+GameObj\.left_hand\.id;?\s*/xm))
            # empty_hands is already a no-op with empty hands.
            steps << { 'do' => 'empty_hands' }
            rest = advance(rest, m[0].length)
          elsif (m = rest.match(/\Afill_hands(?:\s+if\s+refill_hands)?;?\s*/m))
            steps << { 'do' => 'fill_hands' }
            rest = advance(rest, m[0].length)
          else
            return nil # something we do not model; leave the whole body alone
          end
        end
        # The wait may sit inside a conditional ("only wait if the ride is not
        # already here"), so look through branches rather than at the top level.
        has_await = false
        Lich::Common::MapEngine::Validator.each_step(steps) do |s|
          has_await = true if s['do'] == 'await'
        end
        return nil unless has_await

        Result.new('piloted_ride', steps)
      end

      # Scheduled rides: announce the wait, block until the arrival line, then
      # step off. waitfor has no timeout of its own, so these get the long
      # ride-out bound and fail rather than continue if it never comes.
      def convert_scheduled_ride(body)
        m = body.match(/\A(?:sleep\s*\(?[\d.]+\)?;\s*)?
                        _respond\s+"[^"]*?monsterbold_start\}(.+?)\#\{monsterbold_end[^"]*";\s*
                        waitfor\s+#{QUOTED};\s*
                        move\(?#{QUOTED}\)?;?\s*\z/xm)
        return nil unless m

        Result.new('scheduled_ride',
                   [{ 'do' => 'echo', 'msg' => m[1].strip },
                    { 'do' => 'await', 'timeout' => 1800, 'on_timeout' => 'fail',
                      'for' => escape_literal(m[2] || m[3]) },
                    { 'do' => 'move', 'cmd' => m[4] || m[5] }])
      end

      # move CMD; unless <path present>; <fallback moves>; end
      def convert_move_unless_path(body)
        m = body.match(/\Amove\s+#{QUOTED};\s*unless\s+checkpaths\.include\?\(#{QUOTED}\);\s*
                        (.+?);?\s*end;?\z/xm)
        return nil unless m

        alt = convert_command_sequence(m[5])
        return nil unless alt

        Result.new('move_unless_path',
                   [{ 'do' => 'move', 'cmd' => m[1] || m[2] },
                    { 'do' => 'if', 'when' => "not:path:#{m[3] || m[4]}", 'then' => alt }])
      end

      # Repeat while the room title still says we have not left.
      def convert_title_loop(body)
        m = body.match(/\Awhile\s+XMLData\.room_title\s*==\s*#{QUOTED};\s*
                        (.+?);?\s*end;\s*(fill_hands?);?\s*\z/xm)
        return nil unless m

        inner = convert_command_sequence(m[3])
        return nil unless inner

        # The proc compares the whole title, brackets and all; anchor so the
        # converted form is the same test rather than a substring match.
        title = m[1] || m[2]
        Result.new('title_loop',
                   [{ 'do' => 'repeat', 'until' => "not:room_name:\\A#{Regexp.escape(title)}\\z",
                      'steps' => inner },
                    { 'do' => m[4] }])
      end

      # Wait briefly for your own disk to arrive, summoning one if it does not.
      def convert_summon_disk(body)
        m = body.match(/\A(\d+)\.times\s*\{\s*sleep\s+[\d.]+;\s*break\s+if\s+
                        GameObj\.loot\.any\?.*?\};\s*
                        unless\s+GameObj\.loot\.any\?.*?;\s*
                        disk\s*=\s*Spell\[(\d+)\];\s*wait_until\s*\{\s*disk\.affordable\?\s*\};\s*
                        disk\.cast;\s*end;\s*move\s+#{QUOTED}\z/xm)
        return nil unless m

        Result.new('summon_disk',
                   [{ 'do' => 'wait_until', 'when' => 'loot_match:{char} disk$',
                      'timeout' => (m[1].to_i * 0.1).ceil },
                    { 'do' => 'if', 'when' => 'not:loot_match:{char} disk$',
                      'then' => [{ 'do' => 'cast_buff', 'spell' => m[2].to_i }] },
                    { 'do' => 'move', 'cmd' => m[3] || m[4] }])
      end

      # Take the exit if it is already there, otherwise reveal it first.
      def convert_loot_branch(body)
        m = body.match(/\Aif\s+GameObj\.loot\.find\s*\{\s*\|\w+\|\s*\w+\.noun\s*==\s*#{QUOTED}\s*\};\s*
                        fput\s+#{QUOTED};\s*else;\s*(.+?);?\s*end;?\z/xm)
        return nil unless m

        alt = convert_command_sequence(m[5])
        return nil unless alt

        Result.new('loot_branch',
                   [{ 'do' => 'if', 'when' => "loot_noun:#{m[1] || m[2]}",
                      'then' => [{ 'do' => 'send', 'cmd' => m[3] || m[4] }],
                      'else' => alt }])
      end

      # ['west','west','northwest'].each { |d| move(d) } - a fixed walk, often
      # out to a lever and back.
      def convert_move_list(body)
        clauses = split_top_level(body)
        steps = clauses.map do |clause|
          if (m = clause.match(/\A\[(.+?)\]\.each\s*\{\s*\|\w+\|\s*move\(?\w+\)?\s*\}\z/))
            m[1].scan(QUOTED).map { |a, b| { 'do' => 'move', 'cmd' => a || b } }
          elsif (m = clause.match(/\Afput\s+#{QUOTED}\z/))
            [{ 'do' => 'send', 'cmd' => m[1] || m[2] }]
          elsif (m = clause.match(/\Amove\(?#{QUOTED}\)?\z/))
            [{ 'do' => 'move', 'cmd' => m[1] || m[2] }]
          end
        end
        return nil if steps.any?(&:nil?)
        # Only worth it when a list was actually expanded.
        return nil unless body.include?('.each')

        Result.new('move_list', steps.flatten)
      end

      # empty_hands only when a hand is actually full, then cross.
      def convert_conditional_hands(body)
        m = body.match(/\Aempty_hands?\s+if\s+GameObj\.right_hand\.id\s+or\s+GameObj\.left_hand\.id;\s*
                        move\(?#{QUOTED}\)?\z/xm)
        return nil unless m

        # empty_hands is already a no-op with empty hands, so the guard is
        # implicit in the step.
        Result.new('conditional_hands',
                   [{ 'do' => 'empty_hands' },
                    { 'do' => 'move', 'cmd' => m[1] || m[2] }])
      end

      # fput 'search' until <object by name>; then take it.
      def convert_search_until_name(body)
        m = body.match(/\Afput\s+#{QUOTED}\s+until\s+GameObj\.loot\.find\s*\{\s*\|\w+\|\s*
                        \w+\.name\s*(?:==|\.eql\?\()\s*#{QUOTED}\)?\s*\};\s*
                        fput\s+#{QUOTED}\z/xm)
        return nil unless m

        Result.new('search_until_name',
                   [{ 'do' => 'repeat', 'until' => "loot_match:#{Regexp.escape(m[3] || m[4])}",
                      'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] },
                                  { 'do' => 'wait_rt' }] },
                    { 'do' => 'send', 'cmd' => m[5] || m[6] }])
      end

      # Buff with celerity if it is worth casting, then do the crossing.
      def convert_celerity_then(body)
        m = body.match(/\Aif\s+celerity\s*=\s*Spell\[(\d+)\]\s+and\s+celerity\.known\?\s+and\s+
                        celerity\.affordable\?\s+and\s+not\s+celerity\.active\?;\s*
                        celerity\.cast;\s*end;\s*(.+)\z/xm)
        return nil unless m

        rest = convert_command_sequence(m[2])
        return nil unless rest

        Result.new('buff_then_cross',
                   [{ 'do' => 'cast_buff', 'spell' => m[1].to_i }] + rest)
      end

      # Lie down, search until something is revealed, stand, and go through it.
      def convert_lie_search_stand(body)
        m = body.match(/\Afput\s+#{QUOTED}\s+until\s+checkprone;\s*
                        result\s*=\s*dothistimeout\s+#{QUOTED},\s*(\d+),\s*\/(.+?)\/\s+until\s+result;\s*
                        waitrt\??;\s*fput\s+#{QUOTED}\s+until\s+standing\?;\s*waitrt\??;\s*
                        fput\s+#{QUOTED}\z/xm)
        return nil unless m

        # QUOTED is two groups each: 1/2 lie, 3/4 search cmd, 5 timeout,
        # 6 pattern, 7/8 stand, 9/10 crossing.
        Result.new('lie_search_stand',
                   [{ 'do' => 'repeat', 'until' => 'status:prone',
                      'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }] },
                    { 'do' => 'repeat', 'times' => 20,
                      'steps' => [{ 'do' => 'await', 'cmd' => m[3] || m[4],
                                    'timeout' => m[5].to_i, 'for' => m[6],
                                    'on_timeout' => 'continue',
                                    'bind' => { 'found' => 0 } },
                                  { 'do' => 'if', 'when' => 'capture:found',
                                    'then' => [{ 'do' => 'break' }] }] },
                    { 'do' => 'wait_rt' },
                    { 'do' => 'repeat', 'until' => 'status:standing',
                      'steps' => [{ 'do' => 'send', 'cmd' => m[7] || m[8] }] },
                    { 'do' => 'wait_rt' },
                    { 'do' => 'send', 'cmd' => m[9] || m[10] }])
      end

      # Reveal a hidden exit (pull a lever, push a stone) if it is not already
      # showing, then take it.
      def convert_reveal_then_move(body)
        m = body.match(/\Aif\s*!GameObj\.loot\.any\?\s*\{\s*\|\w+\|\s*\w+\.name\s*=~\s*\/([^\/]+)\/\s*\};\s*
                        (.+?);?\s*
                        sleep\s+[\d.]+\s+until\s+GameObj\.loot\.any\?\s*\{\s*\|\w+\|\s*\w+\.name\s*=~\s*\/\1\/\s*\};?\s*
                        end;?\s*move\(?#{QUOTED}\)?;?\z/xm)
        m ||= body.match(/\Aif\s*!GameObj\.loot\.any\?\s*\{\s*\|\w+\|\s*\w+\.name\s*=~\s*\/([^\/]+)\/\s*\};\s*
                          (.+?);\s*end;\s*
                          sleep\s+[\d.]+\s+until\s+GameObj\.loot\.any\?\s*\{\s*\|\w+\|\s*\w+\.name\s*=~\s*\/\1\/\s*\};\s*
                          move\(?#{QUOTED}\)?;?\z/xm)
        return nil unless m

        reveal = convert_command_sequence(m[2])
        return nil unless reveal

        Result.new('reveal_then_move',
                   [{ 'do' => 'if', 'when' => "not:loot_match:#{m[1]}",
                      'then' => reveal + [{ 'do' => 'wait_until', 'when' => "loot_match:#{m[1]}",
                                            'timeout' => 60 }] },
                    { 'do' => 'move', 'cmd' => m[3] || m[4] }])
      end

      # Repeat a command until a line of game text arrives.
      def convert_send_until_text(body)
        m = body.match(/\Aline\s*=\s*fput\s+#{QUOTED}\s+until\s+line\s*=~\s*\/(.+?)\/;\s*
                        move\s+#{QUOTED}\z/xm)
        return nil unless m

        Result.new('send_until_text',
                   [{ 'do' => 'repeat', 'times' => 50,
                      'steps' => [{ 'do' => 'await', 'cmd' => m[1] || m[2], 'timeout' => 3,
                                    'for' => m[3], 'on_timeout' => 'continue',
                                    'bind' => { 'found' => 0 } },
                                  { 'do' => 'if', 'when' => 'capture:found',
                                    'then' => [{ 'do' => 'break' }] }] },
                    { 'do' => 'move', 'cmd' => m[4] || m[5] }])
      end

      # move CMD, then wait for a condition to settle (stun to wear off, an
      # exit to appear).
      def convert_move_then_wait(body)
        m = body.match(/\Amove\s+#{QUOTED};\s*
                        (?:wait_while\s*\{\s*checkstunned\s*\}|
                           wait_until\s*\{\s*checkpaths\.include\?\(#{QUOTED}\)\s*\})\z/xm)
        return nil unless m

        wait = if body.include?('checkstunned')
                 { 'do' => 'wait_until', 'when' => 'not:status:stunned', 'timeout' => 60 }
               else
                 { 'do' => 'wait_until', 'when' => "path:#{m[3] || m[4]}", 'timeout' => 60 }
               end
        Result.new('move_then_wait', [{ 'do' => 'move', 'cmd' => m[1] || m[2] }, wait])
      end

      # N.times { fput 'CMD' } - repeat a command a fixed number of times.
      def convert_repeat_send_times(body)
        m = body.match(/\A(\d+)\.times\s*\{\s*fput\s+#{QUOTED};?\s*\}\z/)
        return nil unless m

        Result.new('repeat_send',
                   [{ 'do' => 'repeat', 'times' => m[1].to_i,
                      'steps' => [{ 'do' => 'send', 'cmd' => m[2] || m[3] }] }])
      end

      # wait_until an object appears in the room, then take it.
      def convert_wait_for_object(body)
        m = body.match(/\Await_until\s*\{\s*GameObj\.loot\.find\s*\{\s*\|\w+\|\s*
                        \w+\.noun\s*==\s*#{QUOTED}\s*\}\s*\};\s*fput\s+#{QUOTED}\z/xm)
        return nil unless m

        Result.new('wait_for_object',
                   [{ 'do' => 'wait_until', 'when' => "loot_noun:#{m[1] || m[2]}", 'timeout' => 300 },
                    { 'do' => 'send', 'cmd' => m[3] || m[4] }])
      end

      # Search until something turns up, then go through it.
      def convert_search_until_object(body)
        m = body.match(/\Auntil\s+GameObj\.loot\.find\s*\{\s*\|\w+\|\s*\w+\.noun\s*==\s*#{QUOTED}\s*\};\s*
                        fput\s+#{QUOTED};\s*waitrt\??;\s*end;\s*move\s+#{QUOTED};?\z/xm)
        return nil unless m

        Result.new('search_until_object',
                   [{ 'do' => 'repeat', 'until' => "loot_noun:#{m[1] || m[2]}",
                      'steps' => [{ 'do' => 'send', 'cmd' => m[3] || m[4] },
                                  { 'do' => 'wait_rt' }] },
                    { 'do' => 'move', 'cmd' => m[5] || m[6] }])
      end

      # Wander until a room-description object shows up, then take it.
      def convert_walk_until_object(body)
        m = body.match(/\Awalk\s+until\s+GameObj\.room_desc\.find\s*\{\s*\|\w+\|\s*
                        \w+\.noun\s*==\s*#{QUOTED}\s*\};\s*move\s+#{QUOTED}\z/xm)
        return nil unless m

        Result.new('walk_until_object',
                   [{ 'do' => 'repeat', 'until' => "room_object:#{m[1] || m[2]}",
                      'steps' => [{ 'do' => 'move_random' }] },
                    { 'do' => 'move', 'cmd' => m[3] || m[4] }])
      end

      # Set a whitelisted event global, then cross.
      def convert_set_global_move(body)
        m = body.match(/\A\$(\w+)\s*=\s*:?(\w+);\s*move\s+#{QUOTED}\z/)
        return nil unless m
        # The engine's global whitelist is closed; anything outside it stays
        # relocated rather than converting to a step that cannot run.
        return nil unless Lich::Common::MapEngine::SETTABLE_GLOBALS.include?(m[1])

        Result.new('set_global_move',
                   [{ 'do' => 'set_global', 'var' => m[1], 'value' => m[2] },
                    { 'do' => 'move', 'cmd' => m[3] || m[4] }])
      end

      # Door-response branches: open the door, read the reply, and act on it -
      # go through if it opened, deal with the lock if it did not. The proc
      # shape is `fput 'open X'; while line = get; if <cases>; ...; break`.
      def convert_wayto_door_branch(body)
        m = body.match(/\Afput\s+#{QUOTED};\s*while\s+line\s*=\s*get;\s*(.+)\s*end;?\s*\z/m)
        return nil unless m

        branches = parse_line_branches(m[3])
        return nil unless branches

        steps = [{ 'do' => 'await', 'cmd' => m[1] || m[2], 'timeout' => 5,
                   'on_timeout' => 'continue',
                   'for' => branches.map { |b| b[:pattern] }.join('|'),
                   'bind' => { 'reply' => 0 } }]
        branches.each do |b|
          steps << { 'do' => 'if', 'when' => "capture_match:reply=#{b[:pattern]}",
                     'then' => b[:steps] }
        end
        Result.new('door_branch', steps)
      end

      # if/elsif chain over `line`, each arm ending in break. Returns nil for
      # anything with an else, a nested condition, or a body we cannot express.
      def parse_line_branches(text)
        # Drop the if-chain's own terminator, then split on elsif. A bare else
        # would need a "nothing matched" arm, which await cannot express.
        inner = text.strip.sub(/\bend;?\s*\z/, '').strip
        return nil if inner =~ /(?<!\w)else(?!if)\b/

        arms = inner.split(/;\s*elsif\s+/).map(&:strip).reject(&:empty?)
        return nil if arms.empty?

        arms.map do |arm|
          arm = arm.sub(/\Aif\s+/, '')
          head = arm.match(/\A(.+?);\s*(.*)\z/m)
          return nil unless head

          pattern = branch_pattern(head[1].strip)
          return nil unless pattern

          steps = convert_command_sequence(head[2].sub(/\bbreak;?\s*\z/, ''))
          return nil unless steps

          { :pattern => pattern, :steps => steps }
        end
      end

      # `line == 'X'`, `line =~ /X/`, or `['X','Y'].include?(line)`.
      def branch_pattern(cond)
        if (m = cond.match(/\Aline\s*==\s*#{QUOTED}\z/))
          escape_literal(m[1] || m[2])
        elsif (m = cond.match(%r{\Aline\s*=~\s*/(.+)/\z}))
          m[1]
        elsif (m = cond.match(/\A\[(.+)\]\.include\?\(line\)\z/))
          m[1].scan(QUOTED).map { |a, b| escape_literal(a || b) }.join('|')
        end
      end

      # Regexp.escape also escapes spaces, which is valid but makes the stored
      # pattern hard to read; only the metacharacters need it here.
      def escape_literal(text)
        text.gsub(%r{[.*+?^$(){}\[\]|\\/]}) { |ch| "\\#{ch}" }
      end

      # Ride-out edges: something else moves you (a lift, a current), so just
      # wait until you are no longer here and let the router take over.
      def convert_wayto_wait_until_gone(body)
        m = body.match(/\Await_while\s*\{\s*(?:Map|Room)\.current\.id\s*==\s*\d+\s*\};?\s*
                        (\$go2_restart\s*=\s*true;?)?\s*\z/xm)
        return nil unless m

        steps = [{ 'do' => 'wait_room_change', 'timeout' => 300 }]
        steps << { 'do' => 'replan' } if m[1]
        Result.new('wait_until_gone', steps)
      end

      # Repeat a command until the room changes, with no preamble.
      def convert_wayto_repeat_until_moved(body)
        m = body.match(/\Awhile\s+Room\.current\.id\s*==\s*\d+;\s*
                        fput\s+#{QUOTED};\s*waitrt\??;\s*end;?\s*\z/xm)
        return nil unless m

        Result.new('repeat_until_moved',
                   [{ 'do' => 'repeat', 'until_room_change' => true,
                      'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] },
                                  { 'do' => 'wait_rt' }] }])
      end

      # A first command, then repeat a second until the room changes.
      def convert_wayto_send_then_repeat(body)
        m = body.match(/\Afput\s+#{QUOTED};\s*
                        while\s+Room\.current\.id\s*==\s*\d+;\s*
                        fput\s+#{QUOTED};\s*waitrt\??;\s*end;\s*
                        (?:if\s+Room\.current\.id\s*!=\s*\d+;\s*
                        (\$go2_restart\s*=\s*true);?\s*end;?)?\s*\z/xm)
        return nil unless m

        steps = [{ 'do' => 'send', 'cmd' => m[1] || m[2] },
                 { 'do' => 'repeat', 'until_room_change' => true,
                   'steps' => [{ 'do' => 'send', 'cmd' => m[3] || m[4] },
                               { 'do' => 'wait_rt' }] }]
        steps << { 'do' => 'replan' } if m[5]
        Result.new('send_then_repeat', steps)
      end

      # Blocked-way retries: note the room, try the crossing, and if it did not
      # change, clear the obstruction and go again. The locker rooms are the
      # common case (your open locker blocks the exit).
      def convert_wayto_try_then_clear(body)
        m = body.match(/\Aroom\s*=\s*Room\.current\.id;\s*
                        fput\s+#{QUOTED};\s*
                        if\s*\(?\s*room\s*==\s*Room\.current\.id\s*\)?;\s*
                        (.*?);?\s*end\s*;?\s*
                        (\$go2_restart\s*=\s*true;?)?\s*\z/xm)
        return nil unless m

        fallback = convert_command_sequence(m[3])
        return nil unless fallback

        steps = [{ 'do' => 'try_move', 'cmd' => m[1] || m[2], 'fallback' => fallback }]
        steps << { 'do' => 'replan' } if m[4]
        Result.new('try_then_clear', steps)
      end

      # Guild doors that only answer Guildspeak: note the language you are
      # speaking, switch, cross, switch back. The restore is skipped when you
      # were already speaking Guildspeak, exactly as the proc does.
      def convert_wayto_speak_language(body)
        m = body.match(/\Afput\s+#{QUOTED};\s*
                        language\s*=\s*\/You\ are\ currently\ speaking\ \(\.\*\?\)\\\.\/\.match\(get\)
                        \.captures\.first\s+until\s+language;+\s*
                        fput\(#{QUOTED}\)\s+unless\s+language\s*==\s*#{QUOTED};\s*
                        fput\('unhide'\)\s+if\s+hidden\?\s+or\s+invisible\?;\s*
                        move\s+#{QUOTED};\s*
                        fput\('speak\ '\s*\+\s*language\.to_s\)\s+unless\s+language\s*==\s*#{QUOTED}\z/xm)
        return nil unless m

        # QUOTED carries two groups apiece: 1/2 ask, 3/4 switch command,
        # 5/6 native language, 7/8 crossing command, 9/10 the same language.
        native = m[5] || m[6]
        Result.new('speak_language',
                   [{ 'do' => 'await', 'cmd' => m[1] || m[2], 'timeout' => 5,
                      'for' => 'You are currently speaking (.*?)\.',
                      'bind' => { 'language' => 1 } },
                    { 'do' => 'if', 'when' => "not:capture:language=#{native}",
                      'then' => [{ 'do' => 'send', 'cmd' => m[3] || m[4] }] },
                    # One unhide for either condition, as the proc's `or` does.
                    { 'do' => 'if', 'when' => 'status:hidden',
                      'then' => [{ 'do' => 'send', 'cmd' => 'unhide' }],
                      'else' => [{ 'do' => 'if', 'when' => 'status:invisible',
                                   'then' => [{ 'do' => 'send', 'cmd' => 'unhide' }] }] },
                    { 'do' => 'move', 'cmd' => m[7] || m[8] },
                    { 'do' => 'if', 'when' => "not:capture:language=#{native}",
                      'then' => [{ 'do' => 'send', 'cmd' => 'speak {capture:language}' }] }])
      end

      # walk until checkloot.include?('path'); move 'go path'
      # Wander the fixed maze until the exit object shows up in the room.
      def convert_wayto_walk_until_loot(body)
        m = body.match(/\Awalk\s+until\s+checkloot\.include\?\(#{QUOTED}\);\s*move\s+#{QUOTED}\z/)
        return nil unless m

        # loot_noun, not loot_match: checkloot compares nouns exactly, while
        # loot_match is a regex over full names and would match wider.
        Result.new('walk_until_loot',
                   [{ 'do' => 'repeat', 'until' => "loot_noun:#{m[1] || m[2]}",
                      'steps' => [{ 'do' => 'move_random' }] },
                    { 'do' => 'move', 'cmd' => m[3] || m[4] }])
      end

      # move ['a','b'][rand(2)] while checkpaths == [...]; then gated moves.
      # Wander between two exits while the room still shows the full set.
      def convert_wayto_random_wander_gated(body)
        clauses = split_top_level(body)
        first = clauses.first.to_s
        m = first.match(/\Amove\s+\[((?:\s*#{QUOTED}\s*,?)+)\]\[rand\(\d+\)\]\s+
                         while\s+checkpaths\s*==\s*\[([^\]]*)\]\z/x)
        return nil unless m

        among = m[1].scan(QUOTED).map { |a, b| a || b }
        paths = m[4].scan(QUOTED).map { |a, b| a || b }
        return nil if among.empty? || paths.empty?

        rest = convert_wayto_gated_moves(clauses[1..].join(';'))
        return nil unless rest

        Result.new('random_wander',
                   [{ 'do' => 'repeat', 'until' => "not:paths_are:#{paths.join(',')}",
                      'steps' => [{ 'do' => 'move_random', 'among' => among }] }] + rest.schema)
      end

      # Escort crossings: resolve the bounty/Society escortee once, then wait
      # for it to follow before and after each move. escort_wait encapsulates
      # the whole idiom - the same task checks and the same 50 x 0.1s bound -
      # so the body reduces to an alternating wait/move list.
      ESCORT_PREAMBLE = /\Aif\s+\(\(bounty\?\s*=~.*?\)\|\|\(Society\.task\s*=~.*?\)\);\s*
                         mynpc\s*=\s*GameObj\.npcs\.find.*?;\s*
                         else;\s*mynpc\s*=\s*nil;\s*end;\s*/xm
      ESCORT_WAIT = /\A50\.times\s*\{\s*break\s+if\s+GameObj\.npcs\.any\?.*?\s*sleep\s+0\.1\s*\}\s+if\s+mynpc\z/m

      # Split on semicolons that separate statements, ignoring those nested in
      # braces or brackets (the escort wait carries one inside its block).
      def split_top_level(text)
        parts = []
        depth = 0
        current = +''
        text.each_char do |ch|
          case ch
          when '{', '[', '(' then depth += 1
          when '}', ']', ')' then depth -= 1
          end
          if ch == ';' && depth <= 0
            parts << current.strip
            current = +''
          else
            current << ch
          end
        end
        parts << current.strip
        parts.reject(&:empty?)
      end

      def convert_wayto_escort(body)
        return nil unless body =~ ESCORT_PREAMBLE

        rest = body.sub(ESCORT_PREAMBLE, '')
        steps = split_top_level(rest).map do |clause|
          if clause =~ ESCORT_WAIT
            { 'do' => 'escort_wait' }
          elsif (m = clause.match(/\Amove\s+#{QUOTED}\z/))
            { 'do' => 'move', 'cmd' => m[1] || m[2] }
          end
        end
        return nil if steps.any?(&:nil?) || steps.none? { |s| s['do'] == 'move' }

        Result.new('escort_moves', steps)
      end

      # Seated vs standing crossings: row out of the room if you are in a boat,
      # otherwise climb. The row loop's "while still in room N" is simply
      # "until the room changes", which also holds in unmapped rooms.
      def convert_wayto_sit_branch(body)
        m = body.match(/\Aif\s+checksitting;\s*
                        while\s+Room\.current\.id\s*==\s*\d+;\s*
                        fput\(?#{QUOTED}\)?;\s*waitrt\?;\s*end;\s*
                        else;\s*move\(?#{QUOTED}\)?;\s*end;\s*
                        (?:(fill_hands?);?)?\s*\z/xm)
        return nil unless m

        steps = [{ 'do' => 'if', 'when' => 'status:sitting',
                   'then' => [{ 'do' => 'repeat', 'until_room_change' => true,
                                'steps' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] },
                                            { 'do' => 'wait_rt' }] }],
                   'else' => [{ 'do' => 'move', 'cmd' => m[3] || m[4] }] }]
        # fill_hand and fill_hands are different steps; keep whichever it said.
        steps << { 'do' => m[5] } if m[5]
        Result.new('sit_branch', steps)
      end

      # Save the stance, force one for the crossing, restore it after: the
      # climb idiom. preserve_stance already does exactly this, including the
      # "only switch if it differs" guard on both ends.
      def convert_wayto_preserve_stance(body)
        m = body.match(/\Asave_stance\s*=\s*XMLData\.stance_text;\s*
                        fput\s+#{QUOTED}\s+if\s+save_stance\s*!=\s*#{QUOTED};\s*
                        (.*?);\s*
                        fput\s+"stance\s\#\{save_stance\}"\s+if\s+save_stance\s*!=\s*XMLData\.stance_text;+\s*
                        (\$go2_restart\s*=\s*true;?)?\s*\z/xm)
        return nil unless m

        wanted = m[3] || m[4]
        # The forced stance must be the one the guard compares against, or the
        # proc and preserve_stance would disagree about when to switch back.
        return nil unless (m[1] || m[2]).to_s.downcase == "stance #{wanted.downcase}"

        inner = convert_command_sequence(m[5])
        return nil unless inner

        steps = [{ 'do' => 'preserve_stance', 'stance' => wanted, 'steps' => inner }]
        steps << { 'do' => 'replan' } if m[6]
        Result.new('preserve_stance', steps)
      end

      # A sequence of moves, each optionally gated on an obvious path being
      # present ("move east while there is still an east") - the corridor and
      # ledge idiom. Any clause the vocabulary cannot express aborts the whole
      # conversion, so a partial crossing is never emitted.
      MOVE_CLAUSE = /\Amove\s*\(?\s*#{QUOTED}\s*\)?
                     (?:\s+(while|if)\s+checkpaths\.include\?\(#{QUOTED}\))?\z/x
      def convert_wayto_gated_moves(body)
        clauses = split_top_level(body)
        return nil unless clauses.length.between?(1, 6)

        steps = clauses.map do |clause|
          m = clause.match(MOVE_CLAUSE)
          return nil unless m

          cmd = m[1] || m[2]
          dir = m[4] || m[5]
          case m[3]
          when 'while'
            # Bounded: repeat only while that exit is still listed.
            { 'do' => 'repeat', 'until' => "not:path:#{dir}",
              'steps' => [{ 'do' => 'move', 'cmd' => cmd }] }
          when 'if'
            { 'do' => 'if', 'when' => "path:#{dir}",
              'then' => [{ 'do' => 'move', 'cmd' => cmd }] }
          else
            { 'do' => 'move', 'cmd' => cmd }
          end
        end
        # A bare move list is already the plain command_sequence case.
        return nil if steps.none? { |s| s['do'] != 'move' }

        Result.new('gated_moves', steps)
      end

      # Fog-sphere transits: enter, repeat a direction until the game finishes
      # placing you (transit rooms report an empty description), then stand.
      # The proc's two breaks - matched arrival text, or a loaded room - are
      # both "we have landed", which repeat's until_ bound expresses directly.
      def convert_wayto_fog_transit(body)
        m = body.match(/\Afput\s+#{QUOTED}\s*
                        loop\s+do\s*
                        result\s*=\s*dothistimeout\(#{QUOTED},\s*(\d+),\s*\/(.+?)\/\)\s*
                        break\s+if\s+result\s*=~\s*\/.+?\/\s*
                        break\s+unless\s+XMLData\.room_description\.empty\?\s*
                        end\s*
                        sleep\(?[\d.]+\)?\s+while\s+XMLData\.room_description\.empty\?;?\s*
                        (fput\s+#{QUOTED}\s+unless\s+standing\?;?)?\s*\z/xm)
        return nil unless m

        steps = [{ 'do' => 'send', 'cmd' => m[1] || m[2] },
                 { 'do' => 'repeat', 'until' => 'room_loaded',
                   'steps' => [{ 'do' => 'await', 'cmd' => m[3] || m[4],
                                 'timeout' => m[5].to_i, 'for' => m[6],
                                 'on_timeout' => 'continue' }] },
                 { 'do' => 'wait_until', 'when' => 'room_loaded', 'timeout' => 30 }]
        if m[7]
          steps << { 'do' => 'if', 'when' => 'not:status:standing',
                     'then' => [{ 'do' => 'send', 'cmd' => m[8] || m[9] }] }
        end
        Result.new('fog_transit', steps)
      end

      # move "knock wall"; fput "stand"  - a crossing with a trailing command.
      def convert_move_then_send(body)
        m = body.match(/\Amove\s*#{QUOTED};\s*fput\s*#{QUOTED}\z/)
        return nil unless m

        Result.new('move_then_send',
                   [{ 'do' => 'move', 'cmd' => m[1] || m[2] },
                    { 'do' => 'send', 'cmd' => m[3] || m[4] }])
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

      # Keyed doors: walk through if the key is already in hand, otherwise
      # fetch it from the configured sack, cross, and put it back. The key
      # item and sack are per-character UserVars, so they stay tokens.
      def convert_wayto_keyed_door(body)
        m = body.match(/\Aif\s+GameObj\.inv\.find\s*\{\|obj\|\s*obj\.noun\s*(?:==\s*"(\w+)"|=~\s*\/([^\/]+)\/)\s*\};\s*
                        fput\s+"go\ ([^"]+)";\s*else;\s*empty_hand;\s*
                        multifput\s+"get\ my\ ([^"]+)\ from\ my\ \#\{UserVars\.(\w+)\}",\s*
                        "go\ ([^"]+)",\s*"put\ my\ (\w+)\ in\ my\ \#\{UserVars\.(\w+)\}";\s*
                        fill_hand;\s*end;?\z/xm)
        return nil unless m

        noun = m[1] || m[2]
        key_ref = m[4].start_with?('#{') ? m[4] : m[4]
        get_cmd = "get my #{key_ref.sub(/\A\#\{UserVars\.(\w+)\}\z/) { "{uservar:#{Regexp.last_match(1)}}" }} " \
                  "from my {uservar:#{m[5]}}"
        Result.new('keyed_door',
                   [{ 'do' => 'if', 'when' => "has_item:#{noun}",
                      'then' => [{ 'do' => 'send', 'cmd' => "go #{m[3]}" }],
                      'else' => [{ 'do' => 'empty_hand' },
                                 { 'do' => 'send', 'cmd' => get_cmd },
                                 { 'do' => 'send', 'cmd' => "go #{m[6]}" },
                                 { 'do' => 'send', 'cmd' => "put my #{m[7]} in my {uservar:#{m[8]}}" },
                                 { 'do' => 'fill_hand' }] }])
      end

      # Retry-until-paths (Red Forest fog and relatives): stand, try the
      # crossing command, and repeat until the room's obvious paths match the
      # expected exit set. Optionally records an origin UserVar first.
      def convert_wayto_retry_paths(body)
        m = body.match(/\A(?:UserVars\.mapdb_(\w+)\s*=\s*'([^']+)';)?\s*result\s*=\s*nil;\s*
                        until\s+result\s*=~\s*\/Obvious\ paths:\ ([^\/]+)\/;\s*
                        fput\s+"stand"\s+until\s+standing\?;\s*
                        result\s*=\s*dothistimeout\s+"([^"]+)",\s*(\d+),\s*\/(.+?)\/;\s*
                        (?:if\s+result\s*=~.*?end;)?\s*end;?
                        # Exit variants: clear the origin var, ask go2 to replan, or both.
                        (?:\s*UserVars\.mapdb_(\w+)\s*=\s*nil;?)?
                        (?:\s*\$go2_restart\s*=\s*true;?)?\s*\z/xm)
        return nil unless m

        expected = m[3].strip
        steps = []
        steps << { 'do' => 'set', 'var' => m[1], 'value' => m[2] } if m[1]
        steps << { 'do' => 'repeat', 'until' => "paths_are:#{expected}",
                   'steps' => [{ 'do' => 'repeat', 'until' => 'status:standing',
                                 'steps' => [{ 'do' => 'send', 'cmd' => 'stand' }] },
                               { 'do' => 'await', 'cmd' => m[4], 'timeout' => m[5].to_i, 'for' => m[6] },
                               { 'do' => 'sleep', 'seconds' => 0.5 },
                               { 'do' => 'wait_rt' }] }
        steps << { 'do' => 'set', 'var' => m[7], 'value' => nil } if m[7]
        # The replan is only meaningful if we have not already arrived; an
        # unconditional restart loops when the crossing succeeded.
        steps << { 'do' => 'replan' } if body.include?('$go2_restart')
        Result.new('retry_until_paths', steps)
      end

      # Capture families: procs that match a game line, keep part of it, and
      # use that part in a later command. These became expressible once await
      # gained `bind` + the {capture:name} token.
      def convert_wayto_captures(body)
        # matchfindword: capture a direction word from a prompt line, move it.
        if (m = body.match(/\Amove\s+#{QUOTED}\s+fput\s+#{QUOTED}\s+
                            dir\s*=\s*matchfindword\s+#{QUOTED}\s+
                            move\s+#{QUOTED}\s+
                            sleep\s+(#{NUM})\s+if\s+running\?\(#{QUOTED}\)\s+
                            move\s+dir\z/xm))
          prompt = (m[5] || m[6]).sub(/\s*\?\s*\z/, '')
          return Result.new('capture_direction',
                            [{ 'do' => 'move', 'cmd' => m[1] || m[2] },
                             { 'do' => 'await', 'cmd' => m[3] || m[4],
                               'for' => "#{Regexp.escape(prompt)}\\s*(\\w+)",
                               'bind' => { 'dir' => 1 }, 'timeout' => 10 },
                             { 'do' => 'move', 'cmd' => m[7] || m[8] },
                             { 'do' => 'move', 'cmd' => '{capture:dir}' }])
        end
        # Rotating staircases: four positions in one line; climb the Nth whose
        # wall matches the target.
        if (m = body.match(/\Aclear\s+put\s+'look'\s+loop\s*\{\s*line\s*=\s*get\s+
                            if\s+line\s*=~\s*\/(.+?)\/\s+
                            if\s+\$3\s*==\s*'(\w+)'.*?\}\z/xm))
          words = body.scan(/move\s+'climb ([^']+)'/).flatten
          return nil unless words.length == 4
          pattern = m[1].gsub('(northern|eastern|southern|western)', '(?<wall>northern|eastern|southern|western)')
          return Result.new('capture_ordinal',
                            [{ 'do' => 'send', 'cmd' => 'look' },
                             { 'do' => 'await', 'for' => pattern, 'timeout' => 10,
                               'bind' => { 'which' => { 'group' => 'wall', 'equals' => m[2], 'words' => words } } },
                             { 'do' => 'move', 'cmd' => 'climb {capture:which}' }])
        end
        # Language swap: capture current language, speak the passphrase in
        # Guildspeak, restore.
        if (m = body.match(/\Afput\s+'speak';\s*language\s*=\s*\/You are currently speaking \(\.\*\?\)\\\.\/\.match\(get\)\.captures\.first\s+until\s+language;+\s*
                            fput\('speak (\w+)'\)\s+unless\s+language\s*==\s*'(\w+)';\s*
                            fput\('unhide'\)\s+if\s+hidden\?\s+or\s+invisible\?;\s*
                            move\s+#{QUOTED};\s*
                            fput\('speak '\s*\+\s*language\.to_s\)\s+unless\s+language\s*==\s*'\2'\z/xm))
          return Result.new('capture_language',
                            [{ 'do' => 'await', 'cmd' => 'speak',
                               'for' => 'You are currently speaking (.*?)\\.',
                               'bind' => { 'lang' => 1 }, 'timeout' => 10 },
                             { 'do' => 'if', 'when' => "not:capture:lang=#{m[2]}",
                               'then' => [{ 'do' => 'send', 'cmd' => "speak #{m[1]}" }] },
                             { 'do' => 'if', 'when' => 'status:hidden',
                               'then' => [{ 'do' => 'send', 'cmd' => 'unhide' }] },
                             { 'do' => 'move', 'cmd' => m[3] || m[4] },
                             { 'do' => 'if', 'when' => "not:capture:lang=#{m[2]}",
                               'then' => [{ 'do' => 'send', 'cmd' => 'speak {capture:lang}' }] }])
        end
        nil
      end

      # The group-wait preamble: scan the room's "X, Y and Z followed." line
      # into a member list. Every crossing carrying it is move_with_group with
      # decoration. Anchored on the preamble's own terminator, since its body
      # contains inner braces.
      GROUP_SCAN = /\Agroup_members\s*=\s*nil;\s*clear\.reverse\.each\s*\{.*?
                    group_members\s*=\s*nil\s+if\s+group_members\.empty\?;\s*break;\s*end\s*\};\s*/xm

      def convert_wayto_group(body)
        return nil unless body =~ /\Agroup_members\s*=\s*nil;\s*clear\.reverse\.each/
        rest = body.sub(GROUP_SCAN, '')
        # Remaining shapes: [empty_hands;] move 'CMD'; [waitrt?;] [fill_hands;]
        # then the wait-for-group tail (any of its spellings).
        m = rest.match(/\A(empty_hands;\s*)?move\s+#{QUOTED};\s*(waitrt\?;\s*)?(fill_hands;\s*)?
                        if\s+\(?group_members/xm)
        return nil unless m

        steps = []
        steps << { 'do' => 'empty_hands' } if m[1]
        steps << { 'do' => 'move_with_group', 'cmd' => m[2] || m[3] }
        steps << { 'do' => 'wait_rt' } if m[4]
        steps << { 'do' => 'fill_hands' } if m[5]
        Result.new('group_move', steps)
      end

      # The same group preamble, but the crossing between it and the wait is
      # something other than a plain move - a jump that stuns you, a climb.
      # note_group and group_wait bracket whatever it is.
      def convert_wayto_group_bracketed(body)
        return nil unless body =~ /\Agroup_members\s*=\s*nil;\s*clear\.reverse\.each/

        rest = body.sub(GROUP_SCAN, '')
        # Everything up to the group-wait tail is the crossing proper.
        idx = rest.index(/if\s+\(?group_members/)
        return nil unless idx

        middle = convert_command_sequence(rest[0...idx].sub(/;\s*\z/, ''))
        return nil unless middle

        Result.new('group_bracketed',
                   [{ 'do' => 'note_group' }] + middle + [{ 'do' => 'group_wait' }])
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
        # Posture guards: the step is a no-op when already in that posture.
        /\Afput\s+#{QUOTED}\s+unless\s+(kneeling|standing|sitting)\?\z/                                                                                               => lambda { |m|
          { 'do' => 'if', 'when' => "not:status:#{m[3]}",
            'then' => [{ 'do' => 'send', 'cmd' => m[1] || m[2] }] }
        },
        # Wander whatever exits remain, while there are more than N of them.
        %r{\Amove\s+checkpaths\[rand\(checkpaths\.length\)\]\s+while\s+checkpaths\.length\s*>\s*(\d+)\z}                                                              => lambda { |m|
          { 'do' => 'repeat', 'times' => 20, 'until' => "paths_at_most:#{m[1]}",
            'steps' => [{ 'do' => 'move_random' }] }
        },
        # Ride out a stun: wait for it to land, then wait for it to pass.
        /\Await_until\s*\{\s*stunned\?\s*\}\z/                                                                                                                        => ->(_) { { 'do' => 'wait_until', 'when' => 'status:stunned', 'timeout' => 30 } },
        /\Await_while\s*\{\s*stunned\?\s*\}\z/                                                                                                                        => ->(_) { { 'do' => 'wait_until', 'when' => 'not:status:stunned', 'timeout' => 300 } },
        /\Await_while\s*\{\s*checkstunned\s*\}\z/                                                                                                                     => ->(_) { { 'do' => 'wait_until', 'when' => 'not:status:stunned', 'timeout' => 300 } },
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

      # Edges whose proc no recognizer or manual entry could handle, as
      # [field, room_id, dest] triples. A submission that produces any of
      # these is not convertible yet: the fix is a recognizer or a manual
      # conversion, decided by a human during review. Callers gate on this
      # rather than shipping a map with an eval'd string still in it.
      def unconverted
        %w[timeto wayto].flat_map do |field|
          @residue[field].flat_map { |_, edges| edges.map { |room, dest| [field, room, dest] } }
        end
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
