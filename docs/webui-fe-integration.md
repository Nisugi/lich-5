# Embedding Lich WebUI pages in your frontend

*A primer for FE developers (VellumFE and friends): how to host Lich
script UIs as chromeless docked panels, and what the CreatureBar pilot
needs from you. Current as of Lich 5.18 / `feat/webui`, WebUI schema 1.*

## The one-paragraph version

Every Lich session runs a small HTTP + WebSocket server on
`127.0.0.1:<ephemeral port>`. Scripts register **pages** (a live map, a
status bar, a settings panel) that render as ordinary web pages. Anything
that can display a web page can host them — so if your FE can embed a
webview (Electron `WebContentsView`, Tauri child webview, WebView2, a
QWebEngineView...), you can dock Lich script UIs as native-feeling panels.
You need exactly three things: the server's address, an auth cookie, and
a page URL.

## Step 1 — handshake: find the server, get the keys

Send this through Lich as if the player typed it:

```
;ui handshake
```

Lich swallows it and replies with **exactly one line** on the game stream:

```xml
<LichWebUI status="ok" port="51423" url="http://127.0.0.1:51423/" auth="http://127.0.0.1:51423/auth?token=<64 hex chars>" schema="1"/>
```

Other replies: `<LichWebUI status="disabled"/>` (tell the player to run
`;ui on`) and `<LichWebUI status="stopped"/>` (service failed to start;
rare). Parse it with a regex; the attribute set is stable.

**Do the handshake at every session start.** The port is ephemeral and
the token is regenerated per Lich process. (A player can pin the port
with `;ui port <n>`, but never rely on that.) Each Lich session — each
character — has its own server, port, and token; talk to the one your
connection rides through.

## Step 2 — authorize the webview

Load the `auth` URL once in your webview (or its session/partition). It
sets an `HttpOnly; SameSite=Strict` cookie for that origin and 302s to
the landing page. Every subsequent request from that webview session is
authorized. The cookie is per-origin, and the origin includes the port —
after a Lich restart the port changes, so just load the fresh `auth` URL
again (handshake → auth is a cheap, idempotent pair).

## Step 3 — navigate panels to pages

```
http://127.0.0.1:<port>/?embedded=1#/<script>/<page>
```

for example `.../?embedded=1#/creaturebar/main`.

`?embedded=1` tells the page its lifecycle belongs to **you**:

- compact "bare" styling always applies (no top bar, no nav, tight
  padding — panel density);
- the page never reports window geometry and never tries to close or
  resize its window;
- when the page ends (script killed), the panel shows a "This page has
  ended" notice instead of self-closing — keep the panel, close it, or
  offer a restart; your call.

Reloads and reconnects are free: the page's WebSocket auto-reconnects
with backoff, and if the owning script restarts and re-registers the
page, the same URL picks it right back up. There is nothing to babysit.

## Step 4 (optional) — build an "Add panel" menu

Open a WebSocket to `ws://127.0.0.1:<port>/ws` from an authorized
context (same cookie). The first message is a `hello` envelope:

```json
{ "type": "hello", "schema_version": 1,
  "session": { "name": "Nisugi", "game": "GSIV" },
  "pages": [
    { "id": "creaturebar/main", "title": "Creature Bar",
      "kind": "panel", "bare": true, "size": [320, 90] },
    { "id": "map/map", "title": "Map: Nisugi", "kind": "window", "bare": true }
  ],
  "siblings": [ { "name": "Alt", "game": "GSIV", "port": 51999 } ] }
```

`pages` broadcasts arrive whenever scripts register/unregister, so the
menu stays live. The embedding hints are yours to use:

- `kind: "panel"` — the author expects docking (status bars, feeds);
  `kind: "window"` — the author expects floating (the map). Absent =
  no opinion.
- `size` — preferred content size in CSS pixels; a good default dock size.
- `siblings` — other running Lich sessions' landing pages (name/port
  only, no tokens — each session authorizes separately).

If you skip this step, a text field where the player pastes a page id
works fine too.

## Security model (please read)

The tokenized URL is **script-level power**: WebUI callbacks run
arbitrary Ruby inside the player's Lich. Handing it to you is
trust-clean — the FE already carries the account password and every game
line — but treat it accordingly: keep it out of logs, crash reports, and
telemetry; never send it off-box. The server binds loopback only,
validates `Host` and `Origin` (allow `127.0.0.1:<port>`; WS upgrades
from a `file://` or app origin send no/other Origin — use the cookie
path above rather than spoofing), and everything is served same-origin
with no external resources.

## The CreatureBar pilot

The Lich side will ship a `creaturebar` script registering
`creaturebar/main` — `bare`, `kind: "panel"`, size hint around
`[320, 90]`, pushing updates on game events (no polling needed on your
end; renders arrive over the page's own WebSocket). Your side is
literally: dockable webview + the three steps above, defaulting the
panel to the descriptor's `size`. That's the whole integration.

To develop against something today, before creaturebar exists:
`;ui on`, `;webui-demo`, then embed
`.../?embedded=1#/webui-demo/demo` — it exercises every widget type,
live updates, and the ended-page notice (kill the script to see it).

You can also prototype with zero FE code: do the handshake by hand, open
the auth link in Chrome, then open the `?embedded=1` URL in a small
`--app=` window. What you see is exactly what your panel will render.

## Level 2 (later, optional): native rendering

If you ever want panels that match your theme perfectly, skip HTML: keep
the same WebSocket, send `{"type":"subscribe","page":"creaturebar/main"}`,
and render the `render` envelopes yourself. Trees are JSON component
nodes (`header`, `text`, `markdown`, `button`, `text_input`,
`password_input`, `number_input`, `select`, `radio`, `checkbox`,
`slider`, `progress`, `table`, `log`, `image`, `image_map`, and
containers `columns`/`tabs`/`expander` with `children`). Interactions go
back as `{"type":"event","page":...,"cid":...,"event":"click|change|row",
"value":...}` using each node's `cid`. The envelope shape is versioned
(`schema_version`); we will not break it silently. Ask us before starting
this tier and we'll freeze the details with you.

## Quick reference

| What | Value |
|---|---|
| Handshake | send `;ui handshake`, parse the single `<LichWebUI .../>` line |
| Authorize | load the `auth` URL once per webview session |
| Panel URL | `<url>?embedded=1#/<script>/<page>` |
| Page list | WS `hello`/`pages` envelopes (`kind`, `bare`, `size` hints) |
| Page ended | in-panel notice; panel lifecycle is yours |
| Lich restart | new port + token: re-handshake, re-auth |
| Player prereq | `;ui on` once (persists) |
