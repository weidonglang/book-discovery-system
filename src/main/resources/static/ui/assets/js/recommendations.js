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
  copyEl.textContent = `Popular shelves are currently using a ${recentDays}-day activity window. The popularity model weighs borrows x5, detail clicks x3, and rating count x2.`;
}

async function loadRecommendationOverview(recentDays) {
  const wrap = document.getElementById('recommend-result');
  wrap.innerHTML = '<div class="card">Loading recommendations...</div>';
  updateWindowCopy(recentDays);

  try {
    const response = await BookApi.apiRequest(buildOverviewQuery(recentDays));
    wrap.innerHTML = BookUi.renderRecommendationShelves(response?.body, {
      emptyMessage: 'No recommendation shelves are available for the current account.'
    });
  } catch (error) {
    wrap.innerHTML = `<div class="card">Failed to load recommendations: ${escapeHtml(error.message)}</div>`;
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
    document.getElementById('recommend-user').textContent = 'Unavailable';
  }

  await loadRecommendationOverview(windowSelect.value);

  windowSelect.addEventListener('change', () => {
    loadRecommendationOverview(windowSelect.value);
  });
});
