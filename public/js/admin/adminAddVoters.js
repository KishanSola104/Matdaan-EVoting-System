window.initAddVoters = function () {
  console.log("Admin Add Voters JS Loaded");

  // Populate the date of birth dropdowns
  const yearSelect = document.getElementById("dobYear");
  const monthSelect = document.getElementById("dobMonth");
  const daySelect = document.getElementById("dobDay");

  // Add default label options
  yearSelect.innerHTML = `<option value="">Year</option>`;
  monthSelect.innerHTML = `<option value="">Month</option>`;
  daySelect.innerHTML = `<option value="">Day</option>`;

  // Populate Year dropdown
  for (let y = 2006; y >= 1900; y--) {
    yearSelect.innerHTML += `<option value="${y}">${y}</option>`;
  }

  // Month names for display
  const monthNames = [
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

  // Populate Month dropdown with names
  for (let m = 1; m <= 12; m++) {
    const monthName = monthNames[m - 1];
    monthSelect.innerHTML += `<option value="${m}">${monthName}</option>`;
  }

  // Function to update days based on selected month and year
  function updateDays() {
    const year = parseInt(yearSelect.value);
    const month = parseInt(monthSelect.value);

    // Reset day dropdown
    daySelect.innerHTML = `<option value="">Day</option>`;

    if (!year || !month) return;

    const daysInMonth = new Date(year, month, 0).getDate();

    for (let d = 1; d <= daysInMonth; d++) {
      daySelect.innerHTML += `<option value="${d}">${d}</option>`;
    }
  }

  // Trigger day update when year or month changes
  yearSelect.addEventListener("change", updateDays);
  monthSelect.addEventListener("change", updateDays);

  // get the state and district dropdowns
  const stateDropdown = document.getElementById("voterState");
  const districtDropdown = document.getElementById("voterDistrict");

  const selectedStateDistrict = sessionStorage.getItem("selectedStateDistrict");
  if (selectedStateDistrict) {
    const stateDistrictObj = JSON.parse(selectedStateDistrict);
    stateDropdown.value = stateDistrictObj.state;
    districtDropdown.value = stateDistrictObj.district;
  }

  // on cancel click reset All Input Fields except The State and district
  const cancelBtn = document.getElementById("cancelVoterBtn");

  cancelBtn.addEventListener("click", () => {
    // Reset basic text inputs
    document.getElementById("voterId").value = "";
    document.getElementById("aadharNumber").value = "";
    document.getElementById("voterName").value = "";
    document.getElementById("voterEmail").value = "";
    document.getElementById("voterMobile").value = "";

    // Reset Gender radio buttons
    const genderRadios = document.getElementsByName("gender");
    genderRadios.forEach((radio) => (radio.checked = false));

    // Reset DOB dropdowns
    const yearSelect = document.getElementById("dobYear");
    const monthSelect = document.getElementById("dobMonth");
    const daySelect = document.getElementById("dobDay");

    yearSelect.innerHTML = `<option value="">Year</option>`;
    monthSelect.innerHTML = `<option value="">Month</option>`;
    daySelect.innerHTML = `<option value="">Day</option>`;

    for (let y = 2006; y >= 1900; y--) {
      yearSelect.innerHTML += `<option value="${y}">${y}</option>`;
    }

    const monthNames = [
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
    for (let m = 1; m <= 12; m++) {
      monthSelect.innerHTML += `<option value="${m}">${
        monthNames[m - 1]
      }</option>`;
    }

    // Clear image file input
    document.getElementById("voterImage").value = "";

    // NOTE: State and District are intentionally NOT reset
  });
};
