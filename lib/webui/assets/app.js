/* Lich WebUI client — M1: connection, hello, landing page.
 *
 * All dynamic content is built with document.createElement/textContent —
 * never innerHTML — so strings from scripts cannot inject markup. Keep it
 * that way when adding component factories in M2.
 */
'use strict';

(function () {
  var ws = null;
  var reconnectDelay = 500; // ms, doubles up to 8s
  var RECONNECT_MAX = 8000;

  var el = {
    sessionLabel: document.getElementById('session-label'),
    sessionTitle: document.getElementById('session-title'),
    connStatus: document.getElementById('conn-status'),
    pageList: document.getElementById('page-list'),
    noPages: document.getElementById('no-pages'),
    siblingsBlock: document.getElementById('siblings-block'),
    siblingList: document.getElementById('sibling-list'),
    notices: document.getElementById('notices'),
    themeToggle: document.getElementById('theme-toggle')
  };

  function setStatus(state, text) {
    el.connStatus.className = 'status ' + state;
    el.connStatus.textContent = text;
  }

  function connect() {
    setStatus('connecting', 'connecting…');
    ws = new WebSocket('ws://' + location.host + '/ws');

    ws.onopen = function () {
      reconnectDelay = 500;
      setStatus('connected', 'connected');
    };

    ws.onmessage = function (event) {
      var msg;
      try { msg = JSON.parse(event.data); } catch (e) { return; }
      if (msg.type === 'hello') handleHello(msg);
      else if (msg.type === 'pages') renderPages(msg.pages || []);
      else if (msg.type === 'notice') showNotice(msg.level || 'info', msg.text || '');
      // 'render' arrives in M2.
    };

    ws.onclose = function () {
      setStatus('disconnected', 'disconnected — retrying');
      setTimeout(connect, reconnectDelay);
      reconnectDelay = Math.min(reconnectDelay * 2, RECONNECT_MAX);
    };

    ws.onerror = function () { ws.close(); };
  }

  function handleHello(msg) {
    var name = (msg.session && msg.session.name) || '';
    var game = (msg.session && msg.session.game) || '';
    var label = name ? name + (game ? ' · ' + game : '') : 'Lich WebUI';
    el.sessionLabel.textContent = label;
    el.sessionTitle.textContent = name ? name : 'Lich WebUI';
    document.title = (name ? name + ' — ' : '') + 'Lich WebUI';
    renderPages(msg.pages || []);
    renderSiblings(msg.siblings || []);
  }

  function renderPages(pages) {
    el.pageList.textContent = '';
    el.noPages.hidden = pages.length > 0;
    pages.forEach(function (page) {
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

  el.themeToggle.addEventListener('click', function () {
    var root = document.documentElement;
    var current = root.getAttribute('data-theme') ||
      (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
    var next = current === 'dark' ? 'light' : 'dark';
    root.setAttribute('data-theme', next);
    localStorage.setItem('lich-webui-theme', next);
  });

  connect();
})();
