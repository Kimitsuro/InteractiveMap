// base-map.js
class LipetskMapBase {
    constructor() {
        this.isAdminMode = false;
        this.currentDistrictName = null;
        this.editingInstitution = null;
        this.institutions = [];
        this.districts = {};
        this.districtIdMap = {};
        this.districtColors = {};
        this.aoopCounter = 0;
        this.isAdmin = false;
        this.animationPlayed = false;

        this.loaderTimeout = null;
        this.pageLoaderTimeout = null;
    }

    // Методы для загрузчика страницы
    showPageLoader() {
        const pageLoader = document.getElementById("pageLoader");
        if (pageLoader) {
            pageLoader.style.display = 'flex';
        }
    }

    hidePageLoader() {
        const pageLoader = document.getElementById("pageLoader");
        if (pageLoader) {
            pageLoader.style.opacity = '0';
            setTimeout(() => {
                pageLoader.style.display = 'none';
            }, 300);
        }
    }

    // Методы для загрузчика модального окна
    showModalLoader() {
        const modalLoader = document.getElementById("modalLoader");
        if (modalLoader) {
            modalLoader.classList.remove("hidden");
        }
    }

    hideModalLoader() {
        const modalLoader = document.getElementById("modalLoader");
        if (modalLoader) {
            modalLoader.classList.add("hidden");
        }
    }

    async loadDistricts() {
        try {
            const response = await fetch("/api/get_districts.php");
            if (!response.ok) throw new Error(`HTTP ${response.status}`);
            const data = await response.json();
            if (data.error) throw new Error(data.error);
            this.districts = data.districts;
            this.districtIdMap = {};
            Object.entries(this.districts).forEach(([id, name]) => {
                this.districtIdMap[name] = parseInt(id);
            });
            this.populateLegend();
            this.populateDistrictSelect();
        } catch (error) {
            console.error("Error loading districts:", error);
            this.districts = { 1: "Липецкий район", 2: "Елецкий район" };
            this.populateLegend();
        }
    }

    populateDistrictSelect() {
        const districtSelect = document.getElementById("districtId");
        const sortedDistricts = Object.values(this.districts).sort();
        districtSelect.innerHTML = `
        <option value="">Выберите район</option>
        ${sortedDistricts
                .map(
                    (name) =>
                        `<option value="${this.districtIdMap[name]}">${name}</option>`
                )
                .join("")}
      `;
    }

    getDistrictName(districtId) {
        const name = Object.values(this.districts).find((name) =>
            name.includes(districtId)
        );
        return name || `Район ${districtId}`;
    }

    clearInstitutionForm() {
        document.getElementById('institutionForm').reset();
        document.getElementById('aoopList').innerHTML = '';
        this.aoopCounter = 0;

        document.getElementById('rangeMin').value = '';
        document.getElementById('rangeMax').value = '';
        document.getElementById('rangeMin').removeAttribute('min');
        document.getElementById('rangeMin').removeAttribute('max');
        document.getElementById('rangeMax').removeAttribute('min');
        document.getElementById('rangeMax').removeAttribute('max');

        this.editingInstitution = null;
        document.getElementById('institutionModalTitle').textContent = 'Добавить учреждение';
    }

    resetFilters() {
        document.querySelectorAll('.filter-group-accordion input[type="checkbox"]').forEach((cb) => {
            cb.checked = false;
        });
        this.currentPage = 1;
        const districtName = document.getElementById("regionName").textContent;
        this.loadInstitutionsForDistrict(districtName);
        if (window.innerWidth <= 768) {
            document.getElementById("filtersSection").classList.add("hidden");
        }
    }
}