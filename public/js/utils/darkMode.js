document.addEventListener("DOMContentLoaded", () => {
  const themeBtn = document.getElementById("theme-toggle");
  const icon = themeBtn.querySelector("i");

  // Check stored preference
  if (localStorage.getItem("theme") === "dark") {
    document.body.classList.add("dark-mode");
    icon.classList.remove("fa-moon");
    icon.classList.add("fa-sun");
  }

  themeBtn.addEventListener("click", () => {
    document.body.classList.toggle("dark-mode");

    if (document.body.classList.contains("dark-mode")) {
      icon.classList.remove("fa-moon");
      icon.classList.add("fa-sun");
      localStorage.setItem("theme", "dark");
    } else {
      icon.classList.remove("fa-sun");
      icon.classList.add("fa-moon");
      localStorage.setItem("theme", "light");
    }
  });
});



// JS For Handling The Admin name Clicking 
// Toggle dropdown when admin name clicked
document.querySelector('.admin-name').addEventListener('click', (e) => {
  e.preventDefault();
  document.querySelector('.admin-profile').classList.toggle('show-dropdown');
});

// Hide dropdown when any dropdown link is clicked
document.querySelectorAll('.admin-dropdown a').forEach(link => {
  link.addEventListener('click', (e) => {
    e.preventDefault();
    document.querySelector('.admin-profile').classList.remove('show-dropdown');
  });
});

// Hide dropdown when clicking outside
document.body.addEventListener('click', function(e) {
  const profile = document.querySelector('.admin-profile');
  if (!profile.contains(e.target)) {
    profile.classList.remove('show-dropdown');
  }
});
