# MapDB edge classification study

Full classification of every StringProc edge in a stock GemStone mapdb,
undertaken to answer a question the conversion work had been dodging:
**what actually makes an edge a "one-off"?**

The honest prior answer was: nothing principled. Recognizers were written by
pattern-matching whatever the corpus produced, and anything that did not fit
was hand-written into the manual overlay. "One-off" meant "the leftovers,"
not a category discovered in the data. This study replaces that with
measurement.

It also tests a second proposition: the mapdb is *editable*. Rather than
adapting the converter to every spelling mappers invent, **normalize the
procs themselves** — keeping tillmen's format, keeping Ruby, keeping the
workflow mappers know, but converging on one canonical way to say each
thing.

Method: every `;e ` edge was extracted with its converted idiom and overlay
status, grouped into structural *shapes* (source with numbers and string
literals masked), and classified by twelve independent agents reading the
real Ruby. Singleton shapes were classified individually; multi-edge shapes
were classified per shape and weighted by edge count.

Source: `data/GSIV/map-*.json`, the newest proc-bearing map in the checkout.

---

## Corpus at a glance

| measure | value |
|---|---|
| Proc edges | 9,796 |
| Distinct bodies | 1,775 |
| Distinct **shapes** | 423 |
| Edges with a manual-overlay entry | 304 |
| Edges no recognizer matches | 208 |
| Recognizers in use | 103 |

Shapes are the unit that matters: 9,796 edges collapse to 423 shapes. 217
shapes cover 9,590 edges; the remaining **206 shapes appear on exactly one
edge each** — the presumed "one-offs."

---

## Finding 1 — 78% of "one-offs" are accidental

The 206 single-edge shapes, classified individually:

| verdict | count | share |
|---|---|---|
| **ACCIDENTAL** — ordinary behavior, unusual spelling | **161** | **78%** |
| ESSENTIAL — genuinely unique behavior | 42 | 20% |
| BROKEN — dead or wrong code | 2 | 1% |
| UNCLEAR | 1 | 0% |

**Four out of five "unique" edges are not unique.** They are ordinary
behavior written by someone who did not know the house style:

- `fput 'search'; waitrt?; move('go steps')` — parenthesized `move` makes it
  a new shape.
- `(!UserVars.x.nil? and UserVars.x == y) ? 0.2 : nil` instead of the
  canonical ternary — same semantics, new shape.
- Five rooms each implementing "retry `go fog` until the exits match," each
  with slightly different loop spelling.
- `move 'south' until Room.current.id != 3035` vs. the same as `while`/`end`.

The 42 ESSENTIAL cases are real and should stay: the Confluence maze solver,
the rune staircase puzzle, mirror-aiming, deity-verse murals, ferry-ticket
purchase with bank withdrawal, familiar-driven door puzzles. Algorithms, not
spellings.

---

## Finding 2 — a third of all edge traffic is duplicated boilerplate

Classifying the 217 multi-edge shapes and weighting by edges gives the
picture for the corpus as a whole:

| verdict | edges | share |
|---|---|---|
| CANONICAL — already the right reference form | 6,067 | 64.3% |
| **NORMALIZE — a worse spelling of something else** | **3,228** | **34.2%** |
| ESSENTIAL-COMPLEX — genuinely algorithmic | 83 | 0.9% |
| UNCLEAR | 41 | 0.4% |
| BROKEN | 11 | 0.1% |

**~3,200 edges are duplicated boilerplate.** Under 1% of edge traffic is
genuinely algorithmic. The biggest offenders, by edges affected:

| edges | family | what it is | proposed primitive |
|---|---|---|---|
| 541 | patrol | 3 copies of patrol-until-object, each with a 100+ element route table inlined | `patrol_until(route, target, then:)` |
| 497 | shifting maze | 3 copies of one byte-identical minotaur solver | `shifting_maze_move(target, maze:)` |
| 478 | table join | **468 distinct bodies** differing only in the table name | `join_table(name)` |
| 477 | confluence | string-target variant of the numeric confluence shape | `confluence_travel(target)` |
| 161 | pedal loop | "repeat until room changes," hardcoded to `pedal` | `repeat_until_moved(cmd)` |
| 150 | ice caution | encumbrance/survival/haste check duplicated verbatim | `ice_caution` |
| 113 | spell branch | old `checkspell()` spelling of `Spell[N].active?` | `move_if_spell(...)` |
| 80 | row or swim | 80 edges, **80 distinct bodies**, room id inlined in each | `row_or_swim(dir)` |

The `join_table` case is the clearest: one behavior, one regex, copy-pasted
478 times with only the table name varying. The `row_or_swim` case is worse
per-edge — every single one of the 80 is a distinct body, because the source
room id is inlined into the loop.

Beyond these, the agents repeatedly proposed the same small set of helpers:
`climb(target)` (empty hands / move / waitrt / fill hands, appearing in at
least five spellings, several of which omit the `waitrt?` and refill during
roundtime), `unlock_door(door, key:)`, `ensure_buff(spell)`, `with_stance`,
`move_until_moved`, and a unified gate family
(`race_gate` / `citizenship_gate` / `prof_only` / `have_item?`).

---

## Finding 3 — the recognizer set mostly absorbs spelling variance

Of 103 recognizers in use, **40 match three or fewer edges**, together
covering just **65 edges**. Twenty-three serve **exactly one edge each**:

```
timed_grant_gate, shop_by_name, capture_direction, group_bracketed,
title_loop, walk_until_object, move_unless_path, scheduled_ride,
conditional_hands, repeat_send, wait_for_object, loot_branch,
search_branch, send_until_count, repeat_until_left, fog_retry_loop,
move_list, send_until_text, sleep_wake, search_until_name,
repeat_until_moved, send_then_repeat, search_until_object
```

Each is a maintained code path in `map_convert.rb` whose whole job is to
absorb one mapper's phrasing of a behavior that already has a canonical
form. This is the measurable cost of *adapting to* the corpus instead of
*normalizing* it — and it answers "why do we need multiple primitives that
do similar things?" We do not. The primitives were derived from surface
spellings rather than from what edges actually do.

---

## Finding 4 — the overlay is mostly justified, with a small dead core

**This section corrects an earlier draft of this study.** That draft claimed
96 overlay entries were redundant. The figure was wrong: it counted "a
recognizer matched this body" as "the overlay is unnecessary," without
comparing the two outputs. Re-auditing by actually diffing the schema:

| category | count | assessment |
|---|---|---|
| `wayto` genuinely needed | 146 | no recognizer handles these |
| `timeto` genuinely needed | 62 | same |
| **`wayto` schema *differs* from recognizer** | **84** | deliberate improvement; **keep** |
| **byte-identical to recognizer output** | **12** | dead weight; deleted |
| not a proc at all | 23 | overriding *plain* edges |
| orphaned (edge no longer exists) | 1 | deleted |

The 84 differing entries are the interesting case, and they cut both ways:

- `19377:25691` — the proc blindly sends `ask sailor about boat` twice; the
  overlay detects the "have enough for the fare" refusal. The overlay is
  strictly better and must stay.
- `11357:11355` — the overlay ends with a bare `replan`; the recognizer now
  wraps it in a `not:in_room` guard. Here the *recognizer* is better, and
  the overlay is holding that edge back.

So the overlay is not dead weight in bulk — it is a mix of genuine
improvements and a few entries that have quietly fallen behind. Only the 12
byte-identical duplicates and the 1 orphan were removed (see the
`the manual overlay earns its place` spec, which now fails if such an entry
reappears).

The 23 non-proc entries remain a separate concern wearing the same coat:
Lich silently patching *plain* edges the upstream map got wrong. That is a
map fix shipped on Lich's release schedule, invisible to the mapper who owns
the room — the same objection that killed `map_crossings.rb`. They are
untouched here and still want a decision.

---

## Things that should not be in map data at all

The classifiers flagged several edges as wrong in kind, not just in style:

- **`if Script.running? 'ego2'; nil; else; 180; end`** — a named third-party
  user script hardcoded into shared map data, with a 180-second cost.
  Character-local config masquerading as map topology. Also
  `bigshot`/`wander` in five more edges.
- **`UserVars.Mularos_Lover.each { |c| fput c }`** — executes an arbitrary
  user-supplied array of raw game commands as the traversal. Unbounded
  content, no actual movement.
- **`move (XMLData.room_exits - ['ne']).first`** — picks an arbitrary exit
  from whatever the room advertises, so the destination is not determined by
  the edge.
- **`move 'out';waitrt`** — `waitrt` without the `?` is a different call from
  the `waitrt?` used everywhere else; almost certainly a typo.
- **`empty_hand` (singular)** in room 13960 — not a Lich method; the call
  raises and the move never runs.
- **Multi-room walks as one edge** — `fput 'search';move;move;move;move;move`
  hides intermediate rooms from the pathfinder. These should be real edges.

---

## What follows

The mapdb stays Ruby procs in tillmen's format. What changes is that procs
get **one canonical way to say each thing**, which:

1. **Shrinks the recognizer set toward one-per-behavior.** ~40 recognizers
   become deletable once their edges are respelled.
2. **Shrinks the overlay.** An edge that is "one-off" only because of
   spelling stops being one-off when respelled. Note the corrected Finding 4:
   most current overlay entries are earning their place, so the gain here is
   real but smaller than the first draft of this study claimed.
3. **Gives new mappers a spec to write against.** This is the
   skilled-vs-first-time-mapper gap: there is currently no canonical form to
   learn, so every newcomer invents one.
4. **Makes drift a review signal** instead of silently growing recognizer
   #104.

Sequencing note: normalization changes map *data*, so it belongs in the
submission pipeline, and every rewrite must be behavior-preserving.

---

## Caveats

These matter for anyone acting on the numbers.

- **Classification was done by language models reading Ruby, not executing
  it.** The aggregate split is a strong signal; individual verdicts must be
  confirmed before any edge is rewritten.
- **Several suggested rewrites are approximately, not exactly, equivalent.**
  One agent flagged this directly: `fput X until line =~ /.../` differs from
  a `waitfor` rewrite, because `fput` returns the matched line and consumes
  the stream differently. Another noted `line = get until ...` busy-drains
  the stream where `wait_until` does not. Behavior-preservation is per-edge
  work.
- **"Shape" masks numbers and quoted strings.** Two edges sharing a shape can
  differ in ways that matter — different destinations, different regexes.
  The 478-edge `join_table` family is one shape but 468 distinct bodies.
- **The CANONICAL 64% is not all pristine.** It includes the 2,756-edge
  confluence family and 957-edge delegation family, which are canonical
  because they are *consistent*, not because they are simple.
- **`timeto` is under-represented** in the singleton half of the study,
  simply because there are fewer distinct timeto shapes.
- **11 edges were flagged BROKEN and 41 UNCLEAR.** Those need human
  decisions, not mechanical rewrites.

---

## Reproducing

The corpus dump and per-shape grouping came from a throwaway RSpec harness
that loads the map through the normal loader, converts each edge with
`MapConvert`, and records `(field, room, dest, body, shape, idiom, overlay)`.
To regenerate: iterate the map JSON, and for each `;e ` edge record
`MapConvert#cluster_key(body)` as the shape and the `Result#idiom` of
`convert_wayto` / `convert_timeto`.

Per-edge verdicts and the classification prompts are in the session
transcript for this study.
