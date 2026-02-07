<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminResetPassword.aspx.cs" Inherits="adminResetPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
   <title>Reset Password</title>
      <style>
        
          /* Global Styles */
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            height: 100%;
            overflow: hidden;
            transition: background-color 0.3s ease;
        }

        /* Dark Mode */
        body.dark-mode {
            background-color: #2c3e50;
            color: #ecf0f1;
        }

        /* Header Styling */
        .header {
            height: 60px;
            background: #2d3436;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            position: fixed; /* Make the header stick to the top */
            top: 0;
            left: 0;
            width: 100%; /* Span the full width of the viewport */
            z-index: 1000; /* Ensure it appears above other elements */
        }

        /* Sidebar */
        .sidebar {
            width: 70px;
            background-color: #2d3436;
            color: #fff;
            height: 100%;
            position: fixed; /* Make the sidebar stick to the left */
            top: 0;
            left: 0;
            transition: width 0.3s ease-in-out;
            overflow-y: auto;
            z-index: 999; /* Ensure it is below the header but above content */
        }

        /* Expand Sidebar on Hover */
        .sidebar:hover {
            width: 220px;
        }

        .sidebar .logo-container {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 10px;
            color: #fff;
            background-color: #2d3436;
            transition: width 0.3s ease-in-out;
        }

        .sidebar:hover .logo-container {
            justify-content: flex-start;
            padding-left: 20px;
        }

        .logo-icon {
            font-size: 24px;
            margin-right: 8px;
            transition: margin 0.3s ease;
        }

        .logo-text {
            display: none;
            font-size: 18px;
            font-weight: bold;
            transition: opacity 0.3s ease;
        }

        .sidebar:hover .logo-text {
            display: inline-block;
            opacity: 1;
        }

        /* Sidebar Links */
        .sidebar a {
            display: flex;
            align-items: center;
            padding: 15px;
            color: #fff;
            text-decoration: none;
            font-size: 16px;
            border-bottom: 1px solid #636e72;
            transition: padding-left 0.3s ease;
            position: relative;
        }

        .sidebar a:hover {
            background-color: #575757;
        }

        .sidebar:hover a {
            padding-left: 20px;
        }

        .sidebar i {
            font-size: 20px;
            margin-right: 15px;
            transition: margin 0.3s ease;
        }

        .sidebar a span {
            display: none;
        }

        .sidebar:hover a span {
            display: inline-block;
        }

        /* Content Styling */
        .content {
            margin-top: 60px; /* Offset for fixed header */
            margin-left: 70px; /* Offset for fixed sidebar */
            padding: 20px;
            height: calc(100vh - 60px); /* Account for header height */
            overflow-y: auto; 
        }

        .sidebar:hover ~ .content {
            margin-left: 220px; 
        }

        /* Content Section */
        .container {
            display: flex;
            margin-left: 70px;
            transition: margin-left 0.3s ease-in-out;
            
        }

        .container .content {
            padding: 20px;
            flex-grow: 1;
            overflow-y: auto;
        }

        /* Toggle Button for Sidebar */
        .sidebar-toggle {
            position: absolute;
            right: -25px;
            top: 20px;
            cursor: pointer;
            width: 25px;
            height: 25px;
            background-color: #2d3436;
            color: #fff;
            border: none;
            border-radius: 50%;
            display: none;
        }

        .sidebar:hover .sidebar-toggle {
            display: block;
        }

        /* Mobile View */
        @media (max-width: 768px) {
            .sidebar {
                width: 100px;
                position: absolute;
                left: -100px; /* Sidebar hidden by default */
                z-index: 10;
            }

            .sidebar.open {
                left: 0; /* Show sidebar when open */
            }

            .container {
                margin-left: 100px;
            }

            .header {
                padding: 0 15px;
            }

            /* Toggle button visible on mobile */
            .sidebar-toggle {
                display: block;
                position: absolute;
                top: 20px;
                left: 10px;
                font-size: 24px;
                background: transparent;
                border: none;
                color: #fff;
            }

            .sidebar a {
                font-size: 14px;
                padding: 12px;
            }

            .logo-container {
                justify-content: center;
                padding: 15px;
            }

            .logo-text {
                font-size: 16px;
            }

            .sidebar:hover .logo-text {
                display: inline-block;
                opacity: 1;
            }
        }

        /* Admin Profile Styling */
        .admin-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
        }

        .profile-container {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            position: relative;
        }

        .profile-pic {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            object-fit: cover;
        }

        .admin-name {
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 5px;
            margin-right:30px;
        }
        
         .admin-name:hover {
        color: #ff9933; /* Change color on hover */
    }

    /* Dropdown Menu Styles */
    .dropdown-menu {
        display: none;
        position: absolute;
        top: 100px; /* Position it below the profile */
        right: 20px;
        background-color: #333;
        color: #fff;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        width: 200px;
        z-index: 1000;
    }

    .dropdown-item {
        padding: 10px;
        text-decoration: none;
        color: #fff;
        display: block;
        font-size: 16px;
        border-bottom: 1px solid #444;
        transition: background-color 0.3s ease;
    }

    .dropdown-item:last-child {
        border-bottom: none; /* Remove bottom border for the last item */
    }

    .dropdown-item:hover {
        background-color: #575757; /* Highlight on hover */
    }

    .logout {
        color: red; /* Red text for Log Out */
    }

    /* Show dropdown when toggled */
    .show-dropdown {
        display: block;
    }
        

        /* Navbar Icons Styles */
        .icon {
            font-size: 20px;
            color: #fff;
            cursor: pointer;
            margin-right: 15px;
        }

        /* New Navbar Style */
        .navbar-icons {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        /* Adjust icon size and spacing */
        .dropdown-item span.material-icons {
     font-size: 20px; /* Set the size of the icons */
    margin-right: 10px; /* Space between the icon and text */
    vertical-align: middle; /* Align icon and text vertically */
        }
        
        
        /* Footer Styles */
.footer {
    position: fixed;
    bottom: 0;
    left: 0;
    height:5px;
    width: 100%;
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 8px;
    font-size: 13px;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    z-index: 1000;
}

.footer span.material-icons {
    font-size: 10px; /* Adjust icon size */
    vertical-align: middle; /* Align icon and text vertically */
}


.admin-info-section {
    display: flex;
    align-items: center;
    margin: 10px 0 20px;
    gap: 10px;
}

.admin-info-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
}

.admin-info-hr {
    flex-grow: 1;
    height: 1px;
    background-color: #333;
    border: none;
}


/* Admin Profile Links Styling */
.admin-profile-links {
    display: flex;
    gap: 20px;
    margin-top: 20px;
}

.profile-link-button {
    display: flex;
    align-items: center;
    gap: 5px;
    text-decoration: none;
    color: #fff;
    font-size: 16px;
    padding: 8px 12px;
    border-radius: 5px;
    background-color: #2d3436;
    transition: background-color 0.3s ease;
}

.profile-link-button:hover {
    background-color: #6495ED;
}

.logout-button {
    color: red;
}

.profile-link-button .material-icons {
    font-size: 20px;
}

       
/* Admin Profile Container */
.admin-profile-container {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    padding: 30px;
    flex-wrap: wrap; /* Allow wrapping for smaller screens */
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

.admin-profile-left {
    margin-bottom: 20px;
}

.admin-profile-right {
    padding-left: 50px;
}

/* Admin Profile Image */
.admin-profile-img {
    width: 200px;
    height: 200px;
    object-fit: cover;
   /* border-radius: 50%; */
    border: 5px solid #fff;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
    transition: transform 0.3s ease, box-shadow 0.3s ease, border-color 0.3s ease;
    margin: 0 auto; /* Center the image */
    margin-bottom: 10px; /* Space below the image */
    margin-left:10%;
}

.admin-profile-img:hover {
    transform: scale(1.1);
    border-color: #ff9933;
    box-shadow: 0 0 25px rgba(255, 153, 51, 0.5);
}

/* Admin Profile Name */
.admin-profile-name {
    font-size: 28px;
    font-weight: bold;
    color: #333;
    margin-top: 10px; /* Space between name and image */
    transition: color 0.3s ease, transform 0.3s ease;
    margin-left:10%;
}

.admin-profile-name:hover {
    color: #ff9933;
    transform: translateY(-5px);
}

/* Admin Info Container */
.admin-info-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    width: 70%;
    margin: 0 auto;
    padding: 20px;
}

.row {
    width: 48%;
    margin-bottom: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
}

/* Label and Value Styling */
.label {
    font-weight: bold;
    color: #0000FF;
    font-size: 16px;
    transition: color 0.3s ease;
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
    transition: all 0.3s ease;
    overflow-wrap: break-word; /* Break long words */
    word-wrap: break-word; /* Compatibility */
    word-break: break-word; /* Ensure proper breaking */
    text-overflow: ellipsis; /* Truncate if necessary */
    white-space: nowrap; /* Prevent wrapping initially */
    overflow: hidden; /* Hide overflowing text */
}

/* Adjustments for Smaller Screens */
@media (max-width: 480px) {
    .value {
        font-size: 12px; /* Reduce font size */
        width: 100%; /* Use full width to avoid overflow */
        white-space: normal; /* Allow text to wrap for very small screens */
        text-overflow: unset; /* Disable truncation for smaller widths */
    }
}

.value:hover,
.value:focus {
    background-color: #e0e0e0;
    border-color: #ff9933;
    transform: scale(1.05);
}

/* Horizontal Line and Title Styling */
.admin-info-section {
    display: flex;
    align-items: center;
    margin: 10px 0 20px;
    gap: 10px;
}

.admin-info-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
}

.admin-info-hr {
    flex-grow: 1;
    height: 1px;
    background-color: #333;
    border: none;
}

/* Admin Profile Links Styling */
.admin-profile-links {
    display: flex;
    gap: 20px;
    margin-top: 20px;
}

.profile-link-button {
    display: flex;
    align-items: center;
    gap: 5px;
    text-decoration: none;
    color: #fff;
    font-size: 16px;
    padding: 8px 12px;
    border-radius: 5px;
    background-color: #2d3436;
    transition: background-color 0.3s ease;
}

.profile-link-button:hover {
    background-color: #6495ED;
}

.logout-button {
    color: red;
}

.profile-link-button .material-icons {
    font-size: 20px;
}

/* Responsive Styling */

/* Tablets and Smaller Screens */
@media (max-width: 1024px) {
    .admin-profile-container {
        flex-direction: column;
        padding: 20px;
    }

    .admin-profile-left,
    .admin-profile-right {
        width: 100%;
        padding: 0;
    }

    .admin-profile-name {
        font-size: 24px;
    }

    .admin-profile-img {
        width: 150px;
        height: 150px;
    }

    .admin-info-container {
        width: 100%;
    }

    .row {
        width: 100%;
        flex-direction: column;
        align-items: flex-start;
    }
}

/* Mobile Screens */
@media (max-width: 768px) {
    .admin-profile-name {
        font-size: 20px;
    }

    .admin-info-title {
        font-size: 18px;
    }

    .admin-info-hr {
        width: 90%;
    }

    .profile-link-button {
        font-size: 14px;
        padding: 6px 10px;
    }
}

/* Extra Small Screens */
@media (max-width: 480px) {
    .admin-profile-container {
        padding: 10px;
    }

    .admin-profile-name {
        font-size: 18px;
    }

    .admin-profile-img {
        width: 120px;
        height: 120px;
    }

    .profile-link-button {
        font-size: 12px;
        padding: 5px 8px;
    }

    .label,
    .value {
        font-size: 12px;
    }
}

   img {
        max-width: 100%;
        height: auto;
        display: block;
        margin-top: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 5px;
    }
        
    </style>

    <style>
    /* General Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Container Styling */
.container1 {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
    min-height: 80vh; /* Ensures it adjusts within content section */
    background-color: #f9f9f9;
}

/* Reset Password Form Container */
.reset-password-container {
    background-color: #ffffff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    padding: 20px 30px;
    width: 100%;
    max-width: 400px;
}

/* Form Title */
.reset-password-form h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333333;
    font-size: 24px;
}

/* Form Group */
.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #555555;
    font-weight: bold;
}

.form-group input[type="password"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
    color: #333;
}

.form-group input[type="password"]::placeholder {
    color: #999;
}

/* Button Styling */
.btn {
    display: block;
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 4px;
    background-color: #007bff;
    color: #ffffff;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn:hover {
    background-color: #0056b3;
}

/* Error Message Styling */
.error-message {
    display: block;
    margin-bottom: 15px;
    color: #ff4d4d;
    font-weight: bold;
    text-align: center;
}

/* General Message Label Styling */
.message-label {
    display: block;
    margin-top: 15px;
    text-align: center;
    font-size: 14px;
    color: #28a745;
    font-weight: bold;
}

/* Responsiveness */
@media (max-width: 768px) {
    .reset-password-container {
        padding: 15px 20px;
    }

    .reset-password-form h2 {
        font-size: 20px;
    }

    .btn {
        font-size: 14px;
    }
}

    </style>
</head>
<body>
      <!-- Include Font Awesome for Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<!-- Include Google Material Icons -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<!-- Header -->
<div class="header">
    <div>Admin Profile</div>
    <div class="sidebar-toggle" onclick="toggleSidebar()">☰</div>

    <!-- Navbar Icons -->
    <div class="navbar-icons">
        <!-- Dark Mode Toggle Icon -->
        <div class="icon" onclick="toggleDarkMode()" id="darkModeIcon">
            <i class="fas fa-moon"></i>
        </div>

        <!-- Email Notifications Icon -->
        <div class="icon" onclick="openEmailNotifications()">
            <i class="fas fa-envelope"></i>
        </div>

        <!-- General Notifications Icon -->
        <div class="icon" onclick="openNotifications()">
            <i class="fas fa-bell"></i>
        </div>

        <!-- Admin Profile -->
        <a href="#" class="profile-link" onclick="toggleDropdown(event)">
            <div class="profile-container">
                <!-- Bind image source dynamically -->
                <img id="ProfilePic" src="kishan.jpeg" class="profile-pic" alt="Admin Picture" runat="server">

                <!-- Display admin's name dynamically -->
                <div id="AdminName" runat="server" class="admin-name"></div>
            </div>
        </a>

        <!-- Dropdown Menu -->
        <div class="dropdown-menu" id="dropdownMenu">
            <a href="adminProfile.aspx" class="dropdown-item">
                <span class="material-icons">account_circle</span> My Account
            </a>
            <a href="adminResetPassword.aspx" class="dropdown-item">
                <span class="material-icons">lock</span> Reset Password
            </a>
            <a href="http://localhost:35218/Final_year_project/AdminLoginVerification.aspx" class="dropdown-item logout">
                <span class="material-icons">exit_to_app</span> Log Out
            </a>
        </div>
    </div>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <!-- Logo -->
    <div class="logo-container">
        <div class="logo-icon">
            <i class="fas fa-vote-yea"></i>
        </div>
        <div class="logo-text">E-Vote<span style="color: #ff9933;">India</span></div>
    </div>

    <!-- Sidebar Links -->
    <a href="adminDashboard.aspx"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a>
    <a href="Elections.aspx"><i class="fas fa-poll"></i><span>Elections</span></a>
    <a href="Parties_Page.aspx"><i class="fas fa-users"></i><span>Parties</span></a>
    <a href="candidates.aspx"><i class="fas fa-user-tie"></i><span>Candidates</span></a>
    <a href="voters.aspx"><i class="fas fa-users"></i><span>Voters</span></a>
    <a href="results.aspx"><i class="fas fa-chart-bar"></i><span>Results</span></a>
   
</div>


    
    
   <!-- Content -->
<div class="container">
    <div class="content">
        <!-- Admin Profile Links -->
        <div class="admin-profile-links">
            <a href="adminProfile.aspx" class="profile-link-button">
                <span class="material-icons">account_circle</span> My Account
            </a>
            <a href="adminResetPassword.aspx" class="profile-link-button">
                <span class="material-icons">lock</span> Reset Password
            </a>
            <a href="http://localhost:35218/Final_year_project/ADMIN_SIDE/AdminLoginVerification.aspx" class="profile-link-button logout-button">
                <span class="material-icons">exit_to_app</span> Log Out
            </a>
        </div>

        <!-- Horizontal Line with Title -->
        <div class="admin-info-section">
            <span class="admin-info-title">Reset Password</span>
               <hr class="admin-info-hr" />
        </div>
       
        <!-- Reset Password Container Content will come here  -->
          <form id="form1" runat="server">
    <div class="container1">
            <div class="reset-password-container">
                <div class="reset-password-form">
                    <h2>Reset Password</h2>
                    
                    <!-- Error Message Display -->
                    <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
                    
                    <!-- Current Password Field -->
                    <div class="form-group">
                        <label for="txtCurrentPassword">Current Password</label>
                        <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" placeholder="Enter current password"></asp:TextBox>
                    </div>
                    
                    <!-- New Password Field -->
                    <div class="form-group">
                        <label for="txtNewPassword">New Password</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="Enter new password"></asp:TextBox>
                    </div>
                    
                    <!-- Confirm New Password Field -->
                    <div class="form-group">
                        <label for="txtConfirmPassword">Confirm New Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm new password"></asp:TextBox>
                    </div>
                    
                    <!-- Submit Button -->
                    <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" 
                        CssClass="btn btn-primary" onclick="btnResetPassword_Click1"  />

                        <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>
                </div>
            </div>
        </div>
</form>


  

    <!-- Footer Section -->
<div class="footer">
    <span class="material-icons">lock</span> All Rights Reserved &copy; E-VoteIndia
</div>


    <script>
        // Sidebar toggle functionality
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('open');
        }

        // Dark Mode Toggle functionality
 // Dark Mode Toggle Function
function toggleDarkMode() {
    document.body.classList.toggle('dark-mode');
    const darkModeIcon = document.getElementById('darkModeIcon');
    
    if (document.body.classList.contains('dark-mode')) {
        darkModeIcon.textContent = '🌕';  // Change icon to sun
        localStorage.setItem('dark-mode', 'enabled');  // Store the preference
    } else {
        darkModeIcon.textContent = '🌑';  // Change icon to moon
        localStorage.setItem('dark-mode', 'disabled');  // Store the preference
    }
}

// Apply dark mode based on previous user preference
window.onload = function() {
    const darkModeSetting = localStorage.getItem('dark-mode');
    if (darkModeSetting === 'enabled') {
        document.body.classList.add('dark-mode');
        document.getElementById('darkModeIcon').textContent = '🌕';
    }
};



        // Email and Notifications functions
        function openEmailNotifications() {
            alert('Open email notifications');
        }

        function openNotifications() {
            alert('Open general notifications');
        }

        // Toggle the dropdown menu when the admin clicks on the profile image or name
    function toggleDropdown(event) {
        event.preventDefault(); // Prevent the default action of the anchor tag
        const dropdown = document.getElementById('dropdownMenu');
        dropdown.classList.toggle('show-dropdown');
    }

    // Close the dropdown if the user clicks outside of it
    window.onclick = function(event) {
        const dropdown = document.getElementById('dropdownMenu');
        if (!event.target.matches('.profile-link') && !event.target.matches('.profile-container *')) {
            if (dropdown.classList.contains('show-dropdown')) {
                dropdown.classList.remove('show-dropdown');
            }
        }
    }
    </script>

    <!-- Font Awesome Icons -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js" crossorigin="anonymous"></script>

</body>
</html>
