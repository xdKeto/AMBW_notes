const CACHE_NAME = 'my-app-cache-v2'; // Ganti versi cache agar SW di-update
const urlsToCache = [
  '/',
  '/index.html',
  '/style.css',
  '/app.js',
  '/icons/icon-192x192.png',
  '/icons/icon-512x512.png',
  '/offline.html' // <-- Tambahkan halaman offline ke daftar cache
];

// Event 'install': Menyimpan aset-aset inti ke cache.
self.addEventListener('install', event => {
  console.log('Service Worker: Menginstal...');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('Service Worker: Pre-caching app shell.');
        return cache.addAll(urlsToCache);
      })
  );
});

// Event 'activate': Membersihkan cache lama.
self.addEventListener('activate', event => {
  console.log('Service Worker: Aktif.');
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            console.log('Service Worker: Menghapus cache lama:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

// Event 'fetch': Mengintersep permintaan jaringan.
self.addEventListener('fetch', event => {
  console.log('Service Worker: Mengambil resource:', event.request.url);

  // Gunakan strategi "Cache First, falling back to Network"
  event.respondWith(
    // 1. Coba cari permintaan di cache.
    caches.match(event.request)
      .then(response => {
        // 2. Jika ditemukan di cache, kembalikan respons dari cache.
        if (response) {
          console.log('Menyajikan dari cache:', event.request.url);
          return response;
        }

        // 3. Jika tidak ditemukan, lanjutkan ke jaringan.
        console.log('Mengambil dari jaringan:', event.request.url);
        return fetch(event.request);
      })
      .catch(error => {
        // 4. Jika jaringan gagal (offline), sajikan halaman offline.html.
        console.log('Gagal mengambil dari jaringan. Menyajikan halaman offline.');
        return caches.match('/offline.html');
      })
  );
});
