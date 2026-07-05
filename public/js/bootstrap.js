// ============================================================
// bootstrap.js — Точка входа приложения.
// ============================================================

let lipetskMap;

const ASSET_VERSION = '20260705b';

function loadScript(src) {
  return new Promise((resolve, reject) => {
    const script = document.createElement('script');
    script.src = src.includes('?') ? src : `${src}?v=${ASSET_VERSION}`;
    script.onload = resolve;
    script.onerror = reject;
    document.body.appendChild(script);
  });
}

async function loadAdminScripts() {
  await loadScript('js/admin.js');
  await loadScript('js/admin-auth.js');
  await loadScript('js/admin-form.js');
  await loadScript('js/admin-crud.js');
}

document.addEventListener("DOMContentLoaded", async () => {
  lipetskMap = new LipetskMap();
  lipetskMap.isAdminMode = window.IS_ADMIN_ROUTE === true;
  await lipetskMap.init();

  if (window.IS_ADMIN_ROUTE) {
    await loadAdminScripts();
    new AdminManager(lipetskMap);
  }
});

window.addEventListener('error', () => {
  const pageLoader = document.getElementById("pageLoader");
  if (pageLoader) {
    pageLoader.innerHTML = `
      <div style="text-align: center; color: #e74c3c;">
        <div style="font-size: 48px; margin-bottom: 10px;">⚠️</div>
        <p>Ошибка загрузки страницы</p>
        <button onclick="location.reload()" class="btn btn-primary" style="margin-top: 10px;">
          Обновить страницу
        </button>
      </div>
    `;
  }
});

setTimeout(() => {
  const pageLoader = document.getElementById("pageLoader");
  if (pageLoader && pageLoader.style.display !== 'none') {
    pageLoader.innerHTML = `
      <div style="text-align: center; color: #e74c3c;">
        <p>Загрузка занимает больше времени чем ожидалось</p>
        <button onclick="location.reload()" class="btn btn-primary" style="margin-top: 10px;">
          Обновить страницу
        </button>
      </div>
    `;
  }
}, 10000);