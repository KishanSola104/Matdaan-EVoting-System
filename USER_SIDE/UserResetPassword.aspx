<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserResetPassword.aspx.cs" Inherits="UserResetPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <head id="Head1" runat="server">
  <title>User Dashboard - E-Vote India</title>
    <!-- Font Awesome Link -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />

<style>
/* General Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

/* Admin Header Styling */
.admin-header {
    background-color: orange;
    color: white;
    font-size: large;
    font-weight: bold;
    padding: 10px 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 100;
    position: fixed;
    width: 100%;
    top: 0;
}

/* Admin Info */
.admin-info {
    display: flex;
    align-items: center;
}

.admin-profile-img {
    border-radius: 50%;
    border: 2px solid #fff;
    object-fit: cover;
    width: 40px;
    height: 40px;
    margin-left: 10px;
}

.logout-btn {
    margin-left: 15px;
    background-color: #f44336;
    color: white;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
    border-radius: 5px;
}

.logout-btn:hover {
    background-color: #d32f2f;
}

/* Sidebar Styling */
.sidebar {
    width: 200px;
    background: #222;
    color: white;
    padding: 15px;
    position: fixed;
    height: 100%;
    transition: 0.3s ease-in-out;
}

.sidebar a {
    display: flex;
    align-items: center;
    color: white;
    padding: 12px;
    font-size: 14px;
    text-decoration: none;
    transition: background 0.3s ease-in-out;
}

.sidebar a i {
    margin-right: 10px;
    font-size: 16px;
}

.sidebar a:hover {
    background: #333;
    border-radius: 5px;
}

/* Settings Dropdown */
.settings {
    margin-top: 10px;
}

.settings a {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.dropdown {
    display: none;
    background: #333;
    padding: 5px;
    border-radius: 5px;
    flex-direction: column;
}

.dropdown a {
    padding: 8px 15px;
    font-size: 13px;
    display: flex;
    align-items: center;
    gap: 10px;
    transition: 0.3s;
}

.dropdown a:hover {
    background: #444;
}

.settings .fa-chevron-down {
    transition: transform 0.3s ease;
}

.settings.open .fa-chevron-down {
    transform: rotate(180deg);
}

/* Main Content */
.main-content {
    margin-left: 200px;
    padding: 20px;
    transition: margin-left 0.3s;
    margin-top: 60px;
}

/* Footer Styles */
footer {
    background: #2E8B57;
    color: white;
    padding: 15px;
    font-size: 13px;
    width: calc(100% - 200px);
    left: 200px;
    position: fixed;
    bottom: 0;
    transition: width 0.3s;
}

.footer-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    max-width: 1100px;
    margin: 0 auto;
}

.footer-section {
    flex: 1;
    padding: 5px;
    min-width: 220px;
}

.footer-section h3 {
    font-size: 16px;
    margin-bottom: 8px;
    border-bottom: 1px solid white;
    padding-bottom: 3px;
    display: inline-block;
}

.footer-section p {
    font-size: 12px;
    line-height: 1.4;
    margin-bottom: 5px;
}

.footer-section .social-icons a {
    color: white;
    font-size: 14px;
    margin: 0 3px;
    transition: 0.3s;
}

.footer-section .social-icons a:hover {
    color: #222;
}

.footer-section ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer-section ul li {
    margin-bottom: 5px;
}

.footer-section ul li a {
    color: white;
    text-decoration: none;
    font-size: 12px;
    transition: 0.3s;
}

.footer-section ul li a:hover {
    text-decoration: underline;
}

.footer-bottom {
    text-align: center;
    margin-top: 5px;
    padding-top: 5px;
    border-top: 1px solid white;
    font-size: 11px;
}

/* Responsive Design */
@media screen and (max-width: 1024px) {
    .sidebar {
        width: 180px;
    }
    
    .main-content {
        margin-left: 180px;
    }
    
    footer {
        width: calc(100% - 180px);
        left: 180px;
    }
}

@media screen and (max-width: 768px) {
    .sidebar {
        width: 0;
        overflow: hidden;
        padding: 0;
    }

    .main-content {
        margin-left: 0;
    }

    .admin-header {
        padding: 10px;
        font-size: medium;
    }

    .admin-profile-img {
        width: 35px;
        height: 35px;
    }

    footer {
        width: 100%;
        left: 0;
        text-align: center;
    }

    .footer-container {
        flex-direction: column;
        align-items: center;
    }

    .footer-section {
        text-align: center;
        padding: 10px;
    }
}

@media screen and (max-width: 480px) {
    .admin-header {
        flex-direction: column;
        text-align: center;
    }

    .admin-info {
        margin-top: 5px;
    }

    .logout-btn {
        padding: 4px 8px;
    }

    .main-content {
        padding: 15px;
    }

    footer {
        padding: 10px;
        font-size: 12px;
    }
}

</style>

<style>
/* General Styles */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}
/* Profile Links */
.voter-profile-links {
    display: flex;
    justify-content: space-around;
    padding: 10px;
    background: #007bff;
    border-radius: 5px;
}

.voter-profile-links a {
    text-decoration: none;
    color: white;
    font-size: 16px;
    padding: 10px 15px;
    border-radius: 5px;
    transition: 0.3s;
}

.voter-profile-links a:hover {
    background: #0056b3;
}

.logout-button {
    background: red !important;
}

.logout-button:hover {
    background: darkred !important;
}
/* Container */
.container {
    width: 50%;
    margin: 50px auto;
    background: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

/* Section Title */
.voter-info-section {
    text-align: center;
    font-size: 22px;
    font-weight: bold;
    color: #333;
}

.voter-info-hr {
    width: 50%;
    margin: 10px auto;
    border: 1px solid #007bff;
}

/* Reset Password Form */
.reset-password-form {
    padding: 20px;
}

.row {
    display: flex;
    flex-direction: column;
    margin-bottom: 15px;
}

.label {
    font-weight: bold;
    color: #333;
    margin-bottom: 5px;
}

.input-field {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

/* Submit Button */
.button-container {
    text-align: center;
}

.submit-button {
    background: #007bff;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: 0.3s;
}

.submit-button:hover {
    background: #0056b3;
}

/* Error Message */
.error-message {
    text-align: center;
    color: red;
    font-weight: bold;
    margin-bottom: 10px;
}

/* Responsive */
@media screen and (max-width: 768px) {
    .container {
        width: 90%;
    }
}

</style>
</head>
<body>

    <form id="adminDashboardForm" runat="server">
        <!-- Header Section -->
        <header class="admin-header">
            <div class="logo">E-Vote India</div>
            <div class="admin-info">
                <span>Welcome, <asp:Label ID="lblAdminName" runat="server" Text=""></asp:Label></span>
                <asp:Image ID="imgAdminProfile" runat="server" CssClass="admin-profile-img" Width="40px" Height="40px" />
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />
            </div>
        </header>

        <!-- Sidebar Section -->
        <div class="sidebar">
            <a href="UserDashboard.aspx"><i class="fas fa-home"></i>Home</a>
     

          <a href="UserElection.aspx"><i class="fas fa-landmark"></i> Elections</a> <!-- Government/Building icon -->
<a href="CastVote.aspx"><i class="fas fa-vote-yea"></i> Cast Vote</a> <!-- Voting icon -->
<a href="UserResults.aspx"><i class="fas fa-poll"></i> Results</a> <!-- Poll/Results icon -->


            <div class="settings">
                <a href="#" id="settings-btn"><i class="fas fa-cogs"></i> Settings <i class="fas fa-chevron-down"></i></a>
                <div class="dropdown" id="settings-dropdown">
                    <a href="UserProfile.aspx"><i class="fas fa-user"></i> My Account</a>
                    <a href="UserResetPassword.aspx"><i class="fas fa-key"></i> Reset Password</a>
                    <a href="login.aspx"><i class="fas fa-sign-out-alt"></i> Log Out</a>
                </div>
            </div>
        </div>

 <div class="container">
         <div class="content">
        <!-- Voter Profile Links -->
        <div class="voter-profile-links">
            <a href="UserProfile.aspx" class="profile-link-button">
                My Account
            </a>
            <a href="UserResetPassword.aspx" class="profile-link-button">
               Reset Password
            </a>
            <a href="login.aspx" class="profile-link-button logout-button">
                 Log Out
            </a>
        </div>

        <!-- Reset Password Form -->
        <div class="reset-password-form">
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>

            <div class="row">
                <label class="label">Current Password:</label>
                <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>
            </div>

            <div class="row">
                <label class="label">New Password:</label>
                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>
            </div>

            <div class="row">
                <label class="label">Confirm Password:</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>
            </div>

            <div class="button-container">
                <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" CssClass="submit-button" OnClick="btnResetPassword_Click" />
            </div>
        </div>
    </div>

        <!-- Footer Section -->
        <!-- Footer Section -->
<footer>
    <div class="footer-container">
        <!-- About Section -->
        <div class="footer-section about">
            <h3>E-Vote India</h3>
            <p>E-Vote India ensures secure, transparent, and fair elections with advanced technology.</p>
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-youtube"></i></a>
            </div>
        </div>

        <!-- Quick Links Section -->
        <div class="footer-section links">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="UserAboutUs.aspx">About E-Vote India</a></li>
                 <li><a href="ContactUs.aspx">Contact Us</a></li>
                <li><a href="Party_Affi.aspx">Party Affidavits</a></li>
               
            </ul>
        </div>

        <div class="footer-section links">
        <h3>Quick Links</h3>
        <ul>
         <li><a href="Terms_Conditions.aspx">Election Guidelines</a></li>
                <li><a href="Candidate_Affi.aspx">Candidate Affidavits</a></li>
                   <li><a href="https://voicenet.in/">VoiceNet</a></li>
        </ul>
        </div>
    </div>

    <!-- Copyright Section -->
    <div class="footer-bottom">
        <p>© 2025 E-Vote India. All Rights Reserved.</p>
    </div>
</footer>




    </form>

    <!-- JavaScript for Settings Dropdown -->
    <script>
        document.getElementById('settings-btn').addEventListener('click', function (event) {
            event.preventDefault();
            var dropdown = document.getElementById('settings-dropdown');
            var settings = document.querySelector('.settings');

            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
            settings.classList.toggle('open');
        });
    </script>
</body>
</html>
    
</body>

</html>
