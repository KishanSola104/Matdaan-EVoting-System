window.initUpdateVoters = function () {


  // get the selected state and district from the session storage
  const selectedStateDistrict = JSON.parse(
    sessionStorage.getItem("selectedStateDistrict")
  );

  if (
    !selectedStateDistrict ||
    !selectedStateDistrict.state ||
    !selectedStateDistrict.district
  ) {
    alert("No state or district selected");
    return;
  }

  const stateDropdown = document.getElementById("voterState");
  const districtDropdown = document.getElementById("voterDistrict");
  if (!stateDropdown || !districtDropdown) {
    alert("State or District dropdown not found in the DOM.");
    return;
  }
  stateDropdown.value = selectedStateDistrict.state;
  districtDropdown.value = selectedStateDistrict.district;

  // Search logic
  const voterIdInput = document.getElementById("searchVoterId");
  const searchButton = document.getElementById("searchVoterBtn");

  function handleSearch() {
    const voterID = voterIdInput.value.trim();
    if (!voterID) {
      alert("Please Enter a Valid Voter ID");
      return;
    }
    // fetchCandidateData(voterID);
  }

  searchButton.addEventListener("click", handleSearch);
  voterIdInput.addEventListener("keypress", (event) => {
    if (event.key === "Enter") {
      handleSearch();
    }
  });

  const yearDropdown = document.getElementById("Year");
  const monthDropdown = document.getElementById("Month");
  const dayDropdown = document.getElementById("Day");

  setLabel(yearDropdown, "Year");
  setLabel(monthDropdown, "Month");
  setLabel(dayDropdown, "Day");

  // function to add The label for All The Dropdowns
  function setLabel(selectDropdown, labelText) {
    const labelOption = document.createElement("option");
    labelOption.value = "";
    labelOption.textContent = labelText;
    selectDropdown.appendChild(labelOption);
  }

  // set The Year , Month and Day for dropdowns
  for (let y = 1950; y <= 2005; y++) {
    const yearOption = document.createElement("option");
    yearOption.value = y;
    yearOption.textContent = y;
    yearDropdown.appendChild(yearOption);
  }

  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  months.forEach((month, index) => {
    const monthOption = document.createElement("option");
    monthOption.value = index + 1;
    monthOption.textContent = month;
    monthDropdown.appendChild(monthOption);
  });

  function populateDays(yearDropdown, monthDropdown, dayDropdown) {
    if (!yearDropdown || !monthDropdown || !dayDropdown) {
      return;
    }

    // Get number of days in selected month/year
    const year = parseInt(yearDropdown.value);
    const month = parseInt(monthDropdown.value);

    if (isNaN(year) || isNaN(month)) {
      return;
    }

    const daysInMonth = new Date(year, month, 0).getDate();

    // Populate day dropdown
    for (let day = 1; day <= daysInMonth; day++) {
      const dayOption = document.createElement("option");
      dayOption.value = day;
      dayOption.textContent = day;
      dayDropdown.appendChild(dayOption);
    }
  }

  // Event listeners
  yearDropdown.addEventListener("change", () =>
    populateDays(yearDropdown, monthDropdown, dayDropdown)
  );
  monthDropdown.addEventListener("change", () =>
    populateDays(yearDropdown, monthDropdown, dayDropdown)
  );
};
