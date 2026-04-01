document.addEventListener('DOMContentLoaded', async () => {
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();
  const wrap = document.getElementById('recommend-result');
  try {
    const currentUser = await BookApi.fetchCurrentUser();
    if (currentUser) {
      document.getElementById('recommend-user').textContent = `${currentUser.firstName || ''} ${currentUser.lastName || ''}`.trim() || currentUser.email;
    }
    const res = await BookApi.apiRequest('/api/book/find-all-recommended');
    const books = Array.isArray(res?.body) ? res.body : [];
    wrap.innerHTML = books.length
      ? books.map((book, index) => BookUi.renderBookCard(book, { comment: `推荐理由骨架：当前仓库只有“推荐结果接口”，后续你可以把真实解释绑定到这里。推荐序号 #${index + 1}` })).join('')
      : '<div class="card muted">暂无推荐结果。</div>';
  } catch (error) {
    wrap.innerHTML = `<div class="card">推荐加载失败：${error.message}</div>`;
  }
});
