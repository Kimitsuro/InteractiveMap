// ============================================================
// admin.js — Класс AdminManager: конструктор, init, bindEvents.
// ============================================================

class AdminManager {
    constructor(map) {
      this.map = map;
      this.aoopCounter = 0;
      this.init();
    }
  
    init() {
      if (!window.IS_ADMIN_ROUTE) {
        return;
      }
      document.getElementById('adminLogin').classList.remove('hidden');
      this.bindEvents();
      this.checkSession();
    }
  
    bindEvents() {
      document.getElementById('adminLogin').addEventListener('click', () => this.showLoginModal());
      document.getElementById('loginForm').addEventListener('submit', (e) => this.handleLogin(e));
      document.getElementById('cancelLogin').addEventListener('click', () => this.hideLoginModal());
      document.getElementById('closeLoginModal').addEventListener('click', () => this.hideLoginModal());
      document.getElementById('logout').addEventListener('click', () => this.handleLogout());
      this.map.openInstitutionForm = (inst = null) => this.openInstitutionForm(inst);
      this.map.editInstitution = (id) => this.editInstitution(id);
      this.map.deleteInstitution = (id) => this.deleteInstitution(id);
  
      document.getElementById('institutionForm').addEventListener('submit', (e) => {
        e.preventDefault();
        this.saveInstitution();
      });
      document.getElementById('addAoOp').addEventListener('click', () => {
        this.addAoOpField();
      });
      document.getElementById('institutionType').addEventListener('change', (e) => {
        this.toggleFormFields(e.target.value);
      });
      this.bindPhoneValidation();
    }

    bindPhoneValidation() {
      const input = document.getElementById('directorPhone');
      const hint = document.getElementById('directorPhoneHint');
      if (!input || !hint) return;

      const defaultHint = 'Можно вводить с +7, скобками и дефисами — при сохранении номер приведётся к стандартному виду';

      input.addEventListener('input', () => {
        const invalidChars = this.map.getInvalidPhoneCharacters(input.value);
        if (invalidChars.length > 0) {
          hint.textContent = `Недопустимые символы: ${invalidChars.join(', ')}`;
          hint.classList.add('field-error');
          input.classList.add('input-invalid');
        } else {
          hint.textContent = defaultHint;
          hint.classList.remove('field-error');
          input.classList.remove('input-invalid');
        }
      });
    }
  }