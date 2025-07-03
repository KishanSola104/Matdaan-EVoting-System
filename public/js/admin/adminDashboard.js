console.log("Hello Admin Dashboard");

document.addEventListener("DOMContentLoaded", () => {
  loadContent("/public/admin/adminDashboardMain.html");

  document
    .querySelectorAll(".admin-sidebar nav a, .admin-dropdown a")
    .forEach((link) => {
      link.addEventListener("click", function (e) {
        e.preventDefault();

        const url = this.getAttribute("href");

        if (url && url !== "#") {
          loadContent(url);
        }

        document
          .querySelectorAll(".admin-sidebar nav a, .admin-dropdown a")
          .forEach((l) => {
            l.classList.remove("active");
          });

        this.classList.add("active");

        document.querySelector(".admin-sidebar").classList.remove("active");
        document.querySelectorAll(".admin-dropdown").forEach((drop) => {
          drop.classList.remove("active");
        });
      });
    });

  
  const defaultLink = document.querySelector(
    '.admin-sidebar nav a[href="/public/admin/adminDashboardMain.html"]'
  );
  if (defaultLink) {
    defaultLink.classList.add("active");
  }
});

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

      if (url.includes("adminDashboardMain.html")) {
        loadScript("/public/js/admin/adminDashboardMain.js", () => {
          if (window.initAdminDashboardMain) {
            window.initAdminDashboardMain();
          }
        });
      }else if(url.includes("adminElections.html"))
      {
        loadScript("/public/js/admin/adminElections.js",()=>{
          if(window.initAdminElections)
          {
            window.initAdminElections();
          }
        });
      }
    })
    .catch((err) => {
      document.getElementById("main-content").innerHTML =
        "<p>Error loading page.</p>";
      console.error(err);
    });
}

function loadScript(src, callback) {
  const script = document.createElement("script");
  script.src = src;
  script.onload = callback;
  document.body.appendChild(script);
}

document.getElementById("logout-link").addEventListener("click", function (e) {
  e.preventDefault();
  alert("Logging out...");

  window.location.href = "/public/index.html";
  localStorage.clear();
  sessionStorage.clear();
});
