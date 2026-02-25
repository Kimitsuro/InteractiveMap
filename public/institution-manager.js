// institution-manager.js
class InstitutionManager extends DistrictHandler {
    async loadInstitutionsForDistrict(districtName) {
        const districtId = this.districtIdMap[districtName];
        if (!districtId) return;

        try {
            this.loaderTimeout = setTimeout(() => {
                this.showModalLoader();
            }, 200);

            const params = new URLSearchParams({ district_id: districtId });
            const response = await fetch(`/api/get_institutions.php?${params}`);
            if (!response.ok) throw new Error(`HTTP ${response.status}`);
            const data = await response.json();
            if (data.error) throw new Error(data.error);

            this.allInstitutions = Array.isArray(data.institutions) ? data.institutions : [];
            this.displayInstitutions(this.allInstitutions);

        } catch (error) {
            console.error('Error loading institutions:', error);
            document.getElementById("institutionsList").innerHTML = '<p>Ошибка загрузки учреждений</p>';
        } finally {
            if (this.loaderTimeout) {
                clearTimeout(this.loaderTimeout);
            }
            this.hideModalLoader();
        }
    }

    createInstitutionCard(institution) {
        const typeNames = {
            preschool: "Дошкольное",
            school: "Школа",
            school_internat: "Школа-интернат",
            spo: "СПО",
            vo: "ВО",
        };
        const conditionNames = {
            hearing_impairment: "Нарушения слуха",
            vision_impairment: "Нарушения зрения",
            musculoskeletal_impairment: "Нарушения опорно-двигательного аппарата",
            speech_impairment: "Нарушения речи",
            mental_retardation: "Задержка психического развития",
            autism: "Расстройство аутистического спектра",
            multiple_disorders: "Множественные нарушения развития",
        };
        const admissionNames = {
            certificate: "Свидетельство",
            attestat: "Аттестат",
        };

        let rangeInfo = "";
        if (institution.range_min !== null && institution.range_max !== null) {
            if (institution.type === "preschool") {
                rangeInfo = `${institution.range_min}-${institution.range_max} лет`;
            } else if (
                institution.type === "school" ||
                institution.type === "school_internat"
            ) {
                rangeInfo = `${institution.range_min}-${institution.range_max} классы`;
            } else {
                rangeInfo = `${institution.range_min}-${institution.range_max}`;
            }
        } else if (institution.range_min !== null) {
            if (institution.type === "preschool") {
                rangeInfo = `от ${institution.range_min} лет`;
            } else if (institution.type === "school" || institution.type === "school_internat") {
                rangeInfo = `от ${institution.range_min} класса`;
            } else {
                rangeInfo = `от ${institution.range_min}`;
            }
        } else if (institution.range_max !== null) {
            if (institution.type === "preschool") {
                rangeInfo = `до ${institution.range_max} лет`;
            } else if (institution.type === "school" || institution.type === "school_internat") {
                rangeInfo = `до ${institution.range_max} класса`;
            } else {
                rangeInfo = `до ${institution.range_max}`;
            }
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
                            `<span class="tag condition">${conditionNames[condition] || condition
                            }</span>`
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
                            `<span class="tag admission">${admissionNames[admission] || admission
                            }</span>`
                    )
                    .join("")}
          </div>
        </div>`
                : "";

        const aoopSection =
            institution.aoop_programs && institution.aoop_programs.length > 0
                ? `<div class="aoop-section">
          <h5>Реализуемые АООП:</h5>
          <ul class="aoop-list-card">
            ${institution.aoop_programs
                    .map(
                        (prog) => {
                            if (institution.aoop_url) {
                                return `<li><a href="${institution.aoop_url}" target="_blank">${prog.name}</a></li>`;
                            } else {
                                return `<li>${prog.name}</li>`;
                            }
                        }
                    )
                    .join("")}
          </ul>
          ${institution.aoop_url
                    ? `<div class="aoop-global-link"><strong>Общая ссылка на АООП:</strong> <a href="${institution.aoop_url}" target="_blank">${institution.aoop_url}</a></div>`
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
      <h4>${institution.name}</h4>
      <span class="institution-type">${typeNames[institution.type] || institution.type
            }</span>
      
      ${institution.description
                ? `<p class="institution-description">${institution.description}</p>`
                : ""
            }
      
      <div class="institution-details">
        ${rangeInfo
                ? `<div class="detail-item"><strong>${institution.type === "preschool" ? "Возраст:" : institution.type === "school" || institution.type === "school_internat" ? "Классы:" : "Диапазон:"}</strong> ${rangeInfo}</div>`
                : ""
            }
        <div class="detail-item"><strong>Район:</strong> ${this.districts[institution.district_id] || "Неизвестный район"
            }</div>
      </div>
      
      ${conditionsSection}
      ${admissionSection}
      ${aoopSection}
      
      ${institution.director && institution.director.name
                ? `
        <div class="institution-contacts">
          <div class="contact-item"><strong>Руководитель:</strong> ${institution.director.name
                }</div>
          ${institution.director.phone
                    ? `<div class="contact-item"><strong>Телефон:</strong> ${institution.director.phone}</div>`
                    : ""
                }
          ${institution.director.email
                    ? `<div class="contact-item"><strong>Email:</strong> ${institution.director.email}</div>`
                    : ""
                }
        </div>
      `
                : ""
            }
      
      ${institution.website
                ? `
        <div class="contact-item">
          <strong>Сайт:</strong> <a href="${institution.website}" target="_blank">${institution.website}</a>
        </div>
      `
                : ""
            }
      
      ${adminButtons}
    </div>
  `;
    }

    bindAdminActions() {
        document.querySelectorAll(".edit-btn").forEach((btn) => {
            btn.addEventListener("click", (e) => {
                const id = parseInt(e.target.dataset.id);
                this.editInstitution(id);
            });
        });

        document.querySelectorAll(".delete-btn").forEach((btn) => {
            btn.addEventListener("click", (e) => {
                const id = parseInt(e.target.dataset.id);
                this.deleteInstitution(id);
            });
        });
    }
}