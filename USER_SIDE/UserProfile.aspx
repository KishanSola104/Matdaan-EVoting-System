<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserProfile.aspx.cs" Inherits="UserProfile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>User Dashboard - E-Vote India</title>
    <!-- Font Awesome Link -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />

<style>
    /* ====================== Global Reset ====================== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

/* ====================== Header Styling ====================== */
.admin-header {
    background-color: orange;
    color: white;
    font-size: large;
    font-weight: bold;
    padding: 10px 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 1000;
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
    transition: background 0.3s ease;
}

.logout-btn:hover {
    background-color: #d32f2f;
}

/* ====================== Sidebar Styling ====================== */
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

/* ====================== Main Content ====================== */
.main-content {
    margin-left: 200px;
    padding: 20px;
    margin-top: 60px;
    transition: margin-left 0.3s;
}

/* ====================== User Profile Section ====================== */
.admin-profile-container {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    padding: 30px;
    flex-wrap: wrap;
}

/* Left and Right Sections */
.admin-profile-left,
.admin-profile-right {
    width: 45%;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 10px;
}

.admin-profile-img {
    width: 180px;
    height: 180px;
    object-fit: cover;
    border: 5px solid #fff;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.admin-profile-img:hover {
    transform: scale(1.1);
    border-color: #ff9933;
    box-shadow: 0 0 25px rgba(255, 153, 51, 0.5);
}

.admin-profile-name {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    transition: color 0.3s ease, transform 0.3s ease;
}

.admin-profile-name:hover {
    color: #ff9933;
    transform: translateY(-5px);
}

/* ====================== User Information Section ====================== */
.admin-info-container {
    width: 70%;
    margin: 0 auto;
    padding: 20px;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.row {
    width: 48%;
    margin-bottom: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.label {
    font-weight: bold;
    color: #0000FF;
    font-size: 16px;
}

.value {
    width: 70%;
    padding: 8px 12px;
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
    color: #333;
    text-align: left;
    overflow-wrap: break-word;
    transition: all 0.3s ease;
}

/* ====================== Footer Styling ====================== */
footer {
    background: #2E8B57;
    color: white;
    padding: 15px;
    font-size: 13px;
    width: calc(100% - 200px);
    left: 200px;
    position:relative;
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

.footer-section h3 {
    font-size: 16px;
    margin-bottom: 8px;
    border-bottom: 1px solid white;
    padding-bottom: 3px;
}

.footer-section p {
    font-size: 12px;
    line-height: 1.4;
}

.footer-bottom {
    text-align: center;
    margin-top: 5px;
    font-size: 11px;
}

/* ====================== Responsive Design ====================== */
@media (max-width: 1024px) {
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

@media (max-width: 768px) {
    .sidebar {
        width: 0;
        overflow: hidden;
    }

    .main-content {
        margin-left: 0;
    }

    footer {
        width: 100%;
        left: 0;
    }

    .admin-profile-container {
        flex-direction: column;
        padding: 20px;
    }

    .admin-profile-left, .admin-profile-right {
        width: 100%;
        padding: 0;
    }

    .row {
        width: 100%;
        flex-direction: column;
        align-items: flex-start;
    }
}

@media (max-width: 480px) {
    .admin-header {
        flex-direction: column;
        text-align: center;
    }

    .admin-info {
        margin-top: 5px;
    }

    .admin-profile-img {
        width: 120px;
        height: 120px;
    }

    .label, .value {
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

/* Main Container */
.container {
    width: 60%;
    margin: 50px auto;
    background: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
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

/* Profile Image Section */
.voter-profile-display {
    text-align: center;
    margin-top: 20px;
}

.voter-profile-img {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    border: 3px solid #007bff;
    object-fit: cover;
}

.voter-profile-name {
    font-size: 20px;
    font-weight: bold;
    margin-top: 10px;
}

/* Information Section */
.voter-info-section {
    text-align: center;
    margin-top: 20px;
    font-size: 22px;
    font-weight: bold;
    color: #333;
}

.voter-info-hr {
    width: 50%;
    margin: 10px auto;
    border: 1px solid #007bff;
}

/* Profile Information */
.voter-info-container {
    margin-top: 20px;
    padding: 10px;
    background: #f9f9f9;
    border-radius: 5px;
    box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.1);
}

.row {
    display: flex;
    justify-content: space-between;
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

.row:last-child {
    border-bottom: none;
}

.label {
    font-weight: bold;
    color: #333;
}

.value {
    color: #555;
}

/* Responsive Design */
@media screen and (max-width: 768px) {
    .container {
        width: 90%;
    }

    .row {
        flex-direction: column;
        text-align: left;
    }

    .label {
        font-size: 14px;
    }

    .value {
        font-size: 14px;
        margin-top: 5px;
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

   <!-- Content -->
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

        <!-- Horizontal Line with Title -->
        <div class="voter-info-section">
            <span class="voter-info-title">Voter Information</span>
            <hr class="voter-info-hr" />
        </div>

        <!-- Voter Profile Display Section -->
        <div class="voter-profile-display">
            <img id="VoterProfileImage" src="default.jpg" alt="Voter Profile Picture" class="voter-profile-img" runat="server" />
            <div id="VoterProfileName" class="voter-profile-name" runat="server"></div>
        </div>

        <!-- Voter Info Display Section -->
        <div class="voter-info-container">
            <div class="row">
                <div class="label">Voter ID:</div>
                <div class="value">
                    <asp:Label ID="voterIDLabel" runat="server" Text="Voter ID"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="label">Aadhar ID:</div>
                <div class="value">
                    <asp:Label ID="aadharIDLabel" runat="server" Text="Aadhar ID"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="label">Name:</div>
                <div class="value">
                    <asp:Label ID="voterNameLabel" runat="server" Text="Voter Name"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="label">Date of Birth:</div>
                <div class="value">
                    <asp:Label ID="dobLabel" runat="server" Text="DOB"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="label">State:</div>
                <div class="value">
                    <asp:Label ID="stateLabel" runat="server" Text="State"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="label">District:</div>
                <div class="value">
                    <asp:Label ID="districtLabel" runat="server" Text="District"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="label">Gender:</div>
                <div class="value">
                    <asp:Label ID="voterGenderLabel" runat="server" Text="Gender"></asp:Label>
                </div>
            </div>
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
