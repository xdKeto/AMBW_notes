# PWA Project Instructions: "Halaman Resep Offline"

## 📌 Skenario
Anda ditugaskan untuk membangun **aplikasi web halaman tunggal (SPA)** yang menampilkan resep masakan.  
Klien memiliki dua kebutuhan utama:
1. **Aplikasi bisa diinstal** di homescreen perangkat pengguna, layaknya aplikasi native.
2. **Resep (gambar + langkah-langkah) dapat diakses offline**, bahkan ketika koneksi internet buruk (misalnya di dapur).

Selain itu:
- Klien akan **memperbarui resep** (gambar atau langkah-langkah).  
- Pengguna harus bisa **mendapatkan versi terbaru secara otomatis** saat kembali online.

---

## 🎯 Tugas
Buatlah proyek PWA sederhana yang memenuhi semua kebutuhan klien. Proyek terdiri dari 3 bagian:

---

### Bagian A: Struktur Dasar & Kemampuan Instalasi (40%)

#### Struktur File Dasar
- `index.html` → Halaman utama berisi:
  - Judul resep
  - Gambar (`resep.jpg`)
  - Daftar langkah-langkah resep  
- `style.css` → Styling agar halaman rapi.
- `resep.jpg` → File gambar resep.
- `app.js` → Register service worker.

#### `manifest.json`
- Optimalkan agar aplikasi bisa diinstal.
- Properti penting:
  - `short_name`
  - `theme_color`
  - `background_color`
  - Minimal **2 ukuran icons**.

---

### Bagian B: Fungsionalitas Offline dengan Service Worker (40%)

#### `sw.js`
- **Caching saat install**
  - Gunakan `install` event listener.
  - Buat cache, contoh: `resep-cache-v1`.
  - Simpan **App Shell**:
    - `index.html`
    - `style.css`
    - `app.js`
    - `resep.jpg`

- **Sajikan konten dari cache**
  - Gunakan `fetch` event listener.
  - Implementasi strategi: **Cache First (Cache → Network fallback)**  
    - Jika ada di cache → tampilkan.
    - Jika tidak ada → ambil dari jaringan.

---

### Bagian C: Analisis Mekanisme Pembaruan (20%)

Tidak perlu menulis kode, cukup **jawab pertanyaan** berikut di file terpisah (`answers.md`) atau kolom jawaban:

1. Jika file `resep.jpg` & `style.css` diperbarui di server, pengguna lama mungkin masih melihat versi lama (karena strategi Cache First).  
   → Bagaimana Anda memodifikasi `sw.js` agar pengguna mendapat update?

2. Jelaskan **konsep cache versioning** (misalnya ubah `resep-cache-v1` → `resep-cache-v2`).

3. Jelaskan **peran event listener `activate`** dalam membersihkan cache lama.

4. Mengapa proses pembaruan penting untuk **life-cycle sebuah PWA**?

---

## 📦 Submission
- Kumpulkan Bagian A & B (kode) dalam format `.zip`.
- Sertakan link Google Drive jika diminta.

# Answers: Bagian C - Analisis Mekanisme Pembaruan

## 1. Modifikasi `sw.js` agar pengguna mendapat update
Saat file seperti `resep.jpg` atau `style.css` diperbarui di server, strategi **Cache First** bisa menyebabkan pengguna tetap melihat versi lama.  
Solusi: **ubah strategi cache versioning + tambahkan mekanisme update**:

- Ganti nama cache, misalnya dari `resep-cache-v1` menjadi `resep-cache-v2`.
- Di `install` event, cache ulang semua aset dengan versi terbaru.
- Di `activate` event, hapus cache lama (`v1`), sehingga hanya cache baru (`v2`) yang dipakai.
- Dengan begitu, pada refresh berikutnya, pengguna akan otomatis melihat versi terbaru.

---

## 2. Konsep Cache Versioning
- Cache diberi **nama versi**, misalnya:
  - `resep-cache-v1`
  - `resep-cache-v2`
- Saat ada update aset, kita **ubah versi nama cache**.
- Service worker akan membuat cache baru dengan aset terbaru, lalu menghapus cache lama.
- Ini memastikan pengguna **tidak terjebak di aset lama**.

---

## 3. Peran Event Listener `activate`
- `activate` event dijalankan ketika service worker baru aktif.
- Di sini, kita bisa:
  - Mengecek semua cache yang ada.
  - Menghapus cache lama yang tidak sesuai dengan versi terbaru.
- Contoh kode:
  ```js
  self.addEventListener("activate", event => {
    event.waitUntil(
      caches.keys().then(keys => {
        return Promise.all(
          keys.filter(key => key !== "resep-cache-v2")
              .map(key => caches.delete(key))
        );
      })
    );
  });
