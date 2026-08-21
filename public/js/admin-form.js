// ============================================================
// admin-form.js — Форма учреждения: открытие/заполнение,
//                 toggleFormFields, addAoOpField, collectFormData
// ============================================================

Object.assign(AdminManager.prototype, {

    addAoOpField() {
      const aoopList = document.getElementById("aoopList");
      const field = document.createElement("div");
      field.className = "aoop-field form-group";
      field.innerHTML = `
      <input type="text" class="aoop-name" placeholder="Название программы">
      <button type="button" class="remove-aoop btn btn-danger">Удалить</button>
    `;
      aoopList.appendChild(field);
      field.querySelector(".remove-aoop").addEventListener("click", () => {
        field.remove();
      });
    },
  
    openInstitutionForm(inst = null) {
      if (inst) {
        document.getElementById('institutionName').value = inst.name || '';
        document.getElementById('districtId').value = inst.district_id ? inst.district_id.toString() : '';
        document.getElementById('institutionDescription').value = inst.description || '';
        document.getElementById('institutionType').value = inst.type || '';
        document.getElementById('institutionAddress').value = inst.address || '';
        document.getElementById('directorName').value = inst.director ? inst.director.name : '';
        document.getElementById('directorPhone').value = inst.director ? inst.director.phone : '';
        document.getElementById('directorEmail').value = inst.director ? inst.director.email : '';
        document.getElementById('institutionWebsite').value = inst.website || '';
        document.getElementById('rangeMin').value = inst.range_min || '';
        document.getElementById('rangeMax').value = inst.range_max || '';
  
        document.getElementById('institutionAoopUrl').value = inst.aoop_url || '';
  
        document.querySelectorAll('input[name="admission"]').forEach(cb => {
          cb.checked = false;
        });
        if (inst.conditionsAdmission && Array.isArray(inst.conditionsAdmission)) {
          inst.conditionsAdmission.forEach(code => {
            const cb = document.querySelector(`input[name="admission"][value="${code}"]`);
            if (cb) cb.checked = true;
          });
        }
  
        document.querySelectorAll('#institutionForm input[type="checkbox"]:not([name="admission"])').forEach(cb => {
          cb.checked = false;
        });
        if (inst.conditions && Array.isArray(inst.conditions)) {
          inst.conditions.forEach(code => {
            const cb = document.querySelector(`#institutionForm input[value="${code}"]`);
            if (cb) cb.checked = true;
          });
        }

        const aoopList = document.getElementById('aoopList');
        aoopList.innerHTML = '';
        if (inst.aoop_programs && Array.isArray(inst.aoop_programs)) {
          inst.aoop_programs.forEach(prog => {
            this.addAoOpField();
            const fields = aoopList.querySelectorAll('.aoop-field');
            const lastField = fields[fields.length - 1];
            lastField.querySelector('.aoop-name').value = prog.name || '';
          });
        }
  
        this.toggleFormFields(inst.type);
  
        document.getElementById('institutionModalTitle').textContent = 'Редактировать учреждение';
      if (this.map.pendingListPage == null) {
        this.map.pendingListPage = this.map.getListPage();
      }
      this.map.editingInstitution = inst;
        document.getElementById('institutionModal').classList.remove('hidden');
      } else {
        this.map.clearInstitutionForm();
        this.toggleFormFields('school');
        document.getElementById('institutionModal').classList.remove('hidden');
      }
    },
  
    toggleFormFields(type) {
      const group = document.getElementById("rangeGroup");
      const label = document.getElementById("rangeLabel");
      const unit = document.getElementById("rangeUnit");
      const attestatCheckbox = document.getElementById("doc_attestat");
      const certificateCheckbox = document.getElementById("doc_certificate");
      const rangeMin = document.getElementById("rangeMin");
      const rangeMax = document.getElementById("rangeMax");

      if (attestatCheckbox) {
        attestatCheckbox.disabled = false;
        attestatCheckbox.parentElement.style.opacity = "1";
        if (certificateCheckbox) {
          certificateCheckbox.disabled = false;
          certificateCheckbox.parentElement.style.opacity = "1";
        }
        const restrictedTypes = ["preschool", "school", "school_internat"];
        if (restrictedTypes.includes(type)) {
          attestatCheckbox.checked = false;
          attestatCheckbox.disabled = true;
          attestatCheckbox.parentElement.style.opacity = "0.5";
        }
      }

      if (!group) return;

      group.classList.remove("hidden");

      if (type === "preschool") {
        if (label) label.textContent = "Возрастной диапазон";
        if (rangeMin) {
          rangeMin.placeholder = "От (лет)";
          rangeMin.min = "1.5";
          rangeMin.max = "8";
          rangeMin.step = "0.5";
        }
        if (rangeMax) {
          rangeMax.placeholder = "До (лет)";
          rangeMax.min = "1";
          rangeMax.max = "8";
          rangeMax.step = "0.5";
        }
        if (unit) unit.textContent = "(лет)";
      } else if (type === "school" || type === "school_internat") {
        if (label) label.textContent = "Диапазон классов";
        if (rangeMin) {
          rangeMin.placeholder = "От (класс)";
          rangeMin.min = "1";
          rangeMin.max = "11";
          rangeMin.step = "1";
        }
        if (rangeMax) {
          rangeMax.placeholder = "До (класс)";
          rangeMax.min = "1";
          rangeMax.max = "11";
          rangeMax.step = "1";
        }
        if (unit) unit.textContent = "(классов)";
      } else {
        group.classList.add("hidden");
        if (rangeMin) rangeMin.value = "";
        if (rangeMax) rangeMax.value = "";
      }
    },
  
    collectFormData() {
      const name = document.getElementById('institutionName').value.trim();
      const districtId = parseInt(document.getElementById('districtId').value);
      const type = document.getElementById('institutionType').value;
      const description = document.getElementById('institutionDescription').value.trim();
      const address = document.getElementById('institutionAddress').value.trim();
      const website = document.getElementById('institutionWebsite').value.trim();
      const aoopUrl = document.getElementById('institutionAoopUrl').value.trim();
      const rangeMin = document.getElementById('rangeMin').value ? parseFloat(document.getElementById('rangeMin').value) : null;
      const rangeMax = document.getElementById('rangeMax').value ? parseFloat(document.getElementById('rangeMax').value) : null;
      const directorName = document.getElementById('directorName').value.trim();
  
      const formData = {
        name: name,
        district_id: districtId,
        type: type,
        description: description || null,
        address: address || null,
        website: website || null,
        aoop_url: aoopUrl || null,
        range: {
          min: rangeMin,
          max: rangeMax
        },
        conditions: [],
        conditionsAdmission: [],
        aoop_programs: [],
        director: {
          name: directorName
        }
      };
  
      if (!formData.name || !formData.type || !formData.district_id) {
        throw new Error("Заполните обязательные поля: Название, Тип и Район");
      }
  
      document.querySelectorAll('input[name="admission"]:checked').forEach((cb) => {
        formData.conditionsAdmission.push(cb.value);
      });
  
      document.querySelectorAll('#institutionForm input[type="checkbox"]:not([name="admission"]):checked').forEach((cb) => {
        formData.conditions.push(cb.value);
      });
  
      document.querySelectorAll(".aoop-field").forEach((field) => {
        const name = field.querySelector(".aoop-name").value.trim();
        if (name) {
          formData.aoop_programs.push({ name });
        }
      });
  
      const directorPhone = document.getElementById('directorPhone').value.trim();
      const directorEmail = document.getElementById('directorEmail').value.trim();

      if (directorPhone) {
        const invalidChars = this.map.getInvalidPhoneCharacters(directorPhone);
        if (invalidChars.length > 0) {
          throw new Error(`Телефон содержит недопустимые символы: ${invalidChars.join(', ')}`);
        }
        formData.director.phone = this.map.normalizePhone(directorPhone);
      }
      if (directorEmail) formData.director.email = directorEmail;
  
      if (this.map.editingInstitution && this.map.editingInstitution.director?.id) {
        formData.director.id = this.map.editingInstitution.director.id;
      }
  
      if (this.map.editingInstitution) {
        formData.id = this.map.editingInstitution.id;
      }
  
      return formData;
    },
  
  });