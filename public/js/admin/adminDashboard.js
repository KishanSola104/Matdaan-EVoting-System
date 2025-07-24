console.log("Hello Admin Dashboard");

document.addEventListener("DOMContentLoaded", () => {
  loadContent("/admin/adminDashboardMain.html");

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
    '.admin-sidebar nav a[href="/admin/adminDashboardMain.html"]'
  );
  if (defaultLink) {
    defaultLink.classList.add("active");
  }
});

const pageScriptMap = {
  "adminDashboardMain.html": {
    src: "/js/admin/adminDashboardMain.js",
    init: "initAdminDashboardMain",
  },
  "adminElections.html": {
    src: "/js/admin/adminElections.js",
    init: "initAdminElections",
  },
  "adminParties.html": {
    src: "/js/admin/adminParties.js",
    init: "initAdminParties",
  },
  "adminAddParties.html": {
    src: "/js/admin/adminAddParties.js",
    init: "initAdminAddParties",
  },
  "adminUpdateParties.html": {
    src: "/js/admin/adminUpdateParties.js",
    init: "initAdminUpdateParties",
  },
  "adminViewParties.html": {
    src: "/js/admin/adminViewParties.js",
    init: "initAdminViewParties",
  },
  "adminCandidates.html": {
    src: "/js/admin/adminCandidates.js",
    init: "initAdminCandidates",
  },
  "adminAddCandidates.html": {
    src: "/js/admin/adminAddCandidates.js",
    init: "initAddCandidates",
  },
  "adminUpdateCandidates.html": {
    src: "/js/admin/adminUpdateCandidates.js",
    init: "initUpdateCandidates",
  },
  "adminDeleteCandidates.html": {
    src: "/js/admin/adminDeleteCandidates.js",
    init: "initDeleteCandidates",
  },
  "adminViewCandidates.html": {
    src: "/js/admin/adminViewCandidates.js",
    init: "initViewCandidates",
  },
  "adminVoters.html": {
    src: "/js/admin/adminVoters.js",
    init: "initAdminVoters",
  },
  "adminAddVoters.html": {
    src: "/js/admin/adminAddVoters.js",
    init: "initAddVoters",
  },
  "adminUpdateVoters.html": {
    src: "/js/admin/adminUpdateVoters.js",
    init: "initUpdateVoters",
  },
};

function loadContent(url) {
  fetch(url)
    .then((response) => {
      if (!response.ok) throw new Error("Page not found");
      return response.text();
    })
    .then((html) => {
      document.getElementById("main-content").innerHTML = html;
      for (const key in pageScriptMap) {
        if (url.includes(key)) {
          const { src, init } = pageScriptMap[key];
          loadScript(src, () => {
            if (window[init]) window[init]();
          });
          break;
        }
      }
    })
    .catch((err) => {
      document.getElementById("main-content").innerHTML =
        "<p>Error loading page.</p>";
      console.error("Error loading content:", err);
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

  window.location.href = "/index.html";
  localStorage.clear();
  sessionStorage.clear();
});
