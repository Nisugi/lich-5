# Lich stops evaluating map data

> **Draft PR body — not yet opened.** Text intended for the pull request
> description for `feat/mapdb-primitives`. Two things to settle before
> opening: the DR proc count flagged inline below, and a fresh merge from
> `main` (the branch is behind). See `RUNTIME_CONVERSION_PLAN.md` for the
> design and phase status this summarizes.

## What this changes

Lich currently evaluates arbitrary Ruby that arrives in the map database.
Roughly 9,800 edges in a stock GemStone mapdb are `";e ..."` strings —
Ruby source stored as data — and `StringProc#call` runs them through
`eval` every time a route touches one.

This PR removes that. Map procs are converted to a declarative schema and
interpreted by reviewed Lich code. **The mapdb does not change.** It stays
in proc form on disk, on tillmen, and in memory. Mappers' edit / dump /
upload workflow is untouched, and no coordination with the mapdb repo is
required to merge this.

## How

Every `;e ` edge is wrapped at load time in a `GuardedProc < StringProc`.
The first time an edge is used, its body is converted to MapEngine schema
and the schema is executed. The source is never evaluated.

`_dump` still returns the original source, so saving a map or running
mapmap round-trips byte-identically — verified across all 9,796 proc edges
of a stock map with zero mismatches.

Conversion is memoized by source string. The mapdb duplicates bodies
heavily: ~9,800 proc edges reduce to ~1,800 distinct bodies, and the 1,873
`timeto` edges dijkstra actually touches reduce to just 107. A session
converts each body once and then runs pure schema.

### Fail closed

A body no recognizer handles is refused, never evaluated:

- `timeto` → `nil` (dijkstra already treats a nil cost as not routable)
- `wayto` → `false` (go2 treats the crossing as failed)

A refusal makes one edge untravellable. It cannot crash a route, and it
cannot execute anything. Unknown vocabulary, missing state, and evaluation
errors all resolve to "edge not routable" by construction.

## Security posture

`eval` of map data is gone from the map path entirely — `grep -rn "eval("
lib/common/map/` returns nothing. The remaining `eval` in
`StringProc#call` now serves only script-injected procs.

**That exception is deliberate and worth stating plainly.** Scripts like
teleport.lic construct StringProcs directly. That is script code the user
chose to run — already arbitrary Ruby — so guarding it adds no safety.
GuardedProc is constructed only in `parse_map_json`, so the boundary is
exactly "data loaded from a map file."

**What this PR does not do:** it does not filter game commands at runtime.
The command allowlist lives in the cartographer submission pipeline, where
a human reviews new edges. This PR narrows the trust boundary from
"arbitrary Ruby" to "a fixed step vocabulary"; it does not make a
malicious-but-well-formed schema edge safe. Schema is validated at
conversion time (unknown steps, unknown strategies, missing required
params, dangling `steps_ref` all reject), which is what makes the
vocabulary a real wall rather than a suggestion.

## Coverage

The whole approach is only viable if conversion is essentially total — a
refusal is an edge a user can no longer travel.

| gate | result |
|---|---|
| GS stock tillmen map (9,796 procs) | **0 refusals** |
| DR mapdb (~930 procs) | **0 refusals** |
| Dump fidelity (9,796 edges) | **0 mismatches** |

<!-- NOTE before publishing: the GS and fidelity numbers are reproducible
     from this checkout (spec/lib/common/map/guarded_proc_spec.rb against
     data/GSIV). The DR figure was measured in an earlier session against
     the pre-conversion DR map, which is not in any local tree now — only
     the converted one is. Re-run the DR coverage spec against a stock DR
     map and replace "~930" with the exact count before opening. -->


Coverage comes from 137 recognizers, 11 strategies, and a hand-authored
overlay of 328 GS entries plus 19 DR entries for edges whose Ruby was
genuinely one-off. The overlay is JSON data keyed by `"room:dest"` — large
in line count, but reviewable per entry, and not code.

As an independent check, a real DR mapper submission (266 edges over 32
distinct bodies, from the lich_repo_mirror `dr_map` report) converted with
**no recognizer changes**. It is pinned as a regression fixture.

## Performance

Dijkstra touches every `timeto` in the searched region, so cost resolution
is where a regression would surface.

| measurement | result |
|---|---|
| Cold convert, all `timeto` bodies | 16.7 ms total, once per session |
| Warm lookup | **0.63 µs/edge** |
| Eval baseline it replaces | 16.20 µs/edge |
| Steady-state | **25.5× faster** |

Routing gets faster, because the old path re-parsed Ruby on every single
call and the new one does a hash lookup.

The eval baseline is approximate: outside a live session many bodies
reference absent game state and raise, so raise-and-rescue sits inside the
measurement. The direction is not in doubt — the memoized path does no
per-call parsing at all — but treat 25.5× as "much faster," not a precise
ratio. See `spec/lib/common/map/findpath_benchmark_spec.rb`.

## Operator tooling

- `Map.conversion_report` — bodies converted, plus refusal clusters with an
  example edge each. `(true)` adds a per-recognizer breakdown.
- `Map.converted_idioms` — which recognizers this map leans on. A stock GS
  map uses 101, with a 31-entry singleton tail; that tail is where upstream
  idiom drift will surface first.
- `Map.unconverted_edges` — the same refusal data, structured.
- Refusals also append one line per distinct idiom to
  `logs/mapengine-refusals.log`, so a user can hand over the file without
  reproducing anything. Logging is best effort: an unwritable log dir
  disables logging rather than breaking routing.
- `Map.convert_edge(room, dest)` — eager preview of what an edge is already
  doing at runtime, through the same recognizers and overlay.

## Testing

883 map and tool examples, all passing. Beyond unit coverage:

- **Fidelity**: load → dump → byte-compare, every proc edge of a real map.
- **Coverage**: full GS and DR mapdbs must refuse zero edges.
- **Submission regression**: the real DR submission above.
- **Benchmark**: asserts warm resolution beats the eval baseline.

The offline converter CLI (`tools/mapdb_convert.rb`) exits non-zero on any
unconvertible proc, so a submission that introduces an unrecognized idiom
fails review rather than silently shipping.

## Reviewing this

It is a large diff, but it concentrates:

- `lib/common/map/guarded_proc.rb` (218 lines) — **the core.** Wrap,
  convert, memoize, fail closed. Reviewing this file gets you the security
  argument.
- `lib/common/map/map_engine.rb` — the step vocabulary and interpreter.
- `lib/common/map/map_convert.rb` — the 137 recognizers.
- `lib/common/map/manual_conversions_*.json` — data, not code. Skim.
- `lib/common/map/map_base.rb` — the two wrap sites in `parse_map_json`.

## Status and sequencing

#1495 (sparse map indexing) has merged upstream, and this branch already
carries its content via an earlier integration merge. The branch is
currently ~16 commits behind `main` and needs a fresh merge from it before
review — worth doing before opening, since the map files overlap.

Still outstanding, both requiring a live session:

- In-game smoke test against a stock proc-bearing map.
- DR in-game pass.

I would not merge ahead of those two. Everything measurable from outside a
game session is done and green; what remains is confirming real routes
behave in a real client.

## Fallback, if tillmen ever goes away

The loader already handles schema edges natively, and a prepared mapdb
branch holds the fully converted map. If the upstream map source ever
disappears, the flip is: publish the converted map, and GuardedProc simply
stops being constructed because no `;e ` strings remain. Mixed proc/schema
files work edge-by-edge in the meantime. That path is not part of this PR.
