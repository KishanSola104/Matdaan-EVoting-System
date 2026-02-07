<%@ Page Language="C#" AutoEventWireup="true" CodeFile="results.aspx.cs" Inherits="ADMIN_SIDE_results" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <title>Results Page</title>
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



.container {
    width: 80%;
    margin: 0 auto;
    padding-top: 30px;
     margin-left: 150px; /* Adjust to the sidebar width */
    padding-top: 50px; /* Adjust to the header height */
    padding-bottom: 50px; /* Adjust for the footer height */
    overflow-y: auto; /* Ensure the container scrolls vertically */
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
       /* Ensure the container is properly positioned */
.container {
    max-width: 1200px; /* Set a max width */
    margin: 60px auto 50px 200px; /* Add top margin to avoid overlapping header */
    padding: 20px;
    background-color: #fff; /* White background for contrast */
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

/* Ensure the header is properly spaced */
.header1 {
    text-align: center;
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 20px;
}

/* Winner section styling */
.winner-box {
    text-align: center;
    padding: 20px;
    background-color: #f8f9fa;
    border: 2px solid #007bff;
    border-radius: 10px;
    margin-bottom: 20px;
}

.winner-logo {
    max-width: 150px;
    margin-bottom: 10px;
}

/* Results Table Styling */
.results-table {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
}

/* Each party's result card */
.result-card {
    width: 280px;
    background: #ffffff;
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
}

.party-logo1 {
    max-width: 80px;
    margin-bottom: 10px;
}

/* Responsive Design */
@media (max-width: 768px) {
    .container {
        margin: 120px 10px 50px 10px; /* Adjust margin for smaller screens */
    }

    .result-card {
        width: 90%; /* Make cards take full width on small screens */
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
    <div>Results Page</div>
    <div class="sidebar-toggle" onclick="toggleSidebar()">?</div>

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
            
    
        <h1 class="header1">Gujarat State Election Results</h1>

        <!-- Winner Section -->
        <div class="winner-box" id="winnerSection" runat="server" visible="false">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <img id="winnerLogo" runat="server" class="winner-logo" />
            <h2 id="winnerName" runat="server"></h2>
        </div>

        <!-- Election Results Table -->
        <div class="results-table">
            <asp:Repeater ID="rptResults" runat="server">
                <ItemTemplate>
                    <div class="result-card">
                        <img src='<%# ResolveUrl("~/" + Eval("PartyLogo")) %>' class="party-logo1" alt="Party Logo" />
                        <p><b>Party:</b> <%# Eval("PartyName") %></p>
                        <p><b>District:</b> <%# Eval("District") %></p>
                        <p><b>Votes:</b> <%# Eval("TotalVotes") %></p>
                        <p><b>Vote Percentage:</b> <%# Eval("VotePercentage") %>%</p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
   


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
        darkModeIcon.textContent = '??';  // Change icon to sun
        localStorage.setItem('dark-mode', 'enabled');  // Store the preference
    } else {
        darkModeIcon.textContent = '??';  // Change icon to moon
        localStorage.setItem('dark-mode', 'disabled');  // Store the preference
    }
}

// Apply dark mode based on previous user preference
window.onload = function() {
    const darkModeSetting = localStorage.getItem('dark-mode');
    if (darkModeSetting === 'enabled') {
        document.body.classList.add('dark-mode');
        document.getElementById('darkModeIcon').textContent = '??';
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