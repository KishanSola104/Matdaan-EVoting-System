window.initAddCandidates = function () {
  console.log("Add Candidates Page JS is Loaded..");

  // List of Indian States and Union Territories
  const indianStatesAndUTs = [
    "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar",
    "Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh",
    "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra",
    "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha",
    "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana",
    "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal",
    "Andaman and Nicobar Islands", "Chandigarh",
    "Dadra and Nagar Haveli and Daman and Diu", "Delhi",
    "Jammu and Kashmir", "Ladakh", "Lakshadweep", "Puducherry"
  ];

  // Dropdown elements
  const stateDropdown = document.getElementById("state");
  const districtDropdown = document.getElementById("district");
  const year = document.getElementById("Year");
  const month = document.getElementById("Month");
  const day = document.getElementById("Day");

  // Set default labels
  setDropdownLabel(stateDropdown, "Select State");
  setDropdownLabel(districtDropdown, "Select District");
  setDropdownLabel(year, "Year");
  setDropdownLabel(month, "Month");
  setDropdownLabel(day, "Day");

  // Populate states
  indianStatesAndUTs.forEach(state => {
    stateDropdown.appendChild(new Option(state, state));
  });

  // Fetch districts based on selected state
  stateDropdown.addEventListener("change", function () {
    const selectedState = this.value;
    console.log("State selected:", selectedState);

    if (selectedState) {
      fetch(`/api/districts?state=${encodeURIComponent(selectedState)}`)
        .then(response => {
          if (!response.ok) {
            throw new Error("Network response was not ok");
          }
          return response.json();
        })
        .then(data => {
          console.log("Districts fetched:", data);
          populateDistricts(data.districts || []);
        })
        .catch(error => {
          console.error("Error loading districts:", error);
          clearDistrictDropdown();
        });
    } else {
      clearDistrictDropdown();
    }
  });

  // Helpers
  function setDropdownLabel(selectElement, labelText) {
    const labelOption = document.createElement("option");
    labelOption.value = "";
    labelOption.textContent = labelText;
    selectElement.appendChild(labelOption);
  }

  function populateDistricts(districts) {
    districtDropdown.innerHTML = "";
    setDropdownLabel(districtDropdown, "Select District");
    districts.forEach(district => {
      districtDropdown.appendChild(new Option(district, district));
    });
  }

  function clearDistrictDropdown() {
    districtDropdown.innerHTML = "";
    setDropdownLabel(districtDropdown, "Select District");
  }
};
