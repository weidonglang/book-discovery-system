document.addEventListener('DOMContentLoaded', async () => {
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();

  const wrap = document.getElementById('recommend-result');

  try {
    const currentUser = await BookApi.fetchCurrentUser();
    if (currentUser) {
      document.getElementById('recommend-user').textContent =
        `${currentUser.firstName || ''} ${currentUser.lastName || ''}`.trim() || currentUser.email;
    }

    const res = await BookApi.apiRequest('/api/book/recommendations/overview');
    wrap.innerHTML = BookUi.renderRecommendationShelves(res?.body, {
      emptyMessage: 'No recommendations available for the current account.'
    });
  } catch (error) {
    wrap.innerHTML = `<div class="card">Failed to load recommendations: ${escapeHtml(error.message)}</div>`;
  }
});

function escapeHtml(value) {
  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}
