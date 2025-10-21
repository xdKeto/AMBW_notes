const CACHE_NAME = "profile-cache-v1";
const urlsToCache = ["/", "/index.html", "/style.css", "/app.js", "/manifest.json", "/icon/icon-32x32.png", "/icon/icon-192x192.png", "/icon/icon-512x512.png", "https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"];

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

self.addEventListener("fetch", (event) => {
  const apiUrl = "https://randomuser.me/api/";

  // check api
  if (event.request.url.startsWith(apiUrl)) {
    event.respondWith(
      fetch(event.request)
        .then(async (response) => {
          const cache = await caches.open(CACHE_NAME);
          console.log("SW: cache data API");
          cache.put(event.request, response.clone());
          return response;
        })
        .catch(() => {
          console.log("SW: network error");
          return caches.match(event.request);
        })
    );
  } else {
    // fallback ke cache
    event.respondWith(
      caches
        .match(event.request)
        .then((response) => {
          if (response) {
            return response;
          }

          return fetch(event.request);
        })
        .catch((error) => {})
    );
  }
});
