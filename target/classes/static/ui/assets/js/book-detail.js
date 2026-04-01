function escapeHtml(value) {
  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function renderInfoItem(label, value) {
  return `
    <div class="info-item">
      <div class="info-key">${escapeHtml(label)}</div>
      <div class="info-value">${value}</div>
    </div>`;
}

document.addEventListener('DOMContentLoaded', async () => {
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();

  const params = new URLSearchParams(window.location.search);
  const id = params.get('id');
  if (!id) {
    BookUi.showMessage('detail-message', 'error', 'Missing book id.');
    return;
  }

  try {
    const detailRes = await BookApi.apiRequest(`/api/book/find-by-id/${id}`);
    const book = detailRes?.body;
    if (!book) throw new Error('Book details were not returned by the API.');

    const tagNames = (book.tags || []).map(tag => tag.name).filter(Boolean);

    document.getElementById('detail-cover').innerHTML = window.BookUi.renderBookImage(book);
    document.getElementById('detail-title').textContent = book.name || 'Untitled Book';
    document.getElementById('detail-desc').textContent = book.description || 'No description available.';
    document.getElementById('detail-meta').innerHTML = [
      renderInfoItem('Author', escapeHtml(book.author?.name || 'Unknown Author')),
      renderInfoItem('Category', escapeHtml(book.category?.name || 'Uncategorized')),
      renderInfoItem('Publisher', escapeHtml(book.publisher?.name || 'No publisher')),
      renderInfoItem('Tags', escapeHtml(tagNames.length ? tagNames.join(', ') : 'No tags')),
      renderInfoItem('Rate', escapeHtml(book.rate ?? '-')),
      renderInfoItem('Ratings', escapeHtml(book.usersRateCount ?? '-')),
      renderInfoItem('Price', escapeHtml(book.price ?? '-')),
      renderInfoItem('Pages', escapeHtml(book.pagesNumber ?? '-')),
      renderInfoItem('Reading Duration', escapeHtml(book.readingDuration ?? '-')),
      renderInfoItem('Publish Date', escapeHtml(BookApi.toDisplayDate(book.publishDate)))
    ].join('');

    document.getElementById('go-rate').href = `rate-book.html?bookId=${id}`;

    if (book.author?.id) {
      const authorRes = await BookApi.apiRequest(`/api/book/find-all-by-author-id/${book.author.id}`);
      const authorBooks = Array.isArray(authorRes?.body) ? authorRes.body : [];
      const relatedBooks = authorBooks.filter(item => String(item.id) !== String(id)).slice(0, 6);
      document.getElementById('author-books').innerHTML = relatedBooks.length
        ? relatedBooks.map(item => BookUi.renderBookCard(item)).join('')
        : '<div class="card muted">No more books from this author.</div>';
    }
  } catch (error) {
    BookUi.showMessage('detail-message', 'error', error.message);
  }
});
