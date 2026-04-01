document.addEventListener('DOMContentLoaded', async () => {
  if (BookUi.redirectIfLoggedIn()) return;
  BookUi.injectLayout();
  const genderSelect = document.getElementById('gender');
  const maritalSelect = document.getElementById('maritalStatus');
  ['MALE', 'FEMALE', 'OTHERS'].forEach(v => genderSelect.insertAdjacentHTML('beforeend', `<option value="${v}">${v}</option>`));
  ['SINGLE', 'MARRIED', 'IN_RELATIONSHIP'].forEach(v => maritalSelect.insertAdjacentHTML('beforeend', `<option value="${v}">${v}</option>`));

  document.getElementById('email').addEventListener('blur', async (e) => {
    const email = e.target.value.trim();
    if (!email) return;
    try {
      const res = await BookApi.apiRequest(`/api/user/find-is-email-exists/${encodeURIComponent(email)}`, { auth: false });
      const exists = Boolean(res?.body);
      BookUi.showMessage('register-message', exists ? 'warning' : 'info', exists ? '该邮箱似乎已经存在。' : '该邮箱目前可用。');
    } catch (error) {
      BookUi.showMessage('register-message', 'warning', `邮箱校验失败：${error.message}`);
    }
  });

  document.getElementById('register-form').addEventListener('submit', async (event) => {
    event.preventDefault();
    BookUi.hideMessage('register-message');
    const payload = {
      firstName: document.getElementById('firstName').value.trim(),
      lastName: document.getElementById('lastName').value.trim(),
      email: document.getElementById('email').value.trim(),
      password: document.getElementById('password').value.trim(),
      phoneNumber: document.getElementById('phoneNumber').value.trim(),
      birthdate: document.getElementById('birthdate').value || null,
      country: document.getElementById('country').value.trim(),
      age: document.getElementById('age').value ? Number(document.getElementById('age').value) : null,
      gender: document.getElementById('gender').value || null,
      maritalStatus: document.getElementById('maritalStatus').value || null,
      imageUrl: document.getElementById('imageUrl').value.trim()
    };

    try {
      await BookApi.apiRequest('/api/user', {
        method: 'POST',
        auth: false,
        body: payload
      });
      BookUi.showMessage('register-message', 'success', '注册成功，正在跳转到登录页。');
      const email = encodeURIComponent(payload.email);
      setTimeout(() => { window.location.href = `login.html?email=${email}`; }, 800);
    } catch (error) {
      BookUi.showMessage('register-message', 'error', error.message);
    }
  });
});
