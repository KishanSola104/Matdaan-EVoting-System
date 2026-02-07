<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddParties.aspx.cs" Inherits="AddParties" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <title>Add Parties</title>
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
               overflow-y: auto;  /* Add vertical scrollbar */
              
            box-sizing: border-box;
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



 /* Main content styles */
/* Main content section styling */
.content {
    margin-left: 100px; /* To give space for sidebar */
    margin-top: 30px;
    margin-bottom: 40px; /* Make room for footer */
    padding: 20px;
    overflow-x: auto; /* Ensure horizontal scroll is available when necessary */
    box-sizing: border-box;
}
    </style>

    <style>
          .form-heading {
        font-size: 18px;
        font-weight: bold;
        color: #333;
        margin-bottom: 15px;
        text-align: center;
    }
 
 
    /* General styling for the content section */
    .content {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* Responsive grid with min width */
        gap: 20px; /* Space between grid items */
        padding: 20px;
    }

    /* Styling for each form container */
    .party-form {
        background-color: #f9f9f9;
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

  /* Form labels */
label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
    color: #333; /* Default text color for labels in light mode */
}

/* Dark mode styles */
body.dark-mode label {
    color: #fff; /* White text for better contrast in dark mode */
    background-color: #333; /* Dark background for better readability */
    padding: 5px; /* Small padding to enhance visibility */
    border-radius: 3px; /* Rounded corners */
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.5); /* Soft shadow for emphasis */
}

/* Toggle dark mode class */
body {
    transition: background-color 0.3s, color 0.3s;
}

/* Dark mode switch */
.dark-mode-switch {
    position: fixed;
    top: 10px;
    right: 10px;
    background-color: #333;
    color: #fff;
    padding: 5px 10px;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.dark-mode-switch:hover {
    background-color: #555;
}

/* Add a dark-mode class to body when dark mode is activated */
.dark-mode {
    background-color: #121212; /* Dark background */
    color: #fff; /* White text */
}


    /* Input fields and dropdowns */
    input[type="text"], input[type="number"], input[type="file"], select {
        width: 100%;
        padding: 8px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    /* Buttons */
    button {
        padding: 10px 15px;
        margin-right: 10px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
    }

    button:hover {
        background-color: #0056b3;
    }

    button:last-child {
        background-color: #dc3545;
    }

    button:last-child:hover {
        background-color: #a71d2a;
    }

    /* Responsive Image Preview */
    img {
        max-width: 100%;
        height: auto;
        display: block;
        margin-top: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 5px;
    }

    /* Small screen adjustments */
    @media (max-width: 600px) {
        .content {
            grid-template-columns: 1fr; /* Single column for smaller screens */
        }
    }
</style>


<script>
document.addEventListener("DOMContentLoaded", function () {
    const electionID = document.getElementById("ElectionIDHiddenField").value;
    const totalParties = parseInt(document.getElementById("TotalPartiesHiddenField").value);

    if (!electionID || isNaN(totalParties) || totalParties <= 0) {
        alert("Error: Missing or invalid election details.");
        return;
    }

    generateForms(totalParties, electionID);
});

function generateForms(totalParties, electionID) {
    const contentDiv = document.getElementById("contentSection");

    for (let i = 1; i <= totalParties; i++) {
        const formDiv = document.createElement("div");
        formDiv.classList.add("party-form");
        formDiv.style.border = "1px solid #ccc";
        formDiv.style.margin = "10px";
        formDiv.style.padding = "10px";

        const currentYear = new Date().getFullYear();
        let yearOptions = "";
        for (let year = 1949; year <= currentYear; year++) {
            yearOptions += `<option value="${year}">${year}</option>`;
        }

        formDiv.innerHTML = `
            <h2 class="form-heading">Form ${i}</h2>
            <label>Election ID:</label>
            <input type="text" value="${electionID}" readonly><br><br>
            
            <label>Party ID:</label>
            <input type="text" id="partyId_${i}" placeholder="Enter Party ID"><br><br>
            
            <label>Party Name:</label>
            <input type="text" id="partyName_${i}" placeholder="Enter Party Name"><br><br>
            
            <label>Party Leader:</label>
            <input type="text" id="partyLeader_${i}" placeholder="Enter Party Leader"><br><br>

            <label>Leader Picture:</label>
            <input type="file" id="leaderPicture_${i}"><br><br>
            
            <label>Party Slogan / Mantra:</label>
            <input type="text" id="partySlogan_${i}" placeholder="Enter Party Slogan/Mantra"><br><br>
            
            <label>Party Established Year:</label>
            <select id="partyYear_${i}">
                <option value="" disabled selected>Select Year</option>
                ${yearOptions}
            </select><br><br>
            
            <label>Party Logo:</label>
            <input type="file" id="partyLogo_${i}"><br><br>
            
            <label>Total Candidates:</label>
            <input type="number" id="totalCandidates_${i}" placeholder="Enter Total Candidates" min="1"><br><br>
            
            <button type="button" onclick="submitForm(${i})">Submit</button>
            <button type="button" onclick="cancelForm(${i})">Cancel</button>
        `;

        contentDiv.appendChild(formDiv);
    }
}

function submitForm(formIndex) {
    const partyId = document.getElementById(`partyId_${formIndex}`).value;
    const partyName = document.getElementById(`partyName_${formIndex}`).value;
    const partyLeader = document.getElementById(`partyLeader_${formIndex}`).value;
    const leaderPicture = document.getElementById(`leaderPicture_${formIndex}`).files[0];
    const partySlogan = document.getElementById(`partySlogan_${formIndex}`).value;
    const partyYear = document.getElementById(`partyYear_${formIndex}`).value;
    const partyLogo = document.getElementById(`partyLogo_${formIndex}`).files[0];
    const totalCandidates = document.getElementById(`totalCandidates_${formIndex}`).value;

    // Validate all fields
    if (!partyId || !partyName || !partyLeader || !leaderPicture || 
        !partySlogan || !partyYear || !partyLogo || !totalCandidates) {
        alert("All fields are required!");
        return;
    }

    // Prepare form data
    const formData = new FormData();
    formData.append("PartyID", partyId);
    formData.append("PartyName", partyName);
    formData.append("PartyLeader", partyLeader);
    formData.append("LeaderPicture", leaderPicture);
    formData.append("PartySlogan", partySlogan);
    formData.append("EstablishedYear", partyYear);
    formData.append("PartyLogo", partyLogo);
    formData.append("TotalCandidates", totalCandidates);

    // Send data to server
    fetch("SavePartyDataHandler.ashx", {
        method: "POST",
        body: formData,
    })
        .then((response) => response.text())
        .then((result) => {
            alert(`Form ${formIndex}: ${result}`);
        })
        .catch((error) => {
            console.error("Error:", error);
            alert(`Form ${formIndex}: Failed to save data.`);
        });
}

function cancelForm(formIndex) {
    const formDiv = document.getElementById(`partyId_${formIndex}`).closest(".party-form");
    if (formDiv) formDiv.remove();
    alert(`Form ${formIndex} Cancelled!`);
}

</script>





</head>
<body>
   <!-- Include Font Awesome for Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<!-- Include Google Material Icons -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<!-- Header -->
<div class="header">
    <div>Add Parties</div>
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
            <a href="/Final_year_project/AdminLoginVerification.aspx" class="dropdown-item logout">
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



<!-- Main Content Section -->
<form id="form1" runat="server">
    <div class="content" id="contentSection">
        
    </div>
    <!-- Hidden Fields to Pass Server Data -->
    <input type="hidden" id="ElectionIDHiddenField" runat="server" />
    <input type="hidden" id="TotalPartiesHiddenField" runat="server" />
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

       // Email and Notifications functions
        function openEmailNotifications() {
            alert('Open email notifications');
        }

        function openNotifications() {
            alert('Open general notifications');
        }



    </script>

    <!-- Font Awesome Icons -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js" crossorigin="anonymous"></script>

</body></html>
