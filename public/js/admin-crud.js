// ============================================================
// admin-crud.js — CRUD-операции над учреждениями:
//                 редактирование, удаление, сохранение
// ============================================================

Object.assign(AdminManager.prototype, {

  async editInstitution(id) {
    try {
      const restorePage = this.map.getListPage();
      const districtId = this.map.displayedInstitutions.find(inst => inst.id === id)?.district_id
        || this.map.resolveDistrictId(this.map.currentDistrictName)
        || this.map.resolveDistrictId(document.getElementById("regionName")?.textContent)
        || 1;
      const params = new URLSearchParams({ district_id: districtId, id });
      const response = await fetch(`/api/get_institution.php?${params}`);
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const data = await response.json();
      if (data.error || !data.institution) {
        throw new Error('Учреждение не найдено');
      }
      this.map.pendingListPage = restorePage;
      this.openInstitutionForm(data.institution);
    } catch (error) {
      console.error('Error loading for edit:', error);
      alert('Ошибка загрузки для редактирования: ' + error.message);
    }
  },

  async deleteInstitution(id) {
    if (!confirm("Вы уверены, что хотите удалить это учреждение?")) return;
    const restorePage = this.map.getListPage();
    try {
      const response = await fetch('/api/delete_institution.php', {
        method: 'POST',
        credentials: 'same-origin',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id })
      });
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const result = await response.json();
      if (result.error) throw new Error(result.error);
      if (!document.getElementById("districtModal").classList.contains("hidden")) {
        const districtName = document.getElementById("regionName").textContent;
        await this.map.loadInstitutionsForDistrict(districtName, { page: restorePage, scroll: true });
      }
    } catch (error) {
      console.error('Error deleting institution:', error);
      alert('Ошибка удаления');
    }
  },

  async saveInstitution() {
    try {
      const restorePage = this.map.pendingListPage ?? this.map.getListPage();
      const data = this.collectFormData();

      const url = (this.map.editingInstitution && this.map.editingInstitution.id)
        ? '/api/update_institution.php'
        : '/api/create_institution.php';

      const response = await fetch(url, {
        method: 'POST',
        credentials: 'same-origin',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      });

      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const result = await response.json();

      if (result.error) throw new Error(result.error);

      document.getElementById("institutionModal").classList.add("hidden");
      this.map.clearInstitutionForm();
      if (!document.getElementById("districtModal").classList.contains("hidden")) {
        const districtName = document.getElementById("regionName").textContent;
        await this.map.loadInstitutionsForDistrict(districtName, { page: restorePage, scroll: true });
      }

      this.map.pendingListPage = null;

    } catch (error) {
      console.error('Error saving institution:', error);
      alert(`Ошибка: ${error.message}`);
    }
  },

});