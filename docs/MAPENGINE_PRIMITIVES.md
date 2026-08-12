# MapEngine primitives — reference

The complete vocabulary MapEngine can execute. Anything not listed here is
not expressible, on purpose: an edge that uses unknown vocabulary is
**refused** (not routable), never eval'd.

Two audiences:

- **Reviewing an overlay entry or a submission** — this tells you what each
  step actually does at runtime.
- **Deciding whether a proc can be converted** — if the behavior maps onto
  these steps, a recognizer can handle it; if not, it needs new vocabulary
  or it stays refused.

Vocabulary is enforced by `MapEngine::Validator` at conversion time, so an
unknown step name is caught before anything runs.

---

## Shape of an edge

A `wayto` edge is a **step list**, or a **strategy**, or a plain string:

```json
[ {"do": "send", "cmd": "open gate"}, {"do": "move", "cmd": "go gate"} ]
```

```json
{ "strategy": "table_join", "table": "Absinthe" }
```

An empty array `[]` is a valid no-op crossing (a virtual edge).

A step list may carry named sub-lists via `define`, referenced by
`steps_ref` — this is how a body that repeats itself avoids duplication:

```json
{
  "define": { "unlock": [ {"do": "send", "cmd": "turn lock"} ] },
  "steps":  [ {"do": "steps_ref", "name": "unlock"}, {"do": "move", "cmd": "go door"} ]
}
```

A `timeto` edge is a **cost object**, not steps:

```json
{ "cost": 0.2, "requires": ["citizenship:Wehnimer's Landing"] }
{ "same_as": "1234:5678" }
{ "event": "instability", "key": 4521 }
```

`requires` gates the cost: if any requirement fails, the cost is `nil` and
the edge is not routable. `else` supplies a fallback cost instead of `nil`.

---

## Movement and commands

| step | params | what it does |
|---|---|---|
| `move` | `cmd` | Movement that expects a room change. Uses Lich's `move`, which verifies arrival. **Use this for the traversal step.** |
| `send` | `cmd` | Raw command, no arrival expectation (`fput`). Use for setup: opening doors, pushing levers. |
| `echo` | `msg` | Message to the user. No game effect. |
| `move_random` | `dirs` | Pick one of the given directions at random. Mazes only. |
| `move_with_group` | `cmd` | Move, keeping followers together. |
| `cross` | `room`, `dest` | Delegate to another edge's crossing. |
| `travel_to` | `room` | Invoke the router for a full route. Expensive; used by ticket-buying edges. |

**`move` vs `send` is the single most common review question.** `move` waits
for and verifies the room change; `send` does not. An edge whose final step
is `send` will report success without having gone anywhere.

## Waiting

| step | params | what it does |
|---|---|---|
| `await` | `for`, `cmd`, `timeout`, `on_timeout`, `if_match`, `bind` | The workhorse. With `cmd`, sends and waits for a matching line (`dothistimeout`). Without `cmd`, waits passively (`matchtimeout`). |
| `wait_rt` | — | Wait out roundtime (`waitrt?`). |
| `sleep` | `seconds` | Fixed pause. Prefer a real condition where one exists. |
| `wait_room_change` | — | Block until the room changes. For being carried/transported. |
| `wait_until` | `when`, `timeout` | Block until a condition holds. |

`await` details worth knowing when reviewing:

- `for` is a pattern. Literal text from a `waitfor` is escaped on
  conversion, so punctuation is not read as regex.
- `on_timeout` is `continue` (default), `fail`, or `retry`. Converted
  `waitfor` bodies get `timeout: 1800` and `on_timeout: "fail"`, because
  `waitfor` itself has no timeout — failing loudly beats hanging or
  silently proceeding.
- `if_match` runs sub-steps when the matched line also matches a sub-pattern.
  This is how door-branch idioms express "if it was locked, pick it."
- `bind` captures values from the match for later steps.

## Control flow

| step | params | what it does |
|---|---|---|
| `if` | `when`, `then`, `else` | Conditional. |
| `repeat` | `steps`, `times`, `until` | Loop, bounded by `times` and/or a condition. |
| `for_each` | `items` / `items_from` / `items_var`, `steps` | Iterate a list, a capture, or a UserVar. |
| `break` | — | Exit the enclosing repeat. |
| `break_if_moved` | — | Exit if the room changed. |
| `steps_ref` | `name` | Run a named list from `define`. |
| `replan` | — | Tell go2 to recompute the route (`$go2_restart`). |

Every loop is bounded. A `repeat` without `times` still hits an internal
iteration ceiling, so a malformed edge cannot hang a session forever.

## Hands, posture, stance

| step | params | notes |
|---|---|---|
| `empty_hands` / `fill_hands` | — | Stow held items / restore them. |
| `empty_hand` / `fill_hand` | — | Singular variants (one hand). |
| `preserve_stance` | `stance`, `steps` | Set a stance, run steps, restore the prior stance. |

The canonical climb is `empty_hands` → `move` → `wait_rt` → `fill_hands`.
Several map procs omit the `wait_rt`, so hands refill during roundtime —
worth flagging when you see it.

## Items and spells

| step | params | what it does |
|---|---|---|
| `find_item` | `name`, `bind` | Locate an item in inventory/containers. |
| `use_item` / `borrow_item` / `return_item` | `name`, `from` | Item handling, including putting a key back in the container it came from. |
| `cast` | `spell`, `target` | Cast a spell. |
| `cast_buff` | `spell` | Cast only if known, affordable, and not already active. |

## Groups and escorts

| step | params | what it does |
|---|---|---|
| `note_group` | — | Record who is following you. |
| `group_wait` | — | Block until recorded followers rejoin. |
| `escort_wait` | — | Wait for a bounty-escort NPC to catch up. |

## Captures and state

| step | params | what it does |
|---|---|---|
| `set` | `var`, `value` | Set a UserVar. |
| `set_global` | `var`, `value` | Set a global (`$SILVERWOOD_TOWN` and friends). |
| `set_capture` | `name`, `value` | Set a capture slot. |
| `map_capture` | `from`, `to`, `table`, `default` | Translate a captured value through a lookup table. |
| `scan_lines` | `patterns`, `into`, `stop` | Read the stream and classify lines. Used by the mural/verse puzzles. |
| `search_rooms` | — | Scan a room set for an object. |
| `suspend_scripts` | `scripts`, `steps` | Kill named scripts, run steps, restart only what was running. |

---

## Conditions

Used by `if.when`, `repeat.until`, `wait_until.when`, and `timeto.requires`.
Any condition may be negated with the `not:` prefix
(`"not:in_room:1234"`).

**Character:** `prof:`, `race:`, `gender:`, `level:`, `guild:`, `circle:`,
`society:`, `citizenship:`, `skill:`, `stamina:`, `spell:`, `spell_known:`,
`spells_known:`, `climb_bonus:`, `climb_vs_encumbrance:`

**Status:** `status:standing`, `status:sitting`, `status:kneeling`,
`status:prone`, `status:stunned`, `status:hidden`, `status:invisible`,
`holding:`, `left:`, `right:`, `empty_hands`

**Room and world:** `in_room:`, `room_name:`, `room_object:`,
`room_object_match:`, `loot_noun:`, `loot_match:`, `npc_match:`, `path:`,
`paths_are:`, `paths_at_most:`, `climate:`, `month:`, `location:`

**Account and setting:** `premium:`, `platinum:`, `subscription:`, `game:`,
`setting:`, `var:`, `var_raw:`, `global:`, `dr_setting:`, `grant:`

**Scripts:** `script_running:`, `script_exists:`, `no_script:`,
`run_script:`

**Captures:** `capture:`, `capture_match:`

**Items:** `has_item:`

---

## Strategies

When data varies but the algorithm is fixed, the algorithm lives in Lich as
a strategy and the edge supplies parameters. Registered strategies and
their required params:

| strategy | required params | what it does |
|---|---|---|
| `guided_route` | `target`, `dirs` | Per-room direction table walk (swim gauntlets, spider thread). |
| `patrol_search` | `rooms`, `dirs`, `objects` | Walk a cyclic route until a target object appears. |
| `shifting_maze` | `target`, `rooms` | Random-walk a maze while learning exit mappings. |
| `uservar_sends` | `var` | Replay a user-configured command list (Rogue guild knock). |
| `table_join` | `table` | Join a named tavern table, re-issuing on invitation. |
| `confluence_explorer` | `target` | Confluence hot/cold maze pathfinder. |
| `voln_seeking` | `target` | Symbol of Seeking destination cycler. |
| `ice_slope` | `cmd` | Icy climb with slip handling and Haste recovery. |
| `chronomage_day_pass` | `towns`, `npc`, `ask`, `enter`, `exit` | Find or buy a day pass, then travel. |
| `rogue_guild_door` | — | Rogue guild door sequence. |
| `mana_crown` | `amount` | Charge a crown to a mana threshold. |

**When to add a strategy vs. a recognizer:** if the *data* varies and the
*algorithm* is fixed, it is a strategy. If the algorithm itself is unique to
one edge, it is a recognizer emitting inline steps — or, honestly, a
candidate for normalizing the proc instead.

---

## Refusal semantics

Everything above resolves to "edge not routable" rather than an exception:

- Unknown step name, unknown strategy, missing required param → validation
  fails at conversion → the edge refuses.
- Missing game state at runtime → the condition is false → the gate closes.
- A step raising mid-crossing → the crossing fails → go2 treats it as a
  failed edge and re-routes.

For `timeto`, refusal is `nil` (dijkstra already skips nil costs). For
`wayto`, refusal is `false` (go2 treats the crossing as failed). Neither
crashes a route, and neither executes anything.

---

## See also

- `docs/MAPDB_EDGE_CLASSIFICATION.md` — what the corpus actually uses, and
  where the vocabulary is being worked around rather than used.
- `docs/overlay-review/` — the manual overlay, entry by entry, for review.
- `lib/common/map/map_engine.rb` — the interpreter; the dispatch table near
  `run_step` is the authoritative step list.
- `lib/common/map/map_strategies.rb` — strategy implementations and their
  `register` calls (the authoritative required-params list).
