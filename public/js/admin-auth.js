// ============================================================
// admin-auth.js — Авторизация: проверка сессии, вход, выход,
//                 отображение/скрытие панели администратора
// ============================================================

Object.assign(AdminManager.prototype, {

    async checkSession() {
      try {
        const response = await fetch('/api/check_session.php', { credentials: 'same-origin' });
        const data = await response.json();
        if (data.loggedIn && window.IS_ADMIN_ROUTE) {
          this.map.isAdmin = true;
          if (data.csrfToken) {
            this.map.csrfToken = data.csrfToken;
          }
          this.showAdminPanel();
          if (!document.getElementById("districtModal").classList.contains("hidden")) {
            const districtName = document.getElementById("regionName").textContent;
            await this.map.loadInstitutionsForDistrict(districtName);
          }
        }
      } catch (error) {
        console.error('Error checking session:', error);
      }
    },
  
    showLoginModal() {
      document.getElementById('loginModal').classList.remove('hidden');
    },
  
    hideLoginModal() {
      document.getElementById('loginModal').classList.add('hidden');
      document.getElementById('loginForm').reset();
    },
  
    async handleLogin(e) {
      e.preventDefault();
      const login = document.getElementById('adminLoginInput').value;
      const password = document.getElementById('adminPassword').value;
  
      try {
        const response = await fetch('/api/login.php', {
          method: 'POST',
          credentials: 'same-origin',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ login, password })
        });
        const data = await response.json();
        if (data.success) {
          this.map.isAdmin = true;
          if (data.csrfToken) {
            this.map.csrfToken = data.csrfToken;
          }
          this.showAdminPanel();
          this.hideLoginModal();
        } else {
          alert('Ошибка входа: ' + (data.error || 'Неизвестная ошибка'));
        }
      } catch (error) {
        console.error('Login error:', error);
        alert('Ошибка входа');
      }
    },
  
    async handleLogout() {
      try {
        await fetch('/api/logout.php', { method: 'POST', credentials: 'same-origin' });
        this.map.isAdmin = false;
        this.map.csrfToken = null;
        document.getElementById('adminPanel').classList.add('hidden');
        document.getElementById('adminLogin').classList.remove('hidden');
        if (!document.getElementById("districtModal").classList.contains("hidden")) {
          const districtName = document.getElementById("regionName").textContent;
          await this.map.loadInstitutionsForDistrict(districtName);
        }
      } catch (error) {
        console.error('Logout error:', error);
      }
    },
  
    showAdminPanel() {
      document.getElementById('adminLogin').classList.add('hidden');
      document.getElementById('adminPanel').classList.remove('hidden');
      document.getElementById('addInstitution').addEventListener('click', () => {
        this.map.editingInstitution = null;
        document.getElementById('institutionModalTitle').textContent = 'Добавить учреждение';
        document.getElementById('institutionModal').classList.remove('hidden');
        this.map.clearInstitutionForm();
      });
    },
  
  });