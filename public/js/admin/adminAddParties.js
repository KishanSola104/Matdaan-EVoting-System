window.initAdminAddParties = function () {
  console.log("Admin Add Parties JS Loaded");

  const stored = sessionStorage.getItem("selectedElection");
  if (!stored) {
    alert("Missing election data. Please go back and select an election again.");
    window.history.back();
    return;
  }

  const electionData = JSON.parse(stored);
  const electionID = electionData.electionID;
  const electionName = electionData.electionName;
  const stateName = electionData.stateName;
  const numOfParties = electionData.numOfParties;

  console.log("Election ID:", electionID);
  console.log("Election Name:", electionName);
  console.log("State Name:", stateName);
  console.log("Num of Parties:", numOfParties);

  const container = document.getElementById("party-forms");

  for (let i = 1; i <= numOfParties; i++) {
    // Create wrapper div for each party form
    const wrapper = document.createElement("div");
    wrapper.classList.add("party-form-wrapper");

    // Heading for the party form
    const heading = document.createElement("h2");
    heading.textContent = `Party ${i} Form`;
    wrapper.appendChild(heading);

    const form = document.createElement("form");

    // Append fields to form
    form.appendChild(createFormField("text", "Party ID", `partyID-${i}`));
    form.appendChild(createFormField("text", "Party Name", `partyName-${i}`));
    form.appendChild(createFormField("text", "Party Leader Name", `partyLeaderName-${i}`));
    form.appendChild(createFormField("file", "Party Leader Picture", `leaderPic-${i}`));
    form.appendChild(
      createFormField("select", "Party Established Year", `estYear-${i}`, "", {
        choices: generateYearOptions(1950, new Date().getFullYear()),
      })
    );
    form.appendChild(createFormField("file", "Party Logo", `partyLogo-${i}`));
    form.appendChild(createFormField("number", "Total Candidates", `totalCandidates-${i}`));
    form.appendChild(
      createFormField("text", "Election ID", `electionID-${i}`, electionID, {
        readOnly: true,
      })
    );

    // Submit & Cancel buttons
    const buttonGroup = document.createElement("div");
    buttonGroup.classList.add("button-group");

    const submitBtn = document.createElement("button");
    submitBtn.type = "submit";
    submitBtn.textContent = "Submit";
    submitBtn.classList.add("submit-btn");

    const cancelBtn = document.createElement("button");
    cancelBtn.type = "button";
    cancelBtn.textContent = "Cancel";
    cancelBtn.classList.add("cancel-btn");

    buttonGroup.appendChild(submitBtn);
    buttonGroup.appendChild(cancelBtn);
    form.appendChild(buttonGroup);

    // Append form to wrapper
    wrapper.appendChild(form);

    // Finally append wrapper to container
    container.appendChild(wrapper);
  }

  // Utility to generate individual form fields
  function createFormField(type, labelText, name, value = "", options = {}) {
    const fieldWrapper = document.createElement("div");
    fieldWrapper.classList.add("form-group");

    const label = document.createElement("label");
    label.textContent = labelText;
    label.setAttribute("for", name);

    let input;
    if (type === "select") {
      input = document.createElement("select");
      input.id = name;
      input.name = name;

      options.choices.forEach((choice) => {
        const opt = document.createElement("option");
        opt.value = choice;
        opt.textContent = choice;
        input.appendChild(opt);
      });
    } else {
      input = document.createElement("input");
      input.type = type;
      input.id = name;
      input.name = name;
      input.value = value;

      if (options.readOnly) {
        input.readOnly = true;
      }
    }

    fieldWrapper.appendChild(label);
    fieldWrapper.appendChild(input);

    return fieldWrapper;
  }

  // Utility to generate a range of years
  function generateYearOptions(start, end) {
    const years = [];
    for (let y = end; y >= start; y--) {
      years.push(y);
    }
    return years;
  }
};
