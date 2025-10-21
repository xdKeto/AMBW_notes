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

// fecth api
const fetchUsers = () => {
    console.log("fetching data");
    fetch("https://randomuser.me/api/?results=5")
    .then((response) => response.json())
    .then((data) => {
        userCards(data.results);
    })
    .catch((error) => {
        console.error("error fetching:", error);
    });
};

fetchUsers();

const userCards = (users) => {
  const userCards = document.getElementById("user-cards");
  userCards.innerHTML = "";
  users.forEach((user) => {
    console.log("data:", user);
    const card = `
      <div class="col-md-4 mb-4">
        <div class="card border border-secondary rounded-5">
          <img src="${user.picture.large}" class="card-img-top rounded-top-5" alt="User photo">
          <div class="card-body">
            <h5 class="card-title text-light">${user.name.first} ${user.name.last}</h5>
            <p class="card-text text-light">@${user.login.username}</p>
          </div>
        </div>
      </div>
    `;
    userCards.innerHTML += card;
  });
};
