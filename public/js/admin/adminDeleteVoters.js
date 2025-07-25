window.initDeleteVoters=function(){

    console.log("Admin Delete Voters JS Loaded");

    
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

};