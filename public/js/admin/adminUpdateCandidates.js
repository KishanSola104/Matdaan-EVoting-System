window.initUpdateCandidates = function () {
  console.log("Update Candidates JS is Loaded..");

  // get the partdata from the session variables
  const partyData = JSON.parse(sessionStorage.getItem("selectedPartyData"));
  const electionId = partyData.electionId;
  const partyID = partyData.partyID;
  const partyName = partyData.partyName;

  document.getElementById("partyId").value = partyID;
  document.getElementById("partyName").value = partyName;

  // List of Indian States and Union Territories
  const indianStatesAndUTs = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli and Daman and Diu",
    "Delhi",
    "Jammu and Kashmir",
    "Ladakh",
    "Lakshadweep",
    "Puducherry",
  ];

  indianStatesAndUTs.sort();

  //get All the dropdowns
  const stateDropdown = document.getElementById("state");
  const districtDropdown = document.getElementById("district");
  const yearDropdown = document.getElementById("Year");
  const monthDropdown = document.getElementById("Month");
  const dayDropdown = document.getElementById("Day");

  setLabel(stateDropdown, "Select State");

  indianStatesAndUTs.forEach((state) => {
    const stateOption = document.createElement("option");
    stateOption.value = state;
    stateOption.textContent = state;
    stateDropdown.appendChild(stateOption);
  });

  setLabel(districtDropdown, "Select District");
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

  // On the selection of the State, fill up the Districts according to that state
  stateDropdown.addEventListener("change", async () => {
    const selectedState = stateDropdown.value;

    // Clear previous districts
    districtDropdown.innerHTML =
      "<option value=''>-- Select District --</option>";

    if (!selectedState) return;

    try {
      const result = await fetch(
        `/api/districts?state=${encodeURIComponent(selectedState)}`
      );

      if (!result.ok) throw new Error("Network response was not ok");

      const data = await result.json(); //  await added here

      // Validate the structure
      if (!Array.isArray(data.districts)) {
        console.error("Unexpected response structure:", data);
        return;
      }

      // Append districts
      data.districts.forEach((district) => {
        const option = document.createElement("option");
        option.value = district;
        option.textContent = district;
        districtDropdown.appendChild(option);
      });
    } catch (error) {
      console.error("Error in fetching districts: ", error);
    }
  });
};
