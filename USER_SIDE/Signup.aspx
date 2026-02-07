<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="Signup" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sign Up - E-VoteIndia</title>
    <style>
    /* Base styles */
body {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    min-height: 100vh;
    margin: 0;
    background: linear-gradient(135deg, #f4f4f4, #e3e3e3);
    font-family: 'Poppins', Arial, sans-serif;
}

/* Signup Container */
.signup-container {
    width: 420px;
    padding: 20px;
    border-radius: 8px;
    background-color: #fff;
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
    text-align: center;
    opacity: 0;
    animation: fadeIn 1s ease-out forwards;
}

/* Header */
.head {
    background-color: #004085;
    color: white;
    padding: 20px;
    text-align: center;
    font-size: 22px;
    font-weight: bold;
    border-bottom: 5px solid #ffc107;
    width: 100%;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
}

/* Form Fields */
.form-field {
    margin-bottom: 15px;
    width: 85%;
    margin: 0 auto 15px auto;
    text-align: left;
    animation: fadeIn 0.8s ease-out forwards;
    animation-delay: 0.2s;
}

/* Input Fields */
.form-field label {
    font-size: 14px;
    color: #444;
    display: block;
    margin-bottom: 6px;
    font-weight: 600;
}

.form-field input,
.form-field select,
.form-field button {
    width: 100%;
    padding: 12px;
    border-radius: 5px;
    border: 1px solid #ccc;
    font-size: 16px;
    transition: all 0.3s ease-in-out;
}

.form-field input:focus,
.form-field select:focus {
    border-color: #007bff;
    box-shadow: 0 0 8px rgba(0, 123, 255, 0.2);
    outline: none;
}

.form-field input::placeholder {
    font-weight: 300;
    color: #aaa;
}

/* Name Fields */
.name-fields {
    display: flex;
    justify-content: space-between;
    width: 100%;
    gap: 12px;
}

.name-fields .form-field {
    width: 48%;
}

/* Gender Selection */
.gender-options {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
}

/* Date of Birth and State/District */
.dob-fields,
.state-district-fields {
    display: flex;
    justify-content: space-between;
    gap: 10px;
}

/* Terms and Conditions */
.terms-conditions {
    display: flex;
    align-items: center;
    gap: 8px;
    text-align: left;
}

.terms-conditions label a {
    color: #007bff;
    text-decoration: none;
    font-weight: bold;
}

.terms-conditions label a:hover {
    text-decoration: underline;
}

/* Buttons */
.signup-button {
    background-color: #007bff;
    color: white;
    font-weight: bold;
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
}

.signup-button:hover {
    background-color: #0056b3;
    transform: scale(1.05);
}

.signup-button:active {
    background-color: #004080;
    transform: scale(0.98);
}

/* Login Link */
.login-link {
    text-align: center;
    margin-top: 15px;
}

.login-link a {
    color: #28a745;
    text-decoration: none;
    font-weight: 600;
}

.login-link a:hover {
    text-decoration: underline;
}

/* Image Preview */
.image-section {
    text-align: center;
    margin-bottom: 20px;
}

.image-preview img {
    width: 200px;
    height: 200px;
    border-radius: 6px;
    border: 2px solid #ccc;
    object-fit: cover;
}

/* Page Load Animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsive Design */
@media screen and (max-width: 600px) {
    .signup-container {
        width: 90%;
        padding: 18px;
    }

    .name-fields {
        flex-direction: column;
        gap: 10px;
    }

    .name-fields .form-field {
        width: 100%;
    }

    .form-field {
        width: 100%;
    }

    .form-field input,
    .form-field select,
    .form-field button {
        font-size: 14px;
    }

    .terms-conditions {
        font-size: 14px;
    }
}

/* Footer */
footer {
    background-color: #004085;
    color: white;
    text-align: center;
    padding: 12px;
    font-size: 14px;
    border-top: 5px solid #ffc107;
    position: relative;
    width: 100%;
}
</style>

  

</head>
<body>
  <div class="head">E-VoteIndia</div>
  <form id="form1" runat="server">
        <div class="signup-container">
            <center>
                <h3>Register To E-VoteIndia</h3>
                <p>
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </p>
            </center>

            <!-- Voter ID -->
            <div class="form-field">
                <label for="txtVoterID">Voter ID:</label>
                <asp:TextBox ID="txtVoterID" runat="server" CssClass="form-control" Placeholder="Enter Voter ID (e.g., KGH1234567)" />
                <asp:RequiredFieldValidator ID="rfvVoterID" runat="server" ControlToValidate="txtVoterID" ErrorMessage="Voter ID is required." ForeColor="Red" />
                <asp:RegularExpressionValidator ID="revVoterID" runat="server" ControlToValidate="txtVoterID" ValidationExpression="^[A-Za-z]{3}\d{7}$" ErrorMessage="Voter ID must follow the format KGH1234567." ForeColor="Red" />
            </div>

            <!-- Name -->
            <div class="form-field">
                <label for="txtName">Name:</label>
                <asp:TextBox ID="txtName" runat="server" placeholder="Enter Name as per Voter Card"></asp:TextBox>
            </div>

            <!-- State -->
            <div class="form-field">
                <label>State:</label>
                <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="true"></asp:DropDownList>
            </div>

            <!-- District -->
            <div class="form-field">
                <label>District:</label>
                <asp:DropDownList ID="ddlDistrict" runat="server"></asp:DropDownList>
            </div>

            <!-- Email -->
            
           <!-- Email -->
        <div class="form-field">
            <label for="txtEmail">Email Address:</label>
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter your email" TextMode="Email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." ForeColor="Red" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Enter a valid email." ForeColor="Red" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" />
        </div>

            <!-- Mobile Number -->
            <!-- Mobile Number -->
        <div class="form-field">
            <label for="txtPhoneNumber">Mobile Number:</label>
            <asp:TextBox ID="txtPhoneNumber" runat="server" placeholder="Enter your phone number"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Mobile number is required." ForeColor="Red" />
            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Enter a valid 10-digit mobile number." ForeColor="Red" ValidationExpression="^\d{10}$" />
        </div>

            <!-- Gender -->
            <div class="form-field">
                <label>Gender:</label>
                <div class="gender-options">
                    <asp:RadioButton ID="rbMale" runat="server" GroupName="Gender" Text="Male" />
                    <asp:RadioButton ID="rbFemale" runat="server" GroupName="Gender" Text="Female" />
                    <asp:RadioButton ID="rbOther" runat="server" GroupName="Gender" Text="Other" />
                </div>
            </div>

            <!-- Date of Birth -->
            <div class="form-field">
                <label>Date of Birth:</label>
                <asp:DropDownList ID="ddlDay" runat="server"></asp:DropDownList>
                <asp:DropDownList ID="ddlMonth" runat="server"></asp:DropDownList>
                <asp:DropDownList ID="ddlYear" runat="server"></asp:DropDownList>
            </div>

            <!-- User Image -->
            <div class="form-field">
                <label>Image</label>
                <div class="image-preview">
                    <img id="userImage" runat="server" src="user.jpg" alt="User Photo" />
                </div>
            </div>

            <!-- Password -->
      <div class="form-field">
    <label for="txtPassword">Password:</label>
    <div style="position: relative;">
        <asp:TextBox ID="txtPassword" runat="server" placeholder="Enter your password" TextMode="Password" CssClass="form-control" />
        <span id="togglePassword" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;">
            <i class="fa fa-eye"></i>
        </span>
    </div>
    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
        ErrorMessage="Password is required." ForeColor="Red" />
    <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword" 
        ErrorMessage="Password must be at least 8 characters, include a number and a special character." 
        ForeColor="Red" 
        ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" />
</div>




        <!-- Confirm Password -->
        <div class="form-field">
            <label for="txtConfirmPassword">Confirm Password:</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" placeholder="Confirm your password" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password is required." ForeColor="Red" />
            <asp:CompareValidator ID="cvPassword" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Passwords must match" ForeColor="Red"></asp:CompareValidator>
        </div>

            <!-- Terms and Conditions -->
            <div class="terms-conditions">
                <asp:CheckBox ID="CheckBox1" runat="server" />
                <label>
                    <a href="Terms_Conditions.aspx" target="_blank">I agree to the Terms and Conditions</a>
                </label>
            </div>

            <!-- Submit Button -->
            <div class="form-field">
                <asp:Button ID="btnSubmit" runat="server" Text="Sign Up" OnClick="btnSubmit_Click" CssClass="signup-button" />
            </div>

            <div class="login-link">
                <a href="login.aspx">Already have an account? Log in</a>
            </div>
        </div>
    </form>




    <!-- Footer -->
        <footer>
            © 2024-25 Online Election Voting System - Indian States | All Rights Reserved
        </footer>
        <!-- Add a Script to Toggle Password Visibility -->
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById('togglePassword').addEventListener('click', function (e) {
            var passwordField = document.getElementById('<%= txtPassword.ClientID %>');
            var icon = this.querySelector('i');

            if (passwordField.type === "password") {
                passwordField.type = "text"; // Show password
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = "password"; // Hide password
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    });
</script>

      <!-- Include Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">



<!-- Add CSS for the Eye Icon Inside the TextBox -->
<style>
    .password-wrapper {
        position: relative;
        width: 100%;
    }

    .form-control {
        width: 100%;
        padding-right: 40px; /* Add some padding for the icon */
    }

    .eye-icon {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        font-size: 18px;
        color: #000; /* You can change this to the color you want */
    }
</style>
</body>
</html>
