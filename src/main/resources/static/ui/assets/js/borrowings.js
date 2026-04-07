function formatDateTime(value) {
  if (!value) return '-';
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return String(value);
  return date.toLocaleString(window.BookI18n.getLocale());
}

function escapeHtml(value) {
  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function isOverdue(loan) {
  if (!loan || loan.status !== 'BORROWED' || !loan.dueDate) return false;
  return new Date(loan.dueDate).getTime() < Date.now();
}

function canRenew(loan) {
  return loan?.status === 'BORROWED' && Number(loan?.renewCount || 0) < 1;
}

function renderLoanStatus(loan) {
  if (loan.status === 'RETURNED') {
    return `<span class="loan-status returned">${window.BookI18n.t('borrowings.returned')}</span>`;
  }
  if (isOverdue(loan)) {
    return `<span class="loan-status overdue">${window.BookI18n.t('borrowings.overdue')}</span>`;
  }
  return `<span class="loan-status active">${window.BookI18n.t('borrowings.borrowing')}</span>`;
}

function renderReservationStatus(reservation) {
  if (reservation.status === 'FULFILLED') {
    return `<span class="loan-status returned">${window.BookI18n.t('borrowings.fulfilled')}</span>`;
  }
  if (reservation.status === 'CANCELLED') {
    return `<span class="loan-status overdue">${window.BookI18n.t('borrowings.cancelled')}</span>`;
  }
  return `<span class="loan-status pending">${window.BookI18n.t('borrowings.reserving')}</span>`;
}

function renderLoanCard(loan, includeActions) {
  const book = loan.book || {};
  const renewDisabled = canRenew(loan) ? '' : 'disabled';
  return `
    <article class="loan-card">
      <div class="loan-cover">${BookUi.renderBookImage(book)}</div>
      <div class="loan-body">
        <div class="loan-head">
          <div>
            <h3>${escapeHtml(book.name || window.BookI18n.t('common.unknownBook'))}</h3>
            <div class="muted">${escapeHtml(book.author?.name || window.BookI18n.t('common.unknownAuthor'))}</div>
          </div>
          ${renderLoanStatus(loan)}
        </div>
        <div class="loan-meta">
          <span class="tag">${escapeHtml(window.BookI18n.t('borrowings.borrowedAt', { value: formatDateTime(loan.borrowedAt) }))}</span>
          <span class="tag">${escapeHtml(window.BookI18n.t('borrowings.dueAt', { value: formatDateTime(loan.dueDate) }))}</span>
          <span class="tag">${escapeHtml(window.BookI18n.t('borrowings.renewCount', { value: loan.renewCount ?? 0 }))}</span>
        </div>
        ${loan.returnedAt ? `<div class="muted">${escapeHtml(window.BookI18n.t('borrowings.returnedAt', { value: formatDateTime(loan.returnedAt) }))}</div>` : ''}
        <div class="loan-actions">
          <a href="book-detail.html?id=${book.id || ''}"><button type="button">${escapeHtml(window.BookI18n.t('borrowings.viewBook'))}</button></a>
          ${includeActions ? `<button type="button" data-renew-loan="${loan.id}" ${renewDisabled}>${escapeHtml(window.BookI18n.t('borrowings.renew'))}</button>
          <button type="button" class="primary" data-return-loan="${loan.id}">${escapeHtml(window.BookI18n.t('borrowings.returnBook'))}</button>` : ''}
        </div>
      </div>
    </article>`;
}

function renderReservationCard(reservation, includeActions) {
  const book = reservation.book || {};
  return `
    <article class="loan-card">
      <div class="loan-cover">${BookUi.renderBookImage(book)}</div>
      <div class="loan-body">
        <div class="loan-head">
          <div>
            <h3>${escapeHtml(book.name || window.BookI18n.t('common.unknownBook'))}</h3>
            <div class="muted">${escapeHtml(book.author?.name || window.BookI18n.t('common.unknownAuthor'))}</div>
          </div>
          ${renderReservationStatus(reservation)}
        </div>
        <div class="loan-meta">
          <span class="tag">${escapeHtml(window.BookI18n.t('borrowings.requestedAt', { value: formatDateTime(reservation.requestedAt) }))}</span>
          <span class="tag">${escapeHtml(window.BookI18n.t('borrowings.copies', { value: `${book.availableCopies ?? 0}/${book.totalCopies ?? 0}` }))}</span>
        </div>
        ${reservation.fulfilledAt ? `<div class="muted">${escapeHtml(window.BookI18n.t('borrowings.fulfilledAt', { value: formatDateTime(reservation.fulfilledAt) }))}</div>` : ''}
        ${reservation.cancelledAt ? `<div class="muted">${escapeHtml(window.BookI18n.t('borrowings.cancelledAt', { value: formatDateTime(reservation.cancelledAt) }))}</div>` : ''}
        <div class="loan-actions">
          <a href="book-detail.html?id=${book.id || ''}"><button type="button">${escapeHtml(window.BookI18n.t('borrowings.viewBook'))}</button></a>
          ${includeActions ? `<button type="button" class="danger" data-cancel-reservation="${reservation.id}">${escapeHtml(window.BookI18n.t('borrowings.cancelReservation'))}</button>` : ''}
        </div>
      </div>
    </article>`;
}

document.addEventListener('DOMContentLoaded', async () => {
  const t = window.BookI18n.t;
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();

  const activeLoanTarget = document.getElementById('active-loans');
  const loanHistoryTarget = document.getElementById('loan-history');
  const activeReservationTarget = document.getElementById('active-reservations');
  const reservationHistoryTarget = document.getElementById('reservation-history');

  async function loadDashboard() {
    activeLoanTarget.innerHTML = `<div class="muted">${escapeHtml(t('borrowings.loadingActiveLoans'))}</div>`;
    loanHistoryTarget.innerHTML = `<div class="muted">${escapeHtml(t('borrowings.loadingHistory'))}</div>`;
    activeReservationTarget.innerHTML = `<div class="muted">${escapeHtml(t('borrowings.loadingActiveReservations'))}</div>`;
    reservationHistoryTarget.innerHTML = `<div class="muted">${escapeHtml(t('borrowings.loadingReservationHistory'))}</div>`;

    const [activeLoanRes, loanHistoryRes, activeReservationRes, reservationHistoryRes] = await Promise.all([
      BookApi.apiRequest('/api/loan/my-active'),
      BookApi.apiRequest('/api/loan/my-history'),
      BookApi.apiRequest('/api/reservation/my-active'),
      BookApi.apiRequest('/api/reservation/my-history')
    ]);

    const activeLoans = Array.isArray(activeLoanRes?.body) ? activeLoanRes.body : [];
    const loanHistory = Array.isArray(loanHistoryRes?.body) ? loanHistoryRes.body : [];
    const activeReservations = Array.isArray(activeReservationRes?.body) ? activeReservationRes.body : [];
    const reservationHistory = Array.isArray(reservationHistoryRes?.body) ? reservationHistoryRes.body : [];

    activeLoanTarget.innerHTML = activeLoans.length
      ? activeLoans.map(loan => renderLoanCard(loan, true)).join('')
      : `<div class="muted">${escapeHtml(t('borrowings.emptyActiveLoans'))}</div>`;
    loanHistoryTarget.innerHTML = loanHistory.length
      ? loanHistory.map(loan => renderLoanCard(loan, false)).join('')
      : `<div class="muted">${escapeHtml(t('borrowings.emptyHistory'))}</div>`;
    activeReservationTarget.innerHTML = activeReservations.length
      ? activeReservations.map(reservation => renderReservationCard(reservation, true)).join('')
      : `<div class="muted">${escapeHtml(t('borrowings.emptyActiveReservations'))}</div>`;
    reservationHistoryTarget.innerHTML = reservationHistory.length
      ? reservationHistory.map(reservation => renderReservationCard(reservation, false)).join('')
      : `<div class="muted">${escapeHtml(t('borrowings.emptyReservationHistory'))}</div>`;

    BookUi.refreshScrollShells(document);

    activeLoanTarget.querySelectorAll('[data-renew-loan]').forEach(button => {
      button.addEventListener('click', async () => {
        try {
          await BookApi.apiRequest(`/api/loan/${button.dataset.renewLoan}/renew`, { method: 'POST' });
          BookUi.showMessage('loan-message', 'success', t('borrowings.renewSuccess'));
          await loadDashboard();
        } catch (error) {
          BookUi.showMessage('loan-message', 'error', error.message);
        }
      });
    });

    activeLoanTarget.querySelectorAll('[data-return-loan]').forEach(button => {
      button.addEventListener('click', async () => {
        try {
          await BookApi.apiRequest(`/api/loan/${button.dataset.returnLoan}/return`, { method: 'POST' });
          BookUi.showMessage('loan-message', 'success', t('borrowings.returnSuccess'));
          await loadDashboard();
        } catch (error) {
          BookUi.showMessage('loan-message', 'error', error.message);
        }
      });
    });

    activeReservationTarget.querySelectorAll('[data-cancel-reservation]').forEach(button => {
      button.addEventListener('click', async () => {
        try {
          await BookApi.apiRequest(`/api/reservation/${button.dataset.cancelReservation}/cancel`, { method: 'POST' });
          BookUi.showMessage('loan-message', 'success', t('borrowings.cancelSuccess'));
          await loadDashboard();
        } catch (error) {
          BookUi.showMessage('loan-message', 'error', error.message);
        }
      });
    });
  }

  document.getElementById('reload-loans').addEventListener('click', () => {
    loadDashboard().catch(error => BookUi.showMessage('loan-message', 'error', error.message));
  });

  try {
    await loadDashboard();
  } catch (error) {
    BookUi.showMessage('loan-message', 'error', error.message);
  }
});
