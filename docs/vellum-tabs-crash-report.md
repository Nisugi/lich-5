# VellumFE hangs on WebUI setup pages (browser + raw WS client both work)

## Summary
The four converted WebUI setup pages (`ecleanse`, `eherbs`, `ebounty`,
`bigshot`) render correctly in a **plain browser** and in a **raw
WebSocket test client**, but **hang VellumFE** ("Not Responding") when
opened as a docked panel. `webui-demo` (which also uses `ui.tabs`) works
in Vellum. This is a VellumFE rendering bug, not a Lich/WebUI bug - the
payload Lich sends is valid and renders everywhere else.

## Evidence Lich is producing correct output
- Captured the exact WebSocket `render` frames Vellum receives (attach as
  primary FE -> `;ui handshake` for port+token -> `GET /auth?token=` for a
  cookie -> WS `/ws` with cookie+Origin). Payloads are well-formed JSON,
  parse cleanly, no nil/NaN values, no out-of-range sliders, no duplicate
  cids, `select` values are always in their options list.
- A plain desktop browser at `http://<host>:8200/` renders all four pages
  fully and interactively.
- A raw Ruby WS client receives and decodes the frames without issue.
- Sample failing payloads are attached: `vellum-crash-payload-bigshot.json`
  (13 KB, 8 tabs, ~120 widgets) and `vellum-crash-payload-ecleanse.json`
  (2 KB, 3 tabs, the smallest crasher).

## What distinguishes the crashers from webui-demo
- All are `ui.tabs` pages, but so is `webui-demo` (works) - so `tabs`
  alone is not the trigger.
- The crashers have MANY same-type widgets per tab (e.g. ecleanse: 29
  checkboxes across 3 tabs) and tabs whose interactive widgets were all
  conditional and rendered down to headers/markdown only (Lich now backfills
  a placeholder `text` node - present in the captured trees).
- webui-demo has few widgets per tab and a mix of types.

## Reproduction
1. Headless Lich with WebUI (container: `LICH_WEBUI_BIND=0.0.0.0`,
   `LICH_WEBUI_PORT=8200`, published).
2. In game: `;ecleanse setup` (or eherbs/ebounty/bigshot) registers the page.
3. Browser to `http://<host>:8200/`, authorize, open the page -> renders fine.
4. VellumFE: `.webui`, open the same panel -> "Waiting for <page>/setup..."
   then the window goes "(Not Responding)".

## Suspected areas for the Vellum team
- Tab-panel layout/measurement with many children (a layout loop or
  unbounded reflow on N widgets?).
- The subscribe->first-render path: Vellum shows "Waiting for..." (no
  render applied) where a browser gets the same frame and paints it. Does
  Vellum block its UI thread waiting for/parsing the frame?
- Rendering a tab whose only child is a `text` placeholder node.

## Lich-side hardening already shipped (defensive, not the fix)
- `number_input` always emits a concrete `value` (nil dropped the field).
- `tabs` appends a placeholder `text` when a tab has no interactive
  descendant.
- Setup pages keep-alive with a sleep loop, never `Queue#pop` (a blocked
  main thread starved the render workers - fixed a real deadlock, but
  distinct from this Vellum hang).
