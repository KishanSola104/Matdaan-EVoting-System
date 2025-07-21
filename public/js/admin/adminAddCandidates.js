window.initAddCandidates = function () {
  console.log("Add Candidates Page JS is Loaded..");

  // get The selected Party Data
  const partyData = JSON.parse(sessionStorage.getItem("selectedPartyData"));
  const electionId = partyData.electionId;
  const partyID = partyData.partyID;
  const partyName = partyData.partyName;

  // set The Default values for HTML inputs
  document.getElementById("electionId").value = electionId;
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

  // Dropdown elements
  const stateDropdown = document.getElementById("state");
  const districtDropdown = document.getElementById("district");
  const yearDropdown = document.getElementById("Year");
  const monthDropdown = document.getElementById("Month");
  const dayDropdown = document.getElementById("Day");



  // Set default labels
  setDropdownLabel(stateDropdown, "Select State");
  setDropdownLabel(districtDropdown, "Select District");
  setDropdownLabel(yearDropdown, "Year");
  setDropdownLabel(monthDropdown, "Month");
  setDropdownLabel(dayDropdown, "Day");

    // Populate states
  indianStatesAndUTs.forEach((state) => {
    stateDropdown.appendChild(new Option(state, state));
  });

  indianStatesAndUTs.sort();

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

  // fill up the drop down for The Year , Month and Day
  for (let y = 1950; y <= 2005; y++) {
    const option = document.createElement("option");
    option.value = y;
    option.textContent = y;
    yearDropdown.appendChild(option);
  }

  // fufill The Months
  months.forEach((m, index) => {
    const option = document.createElement("option");
    option.value = index + 1; // Optional: use 1-12
    option.textContent = m;
    monthDropdown.appendChild(option);
  });

  // populate The days accroding to The selected year and month 
  function updateDays(){
    const year=parseInt(yearDropdown.value);
    const month=parseInt(monthDropdown.value);

    if(!year || !month) return;

    // get The Number of Days in each Month for the selected Year 
    const daysInMonth=new Date(year,month,0).getDate();

    // Clear previous options
  //dayDropdown.innerHTML = "";

  for (let d = 1; d <= daysInMonth; d++) {
    const option = document.createElement("option");
    option.value = d;
    option.textContent = d;
    dayDropdown.appendChild(option);
  }

  }

  yearDropdown.addEventListener("change",updateDays);
  monthDropdown.addEventListener("change",updateDays);


   stateDropdown.addEventListener("change", async () => {
    const selectedState = stateDropdown.value;

    // Clear previous districts
    districtDropdown.innerHTML = '<option value="">Select District</option>';

    if (!selectedState) return;

    try {
      const res = await fetch(`/api/districts?state=${encodeURIComponent(selectedState)}`);
      const data = await res.json();

      data.districts.forEach((district) => {
        const option = document.createElement("option");
        option.value = district;
        option.textContent = district;
        districtDropdown.appendChild(option);
      });
    } catch (err) {
      console.error("Error fetching districts:", err);
    }
  });

  // Helpers
  function setDropdownLabel(selectElement, labelText) {
    const labelOption = document.createElement("option");
    labelOption.value = "";
    labelOption.textContent = labelText;
    selectElement.appendChild(labelOption);
  }
};
