<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateParties.aspx.cs" Inherits="UpdateParties" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <title> Update Parties Page</title>
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
            overflow-y: auto; /* Enable vertical scroll when content overflows */
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



.sidebar:hover ~ .content {
    margin-left: 220px; 
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
.footer 
{
     margin-top: auto;
    position: fixed;
    bottom: 0;
    left: 0;
    height: 5px;
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


 
 .content {
        margin: 20px auto;
        padding: 20px;
        width: 80%;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* Center the form container */
    .signup-container {
        display: flex;
        justify-content: center;
        align-items: flex-start;
        padding-top: 30px;
    }

    /* Form styling */
    form {
        background-color: #fdfdfd;
        padding: 20px 30px;
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 600px;
    }

    form h1, form h2, form h3 {
        margin-bottom: 20px;
        color: #333;
        text-align: center;
    }

    form label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #555;
    }

    form input[type="text"], 
    form select, 
    form input[type="file"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    form img {
        max-width: 150px;
        height: auto;
        margin-bottom: 15px;
    }

    /* Buttons styling */
    form .btn {
        display: inline-block;
        padding: 10px 20px;
        margin-right: 10px; /* Add spacing between buttons */
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        text-align: center;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s;
    }

    form .btn:hover {
        background-color: #0056b3;
    }

    /* Buttons container */
    .button-container {
        display: flex;
        justify-content: flex-end;
        margin-top: 20px;
    }

    .button-container .btn:last-child {
        margin-right: 0; /* Remove margin from the last button */
        background-color: #6c757d; /* Cancel button color */
    }

    .button-container .btn:last-child:hover {
        background-color: #5a6268;
    }

    /* Responsive design */
    @media (max-width: 768px) {
        form {
            padding: 15px;
        }

        form label, 
        form input[type="text"], 
        form select, 
        form .btn {
            font-size: 14px;
        }
    }

    @media (max-width: 480px) {
        form {
            padding: 10px;
        }

        form label, 
        form input[type="text"], 
        form select, 
        form .btn {
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
   

</head>
<body>
     <!-- Include Font Awesome for Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<!-- Include Google Material Icons -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<!-- Header -->
<div class="header">
    <div>Update Parties</div>
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


 
 <div class="content">
    <div class="signup-container">
        <form id="form1" runat="server">
            <h1>Update Party Information</h1>
            <asp:DropDownList ID="ddlParty" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlParty_SelectedIndexChanged">
                <asp:ListItem Text="-- Select Party --" Value="" />
            </asp:DropDownList>

            <div id="partyDetails" runat="server">
                <h2>Party Details</h2>

                <!-- Party Name -->
                <label for="txtPartyName">Party Name:</label>
                <asp:TextBox ID="txtPartyName" runat="server" />

                <!-- Party Leader -->
                <label for="txtPartyLeader">Party Leader:</label>
                <asp:TextBox ID="txtPartyLeader" runat="server" />

                <!-- Party Slogan -->
                <label for="txtPartySlogan">Party Slogan:</label>
                <asp:TextBox ID="txtPartySlogan" runat="server" />

                <!-- Established Year -->
                <label for="txtEstablishedYear">Established Year:</label>
                <asp:DropDownList ID="txtEstablishedYear" runat="server">
                </asp:DropDownList>

                <!-- Total Candidates -->
                <label for="txtTotalCandidates">Total Candidates:</label>
                <asp:TextBox ID="txtTotalCandidates" runat="server" />

                <!-- Leader Picture -->
                <h3>Leader Picture</h3>
                <asp:Image ID="imgLeaderPicture" runat="server" />
                <asp:FileUpload ID="fuLeaderPicture" runat="server" />

                <!-- Party Logo -->
                <h3>Party Logo</h3>
                <asp:Image ID="imgPartyLogo" runat="server" />
                <asp:FileUpload ID="fuPartyLogo" runat="server" />

                <!-- Buttons -->
                <div class="button-container">
                    <asp:Button ID="btnUpdate" Text="Update" CssClass="btn" runat="server" OnClick="btnUpdate_Click" />
                    <asp:Button ID="Button1" Text="Cancel" CssClass="btn" runat="server" OnClick="Button1_Click" />
                </div>
            </div>
        </form>
    </div>
</div>


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
