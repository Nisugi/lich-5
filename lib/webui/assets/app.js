/* Lich WebUI client.
 *
 * All dynamic content is built with document.createElement/textContent —
 * never innerHTML — so strings from scripts cannot inject markup. Keep it
 * that way when adding component factories.
 *
 * Rendering is full-tree replace with a keyed morph: the server sends the
 * whole component tree on every render; we reconcile against the DOM by
 * data-cid so focus, scroll, and in-progress typing survive updates.
 */
'use strict';

(function () {
  var ws = null;
  var wsReady = false;
  var reconnectDelay = 500; // ms, doubles up to 8s
  var RECONNECT_MAX = 8000;
  var currentPage = null;   // full "script/page" id from the hash route
  var knownPages = [];

  // Embedded mode: this page lives inside a frontend's docked panel
  // (?embedded=1 on the URL) or an iframe. The panel's lifecycle belongs
  // to the FE - no geometry reporting/enforcement, no self-closing, and
  // bare-page density always applies.
  var embeddedMode = /[?&]embedded=1/.test(location.search) ||
    (function () { try { return window.self !== window.top; } catch (e) { return true; } })();
  if (embeddedMode) document.body.classList.add('embedded');

  var el = {
    sessionLabel: document.getElementById('session-label'),
    sessionTitle: document.getElementById('session-title'),
    connStatus: document.getElementById('conn-status'),
    landing: document.getElementById('landing'),
    pageView: document.getElementById('page-view'),
    pageList: document.getElementById('page-list'),
    noPages: document.getElementById('no-pages'),
    siblingsBlock: document.getElementById('siblings-block'),
    siblingList: document.getElementById('sibling-list'),
    notices: document.getElementById('notices'),
    themeToggle: document.getElementById('theme-toggle')
  };

  /* ---------- connection ---------- */

  function setStatus(state, text) {
    el.connStatus.className = 'status ' + state;
    el.connStatus.textContent = text;
  }

  function send(message) {
    if (wsReady) ws.send(JSON.stringify(message));
  }

  function connect() {
    setStatus('connecting', 'connecting…');
    ws = new WebSocket('ws://' + location.host + '/ws');

    ws.onopen = function () {
      wsReady = true;
      reconnectDelay = 500;
      setStatus('connected', 'connected');
      if (currentPage) send({ type: 'subscribe', page: currentPage });
    };

    ws.onmessage = function (event) {
      var msg;
      try { msg = JSON.parse(event.data); } catch (e) { return; }
      if (msg.type === 'hello') handleHello(msg);
      else if (msg.type === 'pages') { knownPages = msg.pages || []; renderPages(); }
      else if (msg.type === 'notice') showNotice(msg.level || 'info', msg.text || '');
      else if (msg.type === 'notify') showNotify(msg.title || 'Lich', msg.text || '');
      else if (msg.type === 'render' && msg.page === currentPage) renderTree(msg.tree);
      else if (msg.type === 'close' && msg.page === currentPage) closePage();
    };

    ws.onclose = function () {
      wsReady = false;
      setStatus('disconnected', 'disconnected — retrying');
      // bare pages are floating app windows: try to close ourselves (allowed
      // when the window has a single-entry history, as app windows usually
      // do), and fall back to an explicit overlay when the browser refuses.
      // Embedded panels never self-close; the overlay tells the story.
      if (barePage && !embeddedMode && !document.getElementById('bare-disconnected')) {
        try { window.close(); } catch (e) { /* ignore */ }
        setTimeout(function () {
          if (document.getElementById('bare-disconnected')) return;
          var overlay = document.createElement('div');
          overlay.id = 'bare-disconnected';
          overlay.textContent = 'Lich session ended — you can close this window.';
          document.body.appendChild(overlay);
        }, 250);
      }
      setTimeout(connect, reconnectDelay);
      reconnectDelay = Math.min(reconnectDelay * 2, RECONNECT_MAX);
    };

    ws.onerror = function () { ws.close(); };
  }

  function handleHello(msg) {
    var name = (msg.session && msg.session.name) || '';
    var game = (msg.session && msg.session.game) || '';
    el.sessionLabel.textContent = name ? name + (game ? ' · ' + game : '') : 'Lich WebUI';
    el.sessionTitle.textContent = name || 'Lich WebUI';
    document.title = (name ? name + ' — ' : '') + 'Lich WebUI';
    knownPages = msg.pages || [];
    renderPages();
    renderSiblings(msg.siblings || []);
  }

  /* ---------- landing page ---------- */

  function renderPages() {
    el.pageList.textContent = '';
    el.noPages.hidden = knownPages.length > 0;
    knownPages.forEach(function (page) {
      var li = document.createElement('li');
      var a = document.createElement('a');
      a.href = '#/' + page.id;
      a.textContent = page.title || page.id;
      var small = document.createElement('small');
      small.textContent = page.script ? ';' + page.script : '';
      li.appendChild(a);
      li.appendChild(small);
      el.pageList.appendChild(li);
    });
  }

  function renderSiblings(siblings) {
    el.siblingsBlock.hidden = siblings.length === 0;
    el.siblingList.textContent = '';
    siblings.forEach(function (sib) {
      var li = document.createElement('li');
      var a = document.createElement('a');
      a.href = 'http://127.0.0.1:' + sib.port + '/';
      a.textContent = (sib.name || 'Lich on port ' + sib.port) + (sib.game ? ' · ' + sib.game : '');
      a.target = '_blank';
      a.rel = 'noopener';
      li.appendChild(a);
      el.siblingList.appendChild(li);
    });
  }

  // Geometry reporting/enforcement and self-closing only make sense for
  // standalone windows - a maximized tab must never overwrite a floating
  // window's remembered geometry. Three window types, three signals:
  // --app windows match display-mode standalone (toolbar.visible is
  // unreliable for them - Chromium only hides BarProps for script-opened
  // windows), popups have an opener and/or hidden toolbar, tabs have none
  // of these.
  function standaloneWindow() {
    try {
      if (window.matchMedia && window.matchMedia('(display-mode: standalone)').matches) return true;
      if (window.opener) return true;
      return !window.toolbar.visible;
    } catch (e) { return false; }
  }

  // The server says the current page is finished (login window after Play,
  // page removed, owning script killed). Standalone windows close
  // themselves; when the browser refuses (multi-entry history), fall back
  // to the landing page. Regular tabs just go back to the landing page.
  function closePage() {
    if (embeddedMode) {
      // the FE owns this panel; just say the page ended
      showNotice('info', 'This page has ended.');
      return;
    }
    if (standaloneWindow() || barePage) {
      try { window.close(); } catch (e) { /* ignore */ }
      setTimeout(function () {
        if (window.closed) return;
        location.hash = '';
      }, 250);
    } else {
      location.hash = '';
    }
  }

  // UI.notify: OS notification when permitted, in-page toast otherwise.
  // Browsers only allow the permission prompt on a user gesture, so when
  // the first notify arrives unpermitted we ask on the next click.
  var wantNotifyPermission = false;
  function showNotify(title, text) {
    try {
      if (window.Notification && Notification.permission === 'granted') {
        new Notification(title, { body: text });
        return;
      }
      if (window.Notification && Notification.permission === 'default') wantNotifyPermission = true;
    } catch (e) { /* fall through to the toast */ }
    showNotice('info', (title ? title + ': ' : '') + text);
  }
  document.addEventListener('click', function () {
    if (!wantNotifyPermission) return;
    wantNotifyPermission = false;
    try { Notification.requestPermission(); } catch (e) { /* ignore */ }
  });

  function showNotice(level, text) {
    var div = document.createElement('div');
    div.className = 'notice ' + level;
    div.textContent = text;
    el.notices.appendChild(div);
    setTimeout(function () { div.remove(); }, 8000);
  }

  /* ---------- routing ---------- */

  function route() {
    var target = location.hash.replace(/^#\//, '');
    if (target === currentPage) return;
    if (currentPage) send({ type: 'unsubscribe', page: currentPage });
    currentPage = target || null;
    document.body.classList.remove('bare-page');
    el.landing.hidden = !!currentPage;
    el.pageView.hidden = !currentPage;
    el.pageView.textContent = '';
    if (currentPage) {
      appendPageHeader();
      send({ type: 'subscribe', page: currentPage });
    }
  }

  function appendPageHeader() {
    var nav = document.createElement('div');
    nav.className = 'page-nav';
    var back = document.createElement('a');
    back.href = '#';
    back.textContent = '‹ pages';
    nav.appendChild(back);
    el.pageView.appendChild(nav);
    var body = document.createElement('div');
    body.className = 'page-body';
    body.id = 'page-body';
    el.pageView.appendChild(body);
  }

  /* ---------- events to server ---------- */

  function emit(cid, eventName, value) {
    send({ type: 'event', page: currentPage, cid: cid, event: eventName, value: value });
  }

  /* ---------- markdown (safe inline subset) ---------- */

  // Supports **bold**, *italic*, `code`, [text](http(s)://url), and
  // {{color:text}} spans from a fixed palette, all built as DOM nodes.
  // Anything else stays literal text.
  var SPAN_COLORS = ['red', 'green', 'blue', 'yellow', 'orange', 'cyan', 'magenta', 'gray'];
  function markdownInto(parent, text) {
    var pattern = /(\*\*([^*]+)\*\*)|(\*([^*]+)\*)|(`([^`]+)`)|(\[([^\]]+)\]\((https?:\/\/[^\s)]+)\))|(\{\{([a-z]+):([^{}]+)\}\})/g;
    var last = 0;
    var match;
    while ((match = pattern.exec(text)) !== null) {
      if (match.index > last) parent.appendChild(document.createTextNode(text.slice(last, match.index)));
      if (match[2]) {
        var b = document.createElement('strong');
        b.textContent = match[2];
        parent.appendChild(b);
      } else if (match[4]) {
        var i = document.createElement('em');
        i.textContent = match[4];
        parent.appendChild(i);
      } else if (match[6]) {
        var c = document.createElement('code');
        c.textContent = match[6];
        parent.appendChild(c);
      } else if (match[8]) {
        var a = document.createElement('a');
        a.textContent = match[8];
        a.href = match[9];
        a.target = '_blank';
        a.rel = 'noopener';
        parent.appendChild(a);
      } else if (match[10]) {
        if (SPAN_COLORS.indexOf(match[11]) !== -1) {
          var s = document.createElement('span');
          s.className = 'md-' + match[11];
          markdownInto(s, match[12]); // colors can wrap bold/italic/code
          parent.appendChild(s);
        } else {
          parent.appendChild(document.createTextNode(match[12]));
        }
      }
      last = pattern.lastIndex;
    }
    if (last < text.length) parent.appendChild(document.createTextNode(text.slice(last)));
  }

  /* ---------- component factories ----------
   * create(node) builds a fresh element; patch(el, node) updates one in
   * place. Both are looked up by node.t. Every root element carries
   * data-cid and data-type for the morph.
   */

  function labelWrap(node, control) {
    var wrap = document.createElement('label');
    wrap.className = 'c-field';
    var span = document.createElement('span');
    span.className = 'c-label';
    span.textContent = node.label || '';
    wrap.appendChild(span);
    wrap.appendChild(control);
    return wrap;
  }

  function isEditing(root) {
    return root.contains(document.activeElement) &&
      (document.activeElement.tagName === 'INPUT' || document.activeElement.tagName === 'SELECT');
  }

  var factories = {
    header: {
      create: function (node) {
        var h = document.createElement('h2');
        h.className = 'c-header';
        h.textContent = node.text;
        return h;
      },
      patch: function (root, node) { root.textContent = node.text; }
    },

    text: {
      create: function (node) {
        var p = document.createElement('p');
        p.className = 'c-text';
        p.textContent = node.text;
        return p;
      },
      patch: function (root, node) { root.textContent = node.text; }
    },

    markdown: {
      create: function (node) {
        var p = document.createElement('p');
        p.className = 'c-markdown';
        markdownInto(p, node.text);
        return p;
      },
      patch: function (root, node) {
        root.textContent = '';
        markdownInto(root, node.text);
      }
    },

    divider: {
      create: function () { return document.createElement('hr'); },
      patch: function () {}
    },

    button: {
      create: function (node) {
        var b = document.createElement('button');
        b.className = 'c-button ' + (node.variant || 'default');
        b.textContent = node.label;
        b.disabled = !!node.disabled;
        b.dataset.label = node.label;
        if (node.confirm) b.dataset.confirmLabel = node.confirm;
        b.addEventListener('click', function () {
          // confirm: two-step - first click arms (label swaps), second
          // click within the window fires; otherwise it reverts
          if (b.dataset.confirmLabel && b.dataset.confirming !== '1') {
            b.dataset.confirming = '1';
            b.classList.add('confirming');
            b.textContent = b.dataset.confirmLabel;
            setTimeout(function () {
              if (b.dataset.confirming !== '1') return;
              b.dataset.confirming = '';
              b.classList.remove('confirming');
              b.textContent = b.dataset.label;
            }, 4000);
            return;
          }
          b.dataset.confirming = '';
          b.classList.remove('confirming');
          b.textContent = b.dataset.label;
          emit(node.cid, 'click', null);
        });
        return b;
      },
      patch: function (root, node) {
        root.dataset.label = node.label;
        if (node.confirm) { root.dataset.confirmLabel = node.confirm; } else { delete root.dataset.confirmLabel; }
        if (root.dataset.confirming !== '1') root.textContent = node.label;
        root.className = 'c-button ' + (node.variant || 'default') + (root.dataset.confirming === '1' ? ' confirming' : '');
        root.disabled = !!node.disabled;
      }
    },

    text_input: {
      create: function (node) {
        var input = document.createElement('input');
        input.type = 'text';
        input.value = node.value || '';
        if (node.placeholder) input.placeholder = node.placeholder;
        input.addEventListener('change', function () { emit(node.cid, 'change', input.value); });
        input.addEventListener('keydown', function (e) { if (e.key === 'Enter') input.blur(); });
        return labelWrap(node, input);
      },
      patch: function (root, node) {
        root.querySelector('.c-label').textContent = node.label || '';
        var input = root.querySelector('input');
        if (!isEditing(root)) input.value = node.value || '';
      }
    },

    password_input: {
      create: function (node) {
        var input = document.createElement('input');
        input.type = 'password';
        input.autocomplete = 'current-password';
        if (node.placeholder) input.placeholder = node.placeholder;
        input.addEventListener('change', function () { emit(node.cid, 'change', input.value); });
        input.addEventListener('keydown', function (e) { if (e.key === 'Enter') input.blur(); });
        return labelWrap(node, input);
      },
      patch: function (root, node) {
        // the server never knows the value; leave the field untouched
        root.querySelector('.c-label').textContent = node.label || '';
      }
    },

    select: {
      create: function (node) {
        var sel = document.createElement('select');
        (node.options || []).forEach(function (opt) {
          var o = document.createElement('option');
          o.value = opt;
          o.textContent = opt;
          sel.appendChild(o);
        });
        if (node.value != null) sel.value = node.value;
        sel.addEventListener('change', function () { emit(node.cid, 'change', sel.value); });
        return labelWrap(node, sel);
      },
      patch: function (root, node) {
        root.querySelector('.c-label').textContent = node.label || '';
        var sel = root.querySelector('select');
        var opts = node.options || [];
        var changed = sel.options.length !== opts.length ||
          opts.some(function (opt, i) { return sel.options[i].value !== opt; });
        if (changed) {
          sel.textContent = '';
          opts.forEach(function (opt) {
            var o = document.createElement('option');
            o.value = opt;
            o.textContent = opt;
            sel.appendChild(o);
          });
        }
        if (!isEditing(root) && node.value != null) sel.value = node.value;
      }
    },

    number_input: {
      create: function (node) {
        var input = document.createElement('input');
        input.type = 'number';
        if (node.min != null) input.min = node.min;
        if (node.max != null) input.max = node.max;
        input.step = node.step || 1;
        if (node.value != null) input.value = node.value;
        input.addEventListener('change', function () { emit(node.cid, 'change', Number(input.value)); });
        input.addEventListener('keydown', function (e) { if (e.key === 'Enter') input.blur(); });
        return labelWrap(node, input);
      },
      patch: function (root, node) {
        root.querySelector('.c-label').textContent = node.label || '';
        var input = root.querySelector('input');
        if (node.min != null) input.min = node.min;
        if (node.max != null) input.max = node.max;
        input.step = node.step || 1;
        if (!isEditing(root) && node.value != null) input.value = node.value;
      }
    },

    radio: {
      create: function (node) {
        var group = document.createElement('div');
        group.className = 'c-radio-group';
        buildRadio(group, node);
        var wrap = labelWrap(node, group);
        wrap.classList.add('c-radio');
        return wrap;
      },
      patch: function (root, node) {
        root.querySelector('.c-label').textContent = node.label || '';
        buildRadio(root.querySelector('.c-radio-group'), node);
      }
    },

    log: {
      create: function (node) {
        var wrap = document.createElement('div');
        wrap.className = 'c-log';
        buildLog(wrap, node);
        return wrap;
      },
      patch: function (root, node) {
        buildLog(root, node);
      }
    },

    checkbox: {
      create: function (node) {
        var input = document.createElement('input');
        input.type = 'checkbox';
        input.checked = !!node.checked;
        input.addEventListener('change', function () { emit(node.cid, 'change', input.checked); });
        var wrap = labelWrap(node, input);
        wrap.className = 'c-field c-checkbox';
        return wrap;
      },
      patch: function (root, node) {
        root.querySelector('.c-label').textContent = node.label || '';
        root.querySelector('input').checked = !!node.checked;
      }
    },

    slider: {
      create: function (node) {
        var input = document.createElement('input');
        input.type = 'range';
        input.min = node.min;
        input.max = node.max;
        input.step = node.step || 1;
        input.value = node.value;
        var bubble = document.createElement('output');
        bubble.className = 'c-slider-value';
        bubble.textContent = String(node.value);
        input.addEventListener('input', function () { bubble.textContent = input.value; });
        input.addEventListener('change', function () { emit(node.cid, 'change', Number(input.value)); });
        var wrap = labelWrap(node, input);
        wrap.classList.add('c-slider');
        wrap.appendChild(bubble);
        return wrap;
      },
      patch: function (root, node) {
        root.querySelector('.c-label').textContent = node.label || '';
        var input = root.querySelector('input');
        input.min = node.min;
        input.max = node.max;
        input.step = node.step || 1;
        if (!isEditing(root)) {
          input.value = node.value;
          root.querySelector('output').textContent = String(node.value);
        }
      }
    },

    progress: {
      create: function (node) {
        var wrap = document.createElement('div');
        wrap.className = 'c-progress';
        var span = document.createElement('span');
        span.className = 'c-label';
        span.textContent = node.label || '';
        var track = document.createElement('div');
        track.className = 'c-progress-track';
        var fill = document.createElement('div');
        fill.className = 'c-progress-fill';
        fill.style.width = (node.value * 100).toFixed(1) + '%';
        track.appendChild(fill);
        wrap.appendChild(span);
        wrap.appendChild(track);
        return wrap;
      },
      patch: function (root, node) {
        root.querySelector('.c-label').textContent = node.label || '';
        root.querySelector('.c-progress-fill').style.width = (node.value * 100).toFixed(1) + '%';
      }
    },

    table: {
      create: function (node) {
        var wrap = document.createElement('div');
        wrap.className = 'c-table-wrap';
        buildTable(wrap, node);
        return wrap;
      },
      patch: function (root, node) {
        buildTable(root, node);
      }
    },

    image: {
      create: function (node) {
        var img = document.createElement('img');
        img.className = 'c-image';
        img.src = node.src;
        img.alt = node.alt || '';
        img.loading = 'lazy';
        return img;
      },
      patch: function (root, node) {
        if (root.getAttribute('src') !== node.src) root.src = node.src;
        root.alt = node.alt || '';
      }
    },

    image_map: {
      create: function (node) {
        var root = document.createElement('div');
        root.className = 'c-image-map';
        var inner = document.createElement('div');
        inner.className = 'c-image-map-inner';
        var img = document.createElement('img');
        img.draggable = false;
        var layer = document.createElement('div');
        layer.className = 'c-image-map-layer';
        inner.appendChild(img);
        inner.appendChild(layer);
        root.appendChild(inner);

        function report(e, right) {
          var rect = img.getBoundingClientRect();
          var scale = Number(root.dataset.scale) || 1;
          var marker = e.target.classList && e.target.classList.contains('c-im-marker')
            ? e.target.dataset.markerId : null;
          emit(root.dataset.cid, 'click', {
            x: Math.round((e.clientX - rect.left) / scale),
            y: Math.round((e.clientY - rect.top) / scale),
            shift: e.shiftKey,
            ctrl: e.ctrlKey || e.metaKey,
            right: right,
            marker: marker
          });
        }
        inner.addEventListener('click', function (e) { report(e, false); });
        inner.addEventListener('contextmenu', function (e) {
          e.preventDefault();
          if (node.popup) {
            // open the named page as a small supplemental window; a user
            // gesture, so no popup blocker involvement
            var size = node.popup_size || [420, 560];
            window.open('#/' + node.popup, 'webui-popup-' + node.popup,
              'popup,width=' + size[0] + ',height=' + size[1]);
          } else {
            report(e, true);
          }
        });
        img.addEventListener('load', function () { layoutImageMap(root); });

        renderImageMap(root, node);
        return root;
      },
      patch: function (root, node) {
        renderImageMap(root, node);
      }
    },

    expander: {
      create: function (node) {
        var details = document.createElement('details');
        details.className = 'c-expander';
        details.open = !!node.open;
        var summary = document.createElement('summary');
        summary.textContent = node.label;
        var body = document.createElement('div');
        body.className = 'c-expander-body';
        details.appendChild(summary);
        details.appendChild(body);
        morphChildren(body, node.children || []);
        return details;
      },
      patch: function (root, node) {
        root.querySelector('summary').textContent = node.label;
        // note: the user's open/closed toggle wins over node.open after create
        morphChildren(root.querySelector('.c-expander-body'), node.children || []);
      }
    },

    columns: {
      create: function (node) {
        var row = document.createElement('div');
        row.className = 'c-columns' + (node.compact ? ' compact' : '');
        (node.children || []).forEach(function (colNode, i) {
          var col = document.createElement('div');
          col.className = 'c-col';
          col.dataset.cid = colNode.cid;
          col.dataset.type = 'col';
          applyColumnWeight(col, node, i);
          morphChildren(col, colNode.children || []);
          row.appendChild(col);
        });
        return row;
      },
      patch: function (root, node) {
        root.className = 'c-columns' + (node.compact ? ' compact' : '');
        var cols = node.children || [];
        if (root.children.length !== cols.length) {
          root.textContent = '';
          cols.forEach(function (colNode, i) {
            var col = document.createElement('div');
            col.className = 'c-col';
            col.dataset.cid = colNode.cid;
            col.dataset.type = 'col';
            applyColumnWeight(col, node, i);
            morphChildren(col, colNode.children || []);
            root.appendChild(col);
          });
          return;
        }
        cols.forEach(function (colNode, i) {
          applyColumnWeight(root.children[i], node, i);
          morphChildren(root.children[i], colNode.children || []);
        });
      }
    },

    tabs: {
      create: function (node) {
        var wrap = document.createElement('div');
        wrap.className = 'c-tabs';
        var bar = document.createElement('div');
        bar.className = 'c-tab-bar';
        var panels = document.createElement('div');
        panels.className = 'c-tab-panels';
        wrap.appendChild(bar);
        wrap.appendChild(panels);
        wrap.dataset.active = '0';
        buildTabs(wrap, node);
        return wrap;
      },
      patch: function (root, node) {
        buildTabs(root, node);
      }
    }
  };

  // Proportional column widths (weights: [7, 3] = 70/30). flex-basis 0
  // makes flex-grow the sole width driver; min-width 0 lets a table's own
  // scrollbar engage instead of forcing the column wide.
  function applyColumnWeight(col, node, i) {
    var weight = !node.compact && node.weights && node.weights[i];
    col.style.flex = weight ? weight + ' 1 0' : '';
    col.style.minWidth = weight ? '0' : '';
  }

  // (Re)builds a radio group; radios share the component cid as their name
  // so the browser handles exclusivity.
  function buildRadio(group, node) {
    group.textContent = '';
    (node.options || []).forEach(function (opt) {
      var lab = document.createElement('label');
      lab.className = 'c-radio-option';
      var input = document.createElement('input');
      input.type = 'radio';
      input.name = node.cid;
      input.value = opt;
      input.checked = (opt === node.value);
      input.addEventListener('change', function () { if (input.checked) emit(node.cid, 'change', opt); });
      var span = document.createElement('span');
      span.textContent = opt;
      lab.appendChild(input);
      lab.appendChild(span);
      group.appendChild(lab);
    });
  }

  // (Re)builds a scrolling log. Sticks to the newest line unless the player
  // has scrolled up to read history.
  function buildLog(root, node) {
    var nearBottom = root.childElementCount === 0 ||
      root.scrollTop + root.clientHeight >= root.scrollHeight - 8;
    root.style.maxHeight = (node.max_height || 200) + 'px';
    root.textContent = '';
    (node.lines || []).forEach(function (line) {
      var div = document.createElement('div');
      markdownInto(div, line);
      root.appendChild(div);
    });
    if (nearBottom) {
      // scrollHeight is only meaningful once laid out; defer one frame
      requestAnimationFrame(function () { root.scrollTop = root.scrollHeight; });
    }
  }

  // (Re)builds a tabs component, preserving the active tab across renders
  // via the container's data-active index.
  function buildTabs(root, node) {
    root.className = 'c-tabs' + (node.vertical ? ' vertical' : '');
    var bar = root.querySelector('.c-tab-bar');
    var panels = root.querySelector('.c-tab-panels');
    var tabNodes = node.children || [];
    var active = Math.min(parseInt(root.dataset.active || '0', 10), Math.max(tabNodes.length - 1, 0));

    // tab buttons: rebuild (cheap, no user state beyond active index)
    bar.textContent = '';
    tabNodes.forEach(function (tabNode, i) {
      var btn = document.createElement('button');
      btn.className = 'c-tab-button' + (i === active ? ' active' : '');
      btn.textContent = tabNode.label || '';
      btn.addEventListener('click', function () {
        root.dataset.active = String(i);
        buildTabs(root, node);
      });
      bar.appendChild(btn);
    });

    // panels: morph so inputs inside inactive tabs keep their state
    var existing = new Map();
    Array.prototype.forEach.call(panels.children, function (child) {
      existing.set(child.dataset.cid, child);
    });
    tabNodes.forEach(function (tabNode, i) {
      var panel = existing.get(tabNode.cid);
      if (!panel) {
        panel = document.createElement('div');
        panel.className = 'c-tab-panel';
        panel.dataset.cid = tabNode.cid;
        panel.dataset.type = 'tab';
        panels.appendChild(panel);
      } else {
        existing.delete(tabNode.cid);
      }
      panel.hidden = i !== active;
      morphChildren(panel, tabNode.children || []);
    });
    existing.forEach(function (leftover) { leftover.remove(); });
  }

  // (Re)builds a table inside its wrapper. Sort state lives on the wrapper's
  // dataset so it survives re-renders (the morph reuses the wrapper element).
  // Row clicks always report the row's index into the ORIGINAL rows array,
  // regardless of the current sort order.
  // Applies an image_map's src/scale/markers. Marker geometry is kept in
  // unscaled image coordinates in dataset and positioned by layoutImageMap
  // once the image's natural size is known. Scroll position is preserved
  // across renders because the container element is reused by the morph.
  function renderImageMap(root, node) {
    var img = root.querySelector('img');
    var layer = root.querySelector('.c-image-map-layer');
    root.dataset.scale = String(node.scale || 1);
    if (img.getAttribute('src') !== node.src) img.src = node.src;

    layer.textContent = '';
    (node.markers || []).forEach(function (marker) {
      var box = document.createElement('div');
      box.className = 'c-im-marker ' + (marker.kind || 'marker');
      box.dataset.markerId = marker.id;
      box.dataset.x1 = marker.x1;
      box.dataset.y1 = marker.y1;
      box.dataset.x2 = marker.x2;
      box.dataset.y2 = marker.y2;
      if (marker.label) box.title = marker.label;
      layer.appendChild(box);
    });

    root.dataset.scrollTarget = node.scroll_to || '';
    layoutImageMap(root);
  }

  // Positions everything for the current scale; called on render and again
  // when the image finishes loading (natural size unknown before that).
  function layoutImageMap(root) {
    var img = root.querySelector('img');
    if (!img.naturalWidth) return; // not loaded yet
    var scale = Number(root.dataset.scale) || 1;
    img.style.width = (img.naturalWidth * scale) + 'px';

    var target = null;
    root.querySelectorAll('.c-im-marker').forEach(function (box) {
      var x1 = Number(box.dataset.x1) * scale;
      var y1 = Number(box.dataset.y1) * scale;
      box.style.left = x1 + 'px';
      box.style.top = y1 + 'px';
      box.style.width = Math.max((Number(box.dataset.x2) - Number(box.dataset.x1)) * scale, 6) + 'px';
      box.style.height = Math.max((Number(box.dataset.y2) - Number(box.dataset.y1)) * scale, 6) + 'px';
      if (box.dataset.markerId === root.dataset.scrollTarget) target = box;
    });

    // center on the scroll target when it moves (or first appears)
    if (target) {
      var cx = target.offsetLeft + target.offsetWidth / 2;
      var cy = target.offsetTop + target.offsetHeight / 2;
      var seen = root.dataset.scrolledTo;
      var pos = root.dataset.scrollTarget + '@' + Math.round(cx) + ',' + Math.round(cy);
      if (seen !== pos) {
        root.dataset.scrolledTo = pos;
        root.scrollLeft = cx - root.clientWidth / 2;
        root.scrollTop = cy - root.clientHeight / 2;
      }
    }
  }

  function buildTable(wrap, node) {
    wrap.textContent = '';
    // max_height caps the wrapper and scrolls rows inside it; the sticky
    // thead CSS keeps headings pinned while scrolling
    wrap.style.maxHeight = node.max_height ? node.max_height + 'px' : '';
    wrap.style.overflowY = node.max_height ? 'auto' : '';
    var sortCol = wrap.dataset.sortCol === undefined || wrap.dataset.sortCol === '' ? null : Number(wrap.dataset.sortCol);
    var sortDir = wrap.dataset.sortDir === 'desc' ? -1 : 1;
    if (!node.sortable) sortCol = null;

    var table = document.createElement('table');
    table.className = 'c-table';
    if (node.headings) {
      var thead = document.createElement('thead');
      var headRow = document.createElement('tr');
      node.headings.forEach(function (heading, col) {
        var th = document.createElement('th');
        th.textContent = heading + (col === sortCol ? (sortDir === 1 ? ' ▴' : ' ▾') : '');
        if (node.sortable) {
          th.className = 'sortable';
          th.addEventListener('click', function () {
            if (Number(wrap.dataset.sortCol) === col && wrap.dataset.sortDir !== 'desc') {
              wrap.dataset.sortDir = 'desc';
            } else {
              wrap.dataset.sortCol = String(col);
              wrap.dataset.sortDir = 'asc';
            }
            buildTable(wrap, node);
          });
        }
        headRow.appendChild(th);
      });
      thead.appendChild(headRow);
      table.appendChild(thead);
    }

    var indexed = (node.rows || []).map(function (row, i) { return { row: row, index: i }; });
    if (sortCol !== null) {
      indexed.sort(function (a, b) {
        var av = a.row[sortCol] || '';
        var bv = b.row[sortCol] || '';
        var an = parseFloat(av);
        var bn = parseFloat(bv);
        var cmp = (!isNaN(an) && !isNaN(bn)) ? an - bn : String(av).localeCompare(String(bv));
        return cmp * sortDir;
      });
    }

    var tbody = document.createElement('tbody');
    indexed.forEach(function (entry) {
      var tr = document.createElement('tr');
      if (entry.index === node.selected) tr.classList.add('selected');
      if (node.clickable) {
        tr.classList.add('clickable');
        tr.addEventListener('click', function () { emit(node.cid, 'row', entry.index); });
      }
      entry.row.forEach(function (cell) {
        var td = document.createElement('td');
        td.textContent = cell;
        tr.appendChild(td);
      });
      tbody.appendChild(tr);
    });
    table.appendChild(tbody);
    wrap.appendChild(table);
  }

  /* ---------- render + morph ---------- */

  function renderTree(tree) {
    var body = document.getElementById('page-body');
    if (!body) return;
    if (tree.title) document.title = tree.title + ' — Lich WebUI';
    // embedded panels always get bare-page chrome/density, whatever the page
    document.body.classList.toggle('bare-page', !!tree.bare || embeddedMode);
    barePage = !!tree.bare;
    // Edge/Chrome often ignore --window-size/--window-position for app
    // windows when the browser is already running (and popups open at
    // their default size); enforce the page's intended geometry once, in
    // standalone windows only. resize before move so clamping-to-screen
    // uses the final size.
    if ((tree.size || tree.position) && !window.__webuiSized && !embeddedMode && standaloneWindow()) {
      window.__webuiSized = true;
      if (tree.size) { try { window.resizeTo(tree.size[0], tree.size[1]); } catch (e) { /* ignore */ } }
      // guard the minimized/off-screen sentinel so we never move the window
      // somewhere the user can't see it
      if (tree.position && Math.abs(tree.position[0]) < 30000 && Math.abs(tree.position[1]) < 30000) {
        try { window.moveTo(tree.position[0], tree.position[1]); } catch (e) { /* ignore */ }
      }
    }
    morphChildren(body, tree.children || []);
  }

  /* ---------- window geometry reporting (standalone windows) ----------
   * App windows and popups report their outer geometry so windows reopen
   * where they were. Regular tabs never report - a maximized tab viewing
   * the same page must not overwrite the floating window's geometry.
   */
  var barePage = false;
  var lastGeometry = '';
  function reportGeometry() {
    if (embeddedMode || !standaloneWindow() || !currentPage || !wsReady) return;
    var geo = { w: window.outerWidth, h: window.outerHeight, x: window.screenX, y: window.screenY };
    var packed = geo.w + ',' + geo.h + ',' + geo.x + ',' + geo.y;
    if (packed === lastGeometry) return;
    lastGeometry = packed;
    send({ type: 'geometry', page: currentPage, value: geo });
  }
  window.addEventListener('resize', reportGeometry);
  setInterval(reportGeometry, 3000); // no JS event for window moves; poll
  // last chance to capture a move made just before the window closes
  window.addEventListener('pagehide', reportGeometry);

  // Reconciles the container's children against the new node list by cid.
  // Matching (cid, type) pairs are patched in place; everything else is
  // created fresh. Removed cids are dropped.
  function morphChildren(parent, nodes) {
    var existing = new Map();
    Array.prototype.forEach.call(parent.children, function (child) {
      if (child.dataset.cid) existing.set(child.dataset.cid, child);
    });

    nodes.forEach(function (node, index) {
      var factory = factories[node.t];
      if (!factory) return;
      var current = existing.get(node.cid);
      var target;
      if (current && current.dataset.type === node.t) {
        factory.patch(current, node);
        target = current;
        existing.delete(node.cid);
      } else {
        target = factory.create(node);
        target.dataset.cid = node.cid;
        target.dataset.type = node.t;
      }
      var ref = parent.children[index] || null;
      if (ref !== target) parent.insertBefore(target, ref);
    });

    existing.forEach(function (leftover) { leftover.remove(); });
    while (parent.children.length > nodes.length) parent.lastElementChild.remove();
  }

  /* ---------- boot ---------- */

  el.themeToggle.addEventListener('click', function () {
    var root = document.documentElement;
    var current = root.getAttribute('data-theme') ||
      (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
    var next = current === 'dark' ? 'light' : 'dark';
    root.setAttribute('data-theme', next);
    localStorage.setItem('lich-webui-theme', next);
  });

  window.addEventListener('hashchange', route);
  route();
  connect();
})();
