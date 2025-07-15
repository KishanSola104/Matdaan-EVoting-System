window.initAdminCandidates = function () {
  console.log("Admin Candidates JS Loaded");

  const actionButtons = document.getElementById("action-buttons");
  actionButtons.style.display = "none";

  const selectLinks = document.querySelectorAll(".select-link");
  selectLinks.forEach((link) => {
    link.classList.remove("active");
  });

  let currentlyClicked = null;

  // --- TABLE 1 SELECT LINK HANDLERS ---
  selectLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      e.preventDefault();

      // Toggle off if same link clicked again
      if (this === currentlyClicked) {
        this.classList.remove("active");
        currentlyClicked = null;

        // Hide action buttons and table 2
        actionButtons.style.display = "none";
        clearPartyTable();
      } else {
        // Clear previous active links
        selectLinks.forEach((l) => l.classList.remove("active"));

        this.classList.add("active");
        currentlyClicked = this;

        const row = this.closest("tr");
        if (!row) {
          console.error("Could not locate row of clicked link!");
          return;
        }

        const dataCells = row.querySelectorAll("td");
        if (dataCells.length < 5) {
          console.error("Row does not contain expected columns!");
          return;
        }

        const electionID = dataCells[1].textContent.trim();
        const electionName = dataCells[2].textContent.trim();
        const stateName = dataCells[3].textContent.trim();
        const numOfParties = parseInt(dataCells[4].textContent.trim(), 10);

        console.log("Election ID:", electionID);
        console.log("Election Name:", electionName);
        console.log("State Name:", stateName);
        console.log("Num of Parties:", numOfParties);

        generatePartyTable(numOfParties, electionID, electionName);
      }
    });
  });

  // --- GENERATE SECOND TABLE ---
  function generatePartyTable(numOfParties, electionID, electionName) {
    clearPartyTable();

    const wrapper = document.createElement("div");
    wrapper.id = "party-table-wrapper";

    const table = document.createElement("table");
    table.classList.add("admin-table");

    const thead = document.createElement("thead");
    thead.innerHTML = `
      <tr>
        <th>SELECT</th>
        <th>ELECTION ID</th>
        <th>ELECTION NAME</th>
        <th>PARTY ID</th>
        <th>PARTY NAME</th>
        <th>LEADER NAME</th>
        <th>TOTAL CANDIDATES</th>
      </tr>
    `;

    table.appendChild(thead);

    const tbody = document.createElement("tbody");

    for (let i = 1; i <= numOfParties; i++) {
      const tr = document.createElement("tr");

      const tdSelect = document.createElement("td");
      const selectLink = document.createElement("a");
      selectLink.href = "#";
      selectLink.textContent = "SELECT";
      selectLink.classList.add("select-party-link");
      tdSelect.appendChild(selectLink);

      const tdElectionID = document.createElement("td");
      tdElectionID.textContent = electionID;

      const tdElectionName = document.createElement("td");
      tdElectionName.textContent = electionName;

      const tdPartyID = document.createElement("td");
      tdPartyID.textContent = `Party Id ${i}`;

      const tdPartyName = document.createElement("td");
      tdPartyName.textContent = `Party Name`;

      const tdLeaderName = document.createElement("td");
      tdLeaderName.textContent = `Leader Name`;

      const tdTotalCandidates = document.createElement("td");
      tdTotalCandidates.textContent = ``;

      tr.appendChild(tdSelect);
      tr.appendChild(tdElectionID);
      tr.appendChild(tdElectionName);
      tr.appendChild(tdPartyID);
      tr.appendChild(tdPartyName);
      tr.appendChild(tdLeaderName);
      tr.appendChild(tdTotalCandidates);

      tbody.appendChild(tr);
    }

    table.appendChild(tbody);
    wrapper.appendChild(table);

    const partyTableContainer = document.getElementById(
      "parties-table-container"
    );
    partyTableContainer.innerHTML = "";
    partyTableContainer.appendChild(wrapper);

    attachPartyTableListeners(wrapper);
  }

  function clearPartyTable() {
    const partyTableContainer = document.getElementById(
      "parties-table-container"
    );
    partyTableContainer.innerHTML = "";
    actionButtons.style.display = "none";
  }

  // --- TABLE 2 SELECT LINK HANDLERS ---

  let currentlyClickedPartyLink = null;

  function attachPartyTableListeners(wrapper) {
    const partyLinks = wrapper.querySelectorAll(".select-party-link");

    partyLinks.forEach((link) => {
      link.addEventListener("click", function (e) {
        e.preventDefault();

        // User clicked the same link again → toggle OFF
        if (link === currentlyClickedPartyLink) {
          link.classList.remove("active");
          currentlyClickedPartyLink = null;

          // Hide action buttons
          const actionButtons = document.getElementById("action-buttons");
          actionButtons.style.display = "none";
        } else {
          // Remove active from all
          partyLinks.forEach((l) => {
            l.classList.remove("active");
          });

          link.classList.add("active");
          currentlyClickedPartyLink = link;

          // Show action buttons
          const actionButtons = document.getElementById("action-buttons");
          actionButtons.style.display = "grid";
        }
      });
    });
  }

  // --- SHOW/HIDE ACTION BUTTONS ---
  function showActionButtons() {
    actionButtons.style.display = "grid";
  }

  // Handle clicks of the Action Buttons
  const addCandidatesBtn = document.getElementById("add-candidates-btn");
  const updateCandidatesBtn = document.getElementById("update-candidates-btn");
  const deleteCandidatesBtn = document.getElementById("delete-candidates-btn");
  const viewCandidatesBtn = document.getElementById("view-candidates-btn");

  // Add Candidates Data
  addCandidatesBtn.addEventListener("click", () => {
    const partyData = getSelectedPartyData();
    if (!partyData) return;

    sessionStorage.setItem(
      "selectedPartyData",
      JSON.stringify(partyData)
    );
    loadContent("/public/admin/adminAddCandidates.html");
  });

  // Update Candidates Data
  updateCandidatesBtn.addEventListener("click",()=>{
    const partyData=getSelectedPartyData();
    if(!partyData) return;

    sessionStorage.setItem("selectedPartyData",JSON.stringify(partyData));
    loadContent("/public/admin/adminUpdateCandidates.html");
  });

  // Delet Candidates Data
  deleteCandidatesBtn.addEventListener("click",()=>{
    const partyData=getSelectedPartyData();
    if(!partyData) return;

    sessionStorage.setItem("selectedPartyData",JSON.stringify(partyData));
    loadContent("/public/admin/adminDeleteCandidates.html");
  });

  // View Cndidates
  viewCandidatesBtn.addEventListener("click",()=>{
    const partyData=getSelectedPartyData();
    if(!partyData) return;

    sessionStorage.setItem("selectedPartyData",JSON.stringify(partyData));
    loadContent("/public/admin/adminViewCandidates.html");
  });

  // Common function to fetch selected party info
  function getSelectedPartyData() {
    if (currentlyClicked == null || currentlyClickedPartyLink == null) {
      alert("Please select a valid election and party");
      return null;
    }

    const selectedPartyRow = currentlyClickedPartyLink.closest("tr");
    if (!selectedPartyRow) {
      alert("Could not locate the selected party row!");
      return null;
    }

    const cells = selectedPartyRow.querySelectorAll("td");
    if (cells.length < 7) {
      alert("Party row does not contain the required columns!");
      return null;
    }

    const electionId = cells[1].textContent.trim();
    const electionName = cells[2].textContent.trim();
    const partyID = cells[3].textContent.trim();
    const partyName = cells[4].textContent.trim();
    const leaderName = cells[5].textContent.trim();
    // const tdTotalCandidates = parseInt(cells[6].textContent.trim(), 10);

    if (!electionId || !electionName || !partyID || !partyName || !leaderName) {
      alert("Invalid or incomplete data selected.");
      return null;
    }

    return {
      electionId,
      electionName,
      partyID,
      partyName,
      leaderName,
      // tdTotalCandidates,
    };
  }
};
