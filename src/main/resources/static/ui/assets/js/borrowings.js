function formatDateTime(value) {
  if (!value) return '-';
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return String(value);
  return date.toLocaleString('zh-CN');
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
    return '<span class="loan-status returned">Returned</span>';
  }
  if (isOverdue(loan)) {
    return '<span class="loan-status overdue">Overdue</span>';
  }
  return '<span class="loan-status active">Borrowed</span>';
}

function renderReservationStatus(reservation) {
  if (reservation.status === 'FULFILLED') {
    return '<span class="loan-status returned">Fulfilled</span>';
  }
  if (reservation.status === 'CANCELLED') {
    return '<span class="loan-status overdue">Cancelled</span>';
  }
  return '<span class="loan-status pending">Active</span>';
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
            <h3>${escapeHtml(book.name || 'Untitled Book')}</h3>
            <div class="muted">${escapeHtml(book.author?.name || 'Unknown Author')}</div>
          </div>
          ${renderLoanStatus(loan)}
        </div>
        <div class="loan-meta">
          <span class="tag">Borrowed: ${escapeHtml(formatDateTime(loan.borrowedAt))}</span>
          <span class="tag">Due: ${escapeHtml(formatDateTime(loan.dueDate))}</span>
          <span class="tag">Renew Count: ${escapeHtml(loan.renewCount ?? 0)}</span>
        </div>
        ${loan.returnedAt ? `<div class="muted">Returned at ${escapeHtml(formatDateTime(loan.returnedAt))}</div>` : ''}
        <div class="loan-actions">
          <a href="book-detail.html?id=${book.id || ''}"><button type="button">View Book</button></a>
          ${includeActions ? `<button type="button" data-renew-loan="${loan.id}" ${renewDisabled}>Renew</button>
          <button type="button" class="primary" data-return-loan="${loan.id}">Return</button>` : ''}
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
            <h3>${escapeHtml(book.name || 'Untitled Book')}</h3>
            <div class="muted">${escapeHtml(book.author?.name || 'Unknown Author')}</div>
          </div>
          ${renderReservationStatus(reservation)}
        </div>
        <div class="loan-meta">
          <span class="tag">Requested: ${escapeHtml(formatDateTime(reservation.requestedAt))}</span>
          <span class="tag">Available: ${escapeHtml(`${book.availableCopies ?? 0}/${book.totalCopies ?? 0}`)}</span>
        </div>
        ${reservation.fulfilledAt ? `<div class="muted">Fulfilled at ${escapeHtml(formatDateTime(reservation.fulfilledAt))}</div>` : ''}
        ${reservation.cancelledAt ? `<div class="muted">Cancelled at ${escapeHtml(formatDateTime(reservation.cancelledAt))}</div>` : ''}
        <div class="loan-actions">
          <a href="book-detail.html?id=${book.id || ''}"><button type="button">View Book</button></a>
          ${includeActions ? `<button type="button" class="danger" data-cancel-reservation="${reservation.id}">Cancel Reservation</button>` : ''}
        </div>
      </div>
    </article>`;
}

document.addEventListener('DOMContentLoaded', async () => {
  if (!BookUi.requireLogin()) return;
  BookUi.injectLayout();

  const activeLoanTarget = document.getElementById('active-loans');
  const loanHistoryTarget = document.getElementById('loan-history');
  const activeReservationTarget = document.getElementById('active-reservations');
  const reservationHistoryTarget = document.getElementById('reservation-history');

  async function loadDashboard() {
    activeLoanTarget.innerHTML = '<div class="muted">Loading active loans...</div>';
    loanHistoryTarget.innerHTML = '<div class="muted">Loading loan history...</div>';
    activeReservationTarget.innerHTML = '<div class="muted">Loading active reservations...</div>';
    reservationHistoryTarget.innerHTML = '<div class="muted">Loading reservation history...</div>';

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
      : '<div class="muted">No active loans.</div>';
    loanHistoryTarget.innerHTML = loanHistory.length
      ? loanHistory.map(loan => renderLoanCard(loan, false)).join('')
      : '<div class="muted">No returned loans yet.</div>';
    activeReservationTarget.innerHTML = activeReservations.length
      ? activeReservations.map(reservation => renderReservationCard(reservation, true)).join('')
      : '<div class="muted">No active reservations.</div>';
    reservationHistoryTarget.innerHTML = reservationHistory.length
      ? reservationHistory.map(reservation => renderReservationCard(reservation, false)).join('')
      : '<div class="muted">No reservation history yet.</div>';

    activeLoanTarget.querySelectorAll('[data-renew-loan]').forEach(button => {
      button.addEventListener('click', async () => {
        try {
          await BookApi.apiRequest(`/api/loan/${button.dataset.renewLoan}/renew`, { method: 'POST' });
          BookUi.showMessage('loan-message', 'success', 'Loan renewed.');
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
          BookUi.showMessage('loan-message', 'success', 'Book returned.');
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
          BookUi.showMessage('loan-message', 'success', 'Reservation cancelled.');
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
