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

// Get Gender (function to get selected value dynamically)
function getSelectedGender() {
    const gender = document.querySelector('input[name="gender"]:checked');
    return gender ? gender.value : null;
}

// validating All Form Components 

const voterIdError = document.getElementById("voterIdError");
const voterNameError=document.getElementById("voterNameError");
const stateError=document.getElementById("stateError");
const districtError=document.getElementById("districtError");
const emailError=document.getElementById("emailError");
const mobileNumberError=document.getElementById("mobileNumberError");
const dobError=document.getElementById("dobError");
const passwordError=document.getElementById("passwordError");
const confirmPassowrdError=document.getElementById("confirmPasswordError");
const genderError=document.getElementById("genderError");
const termsError=document.getElementById("termsError");

// Functions to Validate All form components 

// 1st Voter ID
function validateVoterId() {
    const idPattern = /^[A-Z]{3}\d{7}$/; // Example: ABC1234567
    const value = voterId.value.trim();

    if (!value) {
        voterIdError.textContent = "Voter ID is required";
        return false;
    } 
    if (!idPattern.test(value)) {
        voterIdError.textContent = "Please enter a valid Voter ID (e.g. ABC1234567)";
        return false;
    }
    voterIdError.textContent = "";
    return true;
};

// 2nd Voter Name
function validateVoterName(){

        const value=voterName.value.trim();
        if(!value){
            voterNameError.textContent="Voter Name is Required";
            return false;
        }else if(value.length<3 || value.length>50){
            voterNameError.textContent="Voter Name must be between 3 and 50 characters";
            return false;
        }else if(~/[^a-zA-Z\s]/.test(value)){
            voterNameError.textContent="Please enter an valid Voter name";
        }else {
            voterNameError.textContent="";
            return true;
        }
};


// 3rd State 
function validateState(){
    const selectedState=voterState.value.trim();

    if(!selectedState){
        stateError.textContent="State is required";
        return false;
    }else{
        stateError.textContent="";
        return true;
    }
};


// 4th District
function validateDistrict(){
    const selectedDistrict=voterDistrict.value.trim();

    if(!selectedDistrict){
        districtError.textContent="District is required";
        return false;
    }
}