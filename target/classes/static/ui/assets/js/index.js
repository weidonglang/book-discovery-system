document.addEventListener('DOMContentLoaded', async () => {
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();

  const categoryWrap = document.getElementById('category-list');
  const recommendWrap = document.getElementById('recommend-list');

  document.getElementById('quick-search-form').addEventListener('submit', event => {
    event.preventDefault();
    const keyword = document.getElementById('quick-keyword').value.trim();
    window.location.href = `books.html?keyword=${encodeURIComponent(keyword)}`;
  });

  try {
    await BookApi.fetchCurrentUser();
    const [categoryRes, recommendRes] = await Promise.all([
      BookApi.apiRequest('/api/book/find-all-categories'),
      BookApi.apiRequest('/api/book/recommendations/overview')
    ]);

    const categories = Array.isArray(categoryRes?.body) ? categoryRes.body : [];
    categoryWrap.innerHTML = categories.length
      ? categories.map(item => `<span class="tag">${item.name || item}</span>`).join('')
      : '<div class="muted">No category data available.</div>';

    recommendWrap.innerHTML = BookUi.renderRecommendationShelves(recommendRes?.body, {
      emptyMessage: 'No recommendation data available.'
    });
  } catch (error) {
    BookUi.showMessage('home-message', 'warning', `Failed to load home data: ${error.message}`);
  }
});
