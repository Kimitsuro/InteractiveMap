// ============================================================
// institutions.js — Загрузка, отображение учреждений,
//                   карточки, пагинация
// ============================================================

Object.assign(LipetskMap.prototype, {

    formatRangeValue(value) {
      if (value === null || value === undefined || value === "") return "";
      const num = Number(value);
      return Number.isInteger(num) ? String(num) : String(num);
    },

    async loadDistricts() {
      try {
        const response = await fetch("/api/get_districts.php");
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        const data = await response.json();
        if (data.error) throw new Error(data.error);
        this.districts = data.districts;
        this.districtIdMap = {};
        Object.entries(this.districts).forEach(([id, name]) => {
          this.registerDistrictIdMapping(name, parseInt(id, 10));
        });
        this.populateLegend();
        this.populateDistrictSelect();
      } catch (error) {
        console.error("Error loading districts:", error);
        this.districts = { 1: "г. Липецк", 2: "г. Елец" };
        this.districtIdMap = {};
        Object.entries(this.districts).forEach(([id, name]) => {
          this.registerDistrictIdMapping(name, parseInt(id, 10));
        });
        this.populateLegend();
      }
    },
  
    buildInstitutionsQueryParams(districtId, page) {
      const params = new URLSearchParams({
        district_id: String(districtId),
        page: String(page),
        page_size: String(this.itemsPerPage),
      });

      const selectedTypes = Array.from(
        document.querySelectorAll('.filter-group-accordion input[value^="preschool"], .filter-group-accordion input[value^="school"], .filter-group-accordion input[value^="spo"], .filter-group-accordion input[value^="vo"]')
      )
        .filter(cb => cb.checked)
        .map(cb => cb.value);
      selectedTypes.forEach(type => params.append('type[]', type));

      const selectedAges = Array.from(
        document.querySelectorAll('.filter-group-accordion input[value^="1.5-"], .filter-group-accordion input[value^="3-"], .filter-group-accordion input[value^="5-"], .filter-group-accordion input[value^="7+"]')
      )
        .filter(cb => cb.checked)
        .map(cb => cb.value);
      selectedAges.forEach(age => params.append('age[]', age));

      const selectedConditions = Array.from(
        document.querySelectorAll('.filter-group-accordion input[value="hearing_impairment"], .filter-group-accordion input[value="vision_impairment"], .filter-group-accordion input[value="musculoskeletal_impairment"], .filter-group-accordion input[value="speech_impairment"], .filter-group-accordion input[value="autism"], .filter-group-accordion input[value="mental_retardation"], .filter-group-accordion input[value="intellectual_impairment"], .filter-group-accordion input[value="psychic_development_delay"], .filter-group-accordion input[value="multiple_disorders"]')
      )
        .filter(cb => cb.checked)
        .map(cb => cb.value);
      selectedConditions.forEach(condition => params.append('condition[]', condition));

      if (document.querySelector('.filter-group-accordion input[value="aoop"]:checked')) {
        params.set('aoop', '1');
      }

      const searchTerm = document.getElementById('institutionSearch')?.value.trim() || '';
      if (searchTerm) {
        params.set('q', searchTerm);
      }

      return params;
    },

    async loadInstitutionsForDistrict(districtName, options = {}) {
      const name = districtName || this.currentDistrictName;
      const districtId = this.resolveDistrictId(name);
      if (!districtId) return;

      const requestedPage = options.page != null
        ? parseInt(options.page, 10)
        : (options.keepPage ? this.getListPage() : 1);
      const page = Number.isFinite(requestedPage) && requestedPage > 0 ? requestedPage : 1;

      try {
        this.loaderTimeout = setTimeout(() => {
          this.showModalLoader();
        }, 200);

        const params = this.buildInstitutionsQueryParams(districtId, page);
        const response = await fetch(`/api/get_institutions.php?${params}`);
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        const data = await response.json();
        if (data.error) throw new Error(data.error);

        const total = Number.isFinite(Number(data.total)) ? Number(data.total) : 0;
        const pageSize = Number(data.page_size) > 0 ? Number(data.page_size) : this.itemsPerPage;
        const maxPage = Math.max(1, Math.ceil(total / pageSize) || 1);
        if (total > 0 && page > maxPage) {
          return this.loadInstitutionsForDistrict(name, { ...options, page: maxPage });
        }

        this.displayInstitutionsPage(data, page);

        if (options.scroll) {
          this.scrollToInstitutions();
        }
      } catch (error) {
        console.error('Error loading institutions:', error);
        document.getElementById("institutionsList").innerHTML = '<p>Ошибка загрузки учреждений</p>';
      } finally {
        if (this.loaderTimeout) {
          clearTimeout(this.loaderTimeout);
        }
        this.hideModalLoader();
      }
    },

    displayInstitutionsPage(data, requestedPage) {
      const institutions = Array.isArray(data.institutions) ? data.institutions : [];
      const total = Number.isFinite(Number(data.total)) ? Number(data.total) : institutions.length;
      const pageSize = Number(data.page_size) > 0 ? Number(data.page_size) : this.itemsPerPage;
      const apiPage = Number(data.page) > 0 ? Number(data.page) : requestedPage;

      this.institutionsTotal = total;
      this.itemsPerPage = pageSize;
      this.totalPages = Math.max(1, Math.ceil(total / pageSize) || 1);
      this.displayedInstitutions = institutions;

      const targetPage = Math.min(
        Math.max(1, apiPage || requestedPage || 1),
        this.totalPages
      );
      this.setListPage(targetPage);

      const debugInfo = document.getElementById("debugInfo");
      const institutionCount = document.getElementById("institutionCount");
      const list = document.getElementById("institutionsList");

      if (institutionCount) {
        institutionCount.textContent = `(${total})`;
      }

      if (total === 0 || institutions.length === 0) {
        list.innerHTML = '<p class="text-muted">Учреждения не найдены</p>';
        const paginationTop = document.getElementById("paginationTop");
        const paginationBottom = document.getElementById("paginationBottom");
        if (paginationTop) paginationTop.classList.add("hidden");
        if (paginationBottom) paginationBottom.classList.add("hidden");
        if (debugInfo) debugInfo.style.display = 'none';
        if (total === 0) this.setListPage(1);
        return;
      }

      list.innerHTML = institutions.map((inst) => this.createInstitutionCard(inst)).join('');

      if (debugInfo) {
        const start = (targetPage - 1) * pageSize + 1;
        const end = Math.min(start + institutions.length - 1, total);
        debugInfo.style.display = 'block';
        debugInfo.textContent = `Показано ${start}-${end} из ${total} учреждений (Страница ${targetPage} из ${this.totalPages})`;
      }

      this.updatePagination();
    },

    restoreListPage(page) {
      const targetPage = Math.min(
        Math.max(1, parseInt(page, 10) || 1),
        this.totalPages || 1
      );
      this.loadInstitutionsForDistrict(this.currentDistrictName, { page: targetPage, scroll: true });
    },

    updatePagination() {
      const paginationTop = document.getElementById("paginationTop");
      const paginationBottom = document.getElementById("paginationBottom");
      const numbersTop = document.getElementById("paginationNumbersTop");
      const numbersBottom = document.getElementById("paginationNumbersBottom");
  
      if (!paginationTop || !paginationBottom || !numbersTop || !numbersBottom) {
        console.error('Pagination elements not found');
        return;
      }
  
      if (this.totalPages <= 1) {
        paginationTop.classList.add("hidden");
        paginationBottom.classList.add("hidden");
        return;
      }
  
      paginationTop.classList.remove("hidden");
      paginationBottom.classList.remove("hidden");
  
      numbersTop.innerHTML = this.generatePaginationNumbers();
      numbersBottom.innerHTML = this.generatePaginationNumbers();
  
      this.updatePaginationButtons();
    },
  
    updatePaginationButtons() {
      const prevButtons = document.querySelectorAll('.pagination-prev');
      const nextButtons = document.querySelectorAll('.pagination-next');
  
      prevButtons.forEach(btn => {
        if (btn) btn.disabled = this.currentPage === 1;
      });
  
      nextButtons.forEach(btn => {
        if (btn) btn.disabled = this.currentPage === this.totalPages;
      });
    },
  
    generatePaginationNumbers() {
      const current = this.currentPage;
      const total = this.totalPages;
  
      if (total <= 5) {
        return Array.from({ length: total }, (_, i) => i + 1)
          .map((page) => this.createPageButton(page, page === current))
          .join("");
      }
  
      let pages = [];
      pages.push(1);
  
      let start = Math.max(2, current - 1);
      let end = Math.min(total - 1, current + 1);
  
      if (current <= 3) {
        end = Math.min(4, total - 1);
      } else if (current >= total - 2) {
        start = Math.max(total - 3, 2);
      }
  
      if (start > 2) pages.push("...");
      for (let i = start; i <= end; i++) pages.push(i);
      if (end < total - 1) pages.push("...");
      if (total > 1) pages.push(total);
  
      return pages
        .map((page) => {
          if (page === "...")
            return `<span class="pagination-ellipsis">...</span>`;
          return this.createPageButton(page, page === current);
        })
        .join("");
    },
  
    createPageButton(page, isActive = false) {
      return `<button class="pagination-number ${isActive ? "active" : ""
        }" data-page="${page}">${page}</button>`;
    },
  
    bindAdminActionsOnce() {
      if (this._adminActionsBound) return;
      const list = document.getElementById("institutionsList");
      if (!list) return;
      this._adminActionsBound = true;
      list.addEventListener("click", (e) => {
        const editBtn = e.target.closest(".edit-btn");
        if (editBtn) {
          const id = parseInt(editBtn.dataset.id, 10);
          if (id) this.editInstitution(id);
          return;
        }
        const deleteBtn = e.target.closest(".delete-btn");
        if (deleteBtn) {
          const id = parseInt(deleteBtn.dataset.id, 10);
          if (id) this.deleteInstitution(id);
        }
      });
    },
  
    createInstitutionCard(institution) {
      const esc = (value) => this.escapeHtml(value);
  
      let rangeInfo = "";
      const hasRangeType = ["preschool", "school", "school_internat"].includes(institution.type);
      if (hasRangeType && institution.range_min !== null && institution.range_max !== null) {
        if (institution.type === "preschool") {
          rangeInfo = `${this.formatRangeValue(institution.range_min)}-${this.formatRangeValue(institution.range_max)} лет`;
        } else {
          rangeInfo = `${this.formatRangeValue(institution.range_min)}-${this.formatRangeValue(institution.range_max)} классы`;
        }
      } else if (hasRangeType && institution.range_min !== null) {
        rangeInfo = institution.type === "preschool"
          ? `от ${this.formatRangeValue(institution.range_min)} лет`
          : `от ${this.formatRangeValue(institution.range_min)} класса`;
      } else if (hasRangeType && institution.range_max !== null) {
        rangeInfo = institution.type === "preschool"
          ? `до ${this.formatRangeValue(institution.range_max)} лет`
          : `до ${this.formatRangeValue(institution.range_max)} класса`;
      }
  
      const uniqueConditions = institution.conditions
        ? [...new Set(institution.conditions)]
        : [];
      const uniqueAdmission = institution.conditionsAdmission
        ? [...new Set(institution.conditionsAdmission)]
        : [];
  
      const conditionsSection =
        uniqueConditions.length > 0
          ? `<div class="conditions-section">
            <h5>Особые условия:</h5>
            <div class="institution-tags">
              ${uniqueConditions
            .map(
              (condition) =>
                `<span class="tag condition">${esc(this.getConditionLabel(condition))}</span>`
            )
            .join("")}
            </div>
          </div>`
          : "";
  
      const admissionSection =
        uniqueAdmission.length > 0
          ? `<div class="admission-section">
            <h5>Условия приема:</h5>
            <div class="institution-tags">
              ${uniqueAdmission
            .map(
              (admission) =>
                `<span class="tag admission">${esc(this.getAdmissionLabel(admission))}</span>`
            )
            .join("")}
            </div>
          </div>`
          : "";
  
      const aoopSection =
        institution.aoop_programs && institution.aoop_programs.length > 0
          ? `<div class="aoop-section">
            <h5>Реализуемые адаптированные образовательные программы:</h5>
            <ul class="aoop-list-card">
              ${institution.aoop_programs
            .map(
              (prog) => {
                const progName = esc(this.expandMedicalAbbreviations(prog.name));
                return `<li>${progName}</li>`;
              }
            )
            .join("")}
            </ul>
            ${institution.aoop_url
            ? `<div class="aoop-global-link"><strong>Общая ссылка на адаптированные программы:</strong> ${this.renderTruncatedLink(institution.aoop_url)}</div>`
            : ''}
          </div>`
          : "";
  
      const adminButtons = this.isAdmin
        ? `<div class="institution-actions">
            <button class="btn btn-primary edit-btn" data-id="${institution.id}">Редактировать</button>
            <button class="btn btn-danger delete-btn" data-id="${institution.id}">Удалить</button>
          </div>`
        : "";
  
      return `
      <div class="institution-card">
        <h4>${esc(institution.name)}</h4>
        <span class="institution-type">${esc(this.getInstitutionTypeLabel(institution.type))}</span>
        
        ${institution.description
          ? `<p class="institution-description">${esc(institution.description)}</p>`
          : ""
        }
        
        <div class="institution-details">
        ${rangeInfo
          ? `<div class="detail-item"><strong>${institution.type === "preschool" ? "Возраст:" : institution.type === "school" || institution.type === "school_internat" ? "Классы:" : "Диапазон:"}</strong> ${esc(rangeInfo)}</div>`
          : ""
        }
          <div class="detail-item"><strong>Округ:</strong> ${esc(this.districts[institution.district_id] || "Неизвестный округ")}</div>
        </div>
        
        ${conditionsSection}
        ${admissionSection}
        ${institution.address 
            ? `<div class="detail-item detail-item-address"><strong>Адрес:</strong><span class="detail-value">${esc(institution.address.trim())}</span></div>` 
            : ""
        }
        ${aoopSection}
        
        ${institution.director && institution.director.name
          ? `
          <div class="institution-contacts">
            <div class="contact-item"><strong>Руководитель:</strong> ${esc(institution.director.name)}</div>
            ${institution.director.phone
            ? `<div class="contact-item"><strong>Телефон:</strong> ${esc(institution.director.phone)}</div>`
            : ""
          }
            ${institution.director.email
            ? `<div class="contact-item"><strong>Email:</strong> ${esc(this.formatEmailForDisplay(institution.director.email))}</div>`
            : ""
          }
          </div>
        `
          : ""
        }
        
        ${institution.website
          ? `
          <div class="contact-item contact-item-link">
            <strong>Сайт:</strong> ${this.renderTruncatedLink(institution.website)}
          </div>
        `
          : ""
        }
        
        ${adminButtons}
      </div>
    `;
    },
  
    clearInstitutionForm() {
      document.getElementById('institutionForm').reset();
      document.getElementById('aoopList').innerHTML = '';
      document.getElementById('institutionAddress').value = '';
      document.getElementById('rangeMin').value = '';
      document.getElementById('rangeMax').value = '';
      document.getElementById('rangeMin').removeAttribute('min');
      document.getElementById('rangeMin').removeAttribute('max');
      document.getElementById('rangeMax').removeAttribute('min');
      document.getElementById('rangeMax').removeAttribute('max');
  
      this.editingInstitution = null;
      document.getElementById('institutionModalTitle').textContent = 'Добавить учреждение';
    },
  
    handlePrevPage() {
      if (this.currentPage > 1) {
        this.loadInstitutionsForDistrict(this.currentDistrictName, {
          page: this.currentPage - 1,
          scroll: true,
        });
      }
    },

    handleNextPage() {
      if (this.currentPage < this.totalPages) {
        this.loadInstitutionsForDistrict(this.currentDistrictName, {
          page: this.currentPage + 1,
          scroll: true,
        });
      }
    },

    handlePageClick(page) {
      const targetPage = parseInt(page, 10);
      if (Number.isFinite(targetPage) && targetPage !== this.currentPage) {
        this.loadInstitutionsForDistrict(this.currentDistrictName, {
          page: targetPage,
          scroll: true,
        });
      }
    },

    scrollToInstitutions() {
      const section = document.querySelector(".institutions-section");
      if (!section) return;

      section.scrollTo({ top: 0, behavior: "smooth" });
    },
  
  });