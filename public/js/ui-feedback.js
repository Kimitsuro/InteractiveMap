// ============================================================
// ui-feedback.js — Toast, form errors, confirm modal
// ============================================================

(function (global) {
  let toastTimer = null;
  let confirmResolve = null;

  function getToast() {
    return document.getElementById('appToast');
  }

  function getConfirmModal() {
    return document.getElementById('confirmModal');
  }

  function showToast(message, type = 'info') {
    const el = getToast();
    if (!el) return;
    el.textContent = message;
    el.className = 'app-toast app-toast--' + type;
    el.classList.remove('hidden');
    el.setAttribute('role', 'status');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => {
      el.classList.add('hidden');
    }, 4200);
  }

  function setFormError(el, message) {
    if (!el) return;
    if (!message) {
      el.textContent = '';
      el.classList.add('hidden');
      return;
    }
    el.textContent = message;
    el.classList.remove('hidden');
  }

  function closeConfirm(result) {
    const modal = getConfirmModal();
    if (modal) modal.classList.add('hidden');
    if (confirmResolve) {
      const resolve = confirmResolve;
      confirmResolve = null;
      resolve(result);
    }
  }

  function showConfirm(message) {
    const modal = getConfirmModal();
    const text = document.getElementById('confirmModalMessage');
    if (!modal || !text) {
      return Promise.resolve(window.confirm(message));
    }
    text.textContent = message;
    modal.classList.remove('hidden');
    return new Promise((resolve) => {
      confirmResolve = resolve;
    });
  }

  function initConfirmModal() {
    const modal = getConfirmModal();
    if (!modal || modal.dataset.bound === '1') return;
    modal.dataset.bound = '1';
    document.getElementById('confirmModalOk')?.addEventListener('click', () => closeConfirm(true));
    document.getElementById('confirmModalCancel')?.addEventListener('click', () => closeConfirm(false));
    document.getElementById('closeConfirmModal')?.addEventListener('click', () => closeConfirm(false));
    modal.addEventListener('click', (e) => {
      if (e.target === modal) closeConfirm(false);
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initConfirmModal);
  } else {
    initConfirmModal();
  }

  global.UiFeedback = {
    showToast,
    setFormError,
    showConfirm,
  };
})(window);
