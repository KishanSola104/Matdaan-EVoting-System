window.initDeleteCandidates = function () {
  // Remove console.log in production
  const candidateIdInput = document.getElementById("searchCandidateId");
  const searchButton = document.getElementById("searchCandidateBtn");

  function handleSearch() {
    const candidateID = candidateIdInput.value.trim();
    if (!candidateID) {
      alert("Please Enter A Valid Candidate ID to delete");
      return;
    }
    // Fetch candidate data logic here
  }

  searchButton.addEventListener("click", handleSearch);

  candidateIdInput.addEventListener("keypress", function (event) {
    if (event.key === "Enter") {
      handleSearch();
    }
  });
};