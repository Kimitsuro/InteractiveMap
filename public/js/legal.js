(function () {
  const STORAGE_KEY = 'cookieNoticeAccepted';

  function initCookieNotice() {
    if (localStorage.getItem(STORAGE_KEY) === 'true') {
      return;
    }

    const notice = document.getElementById('cookieNotice');
    const acceptBtn = document.getElementById('cookieNoticeAccept');
    if (!notice || !acceptBtn) {
      return;
    }

    notice.classList.remove('hidden');
    acceptBtn.addEventListener('click', () => {
      localStorage.setItem(STORAGE_KEY, 'true');
      notice.classList.add('hidden');
    });
  }

  document.addEventListener('DOMContentLoaded', initCookieNotice);
})();
