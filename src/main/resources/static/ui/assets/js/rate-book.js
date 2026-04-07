document.addEventListener('DOMContentLoaded', async () => {
  const t = window.BookI18n.t;
  BookUi.injectLayout();
  if (!BookUi.requireLogin()) return;

  const params = new URLSearchParams(window.location.search);
  const bookId = params.get('bookId');
  if (!bookId) {
    BookUi.showMessage('rate-message', 'error', t('rateBook.missingId'));
    return;
  }

  try {
    const [user, bookRes] = await Promise.all([
      BookApi.fetchCurrentUser(),
      BookApi.apiRequest(`/api/book/find-by-id/${bookId}`)
    ]);
    const book = bookRes?.body;
    document.getElementById('rate-book-name').textContent = book?.name || t('rateBook.bookFallback', { id: bookId });
    document.getElementById('rate-book-summary').textContent = t('rateBook.summary', {
      author: book?.author?.name || t('common.unknownAuthor'),
      isbn: book?.isbn || '-',
      rate: book?.rate ?? '-'
    });

    document.getElementById('rate-form').addEventListener('submit', async event => {
      event.preventDefault();
      const payload = {
        user: user ? { id: user.id, email: user.email } : null,
        book: { id: Number(bookId) },
        rate: Number(document.getElementById('rate').value),
        comment: document.getElementById('comment').value.trim()
      };

      try {
        await BookApi.apiRequest('/api/book/rate', {
          method: 'POST',
          body: payload
        });
        BookUi.showMessage('rate-message', 'success', t('rateBook.success'));
      } catch (error) {
        BookUi.showMessage('rate-message', 'error', error.message);
      }
    });
  } catch (error) {
    BookUi.showMessage('rate-message', 'error', error.message);
  }
});
