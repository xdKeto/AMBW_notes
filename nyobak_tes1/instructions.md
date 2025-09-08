# Instructions

## Backend server (10 pts)
1. Install `json-server` using the following command:
   ```bash
   npm install json-server -g
   ```
2. Run the backend server using the provided JSON file:
   ```bash
   json-server db-test1.json
   ```

## PWA Setup (30 pts)
3. Setup PWA to make it installable to OS. Configure the following files:
   - `manifest.json`
   - `sw.js`

## Data Fetching from Backend (40 pts)
4. Setup user authentication and save the authenticated user to `LocalStorage`.
5. Fetch all posts and their comments, and display them on the web page.
6. Ensure you can add a post or comment to a post.

## Offline Handling and Caching Strategies (20 pts)
7. Ensure your app can handle offline conditions and show the last posts and comments.
8. Disable post and comment creation if the backend is not running.

## Styling (20 pts)
9. If you make your app not use plain HTML (e.g., using Bootstrap or Tailwind), you will get extra points.

---
**Wish the best for your exam!**
