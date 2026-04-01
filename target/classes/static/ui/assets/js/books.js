function buildBookFilterPayload(pageNumber = 1) {
  const selectedCategories = Array.from(document.querySelectorAll('input[name="category"]:checked')).map(x => Number(x.value));
  return {
    pageNumber,
    pageSize: Math.max(1, Number(document.getElementById('pageSize').value || 8)),
    sortingByList: [
      {
        fieldName: document.getElementById('sortField').value || 'id',
        direction: document.getElementById('sortDirection').value || 'ASC',
        isNumber: ['price', 'pagesNumber', 'readingDuration', 'rate', 'id'].includes(document.getElementById('sortField').value)
      }
    ],
    criteria: {
      name: document.getElementById('keyword').value.trim() || null,
      categories: selectedCategories,
      fromPrice: document.getElementById('fromPrice').value ? Number(document.getElementById('fromPrice').value) : null,
      toPrice: document.getElementById('toPrice').value ? Number(document.getElementById('toPrice').value) : null,
      fromPagesNumber: document.getElementById('fromPagesNumber').value ? Number(document.getElementById('fromPagesNumber').value) : null,
      toPagesNumber: document.getElementById('toPagesNumber').value ? Number(document.getElementById('toPagesNumber').value) : null,
      fromReadingDuration: document.getElementById('fromReadingDuration').value ? Number(document.getElementById('fromReadingDuration').value) : null,
      toReadingDuration: document.getElementById('toReadingDuration').value ? Number(document.getElementById('toReadingDuration').value) : null
    },
    deletedRecords: false
  };
}

async function loadBooks(pageNumber = 1) {
  const target = document.getElementById('book-results');
  target.innerHTML = '<div class="card muted">正在加载图书列表...</div>';
  try {
    const response = await BookApi.apiRequest('/api/book/find-all-paginated-filtered', {
      method: 'POST',

      body: buildBookFilterPayload(pageNumber)
    });
    const pagination = BookApi.parsePaginationResult(response);
    target.innerHTML = pagination.list.length
      ? pagination.list.map(book => BookUi.renderBookCard(book)).join('')
      : '<div class="card muted">没有搜索到图书。</div>';
    const currentPage = Math.max(1, Number(pagination.pageNumber || pageNumber));
    document.getElementById('page-summary').textContent = `第 ${currentPage} 页 / 共 ${pagination.totalNumberOfPages || 1} 页，共 ${pagination.totalNumberOfElements} 条记录`;
    document.getElementById('currentPage').value = String(currentPage);
  } catch (error) {
    target.innerHTML = `<div class="card">加载失败：${error.message}</div>`;
  }
}

document.addEventListener('DOMContentLoaded', async () => {
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();
  const params = new URLSearchParams(window.location.search);
  if (params.get('keyword')) document.getElementById('keyword').value = params.get('keyword');
  if (params.get('authorId')) {
    BookUi.showMessage('books-message', 'info', `当前为作者作品模式。authorId=${params.get('authorId')}；如需更严格对接，可继续在后端补一个按作者分页接口。`);
  }

  try {
    const categoryRes = await BookApi.apiRequest('/api/book/find-all-categories');
    const categories = Array.isArray(categoryRes?.body) ? categoryRes.body : [];
    document.getElementById('category-filters').innerHTML = categories.map(item => `
      <label style="display:flex;gap:8px;align-items:center;">
        <input type="checkbox" name="category" value="${item.id}">
        <span>${item.name}</span>
      </label>`).join('');
  } catch (error) {
    BookUi.showMessage('books-message', 'warning', `分类加载失败：${error.message}`);
  }

  document.getElementById('filter-form').addEventListener('submit', (e) => {
    e.preventDefault();
    loadBooks(1);
  });

  document.getElementById('prev-page').addEventListener('click', () => {
    const page = Math.max(1, Number(document.getElementById('currentPage').value || 1) - 1);
    loadBooks(page);
  });
  document.getElementById('next-page').addEventListener('click', () => {
    const page = Number(document.getElementById('currentPage').value || 1) + 1;
    loadBooks(page);
  });

  loadBooks(1);
});
