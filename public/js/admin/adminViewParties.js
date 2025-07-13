window.initAdminViewParties = function () {
  console.log("Admin View Parties JS Loaded");

  // Check session storage for election data
  const stored = sessionStorage.getItem("selectedElection");
  if (!stored) {
    alert("Missing Election Data");
    window.history.back();
    return;
  }

  const electionData = JSON.parse(stored);
  const { electionID, electionName, stateName, numOfParties } = electionData;

  console.log("Election ID:", electionID);
  console.log("Election Name:", electionName);
  console.log("State Name:", stateName);
  console.log("Number Of Parties:", numOfParties);

  const container = document.getElementById("party-forms");

  for (let i = 1; i <= numOfParties; i++) {
    const wrapper = document.createElement("div");
    wrapper.classList.add("party-form-wrapper");

    const heading = document.createElement("h2");
    heading.textContent = `Party ${i} Form`;
    wrapper.appendChild(heading);

    const form = document.createElement("form");

    // All fields are read-only in View page
    form.appendChild(
      createFormField("text", "Party ID", `partyID-${i}`, `PID-${i}`, {
        readOnly: true,
      })
    );
    form.appendChild(
      createFormField("text", "Party Name", `partyName-${i}`, "", {
        readOnly: true,
      })
    );
    form.appendChild(
      createFormField("text", "Party Leader Name", `partyLeaderName-${i}`, "", {
        readOnly: true,
      })
    );

    // Leader image preview
    const leaderImg = createPlaceholderImage(
      `currentLeaderImg-${i}`,
      "https://via.placeholder.com/120x80?text=No+Leader",
      "Current Leader Image Placeholder"
    );
    form.appendChild(leaderImg);

    form.appendChild(
      createFormField("select", "Party Established Year", `estYear-${i}`, "", {
        choices: generateYearOptions(1950, new Date().getFullYear()),
        readOnly: true,
      })
    );

    // Party logo preview
    const logoImg = createPlaceholderImage(
      `currentPartyLogo-${i}`,
      "https://via.placeholder.com/120x80?text=No+Logo",
      "Current Party Logo Placeholder"
    );
    form.appendChild(logoImg);

    form.appendChild(
      createFormField(
        "number",
        "Total Candidates",
        `totalCandidates-${i}`,
        "",
        { readOnly: true }
      )
    );
    form.appendChild(
      createFormField("text", "Election ID", `electionID-${i}`, electionID, {
        readOnly: true,
      })
    );

    wrapper.appendChild(form);
    container.appendChild(wrapper);
  }

  // ------- Helper functions -------

  /* Creates a label + input field
   */
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
      input.disabled = true;
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

  /*Creates a dummy placeholder image element
   */
  function createPlaceholderImage(id, src, alt) {
    const img = document.createElement("img");
    img.id = id;
    img.src = src;
    img.alt = alt;
    img.classList.add("preview-image");
    return img;
  }

  /*Generate array of years
   */
  function generateYearOptions(start, end) {
    const years = [];
    for (let y = end; y >= start; y--) {
      years.push(y);
    }
    return years;
  }
};
