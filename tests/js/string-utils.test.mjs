import test from 'node:test';
import assert from 'node:assert/strict';
import { createRequire } from 'node:module';
import { fileURLToPath } from 'node:url';
import path from 'node:path';

const require = createRequire(import.meta.url);
const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const StringUtils = require(path.join(root, 'public/js/string-utils.js'));

test('escapeHtml escapes markup', () => {
  assert.equal(StringUtils.escapeHtml('<script>"x"&\'y\''), '&lt;script&gt;&quot;x&quot;&amp;&#39;y&#39;');
});

test('escapeHtml nullish', () => {
  assert.equal(StringUtils.escapeHtml(null), '');
  assert.equal(StringUtils.escapeHtml(undefined), '');
});

test('sanitizeUrl allows http(s)', () => {
  assert.equal(StringUtils.sanitizeUrl('https://example.com/a'), 'https://example.com/a');
});

test('sanitizeUrl rejects javascript', () => {
  assert.equal(StringUtils.sanitizeUrl('javascript:alert(1)'), '');
});

test('sanitizeUrl rejects empty', () => {
  assert.equal(StringUtils.sanitizeUrl(''), '');
  assert.equal(StringUtils.sanitizeUrl(null), '');
});

test('normalizeString collapses and strips', () => {
  assert.equal(StringUtils.normalizeString('МБОУ  № 5  г.Ёлки'), 'мбоу5гелки');
});
