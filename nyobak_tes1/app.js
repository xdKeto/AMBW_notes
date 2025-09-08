// Redirect to login if not authenticated
const authenticatedUser = localStorage.getItem('authenticatedUser');
if (!authenticatedUser) {
    window.location.href = '/login.html';
}

if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/sw.js")
      .then((registraion) => {
        console.log("Service Worker berhasil didaftarkan dengan scope:", registraion.scope);
      })
      .catch((error) => {
        console.log("SW Gagal", error);
      });
  });
}

document.addEventListener('DOMContentLoaded', () => {
  const postsContainer = document.getElementById('posts-container');
  const logoutButton = document.getElementById('logoutButton');

  logoutButton.addEventListener('click', () => {
    localStorage.removeItem('authenticatedUser');
    window.location.href = '/login.html';
  });

  Promise.all([fetch("http://localhost:3000/posts"), fetch("http://localhost:3000/comments")])
    .then((responses) => Promise.all(responses.map((res) => res.json())))
    .then(([posts, comments]) => {
      // display data
      console.log("Fetched Posts:", posts);
      console.log("Fetched Comments:", comments);

      postsContainer.innerHTML = ''; // Clear previous content

      posts.forEach(post => {
          const postElement = document.createElement('article');
          postElement.innerHTML = `
              <h3>${post.title}</h3>
              <p>${post.content}</p>
          `;

          const postComments = comments.filter(comment => comment.postId === post.id);
          const commentsContainer = document.createElement('div');
          commentsContainer.classList.add('comments-section'); // for styling

          postComments.forEach(comment => {
              const commentElement = document.createElement('p');
              commentElement.textContent = comment.body;
              commentsContainer.appendChild(commentElement);
          });

          postElement.appendChild(commentsContainer); // Bug fix here
          postsContainer.appendChild(postElement);
      });
    }).catch(error => {
      console.error('error fetching data: ', error);
      postsContainer.innerHTML = '<p>Could not fetch posts. Is the server running?</p>';
    });
});
