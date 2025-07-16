window.initAddCandidates = function () {
  console.log("Add Candidates Page JS is Loaded .. ");

  const indianStatesAndUTs = [
    "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar",
    "Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh",
    "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh",
    "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland",
    "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu",
    "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand",
    "West Bengal", "Andaman and Nicobar Islands", "Chandigarh",
    "Dadra and Nagar Haveli and Daman and Diu", "Delhi",
    "Jammu and Kashmir", "Ladakh", "Lakshadweep", "Puducherry"
  ];

  const stateDropdown = document.getElementById("state");
  const districtDropdown = document.getElementById("district");
  const year = document.getElementById("Year");
  const month = document.getElementById("Month");
  const day = document.getElementById("Day");

  getDropdownLabel(stateDropdown, "Select State");
  getDropdownLabel(districtDropdown, "Select District");
  getDropdownLabel(year, "Year");
  getDropdownLabel(month, "Month");
  getDropdownLabel(day, "Day");

  indianStatesAndUTs.forEach(st => {
    stateDropdown.appendChild(new Option(st, st));
  });

  stateDropdown.addEventListener("change", function () {
    const selectedState = this.value;
    console.log("State selected:", selectedState);

    if (selectedState) {
      fetch(`/api/districts?state=${encodeURIComponent(selectedState)}`)
        .then(response => {
          console.log("Fetch response:", response);
          return response.json();
        })
        .then(data => {
          console.log("Districts fetched:", data);
          populateDistricts(data.districts);
        })
        .catch(error => {
          console.error("Error loading districts:", error);
        });
    } else {
      clearDistrictDropdown();
    }
  });

  function getDropdownLabel(select, labelText) {
    const label = document.createElement("option");
    label.value = "";
    label.textContent = labelText;
    select.appendChild(label);
  }

  function populateDistricts(districts) {
    districtDropdown.innerHTML = "";
    getDropdownLabel(districtDropdown, "Select District");
    districts.forEach(d => {
      districtDropdown.appendChild(new Option(d, d));
    });
  }

  function clearDistrictDropdown() {
    districtDropdown.innerHTML = "";
    getDropdownLabel(districtDropdown, "Select District");
  }
};


