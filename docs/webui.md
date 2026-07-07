# WebUI — browser-based script UIs

The WebUI lets scripts build user interfaces that render in the player's web
browser instead of GTK. Lich hosts a local-only HTTP/WebSocket server; scripts
declare pages as Ruby component trees and Lich does all the HTML/JS. It works
identically under every frontend (Wrayth, Profanity, etc.) and adds **no gem
dependencies** — GTK remains available for legacy scripts, but new UI work
should target the WebUI.

## Player usage

```
;ui on     enable the feature (persists; default off)
;ui        start the service if needed, open the browser
;ui url    print the authorization link instead of opening a browser
;ui off    disable and stop
```

Try it: `;ui on`, `;webui-demo`, then `;ui`.

## Login launcher

`;ui login on` replaces the GTK login window: double-clicking lich.rbw opens
a small browser window instead (`;ui login off` to revert). Command-line
overrides: `--webui-login` forces the browser login, `--gtk-login` forces the
GTK window (the escape hatch if the browser flow breaks — the URL is also
always printed to the log in case no browser opens).

- **Saved Entry** — your saved characters grouped by account (or one tab per
  account with *Tab Layout*). Per row: `Fav`/`Unfav` toggles the favorite
  star, `Play` launches, `X` deletes the entry. The *GUI Settings* section
  holds the same persisted toggles as the GTK launcher — Dark Theme (GTK and
  child sessions; the browser page follows the browser theme), Tab Layout,
  AutoSort, Multi-Launch — so the two launchers stay in sync.
- **Manual Entry** — enter account credentials and either `Connect` to pick
  from the account's character list or fill in the character directly. Tick
  *Save this entry* to add it to Saved Entry for next time.
- **Multi-Launch** — mirrors the GTK launcher's switch (same persisted
  setting). Off: Play turns this launcher into the session and the window
  closes. On: each saved-entry Play spawns a separate detached Lich session
  and the launcher stays open so you can play several characters. Manual
  logins always single-launch.
- **Master password** — if your saved passwords use enhanced encryption and
  the master password is missing from the system keychain, the saved list is
  gated behind a master-password prompt; unlocking restores it to the
  keychain (like the GTK recovery dialog).

Notes: account passwords transit loopback HTTP once, token-gated, into the
same Lich process that handles them today — equivalent exposure to typing
them into the GTK window. First-run migration from the legacy `entry.dat`
format is GTK-only; convert by running the GTK login once.

## Script API

Everything lives on the top-level `UI` module and is a safe no-op while the
feature is disabled — scripts can call it unconditionally.

```ruby
UI.page("hunt", title: "Hunt Panel") do |ui|
  ui.header "Hunt Control"
  ui.text "Kills: #{ui.state[:kills] || 0}"

  if ui.state[:hunting]
    ui.button("Stop", variant: :danger) { ui.state[:hunting] = false; put "stop hunt" }
  else
    ui.button("Start") { ui.state[:hunting] = true; put "hunt" }
  end

  ui.table(ui.state[:log] || [], headings: ["Time", "Creature"])
end

Watchfor.new(/dies with a groan/) do
  UI.state("hunt")[:kills] = (UI.state("hunt")[:kills] || 0) + 1
  UI.refresh("hunt")
end

loop { sleep 60 }  # pages live exactly as long as their script
```

| Method | Purpose |
|---|---|
| `UI.page(name, title:, every:, &block)` | register/replace a page; `every: N` re-renders every N seconds while viewed |
| `UI.refresh(name)` | push an update to viewing browsers |
| `UI.state(name)` | the page's thread-safe state hash (also `ui.state` in the block) |
| `UI.remove(name)` | unregister a page |
| `UI.url` | the landing-page URL, nil when not running |
| `UI.available?` | whether the feature is enabled |

Pages are namespaced per script (`;hunt`'s "main" page is `hunt/main`) and are
**removed automatically when the script exits** — no cleanup code needed.

### Components

Emitters on the builder, in one line each:

```ruby
ui.header "Section title"
ui.text "plain text"
ui.markdown "**bold**, *italic*, `code`, [links](https://gswiki.play.net)"
ui.divider
ui.button("Label", variant: :danger, disabled: false) { ... }
ui.text_input("Label", value: current, placeholder: "hint") { |text| ... }
ui.select("Label", options: %w[a b c], value: current) { |choice| ... }
ui.checkbox("Label", checked: bool) { |checked| ... }
ui.slider("Label", min: 0, max: 100, step: 5, value: current) { |number| ... }
ui.progress(0.42, label: "XP")
ui.table(rows, headings: %w[Time Creature Loot])
ui.image("https://.../map.png", alt: "the map")   # http(s) or data: URIs only
```

Containers nest via builders (`compact: true` sizes columns to content —
right for row-action button groups):

```ruby
ui.expander("Settings", open: false) { |section| section.checkbox("Loot") { |v| ... } }
ui.columns(2) { |left, right| left.button("Go") { ... }; right.text "status" }
ui.tabs(%w[Loot Stats]) { |loot, stats| loot.table(...); stats.text(...) }
```

Tables become interactive with `sortable:` (client-side column sort), a
row-click block (receives the clicked row's index into your original rows,
regardless of sort order), and `selected:` for highlighting:

```ruby
ui.table(rows, headings: %w[Script Author], sortable: true,
         selected: ui.state[:pick]) { |i| ui.state[:pick] = i }
```

### Local images and live maps

`UI.serve(alias, directory)` exposes a directory of images (png/jpg/gif/webp
only, traversal-proof) at `/files/<alias>/...`, owned by your script and
removed when it exits. `ui.image_map` renders an image with overlay markers
and reports clicks in unscaled image coordinates - hit-testing against your
own data stays in your script:

```ruby
UI.serve('maps', MAP_DIR)
ui.image_map("/files/maps/#{room.image}", scale: 1.5, scroll_to: 'current',
             markers: [{ id: 'current', x1: 10, y1: 20, x2: 30, y2: 40, kind: 'current' }]) do |click|
  # click => { x:, y:, shift:, ctrl:, marker: }
  target = my_room_at(click[:x], click[:y])
  Script.start('go2', target.id.to_s) if target && !click[:shift]
end
```

`scroll_to:` re-centers the scrollable container on the named marker whenever
it moves - that is "keep centered" for a live map. Marker kinds: `current`
(highlighted), `marker`, `pin`.

### The rendering model (what you must know)

The page block **re-runs from scratch on every update** (immediate mode, like
Streamlit). Three things trigger it: a control's callback returning,
`UI.refresh`, and the optional `every:` timer.

Consequences:

- **Keep the block cheap and side-effect free.** Read `ui.state` and game
  data; emit components. Never `put`, `echo`, `waitrt`, or sleep inside the
  block — do that in callbacks.
- **Callbacks run inside your script** — on a thread in your script's thread
  group, exactly like a `watchfor` action. `Script.current`, `Settings[]`,
  `GameObj`, `put`, and `echo` all work, and a paused script pauses its
  callbacks.
- Components get positional ids; a component that appears *conditionally*
  should pass `key:` so its identity is stable across renders:
  `ui.button("Retry", key: :retry) { ... }` .
- State you want across sessions still goes through `Settings[]` — save in
  callbacks or `before_dying`, load at registration.

## Security model

- The server binds `127.0.0.1` only and every request must carry a session
  token, delivered to the browser once via the `;ui` link and stored as an
  `HttpOnly` cookie. `Host` and `Origin` headers are validated (DNS-rebinding
  defense) and token comparison is constant-time.
- **A browser tab with the token has script-level power** — callbacks run
  arbitrary Ruby in your session. That is the design: the tab is the player.
  Don't paste your `;ui url` link anywhere.
- Component text renders via `textContent` (never HTML), so game/script
  strings cannot inject markup; markdown supports only a safe inline subset.

## Architecture (for lich-5 developers)

```
lib/webui/websocket.rb   pure RFC 6455 framing/handshake
lib/webui/protocol.rb    JSON envelopes (schema_version), token compare
lib/webui/server.rb      GET-only HTTP router + WS upgrade + connections
lib/webui/webui.rb       lifecycle: token, lazy start, discovery, browser open
lib/webui/registry.rb    page registry, ScriptDeath cleanup
lib/webui/page.rb        render loop, callback dispatch, state, polling
lib/webui/dsl.rb         the component builder
lib/webui/login.rb       pre-login browser launcher (core page, no script)
lib/webui/assets/        vanilla-JS client (factories + keyed DOM morph)
lib/api/webui.rb         the public UI facade
```

Renders send the full component tree; the client morphs the DOM keyed on
component id, preserving focus and in-progress typing. Multiple Lich sessions
each run their own server on an ephemeral port and cross-link via token-free
discovery files in `<tmpdir>/simutronics/webui/`.

Two hard-won implementation notes:

- Never block a server thread in a raw `socket.read` — on Windows, no other
  thread can interrupt it (not even `IO#close`), which deadlocks shutdown.
  Readers poll with `IO.select` and own their socket's close.
- Dispatch into a script's context needs a deadline on thread-group
  membership (`Page::DISPATCH_TIMEOUT`); upstream `watchfor`'s unbounded
  `sleep until Script.current` is a bug, not a pattern to copy.
