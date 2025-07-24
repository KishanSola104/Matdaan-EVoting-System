window.initAdminVoters = function () {
  console.log("Admin Voters JS Loaded");

  const buttonGroup = document.querySelector(".button-group");
  const stateDropdown = document.getElementById("state");
  const districtDropdown = document.getElementById("district");

  const addVotersBtn = document.getElementById("addVotersBtn");
  const updateVotersBtn = document.getElementById("updateVotersBtn");
  const deleteVotersBtn = document.getElementById("deleteVotersBtn");
  const viewVotersBtn = document.getElementById("viewVotersBtn");
  const cancelBtn = document.getElementById("cancelBtn");

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
  ].sort();

  // Hide buttons initially
  buttonGroup.style.display = "none";

  // Clear dropdowns safely
  function resetDropdown(selectElement, defaultLabel) {
    selectElement.innerHTML = "";
    const option = document.createElement("option");
    option.value = "";
    option.textContent = defaultLabel;
    option.disabled = true;
    option.selected = true;
    selectElement.appendChild(option);
  }

  // Initial dropdown population
  resetDropdown(stateDropdown, "Select State");
  resetDropdown(districtDropdown, "Select District");

  indianStatesAndUTs.forEach((state) => {
    const opt = document.createElement("option");
    opt.value = state;
    opt.textContent = state;
    stateDropdown.appendChild(opt);
  });

  // State change handler
  stateDropdown.addEventListener("change", async () => {
    const selectedState = stateDropdown.value;
    resetDropdown(districtDropdown, "Select District");

    if (!selectedState) {
      buttonGroup.style.display = "none";
      return;
    }

    try {
      const response = await fetch(
        `/api/districts?state=${encodeURIComponent(selectedState)}`
      );
      if (!response.ok)
        throw new Error(`HTTP error! Status: ${response.status}`);

      const data = await response.json();

      if (!Array.isArray(data.districts)) {
        throw new Error("Malformed response: 'districts' not an array");
      }

      if (data.districts.length === 0) {
        console.warn("No districts returned for state:", selectedState);
        return;
      }

      data.districts.forEach((district) => {
        const opt = document.createElement("option");
        opt.value = district;
        opt.textContent = district;
        districtDropdown.appendChild(opt);
      });
    } catch (err) {
      console.error("Failed to load districts:", err.message);
      alert("Failed to load districts. Please try again.");
    }

    buttonGroup.style.display = "none"; // Still wait for district selection
  });

  // District selection handler
  districtDropdown.addEventListener("change", () => {
    const selectedDistrict = districtDropdown.value;
    if (selectedDistrict) {
      buttonGroup.style.display = "grid"; // Show buttons
    } else {
      buttonGroup.style.display = "none";
    }
  });

  // Cancel button resets everything
  cancelBtn.addEventListener("click", () => {
    resetDropdown(stateDropdown, "Select State");
    resetDropdown(districtDropdown, "Select District");

    // Repopulate state options
    indianStatesAndUTs.forEach((state) => {
      const opt = document.createElement("option");
      opt.value = state;
      opt.textContent = state;
      stateDropdown.appendChild(opt);
    });

    buttonGroup.style.display = "none";
  });

  addVotersBtn.addEventListener("click", () => {
  const selectedStateDistrict = getSessionValues();
  if (!selectedStateDistrict) return; 

  sessionStorage.setItem(
    "selectedStateDistrict",
    JSON.stringify(selectedStateDistrict)
  );

  loadContent("/admin/adminAddVoters.html");
});

updateVotersBtn.addEventListener("click",()=>{
  const selectedStateDistrict=getSessionValues();
  if(!selectedStateDistrict) return;

  sessionStorage.setItem("selectedStateDistrict",JSON.stringify(selectedStateDistrict));

  loadContent("/admin/adminUpdateVoters.html");
});

deleteVotersBtn.addEventListener("click",()=>{
 const selectedStateDistrict=getSessionValues();
  if(!selectedStateDistrict) return;

  sessionStorage.setItem("selectedStateDistrict",JSON.stringify(selectedStateDistrict));

  loadContent("/admin/adminDeleteVoters.html");
});

viewVotersBtn.addEventListener("click",()=>{
 const selectedStateDistrict=getSessionValues();
  if(!selectedStateDistrict) return;

  sessionStorage.setItem("selectedStateDistrict",JSON.stringify(selectedStateDistrict));

  loadContent("/admin/adminViewVoters.html");
});

// function to get the selected state and district
  function getSessionValues() {
  const selectedState = stateDropdown.value;
  const selectedDistrict = districtDropdown.value;
  if (!selectedState || !selectedDistrict) {
    alert("Please select both state and district before adding voters");
    return;
  }
  return { state: selectedState, district: selectedDistrict };
}

  
};
