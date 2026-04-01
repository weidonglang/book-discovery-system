function buildBookAdminPayload(pageNumber = 1) {
  return {
    pageNumber,
    pageSize: 200,
    sortingByList: [{ fieldName: 'id', direction: 'ASC', isNumber: true }],
    criteria: { name: null, categories: [] },
    deletedRecords: false
  };
}

function buildAuthorAdminPayload(pageNumber = 1) {
  return {
    pageNumber,
    pageSize: 200,
    sortingByList: [{ fieldName: 'id', direction: 'ASC', isNumber: true }],
    criteria: { name: null },
    deletedRecords: false
  };
}

function toDateInput(value) {
  if (!value) return '';
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return '';
  return date.toISOString().slice(0, 10);
}

function escapeHtml(value) {
  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function truncateText(value, length = 160) {
  const text = String(value || '');
  return text.length > length ? `${text.slice(0, length)}...` : text;
}

function getSelectedIds(select) {
  return Array.from(select.selectedOptions)
    .map(option => Number(option.value))
    .filter(value => Number.isFinite(value) && value > 0);
}

function setSelectedIds(select, ids) {
  const selected = new Set((ids || []).map(value => String(value)));
  Array.from(select.options).forEach(option => {
    option.selected = selected.has(option.value);
  });
}

document.addEventListener('DOMContentLoaded', async () => {
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();

  try {
    const currentUser = await BookApi.fetchCurrentUser();
    if (!currentUser || currentUser.role !== 'ADMIN') {
      BookUi.showMessage('admin-message', 'error', 'Admin access is required.');
      setTimeout(() => {
        window.location.href = 'index.html';
      }, 800);
      return;
    }
  } catch (error) {
    BookUi.showMessage('admin-message', 'error', error.message);
    return;
  }

  if (!BookUi.requireAdmin()) return;

  let authors = [];
  let categories = [];
  let books = [];
  let publishers = [];
  let tags = [];

  const bookForm = document.getElementById('book-form');
  const authorForm = document.getElementById('author-form');
  const publisherForm = document.getElementById('publisher-form');
  const tagForm = document.getElementById('tag-form');

  const bookList = document.getElementById('book-admin-list');
  const authorList = document.getElementById('author-admin-list');
  const publisherList = document.getElementById('publisher-admin-list');
  const tagList = document.getElementById('tag-admin-list');

  function renderAuthorOptions() {
    const select = document.getElementById('book-author');
    select.innerHTML = authors.map(author => (
      `<option value="${author.id}">${escapeHtml(author.name)}</option>`
    )).join('');
  }

  function renderCategoryOptions() {
    const select = document.getElementById('book-category');
    select.innerHTML = categories.map(category => (
      `<option value="${category.id}">${escapeHtml(category.name)}</option>`
    )).join('');
  }

  function renderPublisherOptions() {
    const select = document.getElementById('book-publisher');
    const options = publishers.map(publisher => (
      `<option value="${publisher.id}">${escapeHtml(publisher.name)}</option>`
    )).join('');
    select.innerHTML = `<option value="">No Publisher</option>${options}`;
  }

  function renderTagOptions() {
    const select = document.getElementById('book-tags');
    select.innerHTML = tags.map(tag => (
      `<option value="${tag.id}">${escapeHtml(tag.name)}</option>`
    )).join('');
  }

  function resetBookForm() {
    bookForm.reset();
    document.getElementById('book-id').value = '';
    if (authors.length) document.getElementById('book-author').value = String(authors[0].id);
    if (categories.length) document.getElementById('book-category').value = String(categories[0].id);
    document.getElementById('book-publisher').value = '';
    setSelectedIds(document.getElementById('book-tags'), []);
    document.getElementById('book-rate').value = '0';
    document.getElementById('book-users-rate-count').value = '0';
  }

  function resetAuthorForm() {
    authorForm.reset();
    document.getElementById('author-id').value = '';
    document.getElementById('author-gender').value = 'MALE';
  }

  function resetPublisherForm() {
    publisherForm.reset();
    document.getElementById('publisher-id').value = '';
  }

  function resetTagForm() {
    tagForm.reset();
    document.getElementById('tag-id').value = '';
  }

  function editBook(id) {
    const book = books.find(item => String(item.id) === String(id));
    if (!book) return;
    document.getElementById('book-id').value = book.id;
    document.getElementById('book-name').value = book.name || '';
    document.getElementById('book-author').value = book.author?.id ? String(book.author.id) : '';
    document.getElementById('book-category').value = book.category?.id ? String(book.category.id) : '';
    document.getElementById('book-publisher').value = book.publisher?.id ? String(book.publisher.id) : '';
    setSelectedIds(document.getElementById('book-tags'), (book.tags || []).map(tag => tag.id));
    document.getElementById('book-price').value = book.price ?? 0;
    document.getElementById('book-rate').value = book.rate ?? 0;
    document.getElementById('book-users-rate-count').value = book.usersRateCount ?? 0;
    document.getElementById('book-pages').value = book.pagesNumber ?? '';
    document.getElementById('book-duration').value = book.readingDuration ?? '';
    document.getElementById('book-publish-date').value = toDateInput(book.publishDate);
    document.getElementById('book-image-url').value = book.imageUrl || '';
    document.getElementById('book-description').value = book.description || '';
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  function editAuthor(id) {
    const author = authors.find(item => String(item.id) === String(id));
    if (!author) return;
    document.getElementById('author-id').value = author.id;
    document.getElementById('author-name').value = author.name || '';
    document.getElementById('author-country').value = author.country || '';
    document.getElementById('author-birthdate').value = toDateInput(author.birthdate);
    document.getElementById('author-deathdate').value = toDateInput(author.deathdate);
    document.getElementById('author-age').value = author.age ?? '';
    document.getElementById('author-gender').value = author.gender || 'MALE';
    document.getElementById('author-image-url').value = author.imageUrl || '';
    document.getElementById('author-description').value = author.description || '';
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  function editPublisher(id) {
    const publisher = publishers.find(item => String(item.id) === String(id));
    if (!publisher) return;
    document.getElementById('publisher-id').value = publisher.id;
    document.getElementById('publisher-name').value = publisher.name || '';
    document.getElementById('publisher-country').value = publisher.country || '';
    document.getElementById('publisher-website').value = publisher.websiteUrl || '';
    document.getElementById('publisher-description').value = publisher.description || '';
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  function editTag(id) {
    const tag = tags.find(item => String(item.id) === String(id));
    if (!tag) return;
    document.getElementById('tag-id').value = tag.id;
    document.getElementById('tag-name').value = tag.name || '';
    document.getElementById('tag-description').value = tag.description || '';
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  async function removeBook(id) {
    if (!window.confirm(`Soft delete book #${id}?`)) return;
    await BookApi.apiRequest(`/api/book/${id}`, { method: 'DELETE' });
    await loadBooks();
  }

  async function removeAuthor(id) {
    if (!window.confirm(`Soft delete author #${id}?`)) return;
    await BookApi.apiRequest(`/api/author/${id}`, { method: 'DELETE' });
    await loadAuthors();
  }

  async function removePublisher(id) {
    if (!window.confirm(`Soft delete publisher #${id}?`)) return;
    await BookApi.apiRequest(`/api/publisher/${id}`, { method: 'DELETE' });
    await loadPublishers();
  }

  async function removeTag(id) {
    if (!window.confirm(`Soft delete tag #${id}?`)) return;
    await BookApi.apiRequest(`/api/tag/${id}`, { method: 'DELETE' });
    await loadTags();
  }

  function renderBookList() {
    bookList.innerHTML = books.length
      ? books.map(book => {
        const publisherLabel = book.publisher?.name || 'No publisher';
        const tagLabels = (book.tags || []).map(tag => `<span class="tag">${escapeHtml(tag.name)}</span>`).join('');
        return `
          <article class="admin-item">
            <div class="admin-item-head">
              <div>
                <h3>${escapeHtml(book.name)}</h3>
                <div class="muted">#${book.id} | ${escapeHtml(book.author?.name || 'Unknown Author')} | ${escapeHtml(book.category?.name || 'Unknown Category')}</div>
              </div>
              <div class="admin-actions">
                <button type="button" data-edit-book="${book.id}">Edit</button>
                <button type="button" class="danger" data-delete-book="${book.id}">Delete</button>
              </div>
            </div>
            <div class="admin-meta">
              <span class="tag">Publisher: ${escapeHtml(publisherLabel)}</span>
              <span class="tag">Price: ${escapeHtml(book.price ?? '-')}</span>
              <span class="tag">Rate: ${escapeHtml(book.rate ?? '-')}</span>
              <span class="tag">Pages: ${escapeHtml(book.pagesNumber ?? '-')}</span>
            </div>
            <div class="tags">${tagLabels || '<span class="muted">No tags assigned.</span>'}</div>
            <div class="muted">${escapeHtml(truncateText(book.description, 180))}</div>
          </article>`;
      }).join('')
      : '<div class="muted">No books found.</div>';

    bookList.querySelectorAll('[data-edit-book]').forEach(button => {
      button.addEventListener('click', () => editBook(button.dataset.editBook));
    });
    bookList.querySelectorAll('[data-delete-book]').forEach(button => {
      button.addEventListener('click', async () => {
        try {
          await removeBook(button.dataset.deleteBook);
          BookUi.showMessage('admin-message', 'success', 'Book deleted.');
        } catch (error) {
          BookUi.showMessage('admin-message', 'error', error.message);
        }
      });
    });
  }

  function renderAuthorList() {
    authorList.innerHTML = authors.length
      ? authors.map(author => `
        <article class="admin-item">
          <div class="admin-item-head">
            <div>
              <h3>${escapeHtml(author.name)}</h3>
              <div class="muted">#${author.id} | ${escapeHtml(author.country || 'Unknown Country')} | ${escapeHtml(author.gender || 'Unknown Gender')}</div>
            </div>
            <div class="admin-actions">
              <button type="button" data-edit-author="${author.id}">Edit</button>
              <button type="button" class="danger" data-delete-author="${author.id}">Delete</button>
            </div>
          </div>
          <div class="muted">${escapeHtml(truncateText(author.description))}</div>
        </article>`).join('')
      : '<div class="muted">No authors found.</div>';

    authorList.querySelectorAll('[data-edit-author]').forEach(button => {
      button.addEventListener('click', () => editAuthor(button.dataset.editAuthor));
    });
    authorList.querySelectorAll('[data-delete-author]').forEach(button => {
      button.addEventListener('click', async () => {
        try {
          await removeAuthor(button.dataset.deleteAuthor);
          renderAuthorOptions();
          resetAuthorForm();
          resetBookForm();
          BookUi.showMessage('admin-message', 'success', 'Author deleted.');
        } catch (error) {
          BookUi.showMessage('admin-message', 'error', error.message);
        }
      });
    });
  }

  function renderPublisherList() {
    publisherList.innerHTML = publishers.length
      ? publishers.map(publisher => `
        <article class="admin-item">
          <div class="admin-item-head">
            <div>
              <h3>${escapeHtml(publisher.name)}</h3>
              <div class="muted">#${publisher.id} | ${escapeHtml(publisher.country || 'Unknown Country')}</div>
            </div>
            <div class="admin-actions">
              <button type="button" data-edit-publisher="${publisher.id}">Edit</button>
              <button type="button" class="danger" data-delete-publisher="${publisher.id}">Delete</button>
            </div>
          </div>
          <div class="muted">${escapeHtml(truncateText(publisher.description || publisher.websiteUrl || 'No description.'))}</div>
        </article>`).join('')
      : '<div class="muted">No publishers found.</div>';

    publisherList.querySelectorAll('[data-edit-publisher]').forEach(button => {
      button.addEventListener('click', () => editPublisher(button.dataset.editPublisher));
    });
    publisherList.querySelectorAll('[data-delete-publisher]').forEach(button => {
      button.addEventListener('click', async () => {
        try {
          await removePublisher(button.dataset.deletePublisher);
          renderPublisherOptions();
          resetPublisherForm();
          resetBookForm();
          BookUi.showMessage('admin-message', 'success', 'Publisher deleted.');
        } catch (error) {
          BookUi.showMessage('admin-message', 'error', error.message);
        }
      });
    });
  }

  function renderTagList() {
    tagList.innerHTML = tags.length
      ? tags.map(tag => `
        <article class="admin-item">
          <div class="admin-item-head">
            <div>
              <h3>${escapeHtml(tag.name)}</h3>
              <div class="muted">#${tag.id}</div>
            </div>
            <div class="admin-actions">
              <button type="button" data-edit-tag="${tag.id}">Edit</button>
              <button type="button" class="danger" data-delete-tag="${tag.id}">Delete</button>
            </div>
          </div>
          <div class="muted">${escapeHtml(truncateText(tag.description || 'No description.'))}</div>
        </article>`).join('')
      : '<div class="muted">No tags found.</div>';

    tagList.querySelectorAll('[data-edit-tag]').forEach(button => {
      button.addEventListener('click', () => editTag(button.dataset.editTag));
    });
    tagList.querySelectorAll('[data-delete-tag]').forEach(button => {
      button.addEventListener('click', async () => {
        try {
          await removeTag(button.dataset.deleteTag);
          renderTagOptions();
          resetTagForm();
          resetBookForm();
          BookUi.showMessage('admin-message', 'success', 'Tag deleted.');
        } catch (error) {
          BookUi.showMessage('admin-message', 'error', error.message);
        }
      });
    });
  }

  async function loadCategories() {
    const response = await BookApi.apiRequest('/api/book/find-all-categories');
    categories = Array.isArray(response?.body) ? response.body : [];
    renderCategoryOptions();
  }

  async function loadAuthors() {
    const response = await BookApi.apiRequest('/api/author/find-all-paginated-filtered', {
      method: 'POST',
      body: buildAuthorAdminPayload()
    });
    authors = BookApi.parsePaginationResult(response).list;
    renderAuthorOptions();
    renderAuthorList();
  }

  async function loadBooks() {
    const response = await BookApi.apiRequest('/api/book/find-all-paginated-filtered', {
      method: 'POST',
      body: buildBookAdminPayload()
    });
    books = BookApi.parsePaginationResult(response).list;
    renderBookList();
  }

  async function loadPublishers() {
    const response = await BookApi.apiRequest('/api/publisher');
    publishers = Array.isArray(response?.body) ? response.body : [];
    renderPublisherOptions();
    renderPublisherList();
  }

  async function loadTags() {
    const response = await BookApi.apiRequest('/api/tag');
    tags = Array.isArray(response?.body) ? response.body : [];
    renderTagOptions();
    renderTagList();
  }

  bookForm.addEventListener('submit', async event => {
    event.preventDefault();
    const bookId = document.getElementById('book-id').value;
    const publisherId = document.getElementById('book-publisher').value;
    const payload = {
      id: bookId ? Number(bookId) : null,
      name: document.getElementById('book-name').value.trim(),
      author: { id: Number(document.getElementById('book-author').value) },
      category: { id: Number(document.getElementById('book-category').value) },
      publisher: publisherId ? { id: Number(publisherId) } : null,
      tags: getSelectedIds(document.getElementById('book-tags')).map(id => ({ id })),
      price: Number(document.getElementById('book-price').value),
      rate: Number(document.getElementById('book-rate').value),
      usersRateCount: Number(document.getElementById('book-users-rate-count').value),
      pagesNumber: Number(document.getElementById('book-pages').value),
      readingDuration: Number(document.getElementById('book-duration').value),
      publishDate: `${document.getElementById('book-publish-date').value}T00:00:00.000+00:00`,
      description: document.getElementById('book-description').value.trim(),
      imageUrl: document.getElementById('book-image-url').value.trim()
    };

    try {
      await BookApi.apiRequest('/api/book', {
        method: bookId ? 'PUT' : 'POST',
        body: payload
      });
      BookUi.showMessage('admin-message', 'success', bookId ? 'Book updated.' : 'Book created.');
      resetBookForm();
      await loadBooks();
    } catch (error) {
      BookUi.showMessage('admin-message', 'error', error.message);
    }
  });

  authorForm.addEventListener('submit', async event => {
    event.preventDefault();
    const authorId = document.getElementById('author-id').value;
    const payload = {
      id: authorId ? Number(authorId) : null,
      name: document.getElementById('author-name').value.trim(),
      country: document.getElementById('author-country').value.trim(),
      birthdate: `${document.getElementById('author-birthdate').value}T00:00:00.000+00:00`,
      deathdate: document.getElementById('author-deathdate').value
        ? `${document.getElementById('author-deathdate').value}T00:00:00.000+00:00`
        : null,
      age: Number(document.getElementById('author-age').value),
      gender: document.getElementById('author-gender').value,
      imageUrl: document.getElementById('author-image-url').value.trim(),
      description: document.getElementById('author-description').value.trim()
    };

    try {
      await BookApi.apiRequest('/api/author', {
        method: authorId ? 'PUT' : 'POST',
        body: payload
      });
      BookUi.showMessage('admin-message', 'success', authorId ? 'Author updated.' : 'Author created.');
      resetAuthorForm();
      await loadAuthors();
    } catch (error) {
      BookUi.showMessage('admin-message', 'error', error.message);
    }
  });

  publisherForm.addEventListener('submit', async event => {
    event.preventDefault();
    const publisherId = document.getElementById('publisher-id').value;
    const payload = {
      id: publisherId ? Number(publisherId) : null,
      name: document.getElementById('publisher-name').value.trim(),
      country: document.getElementById('publisher-country').value.trim() || null,
      websiteUrl: document.getElementById('publisher-website').value.trim() || null,
      description: document.getElementById('publisher-description').value.trim() || null
    };

    try {
      await BookApi.apiRequest('/api/publisher', {
        method: publisherId ? 'PUT' : 'POST',
        body: payload
      });
      BookUi.showMessage('admin-message', 'success', publisherId ? 'Publisher updated.' : 'Publisher created.');
      resetPublisherForm();
      await loadPublishers();
    } catch (error) {
      BookUi.showMessage('admin-message', 'error', error.message);
    }
  });

  tagForm.addEventListener('submit', async event => {
    event.preventDefault();
    const tagId = document.getElementById('tag-id').value;
    const payload = {
      id: tagId ? Number(tagId) : null,
      name: document.getElementById('tag-name').value.trim(),
      description: document.getElementById('tag-description').value.trim() || null
    };

    try {
      await BookApi.apiRequest('/api/tag', {
        method: tagId ? 'PUT' : 'POST',
        body: payload
      });
      BookUi.showMessage('admin-message', 'success', tagId ? 'Tag updated.' : 'Tag created.');
      resetTagForm();
      await loadTags();
    } catch (error) {
      BookUi.showMessage('admin-message', 'error', error.message);
    }
  });

  document.getElementById('reset-book-form').addEventListener('click', resetBookForm);
  document.getElementById('reset-author-form').addEventListener('click', resetAuthorForm);
  document.getElementById('reset-publisher-form').addEventListener('click', resetPublisherForm);
  document.getElementById('reset-tag-form').addEventListener('click', resetTagForm);

  document.getElementById('reload-books').addEventListener('click', () => loadBooks().catch(error => BookUi.showMessage('admin-message', 'error', error.message)));
  document.getElementById('reload-authors').addEventListener('click', () => loadAuthors().catch(error => BookUi.showMessage('admin-message', 'error', error.message)));
  document.getElementById('reload-publishers').addEventListener('click', () => loadPublishers().catch(error => BookUi.showMessage('admin-message', 'error', error.message)));
  document.getElementById('reload-tags').addEventListener('click', () => loadTags().catch(error => BookUi.showMessage('admin-message', 'error', error.message)));

  try {
    await Promise.all([loadCategories(), loadAuthors(), loadBooks(), loadPublishers(), loadTags()]);
    resetBookForm();
    resetAuthorForm();
    resetPublisherForm();
    resetTagForm();
  } catch (error) {
    BookUi.showMessage('admin-message', 'error', error.message);
  }
});
