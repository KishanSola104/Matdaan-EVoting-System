window.initAdminCandidates = function () {
  console.log("Admin Candidates JS Loaded");

  const actionButtons = document.getElementById("action-buttons");
  actionButtons.style.display = "none";

  const selectLinks = document.querySelectorAll(".select-link");
  selectLinks.forEach((link) => {
    link.classList.remove("active");
  });

  let currentlyClicked = null;

  selectLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      e.preventDefault();

      if (this === currentlyClicked) {
        actionButtons.style.display = "none";
        this.classList.remove("active");
        currentlyClicked = null;
      } else {
        selectLinks.forEach((l) => {
          l.classList.remove("active");
        });

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

  function generatePartyTable(numOfParties, electionID, electionName) {
    // Remove old party table if exists
    const oldWrapper = document.getElementById("party-table-wrapper");
    if (oldWrapper) {
      oldWrapper.remove();
    }

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

    document.querySelector("main").appendChild(wrapper);

    attachPartyTableListeners();
  }

  function attachPartyTableListeners() {
    const partyLinks = document.querySelectorAll(".select-party-link");

    partyLinks.forEach((link) => {
      link.addEventListener("click", function (e) {
        e.preventDefault();

        partyLinks.forEach((l) => {
          l.classList.remove("active");
        });

        this.classList.add("active");
        showActionButtons();
      });
    });
  }

  function showActionButtons() {
    const actionButtons = document.getElementById("action-buttons");

    if (actionButtons.style.display === "none") {
      actionButtons.style.display = "grid";
    } else {
      actionButtons.style.display = "none";
    }
  }
};
