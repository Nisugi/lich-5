# GTK-Free Audit (M7)

**Goal:** make the `gtk3` gem *optional*, not remove it. When gtk3 is
installed, everything GTK keeps working exactly as today (GTK login,
legacy scripts' windows, `Gtk.queue`). When it is absent, Lich must still
deliver every first-class capability: login, play, script UIs (WebUI),
account management.

**Headline finding:** an empirical load test (appendix) shows **every
GTK-adjacent file in `lib/` loads cleanly with no gtk3 installed** — all
26 of them, including the entire `lib/common/gui/*` login stack. Every
`Gtk::` reference in core is inside a method body, resolved at call time.
There is **no require-graph surgery needed**; the whole GTK-drop reduces
to a handful of behavioral call sites.

## What happens today without gtk3

| Launch | Behavior |
|---|---|
| Bare double-click (rubyw, no args) | `init.rb:520` catches the LoadError, shows a Win32 "install gtk3?" MessageBox, and **exits**. The WebUI login never gets a chance. **This is the one real blocker.** |
| Terminal / any CLI args (`--login X`) | `HAVE_GTK = false`, boot continues, CLI login works, sessions run fully (WebUI included) |
| Main loop | already handled: `lich.rbw` runs `Gtk.main` when present, `@main_thread.join` otherwise |

## Inventory by category

### A. Boot & lifecycle — one blocker, rest done
| Site | Status |
|---|---|
| `lib/init.rb:520-583` install-or-exit gate | **BLOCKER** — must proceed GTK-less instead of exiting (see work item 1) |
| `lich.rbw:139-145` main loop | done (both paths) |
| `lib/main/main.rb` login branches + `Gtk.queue` shutdown calls | done (`defined?(Gtk)` guards) |
| `lib/common/gtk.rb` (Gtk.queue, retention fixes, quit guards) | done (entire enhancement body is `if defined?(Gtk)`; loads clean without it) |
| `lib/main/argv_options.rb` dark-theme apply | done (guarded) |

### B. GTK login stack — replaced, stays for choice
`lib/common/gui_login.rb` + 16 files under `lib/common/gui/*_ui.rb`,
`*_tab.rb`, `conversion_ui`, `accessibility`, `theme_utils`,
`components`, etc. Only required lazily from main.rb's GTK branch —
**never loaded when GTK is absent**. Full replacement shipped: the WebUI
login (M4) covers saved/manual entry, Multi-Launch, favorites, account
management, encryption management, and legacy entry.dat conversion.
No work needed; keep for players who prefer it.

### C. Shared data layer — pure, verified
`entry_store`, `account_manager`, `favorites_manager`,
`master_password_manager`, `password_cipher`, `state` live under `gui/`
by history but are GTK-free (keychain + crypto + YAML), verified loading
without gtk3. The one GTK touchpoint — the master-password *recovery
prompt* — is behind the injectable `EntryStore.master_password_prompt`
seam: GTK dialog when GTK is loaded, clean error surface when not.

### D. Runtime call sites — degraded gracefully
| Site | Behavior GTK-less |
|---|---|
| `Lich.msgbox` (`lib/lich.rb:293`) | Win32 branch first on Windows (never needs GTK); GTK is the non-Windows fallback; tty puts after that. Headless non-Windows: silent nil (work item 4) |
| `xmlparser`/`stash` dialogData refs | parse-only, no GTK |
| `authentication/gui.rb` play-button helper | only called from the GTK login |

### E. Ecosystem — scripts that use GTK directly
Community scripts calling `Gtk.*` get a call-time NameError when gtk3 is
absent; Lich's script error handling kills the script with a visible
error. That is acceptable degradation — the convention is
`if defined?(Gtk)`, the migration target is the WebUI (all 8 core GTK
scripts already converted), and `;ui bridge` covers glanceables in
Wrayth. `Gtk.queue` remains available whenever gtk3 is installed.

## Work items (in order)

1. **init.rb boot gate rework** (small, the blocker): on gtk3 LoadError,
   do not exit. Proceed with `HAVE_GTK = false`; a bare launch then flows
   to the WebUI login when `:webui_login` is on. Keep offering the gem
   install as an *option* (it still helps legacy-script users), but
   "No" must mean "continue without GTK", not "quit".
2. **main.rb bare-launch fallback** (small): GTK-less + `:webui_login`
   off + no args currently reaches no login path. Decide: implicitly use
   the WebUI login when GTK is unavailable (recommended - it force-starts
   its own server already), with a log line saying why.
3. **Mid-session master-password browser prompt** (medium): register a
   WebUI prompt on the `EntryStore.master_password_prompt` seam so
   enhanced-mode keychain recovery works in-session without GTK. Today it
   errors cleanly; only affects enhanced-mode users whose keychain
   disappears mid-session.
4. **`Lich.msgbox` headless path** (small, nice-to-have): non-Windows,
   no GTK, no tty currently returns nil silently; route to `UI.notify` /
   `Lich.log` so the message is not lost.
5. **Gemfile packaging** (small): move `gem "gtk3"` to an optional group
   so `bundle install` does not force the native build; document
   `bundle install --without gtk` (or the group name) for GTK-less
   installs.
6. **Verification** (small): promote the load-test from this audit's
   appendix into a spec (`spec/gtk_free_spec.rb`) so a GTK dependency
   creeping into the load path fails CI; add a boot smoke on a gtk3-less
   Ruby when one is available (the new Ruby installer work is the natural
   test bed).

Items 1-2 are the only true blockers, both small; they need a gtk3-less
Ruby install to verify end-to-end. Everything else is polish.

## Explicitly not changing

- `lib/common/gtk.rb` and the GTK login remain; players with gtk3 keep
  the identical experience, and `;ui login off` keeps working.
- `Gtk.queue` and the GTK API surface for legacy community scripts stay
  whenever the gem is present.
- No file moves: the pure data-layer files stay under `lib/common/gui/`
  for now (renaming is churn with no functional payoff; revisit at the
  upstream-PR stage if reviewers care).

## Appendix: verification method

Run with a Ruby that has no gtk3 gem (all files must print OK):

```ruby
LIB_DIR = File.expand_path('lib')
module Lich
  def self.log(_m); end
  def self.msgbox(**_k); end
  module Util; def self.install_gem_requirements(_s); end; end
  module Common; LICH_DIR = File.expand_path('.'); end
end
def respond(*); end
def echo(*); end

%w[
  common/gui/state common/gui/password_cipher common/gui/master_password_manager
  common/gui/master_password_prompt_ui common/gui/master_password_prompt
  common/gui/master_password_change common/gui/password_change
  common/gui/encryption_mode_change common/gui/account_manager
  common/gui/favorites_manager common/gui/utilities common/gui/components
  common/gui/theme_utils common/gui/accessibility common/gui/login_tab_utils
  common/gui/conversion_ui common/gui/account_manager_ui common/gui/saved_login_tab
  common/gui/manual_login_tab common/gui/game_selection common/gui/window_settings
  common/gui/parameter_objects common/authentication/entry_store
  common/authentication/gui common/gui_login common/gtk
].each do |rel|
  require File.join(LIB_DIR, "#{rel}.rb")
  puts "#{rel} OK"
rescue Exception => e
  puts "#{rel} FAILS #{e.class}: #{e.message.lines.first}"
end
```

Last verified: 2026-07-07, Ruby 4.0.3 x64-mingw-ucrt, zero failures.
