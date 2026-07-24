# WebUI: new component nodes for VellumFE to implement

VellumFE renders WebUI page trees natively. These node types were added
after Vellum's renderer was written, so Vellum currently shows
`[unsupported component: <type>]` for them. Each renders correctly in the
plain browser today (see the referenced app.js factory as a working model).
Implement these to reach full parity.

Summary of what's new:
- `grid`   - aligned matrix (uniform columns). Escort from x to grid.
- `textarea` - multi-line text field (GtkTextView equivalent).
- `image_map` marker `kind`s `wound1|wound2|wound3` - colored dots for the
  CreatureBar silhouette (image_map itself already exists; only the new
  marker kinds are additive - render them as small filled circles,
  yellow/orange/red, no border).

All three fire the standard event envelope
`{type:"event", cid:<node cid>, value:<...>}`; there are no new event shapes.

---

# WebUI `grid` node - renderer spec (for VellumFE)

A new component node type, `grid`, for aligned matrices (e.g. the ebounty
Escort from x to travel-preference grid) where every column must line up
across all rows. `columns` does NOT align across rows; `grid` does.

## Node shape

```json
{
  "t": "grid",
  "cid": "grid:escort_matrix",
  "cols": 7,
  "compact": false,
  "children": [
    { "t": "cell", "cid": "grid:escort_matrix.g0", "children": [ ...nodes... ] },
    { "t": "cell", "cid": "grid:escort_matrix.g1", "children": [ ...nodes... ] },
    ...
  ]
}
```

- `cols` (int): number of columns. Rows = `ceil(children.length / cols)`.
- `children`: an array of `cell` nodes, filled **row-major**
  (left-to-right, top-to-bottom). `children[i]` is at row `i / cols`,
  column `i % cols`.
- Each `cell` has its own `children` array of ordinary component nodes
  (text, checkbox, select, text_input, ...). A cell may be empty (renders
  as a spacer, keeping the matrix aligned).
- `compact` (bool, optional): tighter cell gaps.

## Required rendering behavior

- Lay out as a real grid with **uniform column widths** - all columns the
  same width, aligned across every row. The browser renderer uses
  `display: grid; grid-template-columns: repeat(cols, minmax(0, 1fr))`.
- Render each cell's `children` inside its grid cell.
- A checkbox cell's checkbox typically has an empty `label` (the row/column
  header text carries the meaning) - center the box in the cell.
- Events are unchanged: a checkbox inside a cell fires the normal
  `{type:"event", cid:<checkbox cid>, value:<bool>}` message; there is no
  grid-level event.

## Reference

- Browser renderer: `lib/webui/assets/app.js`, `factories.grid`
  (create/patch) - mirror its structure.
- CSS: `lib/webui/assets/app.css`, `.c-grid` / `.c-cell`.
- Sample payload: `webui-grid-node-sample.json` (a 3-col, 6-cell grid).
- DSL: `Lich::WebUI::Builder#grid(cols:, cells:, compact:, key:)` in
  `lib/webui/dsl.rb`.

---

# WebUI `textarea` node - renderer spec (for VellumFE)

Multi-line text field (GTK GtkTextView equivalent) for notes, regex lists,
eval expressions.

## Node shape
```json
{ "t": "textarea", "cid": "textarea:notes", "label": "Notes",
  "value": "line one\nline two", "placeholder": "...", "rows": 5 }
```
- `value` may contain newlines; preserve them.
- `rows`: visible height hint.

## Rendering
- Render as a multi-line text box (HTML `<textarea>`). Label above or beside.
- Fire the normal `{type:"event", cid, value:<full string>}` on commit
  (blur), NOT on every keystroke. Enter inserts a newline, does not commit.
- On a re-render while the field is focused, do NOT overwrite the user's
  in-progress text (see isEditing in app.js - it now includes TEXTAREA).

## Reference
Browser: `app.js` factories.textarea; CSS `.c-textarea`;
DSL `Builder#textarea(label, value:, placeholder:, rows:, key:)`.
