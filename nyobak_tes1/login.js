document.addEventListener('DOMContentLoaded', () => {
    const loginButton = document.getElementById('loginButton');
    const usernameInput = document.getElementById('usernameInput');
    const passwordInput = document.getElementById('passwordInput');

    loginButton.addEventListener('click', () => {
        const username = usernameInput.value;
        const password = passwordInput.value;

        if (!username || !password) {
            alert('Please enter both username and password.');
            return;
        }

        fetch('http://localhost:3000/users')
            .then(response => response.json())
            .then(users => {
                const foundUser = users.find(user => user.username === username && user.password === password);

                if (foundUser) {
                    // Save to local storage and redirect
                    localStorage.setItem('authenticatedUser', JSON.stringify(foundUser));
                    alert('Login successful!');
                    window.location.href = '/index.html'; // Redirect to the main page
                } else {
                    alert('Error: Invalid username or password');
                }
            })
            .catch(error => {
                console.error('Login error:', error);
                alert('Could not connect to the server.');
            });
    });
});
