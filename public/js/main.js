// ============================================================
// main.js — Класс LipetskMap: конструктор и init().
// ============================================================

class LipetskMap {
    constructor() {
      this.currentDistrictName = null;
      this.editingInstitution = null;
      this.districts = {};
      this.mapDistricts = {};
      this.districtIdMap = {};
      this.districtColors = {};
      this.isAdmin = false;
      this.animationPlayed = false;
      this.currentPage = 1;
      this.listPage = 1;
      this.pendingListPage = null;
      this.itemsPerPage = 10;
      this.totalPages = 0;
      this.institutionsTotal = 0;
      this.displayedInstitutions = [];
      this.loaderTimeout = null;
      this.activeDistrict = null;
      this.hoverTimeout = null;
      this._adminActionsBound = false;
    }
  
    async init() {
      this.showPageLoader();
  
      try {
        await this.loadMap();
        this.bindEvents();
        this.bindAdminActionsOnce();
        await this.loadDistricts();
      } catch (error) {
        console.error('Error during initialization:', error);
        const loader = document.getElementById('pageLoader');
        if (loader) {
          loader.innerHTML = '<p>Ошибка загрузки карты. Обновите страницу.</p>';
        }
      } finally {
        this.hidePageLoader();
      }
    }
  }
