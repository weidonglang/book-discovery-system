window.APP_CONFIG = {
  apiBaseUrl: (() => {
    const stored = localStorage.getItem('book_api_base_url');
    if (stored) return stored;
    const { origin, pathname } = window.location;
    if (pathname.includes('/book-service/')) {
      return `${origin}/book-service`;
    }
    return 'http://localhost:8010/book-service';
  })(),
  appName: 'Book Nook UI Skeleton'
};
