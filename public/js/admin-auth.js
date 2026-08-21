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
    },

    hideActionLog() {
      document.getElementById('actionLogModal')?.classList.add('hidden');
    },

    async openActionLog() {
      const modal = document.getElementById('actionLogModal');
      const list = document.getElementById('actionLogList');
      if (!modal || !list) return;
      modal.classList.remove('hidden');
      list.textContent = 'Загрузка…';
      try {
        const response = await fetch('/api/get_action_log.php?limit=50', { credentials: 'same-origin' });
        if (!response.ok) throw new Error('HTTP ' + response.status);
        const data = await response.json();
        if (!data.logs || data.logs.length === 0) {
          list.textContent = 'Записей пока нет';
          return;
        }
        const esc = (v) => this.map.escapeHtml(v);
        list.innerHTML = data.logs.map((row) => {
          const when = esc(row.created_at || '');
          const who = esc(row.admin_login || row.admin_name || '—');
          const action = esc(row.action || '');
          const entity = esc(row.entity || '');
          const rid = esc(row.record_id ?? '');
          return `<div class="action-log-row"><strong>${when}</strong> — ${who}: ${action} ${entity} #${rid}</div>`;
        }).join('');
      } catch (error) {
        console.error('Action log error:', error);
        list.textContent = 'Не удалось загрузить журнал';
      }
    },
  
  });