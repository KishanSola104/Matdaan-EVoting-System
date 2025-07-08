window.initAdminParties = function () {
  console.log("Admin Parties JS Loaded");

  // Hide the buttons initially
  const actionButtons = document.getElementById("action-buttons");
  actionButtons.style.display = "none";

  // Select all SELECT links
  const selectLinks = document.querySelectorAll(".select-link");

  // Remove active class from all initially
  selectLinks.forEach((l) => {
    l.classList.remove("active");
  });

  let currentlyClicked = null;

  // Attach click handlers
  selectLinks.forEach((link) => {
    link.addEventListener("click", (e) => {
      e.preventDefault();

      // Check if this is the same as the already clicked link
      if (link === currentlyClicked) {
        // User clicked same link again : toggle off
        actionButtons.style.display = "none";
        link.classList.remove("active");
        currentlyClicked = null;
      } else {
        // User clicked a new link

        // Remove active from all
        selectLinks.forEach((l) => {
          l.classList.remove("active");
        });

        // Highlight this one
        link.classList.add("active");

        // Show the buttons
        actionButtons.style.display = "grid";

        currentlyClicked = link;
      }
    });
  });

  // The Code for taking values to The next page
  document.getElementById("add-parties-btn").addEventListener("click", () => {
    if (currentlyClicked) {
      // find the <tr> for the selected link
      const selectedRow = currentlyClicked.closest("tr");

      const dataCells = selectedRow.querySelectorAll("td");

      const electionID = dataCells[1].textContent.trim();
      const electionName = dataCells[2].textContent.trim();
      const stateName = dataCells[3].textContent.trim();
      const numOfParties = dataCells[4].textContent.trim();

      const url =
        `/public/admin/adminAddParties.html
?` +
        `electionID=${encodeURIComponent(electionID)}` +
        `&electionName=${encodeURIComponent(electionName)}` +
        `&stateName=${encodeURIComponent(stateName)}` +
        `&numOfParties=${encodeURIComponent(numOfParties)}`;

      window.location.href = url;
    } else {
      alert("Please select an election first.");
    }
  });
};
