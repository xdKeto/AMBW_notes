self.addEventListener("install", (e) => {
  console.log("SW Installed");
});

self.addEventListener("activate", (e) => {
  console.log("SW activated");
});

self.addEventListener('fetch', (e) => {
    console.log('SW fetching...');
});
