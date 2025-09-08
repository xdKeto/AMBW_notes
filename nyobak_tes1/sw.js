const STATIC_CACHE_NAME = 'static-cache-v2';
const DATA_CACHE_NAME = 'data-cache-v1';

const urlsToCache = [
    '/',
    '/index.html',
    '/login.html',
    '/app.js',
    '/login.js',
    '/style.css',
    '/manifest.json',
    '/icons/icon-192x192.png',
    '/icons/icon-512x512.png',
    '/offline.html'
];

// Install service worker: pre-cache the app shell
self.addEventListener('install', (event) => {
    console.log('Service Worker: Installing...');
    event.waitUntil(
        caches.open(STATIC_CACHE_NAME).then((cache) => {
            console.log('Service Worker: Caching app shell');
            return cache.addAll(urlsToCache);
        })
    );
});

// Activate service worker: clean up old caches
self.addEventListener('activate', (event) => {
    console.log('Service Worker: Activating...');
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== STATIC_CACHE_NAME && cacheName !== DATA_CACHE_NAME) {
                        console.log('Service Worker: Deleting old cache:', cacheName);
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
    return self.clients.claim();
});

// Fetch event: handle network requests
self.addEventListener('fetch', (event) => {
    const requestUrl = new URL(event.request.url);

    // Strategy for API calls: Network first, then cache
    if (requestUrl.origin === 'http://localhost:3000') {
        event.respondWith(
            caches.open(DATA_CACHE_NAME).then((cache) => {
                return fetch(event.request)
                    .then((response) => {
                        // If we get a good response, cache it and return it
                        if (response.status === 200) {
                            cache.put(event.request.url, response.clone());
                        }
                        return response;
                    })
                    .catch((err) => {
                        // If network fails, try to serve from cache
                        console.log('Network failed, serving from cache:', event.request.url);
                        return cache.match(event.request);
                    });
            })
        );
        return; // End execution for API calls
    }

    // Strategy for all other requests: Cache first, then network, with offline fallback
    event.respondWith(
        caches.match(event.request).then((response) => {
            // Return cached response if found
            if (response) {
                return response;
            }

            // Otherwise, fetch from network
            return fetch(event.request).then((networkResponse) => {
                // Cache the new response for future use
                return caches.open(STATIC_CACHE_NAME).then((cache) => {
                    cache.put(event.request, networkResponse.clone());
                    return networkResponse;
                });
            });
        }).catch((error) => {
            // If both cache and network fail, show the offline page
            console.log('Fetch failed; returning offline page.');
            return caches.match('/offline.html');
        })
    );
});