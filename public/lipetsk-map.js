// lipetsk-map.js
class LipetskMap extends EventBinder {
    async init() {
        this.showPageLoader();

        try {
            await this.loadMap();
            this.bindEvents();
            await this.loadDistricts();
        } catch (error) {
            console.error('Error during initialization:', error);
        } finally {
            this.hidePageLoader();
        }
    }
}

let lipetskMap;
document.addEventListener("DOMContentLoaded", () => {
    lipetskMap = new LipetskMap();
    lipetskMap.init();
});

document.addEventListener('DOMContentLoaded', () => {
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
});