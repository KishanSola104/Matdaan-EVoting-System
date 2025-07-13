window.initAdminUpdateParties = function () {
  console.log("Admin Update Parties JS Is Loaded");

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

    // Create form fields
    form.appendChild(createFormField("text", "Party ID", `partyID-${i}`, `PID-${i}`, { readOnly: true }));
    form.appendChild(createFormField("text", "Party Name", `partyName-${i}`));
    form.appendChild(createFormField("text", "Party Leader Name", `partyLeaderName-${i}`));

    // Leader image preview
    const leaderImg = createPlaceholderImage(`currentLeaderImg-${i}`, "https://via.placeholder.com/120x80?text=No+Leader", "Current Leader Image Placeholder");
    form.appendChild(leaderImg);

    // Leader image file input
    form.appendChild(createFormField("file", "Party Leader Picture", `leaderPic-${i}`));

    form.appendChild(
      createFormField("select", "Party Established Year", `estYear-${i}`, "", {
        choices: generateYearOptions(1950, new Date().getFullYear()),
      })
    );

    // Party logo preview
    const logoImg = createPlaceholderImage(`currentPartyLogo-${i}`, "https://via.placeholder.com/120x80?text=No+Logo", "Current Party Logo Placeholder");
    form.appendChild(logoImg);

    // Party logo file input
    form.appendChild(createFormField("file", "Party Logo", `partyLogo-${i}`));

    form.appendChild(createFormField("number", "Total Candidates", `totalCandidates-${i}`));
    form.appendChild(createFormField("text", "Election ID", `electionID-${i}`, electionID, { readOnly: true }));

    // Live preview on file selection
    attachImagePreview(`leaderPic-${i}`, `currentLeaderImg-${i}`);
    attachImagePreview(`partyLogo-${i}`, `currentPartyLogo-${i}`);

    // Buttons
    const buttonGroup = document.createElement("div");
    buttonGroup.classList.add("button-group");

    const updateBtn = document.createElement("button");
    updateBtn.type = "button";
    updateBtn.textContent = "Update";
    updateBtn.classList.add("update-btn");
    updateBtn.addEventListener("click", () => {
      showCustomConfirm(`Are you sure you want to update the data of party ${i}?`, () => {
        console.log(`Update confirmed for Party ${i}`);
        const partyName = form.querySelector(`#partyName-${i}`).value;
        console.log("Party Name:", partyName);
        // TODO: handle update logic
      });
    });

    const disableBtn = document.createElement("button");
    disableBtn.type = "button";
    disableBtn.textContent = "Disable";
    disableBtn.classList.add("disable-btn");
    disableBtn.addEventListener("click", () => {
      showCustomConfirm(`Are you sure you want to disable party ${i}?`, () => {
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

  // ------- Helper functions -------

  /**
   * Creates a label + input (or select) field
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

  /**
   * Creates a dummy placeholder image element
   */
  function createPlaceholderImage(id, src, alt) {
    const img = document.createElement("img");
    img.id = id;
    img.src = src;
    img.alt = alt;
    img.classList.add("preview-image");
    return img;
  }

  /**
   * Attach change listener to update preview image
   */
  function attachImagePreview(inputId, imgId) {
    // defer until the input exists in DOM
    setTimeout(() => {
      const input = document.getElementById(inputId);
      if (input) {
        input.addEventListener("change", (e) => {
          const file = e.target.files[0];
          if (file) {
            const url = URL.createObjectURL(file);
            const imgElem = document.getElementById(imgId);
            if (imgElem) {
              imgElem.src = url;
            }
          }
        });
      }
    }, 0);
  }

  /**
   * Generate array of years
   */
  function generateYearOptions(start, end) {
    const years = [];
    for (let y = end; y >= start; y--) {
      years.push(y);
    }
    return years;
  }

  /**
   * Create modal HTML for custom confirmation
   */
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

  /**
   * Show custom confirmation modal
   */
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
