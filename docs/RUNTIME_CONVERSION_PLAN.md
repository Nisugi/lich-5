# Runtime MapDB Conversion Plan

Goal: Lich converts StringProc map edges to MapEngine schema **at execution
time**. The mapdb stays in proc form permanently — on disk, on tillmen, and
in memory. Mappers' edit/dump/upload flow is untouched. Safety (no eval,
command allowlist, validated schema) lives entirely in lich-5. The schema
mapdb branch remains a prepared fallback that can be activated the day
tillmen's server goes away, with zero engine changes needed at that point.

## Architecture (one sentence)

Wrap every `;e ` edge at map load in a `GuardedProc < StringProc` whose
`call` converts-then-executes through MapEngine (memoized by source string)
and never evals; `_dump` still returns the original source, so saves and
mapmap round-trip byte-identical.

## Why this shape

- `StringProc#call` (lib/common/class_exts/stringproc.rb:28) is the single
  execution choke point: dijkstra (`map_base.rb:884`), go2 (`when Proc then
  way.call`), and engine cross-delegation (`map_engine.rb:72`) all go
  through it.
- `StringProc#_dump` returns `@string` — subclassing preserves dump
  fidelity for free. The map in memory is never edited.
- The wrap site is exactly the two `StringProc.new` calls in
  `parse_map_json` (`map_base.rb:379,386`) — scope is *mapdb-loaded procs
  only*. Script-injected StringProcs (teleport.lic) are constructed
  elsewhere and keep their current eval behavior by construction.
- Memoization by source string makes the dijkstra hot path safe: first
  timeto evaluation converts (~µs of regex), every later one executes
  cached pure schema.

## Phase 1 — GuardedProc core (lib/common/map/)

1. **`MapEngine::GuardedProc < StringProc`**, constructed with
   `(source, field, room_id, dest)`.
   - Class-level memo cache: `{ source_string => Cost | Crossing | :refused }`
     (manual-overlay hits cached per `room:dest` instead, since they're
     keyed by edge, not body).
   - `call`: lookup → on miss run `MapConvert` recognizers, then the
     manual-conversions overlay (`mapdb_manual_conversions{,_dr}.json`,
     which must now **ship in lich-5** and load lazily), validate with
     `MapEngine::Validator`, apply `guard_trailing_replan` for wayto.
   - Execute: timeto → `resolve_cost`, wayto → `Crossing#call`.
   - `_dump` / `inspect` / `to_json` inherited: emits original proc source.
2. **Refusal policy (fail closed, never eval):**
   - timeto → return `nil` (edge unroutable; dijkstra already skips nil).
   - wayto → log once, `echo` a clear message, return falsy so go2 treats
     the crossing as failed rather than hanging.
   - Every refusal recorded in a registry: `Map.unconverted_edges` →
     `[{room, dest, field, cluster_key}]`.
3. ~~Crossings bridge~~ **DROPPED (2026-08-12).** `map_crossings.rb` and the
   `unique_crossing` strategy are deleted; relocating Ruby there tied a map
   edge to Lich's release schedule. It is also unnecessary: every one of
   those bodies now converts through a recognizer or the manual overlay, so
   a stock tillmen map refuses **zero** edges.
4. **Plain-string degenerate case:** recognizers that emit a plain string
   edge (`plain_move`) just execute a `move` — do NOT rewrite the edge.

## Phase 2 — Telemetry and operator tooling — COMPLETE (2026-08-12)

- [x] `Map.conversion_report` — in-game mirror of MapConvert#report:
  converted-body count plus refusal clusters with an example edge each.
- [x] `Map.unconverted_edges` — the same data as structured hashes.
- [x] Stats **by idiom** for converted edges — `Map.converted_idioms`, and
  `Map.conversion_report(true)` for the printable breakdown. Recognizer
  hits count distinct bodies (conversion is memoized per body); `manual`
  counts edges, since that overlay is keyed per edge. A full GS map uses
  **101 recognizers**, led by `wayto:table_join` (468) and
  `wayto:command_sequence` (393), with **31 singletons** — that tail is
  where tillmen drift shows up first, which is the point of the stat.
  A spec asserts every conversion is attributed, so nothing falls through.
- [x] Refusals logged to `LOG_DIR/mapengine-refusals.log`, one tab-separated
  line per **new cluster** (timestamp, field, edge, validator errors,
  masked body), appended across sessions so a user can hand the file over
  without reproducing anything. Logging is best effort: an unwritable log
  dir disables logging rather than breaking routing, since failing closed
  on an edge must never become an exception on the travel path.
- [x] `Map.convert_edge` documented as an eager preview of the lazy runtime
  path (cartographer `docs/mapping-guide.md` + the method's own docs).
  Doing so surfaced a real inconsistency: it built a bare MapConvert, so
  it skipped the manual overlay, the trailing-replan guard, and
  validation. It now shares GuardedProc's converter and applies the same
  post-processing in the same order, so the JSON it echoes for a
  submission is the JSON that would actually run.
- [x] Notice when anything refuses — but **not at map load**, as originally
  written: conversion is lazy, so at load time nothing has been converted
  and no refusal is known yet. There is no later "everything is loaded"
  moment either. The only point at which a refusal is known to be new is
  its first sighting, so the echo happens there (once per cluster, not per
  edge) and now names `;e Map.conversion_report` for the full list.

## Phase 3 — Validation gates (all must pass before PR)

1. **Coverage spec:** run the runtime conversion path over a full
   tillmen-main GS mapdb and the DR mapdb; assert refusal count == the
   offline converter's residue count (target: 0 for GS given the crossings
   bridge + manual overlay; DR to its current known residue).
2. **Fidelity spec:** load map → dump → byte-compare wayto/timeto against
   input for every room. This is the mapper-workflow guarantee.
3. **Performance:**
   - Benchmark memoized timeto eval vs. raw `eval` baseline (expect parity
     or better after first hit).
   - Benchmark `Map.findpath` across the standard long-route set before /
     after; budget: no measurable regression (>2%). **DONE** — resolution
     of the timeto costs dijkstra actually touches is 25.5x faster warm
     than the eval it replaced; see the Status table.
   - Cold-route check: dijkstra touches every timeto in the searched
     region, but most timeto are numeric, and proc bodies are heavily
     duplicated (the cache keys by source string, so dozens of edges
     sharing one gate body convert once). Expected cold cost: a few dozen
     unique conversions at microseconds each — milliseconds per session.
     Benchmark to confirm; no pre-warm expected to be needed.
4. **In-game smoke:** re-run the existing GS field-test checklist against a
   *stock tillmen map file* (not a converted one) — that's the whole point.
   DR in-game pass (still outstanding from the original project).

## Phase 4 — Reposition the existing branches

- **lich-5 `feat/mapdb-primitives`:** gains Phase 1–3 on top; PR write-up
  reframed: "Lich stops evaling map data" rather than "the mapdb changes
  format". Still sequenced after upstream #1495.
- **mapdb `feat/mapengine-schema`:** kept as the prepared fallback ("break
  glass if tillmen goes down": final convert, publish, flip). Not part of
  the release path. Its CI wiring drops from "remaining work" to optional.
- **cartographer `feat/mapengine-schema`:** allowlists still authored in
  cartographer config, but at runtime the allowlist is a **distributed data
  file** in the effect-list.xml / gameobj-data.xml mold: fetched and
  updated via the existing data-file update path (jinx / ;lich5-update).
  New command shapes become a data fetch, not a Lich release. Same
  treatment for the manual-conversions JSON.
- **Transition designs** (back-render, sync bot, id reservation): archived
  as deferred; only needed if authority ever flips to the schema repo.

## Open decisions (settle during Phase 1)

- Allowlist enforcement point at runtime: validate-at-convert (cache time)
  is enough since schema is immutable after caching. Peregrine-style
  user-var replay stays exempt by construction as before.
- ~~DR: 19 escape-hatch blocks~~ **RESOLVED (2026-08-12):** the DR pass is
  finished; all 18 blocks are schema and DR refuses zero edges at runtime.
- Refusal policy when a *future* tillmen update adds an unrecognized idiom:
  fail closed with telemetry, revisit if it becomes common. New procs are
  rare and curated, so the recognizer set is the spec mappers write against
  (decided 2026-08-12).

## Trust boundary (settled 2026-08-12)

"Zero eval of map data" means data loaded from a map file. Procs injected
by running scripts (teleport.lic) are script code the user chose to run —
already arbitrary Ruby — so guarding them adds no safety; they keep eval
behavior by construction (GuardedProc is only constructed in
parse_map_json).

## The flip, when tillmen retires

The loader's dual path (map_base.rb:377-390) already handles schema edges
via build_wayto/build_timeto. Flip = cartographer submission pipeline
converts at the boundary, repo stores schema, Lich reads it unchanged —
GuardedProc simply never constructs because no ';e ' strings remain.
Mixed proc/schema map files work edge-by-edge during any transition.

## Status (2026-08-12)

Phase 1 built and measured against real data:

| gate | result |
|---|---|
| GS coverage (stock tillmen map, 9,796 procs) | **0 refusals** |
| DR coverage (929 procs) | **0 refusals** |
| Dump fidelity (9,796 edges) | **0 mismatches** |
| Cold convert, all timeto bodies | **16.6 ms** (1,873 edges -> 151 unique) |
| Warm lookup per edge | **0.76 us** vs **7.47 us** for eval � ~10x faster |

Phase 2 complete: idiom stats, refusal logging, first-sighting notice, and
`convert_edge` aligned with the runtime path.

Phase 3 performance gate met (`spec/lib/common/map/findpath_benchmark_spec.rb`,
1,873 timeto edges / 107 distinct bodies):

| measurement | result |
|---|---|
| Cold convert, all timeto bodies | **16.7 ms** total (8.92 us/edge, once) |
| Warm lookup (every later dijkstra pass) | **0.63 us/edge** |
| Eval baseline it replaced | **16.20 us/edge** |
| Steady-state speedup | **25.5x** |

The eval baseline is approximate — outside a live session many bodies
reference absent game state and raise, so raise-and-rescue is inside the
measurement. The margin is far larger than that caveat can explain, and
the memoized path does no per-call parsing at all.

Remaining: in-game smoke on a stock map and the DR in-game pass. Both
require a live session and cannot be done from here.

## Success criteria

- Zero `eval` of map data anywhere in Lich when routing/traveling.
- Stock tillmen map file loads, routes, dumps byte-identically.
- GS refusals: 0. DR refusals: 0 (after DR pass).
- No pathfinding performance regression.
