<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddVoters.aspx.cs" Inherits="AddVoters" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <title>Add Voters</title>
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
             overflow-y: auto; /* Ensure the container scrolls vertically */
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





   img {
        max-width: 100%;
        height: auto;
        display: block;
        margin-top: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 5px;
    }
    
   /* Basic styling for the labels */
.info-label {
    font-size: 18px;
    font-weight: bold;
    color: #4CAF50;
    margin: 10px 0;
}

        
    </style>

    <style>
 
/* Content Area Styling */
.content {
    width: 60%; /* Adjust width based on your preference */
    margin: 30px auto;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    box-sizing: border-box;
    max-width: 800px;
}

/* Heading Styling */
h2 {
    text-align: center;
    color: #333;
    font-size: 26px;
    margin-bottom: 10px;
}

/* Form Field Styling */
.form-field {
    margin-bottom: 10px; /* Increased margin between fields */
}

/* Label Styling */
.form-field label {
    font-size: 14px;
    font-weight: bold;
    color: #555;
    display: block;
    margin-bottom: 3px;
}

/* Textbox and Dropdown Styling */
.form-control {
    width: 100%;
    padding: 10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #f9f9f9;
    box-sizing: border-box;
}

.form-control:focus {
    border-color: #4CAF50;
    outline: none;
}

/* Dropdown Container (for DOB selects) */
.dob-select {
    display: flex;
    justify-content: space-between;
}

.dob-select select {
    width: 32%;
    padding: 10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #f9f9f9;
}

.dob-select select:focus {
    border-color: #4CAF50;
}

/* Buttons Styling */
.btn {
    background-color: #4CAF50;
    color: white;
    padding: 12px 25px;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-right: 10px;
    display: inline-block;
}

.btn:hover {
    background-color: #45a049;
}

.btn-cancel {
    background-color: #f44336;
}

.btn-cancel:hover {
    background-color: #e53935;
}

/* Error Messages */
span[style*="color:Red"] {
    font-size: 12px;
    color: red;
    margin-top: 5px;
    display: block;
}

/* Form Field Alignment */
.form-field {
    margin-bottom: 20px;
}

/* Ensure the read-only State and District fields are aligned properly */
.form-field input[readonly] {
    background-color: #f0f0f0;
}

/* Responsive Design */
@media only screen and (max-width: 768px) {
    .content {
        width: 90%;
        padding: 15px;
    }

    .dob-select {
        flex-direction: column;
    }

    .dob-select select {
        width: 100%;
        margin-bottom: 10px;
    }

    .form-field {
        margin-bottom: 15px;
    }

    .btn {
        width: 100%;
        margin-bottom: 10px;
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
    <div>Add Voters</div>
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
            <a href="/Final_year_project/ADMIN_SIDE/AdminLoginVerification.aspx" class="dropdown-item logout">
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
 <form id="form1" runat="server">
    <div class="content">
        <h2>Add Voters Information<asp:Label ID="Label1" runat="server"></asp:Label>
        </h2>

       <!-- Aadhar ID -->
        <div class="form-field">
    <label for="txtAadharID">Aadhar ID:</label>
    <asp:TextBox ID="txtAadharID" runat="server" CssClass="form-control" Placeholder="Enter Aadhar ID (e.g., 123456789012)" />
    
    <!-- Required Field Validator -->
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAadharID" 
        ErrorMessage="Aadhar ID is required." ForeColor="Red" Display="Dynamic" />

    <!-- Regular Expression Validator for Aadhar ID -->
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAadharID" 
        ValidationExpression="^\d{12}$" 
        ErrorMessage="Aadhar ID must be exactly 12 digits." ForeColor="Red" Display="Dynamic" />
       </div>


      <!-- Voter ID -->
<div class="form-field">
    <label for="txtVoterID">Voter ID:</label>
    <asp:TextBox ID="txtVoterID" runat="server" CssClass="form-control" Placeholder="Enter Voter ID (e.g., KGH1234567)" />

    <!-- Required Field Validator -->
    <asp:RequiredFieldValidator ID="rfvVoterID" runat="server" ControlToValidate="txtVoterID" 
        ErrorMessage="Voter ID is required." ForeColor="Red" Display="Dynamic" />

    <!-- Regular Expression Validator for Voter ID -->
    <asp:RegularExpressionValidator ID="revVoterID" runat="server" ControlToValidate="txtVoterID" 
        ValidationExpression="^[A-Z]{3}\d{7}$" 
        ErrorMessage="Voter ID must follow the format KGH1234567 (3 uppercase letters followed by 7 digits)." 
        ForeColor="Red" Display="Dynamic" />
</div>


        <!-- Name -->
        <div class="form-field">
            <label for="txtName">Name:</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Placeholder="Enter Voter's Name" />
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required." ForeColor="Red" />
        </div>

        <!-- DOB (Day, Month, Year Dropdowns) -->
        <div class="form-field">
            <label for="ddlDay">Date of Birth:</label>
            <div class="dob-select">
                <asp:DropDownList ID="ddlDay" runat="server" CssClass="form-control" />
                <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control" />
                <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-control" />
            </div>
            <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="ddlDay" ErrorMessage="Day is required." ForeColor="Red" />
            <asp:RequiredFieldValidator ID="rfvMonth" runat="server" ControlToValidate="ddlMonth" ErrorMessage="Month is required." ForeColor="Red" />
            <asp:RequiredFieldValidator ID="rfvYear" runat="server" ControlToValidate="ddlYear" ErrorMessage="Year is required." ForeColor="Red" />
        </div>

        <!-- Gender -->
        <div class="form-field">
            <label for="ddlGender">Gender:</label>
            <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                <asp:ListItem Value="" Text="Select Gender" />
                <asp:ListItem Value="Male" Text="Male" />
                <asp:ListItem Value="Female" Text="Female" />
                <asp:ListItem Value="Other" Text="Other" />
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvGender" runat="server" ControlToValidate="ddlGender" InitialValue="" ErrorMessage="Gender is required." ForeColor="Red" />
        </div>

        <!-- State -->
        <div class="form-field">
            <label for="txtState">State:</label>
            <asp:TextBox ID="txtState" runat="server" CssClass="form-control" ReadOnly="true" />
        </div>

        <!-- District -->
        <div class="form-field">
            <label for="txtDistrict">District:</label>
            <asp:TextBox ID="txtDistrict" runat="server" CssClass="form-control" ReadOnly="true" />
        </div>

        <!-- Image Upload -->
<div class="form-field">
    <label for="fileUploadImage">Upload Image:</label>
    <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="form-control" />
    <asp:RequiredFieldValidator ID="rfvImage" runat="server" ControlToValidate="fileUploadImage"
        ErrorMessage="Please upload an image." ForeColor="Red" Display="Dynamic" />
</div>


        <!-- Submit and Cancel Buttons -->
        <div class="form-field">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-cancel" OnClick="btnCancel_Click" />
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