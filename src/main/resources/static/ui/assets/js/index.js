document.addEventListener('DOMContentLoaded', async () => {
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();
  const categoryWrap = document.getElementById('category-list');
  const recommendWrap = document.getElementById('recommend-list');

  document.getElementById('quick-search-form').addEventListener('submit', (e) => {
    e.preventDefault();
    const keyword = document.getElementById('quick-keyword').value.trim();
    window.location.href = `books.html?keyword=${encodeURIComponent(keyword)}`;
  });

  try {
    await BookApi.fetchCurrentUser();
    const [categoryRes, recommendRes] = await Promise.all([
      BookApi.apiRequest('/api/book/find-all-categories'),
      BookApi.apiRequest('/api/book/find-all-recommended')
    ]);

    const categories = Array.isArray(categoryRes?.body) ? categoryRes.body : [];
    categoryWrap.innerHTML = categories.length
      ? categories.map(item => `<span class="tag">${item.name || item}</span>`).join('')
      : '<div class="muted">暂无分类数据</div>';

    const books = Array.isArray(recommendRes?.body) ? recommendRes.body : [];
    recommendWrap.innerHTML = books.length
      ? books.slice(0, 6).map(book => BookUi.renderBookCard(book)).join('')
      : '<div class="card muted">暂无推荐数据</div>';
  } catch (error) {
    BookUi.showMessage('home-message', 'warning', `首页数据加载失败：${error.message}`);
  }
});
