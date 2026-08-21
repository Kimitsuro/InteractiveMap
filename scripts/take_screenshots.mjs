/**
 * Снимает скриншоты UI для README.
 * Требует: docker compose up, Playwright Chromium.
 *
 *   npx --yes playwright@1.49.1 install chromium
 *   node scripts/take_screenshots.mjs
 */
import { createRequire } from 'node:module';
import { mkdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const require = createRequire(join(__dirname, 'package.json'));
const { chromium } = require('playwright');

const outDir = join(__dirname, '..', 'docs', 'screenshots');
const base = process.env.SCREENSHOT_BASE_URL || 'http://localhost:8080';
const adminLogin = process.env.ADMIN_LOGIN || 'map_admin';
const adminPassword = process.env.ADMIN_PASSWORD || '';

mkdirSync(outDir, { recursive: true });

async function dismissCookie(page) {
  const btn = page.locator('#cookieNoticeAccept');
  if (await btn.isVisible().catch(() => false)) {
    await btn.click();
    await page.waitForTimeout(300);
  }
}

async function waitMapReady(page) {
  await page.waitForSelector('#mapWrapper svg g[data-region-name]', { timeout: 30000 });
  await page.waitForSelector('#pageLoader', { state: 'hidden', timeout: 30000 }).catch(() => {});
  await page.waitForTimeout(1200);
}

const browser = await chromium.launch({ headless: true });
const page = await browser.newPage({ viewport: { width: 1440, height: 900 } });

try {
  await page.goto(base + '/', { waitUntil: 'networkidle', timeout: 60000 });
  await waitMapReady(page);
  await dismissCookie(page);
  await page.screenshot({ path: join(outDir, 'map-main.png'), fullPage: false });

  const district = page.locator('#mapWrapper svg .district').first();
  await district.click({ force: true });
  await page.waitForSelector('#districtModal:not(.hidden)', { timeout: 15000 });
  await page.waitForTimeout(1500);
  await page.screenshot({ path: join(outDir, 'district-list.png'), fullPage: false });

  const filtersToggle = page.locator('#toggleFilters, .filters-toggle, button:has-text("Фильтр")').first();
  if (await filtersToggle.count()) {
    await filtersToggle.click().catch(() => {});
    await page.waitForTimeout(500);
  }
  await page.screenshot({ path: join(outDir, 'filters.png'), fullPage: false });

  await page.goto(base + '/admin', { waitUntil: 'networkidle', timeout: 60000 });
  await waitMapReady(page);
  await dismissCookie(page);
  await page.locator('#adminLogin').click();
  await page.waitForSelector('#loginModal:not(.hidden)');
  await page.waitForTimeout(400);
  await page.screenshot({ path: join(outDir, 'admin-login.png'), fullPage: false });

  if (adminPassword) {
    await page.fill('#adminLoginInput', adminLogin);
    await page.fill('#adminPassword', adminPassword);
    await page.click('#loginForm button[type="submit"]');
    await page.waitForSelector('#adminPanel:not(.hidden)', { timeout: 10000 });
    await page.click('#addInstitution');
    await page.waitForSelector('#institutionModal:not(.hidden)');
    await page.waitForTimeout(500);
    await page.screenshot({ path: join(outDir, 'admin-form.png'), fullPage: false });
  }

  console.log('Screenshots saved to', outDir);
} finally {
  await browser.close();
}
