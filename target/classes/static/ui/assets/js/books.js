function escapeHtml(value) {
  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

let allAuthors = [];

function getCheckedValues(name) {
  return Array.from(document.querySelectorAll(`input[name="${name}"]:checked`))
    .map(input => Number(input.value))
    .filter(value => Number.isFinite(value));
}

function toNullableArray(values) {
  return values.length ? values : null;
}

function buildBookFilterPayload(pageNumber = 1) {
  const sortField = document.getElementById('sortField').value || 'id';
  const criteria = {
    name: document.getElementById('keyword').value.trim() || null,
    categories: toNullableArray(getCheckedValues('category')),
    authors: toNullableArray(getCheckedValues('author')),
    publishers: toNullableArray(getSelectedValues('publisher-filter')),
    tags: toNullableArray(getCheckedValues('tag')),
    fromPrice: document.getElementById('fromPrice').value ? Number(document.getElementById('fromPrice').value) : null,
    toPrice: document.getElementById('toPrice').value ? Number(document.getElementById('toPrice').value) : null,
    fromPagesNumber: document.getElementById('fromPagesNumber').value ? Number(document.getElementById('fromPagesNumber').value) : null,
    toPagesNumber: document.getElementById('toPagesNumber').value ? Number(document.getElementById('toPagesNumber').value) : null,
    fromReadingDuration: document.getElementById('fromReadingDuration').value ? Number(document.getElementById('fromReadingDuration').value) : null,
    toReadingDuration: document.getElementById('toReadingDuration').value ? Number(document.getElementById('toReadingDuration').value) : null
  };
  const hasCriteria = Object.values(criteria).some(value => value !== null);

  return {
    pageNumber,
    pageSize: Math.max(1, Number(document.getElementById('pageSize').value || 8)),
    sortingByList: [
      {
        fieldName: sortField,
        direction: document.getElementById('sortDirection').value || 'ASC',
        isNumber: ['price', 'pagesNumber', 'readingDuration', 'rate', 'id', 'availableCopies'].includes(sortField)
      }
    ],
    criteria: hasCriteria ? criteria : null,
    deletedRecords: false
  };
}

function getSelectedValues(selectId) {
  return Array.from(document.getElementById(selectId).selectedOptions)
    .map(option => Number(option.value))
    .filter(value => Number.isFinite(value));
}

function renderCheckboxList(targetId, name, items) {
  const target = document.getElementById(targetId);
  target.innerHTML = items.map(item => `
    <label class="filter-option">
      <input type="checkbox" name="${name}" value="${item.id}">
      <span>${escapeHtml(item.name)}</span>
    </label>`).join('');
}

function renderSelectOptions(targetId, items, emptyLabel) {
  const select = document.getElementById(targetId);
  select.innerHTML = items.length
    ? items.map(item => `<option value="${item.id}">${escapeHtml(item.name)}</option>`).join('')
    : `<option disabled>${escapeHtml(emptyLabel)}</option>`;
}

function renderAuthorPicker() {
  const container = document.getElementById('author-filter');
  const summary = document.getElementById('author-selected');
  const selectedIds = new Set(getCheckedValues('author').map(String));
  const query = document.getElementById('author-search').value.trim().toLowerCase();
  const filteredAuthors = allAuthors.filter(author => author.name.toLowerCase().includes(query));

  container.innerHTML = filteredAuthors.length
    ? filteredAuthors.map(author => `
      <label class="filter-option">
        <input type="checkbox" name="author" value="${author.id}" ${selectedIds.has(String(author.id)) ? 'checked' : ''}>
        <span>${escapeHtml(author.name)}</span>
      </label>`).join('')
    : '<div class="muted">No authors matched the current search.</div>';

  const selectedAuthors = allAuthors.filter(author => selectedIds.has(String(author.id)));
  summary.innerHTML = selectedAuthors.length
    ? selectedAuthors.map(author => `<span class="tag">${escapeHtml(author.name)}</span>`).join('')
    : '<span class="muted">No authors selected.</span>';
}

function setAuthorSelection(authorIds) {
  const selectedSet = new Set((authorIds || []).map(String));
  document.querySelectorAll('input[name="author"]').forEach(input => {
    input.checked = selectedSet.has(input.value);
  });
  renderAuthorPicker();
}

function applyQueryDefaults(authors) {
  const params = new URLSearchParams(window.location.search);
  const keyword = params.get('keyword');
  const authorId = params.get('authorId');

  if (keyword) {
    document.getElementById('keyword').value = keyword;
  }

  if (authorId) {
    const availableIds = new Set(authors.map(author => String(author.id)));
    if (availableIds.has(String(authorId))) {
      setAuthorSelection([authorId]);
      BookUi.showMessage('books-message', 'info', 'Author filter was preselected from the previous page.');
    }
  }
}

async function loadBooks(pageNumber = 1) {
  const target = document.getElementById('book-results');
  target.innerHTML = '<div class="card muted">Loading books...</div>';

  try {
    const response = await BookApi.apiRequest('/api/book/find-all-paginated-filtered', {
      method: 'POST',
      body: buildBookFilterPayload(pageNumber)
    });
    const pagination = BookApi.parsePaginationResult(response);
    const currentPage = Math.max(1, Number(pagination.pageNumber || pageNumber));

    target.innerHTML = pagination.list.length
      ? pagination.list.map(book => BookUi.renderBookCard(book)).join('')
      : '<div class="card muted">No books matched the current filters.</div>';

    document.getElementById('page-summary').textContent =
      `Page ${currentPage} / ${pagination.totalNumberOfPages || 1}, total ${pagination.totalNumberOfElements} books`;
    document.getElementById('currentPage').value = String(currentPage);
  } catch (error) {
    target.innerHTML = `<div class="card">Failed to load books: ${escapeHtml(error.message)}</div>`;
  }
}

function resetSearchForm() {
  document.getElementById('filter-form').reset();
  document.querySelectorAll('#category-filters input[type="checkbox"], #tag-filters input[type="checkbox"], #author-filter input[type="checkbox"]').forEach(input => {
    input.checked = false;
  });
  ['publisher-filter'].forEach(selectId => {
    Array.from(document.getElementById(selectId).options).forEach(option => {
      option.selected = false;
    });
  });
  document.getElementById('author-search').value = '';
  renderAuthorPicker();
  document.getElementById('pageSize').value = '8';
  document.getElementById('sortField').value = 'id';
  document.getElementById('sortDirection').value = 'ASC';
}

document.addEventListener('DOMContentLoaded', async () => {
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();

  try {
    const [categoryRes, tagRes, publisherRes, authorRes] = await Promise.all([
      BookApi.apiRequest('/api/book/find-all-categories'),
      BookApi.apiRequest('/api/tag'),
      BookApi.apiRequest('/api/publisher'),
      BookApi.apiRequest('/api/author/find-all-paginated-filtered', {
        method: 'POST',
        body: {
          pageNumber: 1,
          pageSize: 300,
          sortingByList: [{ fieldName: 'name', direction: 'ASC', isNumber: false }],
          criteria: { name: null },
          deletedRecords: false
        }
      })
    ]);

    const categories = Array.isArray(categoryRes?.body) ? categoryRes.body : [];
    const tags = Array.isArray(tagRes?.body) ? tagRes.body : [];
    const publishers = Array.isArray(publisherRes?.body) ? publisherRes.body : [];
    allAuthors = BookApi.parsePaginationResult(authorRes).list;

    renderCheckboxList('category-filters', 'category', categories);
    renderCheckboxList('tag-filters', 'tag', tags);
    renderSelectOptions('publisher-filter', publishers, 'No publishers available');
    renderAuthorPicker();
    applyQueryDefaults(allAuthors);
  } catch (error) {
    BookUi.showMessage('books-message', 'warning', `Failed to load search filters: ${error.message}`);
  }

  document.getElementById('author-search').addEventListener('input', () => {
    renderAuthorPicker();
  });

  document.getElementById('author-filter').addEventListener('change', event => {
    if (event.target.matches('input[name="author"]')) {
      renderAuthorPicker();
    }
  });

  document.getElementById('filter-form').addEventListener('submit', event => {
    event.preventDefault();
    loadBooks(1);
  });

  document.getElementById('reset-search').addEventListener('click', () => {
    resetSearchForm();
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
