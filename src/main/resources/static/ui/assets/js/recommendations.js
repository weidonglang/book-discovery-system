function escapeHtml(value) {
  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function buildOverviewQuery(recentDays) {
  if (!recentDays) {
    return '/api/book/recommendations/overview';
  }
  return `/api/book/recommendations/overview?recentDays=${encodeURIComponent(recentDays)}`;
}

function updateWindowCopy(recentDays) {
  const copyEl = document.getElementById('recommend-window-copy');
  if (!copyEl) return;
  copyEl.textContent = window.BookI18n.t('recommendations.currentWindow', { days: recentDays });
}

async function loadRecommendationOverview(recentDays) {
  const wrap = document.getElementById('recommend-result');
  wrap.innerHTML = `<div class="card">${escapeHtml(window.BookI18n.t('recommendations.loading'))}</div>`;
  updateWindowCopy(recentDays);

  try {
    const response = await BookApi.apiRequest(buildOverviewQuery(recentDays));
    wrap.innerHTML = BookUi.renderRecommendationShelves(response?.body, {
      emptyMessage: window.BookI18n.t('recommendations.empty'),
      getShelfScrollSize: (shelf, index) => index === 0 ? 'scroll-size-xl' : 'scroll-size-lg'
    });
    BookUi.refreshSaveButtons(wrap);
    BookUi.refreshScrollShells(wrap);
  } catch (error) {
    wrap.innerHTML = `<div class="card">${escapeHtml(window.BookI18n.t('recommendations.loadFailed', { message: error.message }))}</div>`;
  }
}

document.addEventListener('DOMContentLoaded', async () => {
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();

  const windowSelect = document.getElementById('recommend-window');

  try {
    const currentUser = await BookApi.fetchCurrentUser();
    if (currentUser) {
      document.getElementById('recommend-user').textContent =
        `${currentUser.firstName || ''} ${currentUser.lastName || ''}`.trim() || currentUser.email;
    }
  } catch (error) {
    document.getElementById('recommend-user').textContent = window.BookI18n.t('common.unavailable');
  }

  await loadRecommendationOverview(windowSelect.value);

  windowSelect.addEventListener('change', () => {
    loadRecommendationOverview(windowSelect.value);
  });
});
