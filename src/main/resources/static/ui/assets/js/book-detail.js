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
  const t = window.BookI18n.t;
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();

  const params = new URLSearchParams(window.location.search);
  const id = params.get('id');
  const source = params.get('source') || '';
  const reason = params.get('reason') || '';
  const borrowButton = document.getElementById('borrow-book-btn');
  const reserveButton = document.getElementById('reserve-book-btn');
  const cancelReservationButton = document.getElementById('cancel-reservation-btn');
  const similarBooksWrap = document.getElementById('similar-books');
  const authorBooksWrap = document.getElementById('author-books');

  if (!id) {
    BookUi.showMessage('detail-message', 'error', t('bookDetail.missingId'));
    return;
  }

  function setButtonState(button, visible, text, disabled) {
    if (!button) return;
    button.textContent = text;
    button.disabled = Boolean(disabled);
    button.classList.toggle('hidden', !visible);
  }

  function renderMeta(book, summary) {
    const tagNames = (book.tags || []).map(tag => tag.name).filter(Boolean);
    const queueLabel = summary.currentUserHasActiveReservation
      ? `${summary.activeReservationsCount} / #${summary.currentUserQueuePosition}`
      : String(summary.activeReservationsCount);

    const groups = [
      {
        title: window.BookI18n.isChinese() ? '作品信息' : 'Work profile',
        items: [
          renderInfoItem(t('common.author'), escapeHtml(book.author?.name || t('common.unknownAuthor'))),
          renderInfoItem(t('common.isbn'), escapeHtml(book.isbn || t('bookDetail.noIsbn'))),
          renderInfoItem(t('common.category'), escapeHtml(BookUi.localizeCategoryName(book.category?.name))),
          renderInfoItem(t('common.publisher'), escapeHtml(book.publisher?.name || t('common.noPublisher'))),
          renderInfoItem(t('common.tags'), escapeHtml(tagNames.length ? tagNames.join(', ') : t('common.noTags'))),
          renderInfoItem(t('common.publishDate'), escapeHtml(BookApi.toDisplayDate(book.publishDate)))
        ]
      },
      {
        title: window.BookI18n.isChinese() ? '阅读参考' : 'Reading reference',
        items: [
          renderInfoItem(t('common.rating'), escapeHtml(book.rate ?? '-')),
          renderInfoItem(t('common.ratingCount'), escapeHtml(book.usersRateCount ?? '-')),
          renderInfoItem(t('common.pages'), escapeHtml(book.pagesNumber ?? '-')),
          renderInfoItem(t('common.duration'), escapeHtml(book.readingDuration ?? '-')),
          renderInfoItem(t('common.price'), escapeHtml(book.price ?? '-'))
        ]
      },
      {
        title: window.BookI18n.isChinese() ? '流通状态' : 'Availability',
        items: [
          renderInfoItem(t('common.availableCopies'), escapeHtml(`${book.availableCopies ?? 0} / ${book.totalCopies ?? 0}`)),
          renderInfoItem(t('common.queue'), escapeHtml(queueLabel))
        ]
      }
    ];

    document.getElementById('detail-meta').innerHTML = groups.map(group => `
      <section class="detail-meta-group">
        <h3 class="detail-meta-group-title">${escapeHtml(group.title)}</h3>
        <div class="detail-meta-group-body">
          ${group.items.join('')}
        </div>
      </section>
    `).join('');
  }

  function renderButtons(book, activeLoan, summary) {
    if (activeLoan) {
      setButtonState(borrowButton, true, `${t('bookDetail.borrow')} (${BookApi.toDisplayDate(activeLoan.dueDate)})`, true);
      setButtonState(reserveButton, false, t('bookDetail.reserve'), true);
      setButtonState(cancelReservationButton, false, t('bookDetail.cancelReservation'), true);
      return;
    }

    if (summary.currentUserHasActiveReservation) {
      setButtonState(cancelReservationButton, true, `${t('bookDetail.cancelReservation')} (#${summary.currentUserQueuePosition})`, false);
      if (summary.currentUserIsFirstInQueue && Number(book.availableCopies || 0) > 0) {
        setButtonState(borrowButton, true, t('bookDetail.borrow'), false);
      } else {
        setButtonState(borrowButton, true, t('common.unavailable'), true);
      }
      setButtonState(reserveButton, false, t('bookDetail.reserve'), true);
      return;
    }

    setButtonState(cancelReservationButton, false, t('bookDetail.cancelReservation'), true);

    if (Number(book.availableCopies || 0) > 0) {
      if (Number(summary.activeReservationsCount || 0) > 0) {
        setButtonState(borrowButton, true, t('common.unavailable'), true);
      } else {
        setButtonState(borrowButton, true, t('bookDetail.borrow'), false);
      }
      setButtonState(reserveButton, false, t('bookDetail.reserve'), true);
      return;
    }

    setButtonState(borrowButton, true, t('common.unavailable'), true);
    setButtonState(reserveButton, true, t('bookDetail.reserve'), false);
  }

  async function loadDetailState(trackEntrySource = false) {
    const detailPath = trackEntrySource && source
      ? `/api/book/find-by-id/${id}?source=${encodeURIComponent(source)}&reason=${encodeURIComponent(reason)}`
      : `/api/book/find-by-id/${id}`;

    const [detailRes, activeLoanRes, summaryRes] = await Promise.all([
      BookApi.apiRequest(detailPath),
      BookApi.apiRequest('/api/loan/my-active'),
      BookApi.apiRequest(`/api/reservation/book/${id}/summary`)
    ]);

    const book = detailRes?.body;
    if (!book) {
        throw new Error(t('bookDetail.detailMissing'));
    }

    const activeLoans = Array.isArray(activeLoanRes?.body) ? activeLoanRes.body : [];
    const activeLoan = activeLoans.find(loan => String(loan?.book?.id) === String(id)) || null;
    const summary = summaryRes?.body || {
      bookId: Number(id),
      activeReservationsCount: 0,
      currentUserHasActiveReservation: false,
      currentUserIsFirstInQueue: false,
      currentUserQueuePosition: null,
      currentUserReservationId: null
    };

    document.getElementById('detail-cover').innerHTML = BookUi.renderBookImage(book);
    document.getElementById('detail-title').textContent = book.name || t('common.unknownBook');
    document.getElementById('detail-desc').textContent = book.description || t('common.noDescription');
    renderMeta(book, summary);
    renderButtons(book, activeLoan, summary);
    document.getElementById('go-rate').href = `rate-book.html?bookId=${id}`;
    BookUi.saveRecentView(book);

    return { book, summary };
  }

  try {
    const state = await loadDetailState(true);

    borrowButton.addEventListener('click', async () => {
      try {
        await BookApi.apiRequest('/api/loan/borrow', {
          method: 'POST',
          body: { bookId: Number(id) }
        });
        BookUi.showMessage('detail-message', 'success', t('bookDetail.borrowSuccess'));
        await loadDetailState();
      } catch (error) {
        BookUi.showMessage('detail-message', 'error', error.message);
      }
    });

    reserveButton.addEventListener('click', async () => {
      try {
        await BookApi.apiRequest('/api/reservation/reserve', {
          method: 'POST',
          body: { bookId: Number(id) }
        });
        BookUi.showMessage('detail-message', 'success', t('bookDetail.reserveSuccess'));
        await loadDetailState();
      } catch (error) {
        BookUi.showMessage('detail-message', 'error', error.message);
      }
    });

    cancelReservationButton.addEventListener('click', async () => {
      try {
        const summaryRes = await BookApi.apiRequest(`/api/reservation/book/${id}/summary`);
        const summary = summaryRes?.body;
        if (!summary?.currentUserReservationId) {
          throw new Error(t('bookDetail.noActiveReservation'));
        }
        await BookApi.apiRequest(`/api/reservation/${summary.currentUserReservationId}/cancel`, {
          method: 'POST'
        });
        BookUi.showMessage('detail-message', 'success', t('bookDetail.reserveCancelled'));
        await loadDetailState();
      } catch (error) {
        BookUi.showMessage('detail-message', 'error', error.message);
      }
    });

    const similarRes = await BookApi.apiRequest(`/api/book/recommendations/similar/${id}`);
    similarBooksWrap.innerHTML = BookUi.renderRecommendationShelves(similarRes?.body, {
      emptyMessage: t('bookDetail.similarEmpty')
    });
    BookUi.refreshSaveButtons(similarBooksWrap);

    if (state.book.author?.id) {
      const authorRes = await BookApi.apiRequest(`/api/book/find-all-by-author-id/${state.book.author.id}`);
      const authorBooks = Array.isArray(authorRes?.body) ? authorRes.body : [];
      const relatedBooks = authorBooks.filter(item => String(item.id) !== String(id)).slice(0, 6);
      authorBooksWrap.innerHTML = relatedBooks.length
        ? relatedBooks.map(item => BookUi.renderBookCard(item, {
          source: 'author-shelf',
          sourceLabel: t('bookDetail.authorShelfLabel'),
          reason: t('bookDetail.authorShelfReason', { author: state.book.author?.name || t('common.unknownAuthor') }),
          actionType: 'BOOK_DETAIL_CLICK'
        })).join('')
        : `<div class="card muted">${escapeHtml(t('bookDetail.authorShelfEmpty'))}</div>`;
      BookUi.refreshSaveButtons(authorBooksWrap);
    } else {
      authorBooksWrap.innerHTML = `<div class="card muted">${escapeHtml(t('bookDetail.noAuthorShelf'))}</div>`;
    }
  } catch (error) {
    BookUi.showMessage('detail-message', 'error', error.message);
  }
});
