console.log("Register page initialized");

// Get All Input Fields
const voterId = document.getElementById("voterId");
const voterName = document.getElementById("voterName");
const voterState = document.getElementById("state");
const voterDistrict = document.getElementById("district");
const email = document.getElementById("email");
const mobileNumber = document.getElementById("mobileNumber");
const dobYear = document.getElementById("dobYear");
const dobMonth = document.getElementById("dobMonth");
const dobDay = document.getElementById("dobDay");
const password = document.getElementById("password");
const confirmPassword = document.getElementById("confirmPassword");
const termsCheckbox = document.getElementById("terms");
const formMessage = document.getElementById("formMessage");

// Error message elements
const voterIdError = document.getElementById("voterIdError");
const voterNameError = document.getElementById("voterNameError");
const stateError = document.getElementById("stateError");
const districtError = document.getElementById("districtError");
const emailError = document.getElementById("emailError");
const mobileNumberError = document.getElementById("mobileNumberError");
const dobError = document.getElementById("dobError");
const passwordError = document.getElementById("passwordError");
const confirmPasswordError = document.getElementById("confirmPasswordError");
const genderError = document.getElementById("genderError");
const termsError = document.getElementById("termsError");

// Gender
function getSelectedGender() {
  const gender = document.querySelector('input[name="gender"]:checked');
  return gender ? gender.value : null;
}

// 1. Voter ID
function validateVoterId() {
  const idPattern = /^[A-Z]{3}\d{7}$/;
  const value = voterId.value.trim();

  if (!value) {
    voterIdError.textContent = "Voter ID is required";
    return false;
  }
  if (!idPattern.test(value)) {
    voterIdError.textContent =
      "Please enter a valid Voter ID (e.g. ABC1234567)";
    return false;
  }
  voterIdError.textContent = "";
  return true;
}

// 2. Voter Name
function validateVoterName() {
  const value = voterName.value.trim();
  if (!value) {
    voterNameError.textContent = "Voter Name is required";
    return false;
  } else if (value.length < 3 || value.length > 50) {
    voterNameError.textContent =
      "Voter Name must be between 3 and 50 characters";
    return false;
  } else if (/[^a-zA-Z\s]/.test(value)) {
    voterNameError.textContent = "Please enter a valid Voter Name";
    return false;
  }
  voterNameError.textContent = "";
  return true;
}

// 3. State
function validateState() {
  if (!voterState.value.trim()) {
    stateError.textContent = "State is required";
    return false;
  }
  stateError.textContent = "";
  return true;
}

// 4. District
function validateDistrict() {
  if (!voterDistrict.value.trim()) {
    districtError.textContent = "District is required";
    return false;
  }
  districtError.textContent = "";
  return true;
}

// 5. Gender
function validateGender() {
  if (!getSelectedGender()) {
    genderError.textContent = "Gender is required";
    return false;
  }
  genderError.textContent = "";
  return true;
}

// 6. Date of Birth
function validateDob() {
  if (!dobYear.value.trim() || !dobMonth.value.trim() || !dobDay.value.trim()) {
    dobError.textContent = "Date of Birth is required";
    return false;
  }

  // Check that user's age is >= 18
  const selectedYear = parseInt(dobYear.value, 10);
  const selectedMonth = parseInt(dobMonth.value, 10) - 1; // Month is 0-based
  const selectedDay = parseInt(dobDay.value, 10);

  const voterDob = new Date(selectedYear, selectedMonth, selectedDay);
  const today = new Date();

  let age = today.getFullYear() - voterDob.getFullYear();
  const monthDiff = today.getMonth() - voterDob.getMonth();
  const dayDiff = today.getDate() - voterDob.getDate();

  // Adjust if birthday hasn't occurred yet this year
  if (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) {
    age--;
  }

  if (age < 18) {
    dobError.textContent = "You must be at least 18 years old to register";
    return false;
  }

  dobError.textContent = "";
  return true;
}

// 7. Email
function validateEmail() {
  const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const value = email.value.trim();

  if (!value) {
    emailError.textContent = "Email is required";
    return false;
  } else if (!emailPattern.test(value)) {
    emailError.textContent = "Please enter a valid email address";
    return false;
  }
  emailError.textContent = "";
  return true;
}

// 8. Mobile Number
function validateMobileNumber() {
  const mobilePattern = /^[6-9]\d{9}$/;
  const value = mobileNumber.value.trim();

  if (!value) {
    mobileNumberError.textContent = "Mobile number is required";
    return false;
  } else if (!mobilePattern.test(value)) {
    mobileNumberError.textContent =
      "Please enter a valid 10-digit mobile number";
    return false;
  }
  mobileNumberError.textContent = "";
  return true;
}

// 9. Password
function validatePassword() {
  const value = password.value.trim();
  if (!value) {
    passwordError.textContent = "Password is required";
    return false;
  } else if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/.test(value)) {
    passwordError.textContent =
      "Password must be at least 8 characters, include uppercase, lowercase, and a number";
    return false;
  }
  passwordError.textContent = "";
  return true;
}

// 10. Confirm Password
function confirmPasswordValidation() {
  const value = confirmPassword.value.trim();
  if (!value) {
    confirmPasswordError.textContent = "Confirm Password is required";
    return false;
  } else if (value !== password.value.trim()) {
    confirmPasswordError.textContent = "Passwords do not match";
    return false;
  }
  confirmPasswordError.textContent = "";
  return true;
}

// 11. Terms & Conditions
function validateTerms() {
  if (!termsCheckbox.checked) {
    termsError.textContent = "You must agree to the terms and conditions";
    return false;
  }
  termsError.textContent = "";
  return true;
}

// Attach blur events
voterId.addEventListener("blur", validateVoterId);
voterName.addEventListener("blur", validateVoterName);
voterState.addEventListener("blur", validateState);
voterDistrict.addEventListener("blur", validateDistrict);
email.addEventListener("blur", validateEmail);
mobileNumber.addEventListener("blur", validateMobileNumber);
//dobYear.addEventListener("blur", validateDob);
//dobMonth.addEventListener("blur", validateDob);
//dobDay.addEventListener("blur", validateDob);
password.addEventListener("blur", validatePassword);
confirmPassword.addEventListener("blur", confirmPasswordValidation); 

// Submit button
const registerBtn = document.getElementById("registerBtn");
registerBtn.addEventListener("click", function (event) {
  event.preventDefault();

  const isValid =
    validateVoterId() &&
    validateVoterName() &&
    validateState() &&
    validateDistrict() &&
    validateGender() &&
    validateDob() &&
    validateEmail() &&
    validateMobileNumber() &&
    validatePassword() &&
    confirmPasswordValidation() &&
    validateTerms();

  formMessage.className = "message"; // reset class

  if (isValid) {
    formMessage.textContent =
      "Registration successful! Redirecting for Verification...";
    formMessage.classList.add("success");

    setTimeout(() => {
      window.location.href = "/voter/otp_verification.html";
    }, 2000);
  } else {
    formMessage.textContent =
      "Please fill all the fields correctly before submitting.";
    formMessage.classList.add("error");
  }
});

// add Options to the date of birth dropdowns
const months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

months.forEach((month, index) => {
  const monthOption = document.createElement("option");
  monthOption.value = index + 1;
  monthOption.textContent = month;
  dobMonth.appendChild(monthOption);
});

// add options to the year dropdowns
for (let year = 1900; year <= new Date().getFullYear(); year++) {
  const yearOption = document.createElement("option");
  yearOption.value = year;
  yearOption.textContent = year;
  dobYear.appendChild(yearOption);
}



// populate the day dropdown based on selected month and year
function populateDays(){
    const selectedYear=parseInt(dobYear.value,10);
    const selectedMonth=parseInt(dobMonth.value,10)-1; // Month is 0-based
    const daysInMonth=new Date(selectedYear,selectedMonth+1,0).getDate();
    dobDay.innerHTML="";
    dobDay.appendChild(new Option("Day",""));
    for(let day=1;day<=daysInMonth;day++){
        const dayOption=document.createElement("option");
        dayOption.value=day;
        dayOption.textContent=day;
        dobDay.appendChild(dayOption);
    }
}

dobYear.addEventListener("change",populateDays);
dobMonth.addEventListener("change",populateDays);



  // List of Indian States and Union Territories
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
  ];

  indianStatesAndUTs.forEach((state)=>{
    const stateOption = document.createElement("option");
    stateOption.value=state;
    stateOption.textContent=state;
    voterState.append(stateOption);
  });

  // fetch the districts from the API fro the selected State and Populate the district dropdown
  voterState.addEventListener("change", async function () {
  const selectedState = voterState.value;
  voterDistrict.innerHTML = "";
  voterDistrict.appendChild(new Option("Select District", ""));

  if (selectedState) {
    try {
      const response = await fetch(`/api/districts?state=${encodeURIComponent(selectedState)}`);
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      const data = await response.json();

      // If districts are inside an object
      (data.districts || []).forEach((district) => {
        const districtOption = document.createElement("option");
        districtOption.value = district;
        districtOption.textContent = district;
        voterDistrict.appendChild(districtOption);
      });
    } catch (error) {
      console.error("Error fetching districts:", error);
    }
  }
});
