window.initViewCandidates=function(){

    console.log("View Cnadidates JS is Loaded..");

    // logic to handle view candidate functionality 
    const candidateIdInput=document.getElementById("searchCandidateId");
    const searchButton = document.getElementById("searchCandidateBtn");

    function handleSearch(){
        const candidateID=candidateIdInput.value.trim();
        if(!candidateID){
            alert("Please Enter Valid Candidate ID to view");
            return;
        }

        // logic to fetch candidate data
        // fetchCandidateData(candidateID);
    }

    searchButton.addEventListener("click",handleSearch);

    candidateIdInput.addEventListener("keypress",function(event){
        if(event.key==="Enter"){
            handleSearch();
        }
    });
};