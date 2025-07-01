console.log("Hello Admin Dashboard");

document.addEventListener("DOMContentLoaded", () => {
  // Load default dashboard content on first load
  loadContent("/public/admin/adminDashboardMain.html");

  // Find all sidebar and dropdown links together
  document.querySelectorAll(".admin-sidebar nav a, .admin-dropdown a").forEach((link) => {
    link.addEventListener("click", function (e) {
      e.preventDefault();

      const url = this.getAttribute("href");

      if (url && url !== "#") {
        loadContent(url);
      }

      // Remove active from ALL links (sidebar + dropdown)
      document.querySelectorAll(".admin-sidebar nav a, .admin-dropdown a").forEach((l) => {
        l.classList.remove("active");
      });

      this.classList.add("active");

      // Close sidebar on small screens
      document.querySelector(".admin-sidebar").classList.remove("active");

      // Close dropdowns
      document.querySelectorAll(".admin-dropdown").forEach((drop) => {
        drop.classList.remove("active");
      });
    });
  });

  // Optionally set default active link on load:
  const defaultLink = document.querySelector('.admin-sidebar nav a[href="/public/admin/adminDashboardMain.html"]');
  if (defaultLink) {
    defaultLink.classList.add("active");
  }
});

// Define loadContent outside listener
function loadContent(url) {
  fetch(url)
    .then((response) => {
      if (!response.ok) {
        throw new Error("Page not found");
      }
      return response.text();
    })
    .then((html) => {
      document.getElementById("main-content").innerHTML = html;
    })
    .catch((err) => {
      document.getElementById("main-content").innerHTML =
        "<p>Error loading page.</p>";
      console.error(err);
    });
}

document.getElementById("logout-link").addEventListener("click", function (e) {
  e.preventDefault();
  alert("Logging out...");

  window.location.href = "/public/index.html";
  localStorage.clear();
  sessionStorage.clear();
});
