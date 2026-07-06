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
      else if (msg.type === 'render' && msg.page === currentPage) renderTree(msg.tree);
    };

    ws.onclose = function () {
      wsReady = false;
      setStatus('disconnected', 'disconnected — retrying');
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
      a.textContent = (sib.name || 'session') + (sib.game ? ' · ' + sib.game : '');
      a.target = '_blank';
      a.rel = 'noopener';
      li.appendChild(a);
      el.siblingList.appendChild(li);
    });
  }

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

  // Supports **bold**, *italic*, `code`, and [text](http(s)://url) built as
  // DOM nodes. Anything else stays literal text.
  function markdownInto(parent, text) {
    var pattern = /(\*\*([^*]+)\*\*)|(\*([^*]+)\*)|(`([^`]+)`)|(\[([^\]]+)\]\((https?:\/\/[^\s)]+)\))/g;
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
        b.addEventListener('click', function () { emit(node.cid, 'click', null); });
        return b;
      },
      patch: function (root, node) {
        root.textContent = node.label;
        root.className = 'c-button ' + (node.variant || 'default');
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
        wrap.appendChild(buildTable(node));
        return wrap;
      },
      patch: function (root, node) {
        root.textContent = '';
        root.appendChild(buildTable(node));
      }
    }
  };

  function buildTable(node) {
    var table = document.createElement('table');
    table.className = 'c-table';
    if (node.headings) {
      var thead = document.createElement('thead');
      var tr = document.createElement('tr');
      node.headings.forEach(function (heading) {
        var th = document.createElement('th');
        th.textContent = heading;
        tr.appendChild(th);
      });
      thead.appendChild(tr);
      table.appendChild(thead);
    }
    var tbody = document.createElement('tbody');
    (node.rows || []).forEach(function (row) {
      var tr = document.createElement('tr');
      row.forEach(function (cell) {
        var td = document.createElement('td');
        td.textContent = cell;
        tr.appendChild(td);
      });
      tbody.appendChild(tr);
    });
    table.appendChild(tbody);
    return table;
  }

  /* ---------- render + morph ---------- */

  function renderTree(tree) {
    var body = document.getElementById('page-body');
    if (!body) return;
    if (tree.title) document.title = tree.title + ' — Lich WebUI';
    morphChildren(body, tree.children || []);
  }

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
