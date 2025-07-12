window.initAdminUpdateParties = function () {
  console.log("Admin Update Parties JS Is Loaded");

  const stored = sessionStorage.getItem("selectedElection");
  if (!stored) {
    alert("Missing Election Data");
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
  console.log("Number Of Parties:", numOfParties);

  const container = document.getElementById("party-forms");

  for (let i = 1; i <= numOfParties; i++) {
    const wrapper = document.createElement("div");
    wrapper.classList.add("party-form-wrapper");

    const heading = document.createElement("h2");
    heading.textContent = `Party ${i} Form`;
    wrapper.appendChild(heading);

    const form = document.createElement("form");

    form.appendChild(
      createFormField("text", "Party ID", `partyID-${i}`, `PID-${i}`, {
        readOnly: true,
      })
    );
    form.appendChild(createFormField("text", "Party Name", `partyName-${i}`));
    form.appendChild(
      createFormField("text", "Party Leader Name", `partyLeaderName-${i}`)
    );
    form.appendChild(
      createFormField("file", "Party Leader Picture", `leaderPic-${i}`)
    );
    form.appendChild(
      createFormField("select", "Party Established Year", `estYear-${i}`, "", {
        choices: generateYearOptions(1950, new Date().getFullYear()),
      })
    );
    form.appendChild(createFormField("file", "Party Logo", `partyLogo-${i}`));
    form.appendChild(
      createFormField("number", "Total Candidates", `totalCandidates-${i}`)
    );
    form.appendChild(
      createFormField("text", "Election ID", `electionID-${i}`, electionID, {
        readOnly: true,
      })
    );

    const buttonGroup = document.createElement("div");
    buttonGroup.classList.add("button-group");

    const updateBtn = document.createElement("button");
    updateBtn.type = "button";
    updateBtn.textContent = "Update";
    updateBtn.classList.add("update-btn");

    const disableBtn = document.createElement("button");
    disableBtn.type = "button";
    disableBtn.textContent = "Disable";
    disableBtn.classList.add("disable-btn");

    updateBtn.addEventListener("click", () => {
      showCustomConfirm(
        `Are you sure you want to update the data of party ${i}?`,
        () => {
          console.log(`Update confirmed for Party ${i}`);
          const partyName = form.querySelector(`#partyName-${i}`).value;
          console.log("Party Name:", partyName);
          // TODO: handle update logic
        }
      );
    });

    disableBtn.addEventListener("click", () => {
      showCustomConfirm("Are you sure you want to disable this party?", () => {
        console.log(`Party ${i} disabled!`);
        // TODO: handle disable logic
      });
    });

    buttonGroup.appendChild(updateBtn);
    buttonGroup.appendChild(disableBtn);
    form.appendChild(buttonGroup);

    wrapper.appendChild(form);
    container.appendChild(wrapper);
  }

  // Helper to create fields
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

  // Helper to generate year options
  function generateYearOptions(start, end) {
    const years = [];
    for (let y = end; y >= start; y--) {
      years.push(y);
    }
    return years;
  }


// Create modal HTML
function createCustomConfirmModal() {
  const modal = document.createElement("div");
  modal.id = "confirmModal";
  modal.className = "modal";
  modal.style.display = "none";
  modal.innerHTML = `
    <div class="modal-content">
      <p id="confirmMessage"></p>
      <div class="modal-buttons">
        <button id="modalConfirmBtn">Yes</button>
        <button id="modalCancelBtn">No</button>
      </div>
    </div>
  `;
  document.body.appendChild(modal);
}

// Show modal with custom message and callback
function showCustomConfirm(message, onConfirm) {
  const modal = document.getElementById("confirmModal");
  const messageElem = document.getElementById("confirmMessage");
  const confirmBtn = document.getElementById("modalConfirmBtn");
  const cancelBtn = document.getElementById("modalCancelBtn");

  messageElem.textContent = message;
  modal.classList.add("show");

  function closeModal() {
    modal.classList.remove("show");
    confirmBtn.removeEventListener("click", confirmHandler);
    cancelBtn.removeEventListener("click", closeModal);
  }

  function confirmHandler() {
    onConfirm();
    closeModal();
  }

  confirmBtn.addEventListener("click", confirmHandler);
  cancelBtn.addEventListener("click", closeModal);
}
};