window.APP_CONFIG = {
  apiBaseUrl: (() => {
    const { origin, pathname } = window.location;
    const currentBackendBase = `${origin}/book-service`;

    if (pathname.includes('/book-service/')) {
      return currentBackendBase;
    }

    const stored = localStorage.getItem('book_api_base_url');
    if (stored) return stored;
    return 'http://localhost:8010/book-service';
  })(),
  appName: 'ReadSeek'
};
