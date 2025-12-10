# UAS Context – TicketWave Mobile (Flutter + Supabase)

## Goals

Build a Flutter mobile application called **TicketWave Mobile – Lite Version**, based on Supabase backend. Implement core modules taught in class: UI/UX, StatefulWidget, Navigation, Theming, Supabase Auth, CRUD, Storage, and Deployment.

Time limit during exam: 3 hours.

---

# SPECIFICATIONS

## 1. Authentication (Supabase)

### Sign In

- Inputs: email, password
- Use `supabase.auth.signInWithPassword()`
- On success → navigate to HomePage
- On error → show snackbar

### Sign Up

- Inputs: email, password, confirm password
- On success → redirect to Sign In

### Optional Bonus: Biometric Login

- Use `local_auth`
- Only available if previously logged in (stored via shared_preferences)

---

## 2. Home Page

### Light/Dark Mode

- Use ThemeData (light/dark)
- Persist theme using shared_preferences
- Toggle button in AppBar

### Event List (from Supabase)

Fetch from table **`events`** using Supabase client  
Use `FutureBuilder`  
Display:

- Event image (URL from Storage)
- Title
- Short description
- Price

---

## 3. Event Detail Page

On tapping an event:

- Navigate using `Navigator.push`
- Display:
  - Large event image
  - Title
  - Location & date
  - Price
  - Button: **“Pesan Tiket”**

---

## 4. Ticket Ordering

When “Pesan Tiket” is pressed:

- Insert into Supabase table `orders`:
  - `user_id`
  - `event_id`
  - `created_at`
- After success:
  - Show confirmation dialog
  - Redirect to "Riwayat Pesanan" page

---

## 5. Riwayat Pesanan (Order History)

- SQL filter by `user_id`
- Display:
  - Event title
  - Order date
  - Status
- Use `FutureBuilder`

---

## 6. Profile Page – Image Upload

- Pick image from gallery
- Upload to Supabase Storage → folder `profiles/`
- Save URL to `user_profiles` table
- Display uploaded profile picture

---

## 7. Theming (NO Provider)

- State for theme stored via shared_preferences
- Apply theme in MaterialApp

---

## 8. Bonus (Optional)

- Push Notification (Firebase/OneSignal)
- Sign Out
- Build release files:
  - `flutter build apk`
  - `flutter build web`

---

# OUTPUT

- GitHub Repo
- APK (optional)
- Screenshots:
  - Login
  - Home
  - Event Detail
  - Pemesanan
  - Riwayat Pesanan
- Video demo (optional)

---

# GRADING

| Component                 | Weight |
| ------------------------- | ------ |
| UI/UX                     | 20%    |
| StatefulWidget + setState | 10%    |
| Navigation                | 10%    |
| FutureBuilder + API       | 15%    |
| Authentication            | 10%    |
| CRUD Orders               | 15%    |
| Storage Upload            | 10%    |
| Bonus                     | +20%   |
