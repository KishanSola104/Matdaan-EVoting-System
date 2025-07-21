window.initUpdateCandidates = function () {
  console.log("Update Candidates JS is Loaded..");

  // get the partdata from the session variables
  const partyData = JSON.parse(sessionStorage.getItem("selectedPartyData"));
  const electionId = partyData.electionId;
  const partyID = partyData.partyID;
  const partyName = partyData.partyName;

  document.getElementById("partyId").value = partyID;
  document.getElementById("partyName").value=partyName;
};
