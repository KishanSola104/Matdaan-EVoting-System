window.initAdminViewParties = function () {
  console.log("Admin View Parties JS Loaded");

  // Get election info from session storage
  const stored = sessionStorage.getItem("selectedElection");

  if (!stored) {
    alert("Missing Election Data");
    window.history.back();
    return;
  }

  const electionData = JSON.parse(stored);

  const container = document.getElementById("party-forms");

  // Loop through all parties
  for (let i = 1; i <= electionData.numOfParties; i++) {
    // Create a wrapper div
    const wrapper = document.createElement("div");
    wrapper.className = "party-form-wrapper";

    // Add a heading
    const heading = document.createElement("h2");
    heading.textContent = `Party ${i} Form`;
    wrapper.appendChild(heading);

    // Create the form
    const form = document.createElement("form");

    // Add read-only fields
    form.appendChild(createField("text", "Party ID", `partyID-${i}`, `PID-${i}`));
    form.appendChild(createField("text", "Party Name", `partyName-${i}`));
    form.appendChild(createField("text", "Party Leader Name", `partyLeaderName-${i}`));

    // Add leader image
    form.appendChild(createImage(`currentLeaderImg-${i}`, "https://via.placeholder.com/120x80?text=No+Leader", "Leader Image"));

    // Add established year dropdown
    const years = getYears(1950, new Date().getFullYear());
    form.appendChild(createSelect("Party Established Year", `estYear-${i}`, years));

    // Add party logo image
    form.appendChild(createImage(`currentPartyLogo-${i}`, "https://via.placeholder.com/120x80?text=No+Logo", "Party Logo"));

    form.appendChild(createField("number", "Total Candidates", `totalCandidates-${i}`));
    form.appendChild(createField("text", "Election ID", `electionID-${i}`, electionData.electionID));

    wrapper.appendChild(form);
    container.appendChild(wrapper);
  }

  // ------- Helper Functions ----------

  function createField(type, label, name, value = "") {
    const group = document.createElement("div");
    group.className = "form-group";

    const labelEl = document.createElement("label");
    labelEl.textContent = label;
    labelEl.htmlFor = name;

    const input = document.createElement("input");
    input.type = type;
    input.id = name;
    input.name = name;
    input.value = value;
    input.readOnly = true;

    group.appendChild(labelEl);
    group.appendChild(input);
    return group;
  }

  function createSelect(label, name, options) {
    const group = document.createElement("div");
    group.className = "form-group";

    const labelEl = document.createElement("label");
    labelEl.textContent = label;
    labelEl.htmlFor = name;

    const select = document.createElement("select");
    select.id = name;
    select.name = name;
    select.disabled = true;

    options.forEach(year => {
      const option = document.createElement("option");
      option.value = year;
      option.textContent = year;
      select.appendChild(option);
    });

    group.appendChild(labelEl);
    group.appendChild(select);
    return group;
  }

  function createImage(id, src, alt) {
    const img = document.createElement("img");
    img.id = id;
    img.src = src;
    img.alt = alt;
    img.className = "preview-image";
    return img;
  }

  function getYears(start, end) {
    const arr = [];
    for (let year = end; year >= start; year--) {
      arr.push(year);
    }
    return arr;
  }
};
