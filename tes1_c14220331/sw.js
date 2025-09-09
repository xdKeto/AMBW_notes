const CACHE_NAME = "makanify-cache-v1";
const urlsToCache = ["/", "/index.html", "/style.css", "/app.js", "/assets/resep.jpg", "/assets/icon-48x48.png", "/assets/icon-192x192.png", "/assets/icon-512x512.png"];

// simpan aset ke cache
self.addEventListener("install", (event) => {
  console.log("SW: installing..");
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(urlsToCache);
    })
  );
});

// activate, membersihkan cache lama
self.addEventListener("activate", (event) => {
  console.log("SW: cleaning cache..");
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log("SW: menghapus cache lama: ", cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

// fetch, untuk intersept request
self.addEventListener("fetch", (event) => {
  console.log("SW: fetching resource..");

  event.respondWith(
    caches
      .match(event.request)
      .then((response) => {
        if (response) {
          // cache ketemu
          return response;
        }

        // not found, ambil dari jaringan
        return fetch(event.request);
      })
      .catch((error) => {
        // jaringan gagal
      })
  );
});
