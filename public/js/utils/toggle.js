console.log("Design The Toggle");

document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.querySelector(".admin-sidebar");
  const toggleBtn = document.querySelector(".sidebar-toggle");
  const links = document.querySelectorAll(".admin-sidebar nav a");

  if (toggleBtn) {
    toggleBtn.addEventListener("click", function (e) {
      e.stopPropagation();
      sidebar.classList.toggle("active");
    });
  }

  // Close sidebar on link click
  links.forEach((link) => {
    link.addEventListener("click", () => {
      sidebar.classList.remove("active");
    });
  });

  // Close sidebar on outside click
  document.body.addEventListener("click", function (e) {
    if (sidebar.classList.contains("active")) {
      if (!sidebar.contains(e.target) && !toggleBtn.contains(e.target)) {
        sidebar.classList.remove("active");
      }
    }
  });
});
