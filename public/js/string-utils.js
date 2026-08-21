// ============================================================
// string-utils.js — чистые строковые хелперы (браузер + Node)
// ============================================================
(function (root, factory) {
  if (typeof module === 'object' && module.exports) {
    module.exports = factory();
  } else {
    root.StringUtils = factory();
  }
})(typeof globalThis !== 'undefined' ? globalThis : this, function () {
  'use strict';

  function escapeHtml(text) {
    if (text == null) return '';
    return String(text)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;');
  }

  function sanitizeUrl(url) {
    if (!url) return '';
    try {
      const parsed = new URL(String(url).trim());
      if (parsed.protocol === 'http:' || parsed.protocol === 'https:') {
        return parsed.href;
      }
    } catch {
      return '';
    }
    return '';
  }

  function normalizeString(str) {
    if (!str) return '';
    return String(str)
      .toLowerCase()
      .replace(/ё/g, 'е')
      .replace(/№/g, '')
      .replace(/[^a-zа-я0-9]/gi, '');
  }

  return {
    escapeHtml,
    sanitizeUrl,
    normalizeString,
  };
});
