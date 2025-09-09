if ("serviceWorker" in navigator) {
  // mendaftarkan service worker
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/sw.js")
      .then((regist) => {
        console.log("SW berhasil didaftarkan: ", regist.scope);
      })
      .catch((error) => {
        console.log("SW gagal didaftarkan: ", error);
      });
  });
}
