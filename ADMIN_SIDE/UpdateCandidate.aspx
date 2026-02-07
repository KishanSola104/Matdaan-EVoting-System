<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateCandidate.aspx.cs" Inherits="UpdateCandidate" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <title>Admin Dashboard  Update Candidates Page</title>
<style>
      /* Global Styles */
    body, html {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background: #f4f4f4;
        height: 100%;
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
    
        
    </style>

    <style>
  
    .sidebar:hover ~ .content {
        margin-left: 220px;
    }

   /* Form Styling */
.signup-container {
    max-width: 600px;
    margin: 0 auto; /* Center the form */
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    text-align: center; /* Center content within the container */
    margin-top: 30px; /* Space above the form to avoid overlap with header */
}

.signup-container h3 {
    margin-bottom: 20px;
    font-size: 24px;
    color: #333;
    text-align: center;
}

.form-field {
    margin-bottom: 15px;
    text-align: left; /* Labels remain aligned left */
}

.form-field label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #333;
}

.form-field input[type="text"],
.form-field input[type="password"],
.form-field input[type="email"],
.form-field input[type="file"],
.form-field select {
    width: 100%;
    padding: 10px;
    font-size: 14px;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
    transition: border-color 0.3s ease;
}

.form-field input[type="text"]:focus,
.form-field input[type="password"]:focus,
.form-field input[type="email"]:focus,
.form-field input[type="file"]:focus,
.form-field select:focus {
    border-color: #007bff;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
}

.gender-options {
    display: flex;
    align-items: center;
    gap: 10px;
}

.terms-conditions {
    display: flex;
    align-items: center;
    gap: 5px;
}

.signup-button {
    width: 48%;
    padding: 10px;
    background-color: #28a745;
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.signup-button:hover {
    background-color: #218838;
}

.cancel-button {
    background-color: #dc3545;
}

.cancel-button:hover {
    background-color: #c82333;
}

@media (max-width: 768px) {
    .signup-container {
        width: 90%;
        margin-top: 20px;
    }

    .signup-container h3 {
        font-size: 20px;
    }
}
    
    
    
   
    </style>

   <style>
    /* General GridView Styling */
    .gridview-style {
        border-collapse: collapse;
        width: 100%;
        font-family: 'Roboto', Arial, sans-serif;
        margin-top: 50px;
        overflow-x: auto;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }

    /* Header Styling */
    .gridview-style th {
        background-color: #0078D7;
        color: white;
        padding: 14px;
        text-align: center;
        font-size: 1rem;
        letter-spacing: 0.5px;
        border-top: 2px solid #0056A4;
        border-bottom: 2px solid #0056A4;
    }

    /* Cell Styling */
    .gridview-style td {
        padding: 14px;
        border: 1px solid #ddd;
        font-size: 0.9rem;
        text-align: center;
        vertical-align: middle;
        color: #333;
    }

    /* Row Styling */
    .gridview-style tr:nth-child(even) {
        background-color: #f7f9fc;
    }

    .gridview-style tr:nth-child(odd) {
        background-color: #ffffff;
    }

    .gridview-style tr:hover {
        background-color: #E3F2FD;
        transition: background-color 0.3s ease-in-out;
        cursor: pointer;
    }

    /* Buttons in Command Fields */
    .gridview-style .command-button a {
        display: inline-block;
        padding: 8px 14px;
        margin: 4px;
        font-size: 0.85rem;
        font-weight: bold;
        color: white;
        background-color: #0078D7;
        border: none;
        border-radius: 4px;
        text-decoration: none;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .gridview-style .command-button a:hover {
        background-color: #0056A4;
        transform: scale(1.05);
    }

    /* Responsive Styling */
    @media screen and (max-width: 768px) {
        .gridview-style th,
        .gridview-style td {
            font-size: 0.85rem;
            padding: 10px;
        }
        .gridview-style {
            font-size: 0.9rem;
        }
    }

    @media screen and (max-width: 480px) {
        .gridview-style th,
        .gridview-style td {
            font-size: 0.75rem;
            padding: 8px;
        }
    }
</style>
<style>
    /* General GridView Styling */
    .gridview-style {
        border-collapse: collapse;
        width: 100%;
        font-family: Arial, sans-serif;
        margin-top: 30px;
        overflow-x: auto;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border-radius: 6px;
        font-size: 0.9rem; /* Reduced overall font size */
    }

    /* Header Styling */
    .gridview-style th {
        background-color: #34495E; /* Dark blue-gray */
        color: #ECF0F1; /* Light gray */
        padding: 8px;
        text-align: center;
        font-weight: 600;
        letter-spacing: 0.3px;
        border-top: 2px solid #2C3E50;
        border-bottom: 2px solid #2C3E50;
    }

    /* Cell Styling */
    .gridview-style td {
        padding: 8px;
        border: 1px solid #ddd;
        text-align: center;
        vertical-align: middle;
        color: #2C3E50; /* Dark gray-blue */
        background-color: #FBFCFC; /* Subtle light gray */
    }

    /* Row Styling */
    .gridview-style tr:nth-child(even) {
        background-color: #F2F3F4; /* Slightly darker light gray for alternating rows */
    }

    .gridview-style tr:hover {
        background-color: #D6DBDF; /* Light gray-blue hover */
        transition: background-color 0.2s ease-in-out;
        cursor: pointer;
    }

    /* Buttons in Command Fields */
    .gridview-style .command-button a {
        display: inline-block;
        padding: 6px 10px; /* Reduced button size */
        margin: 2px;
        font-size: 0.8rem;
        font-weight: bold;
        color: #ffffff;
        background-color: #3498DB; /* Soft blue */
        border: none;
        border-radius: 4px;
        text-decoration: none;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .gridview-style .command-button a:hover {
        background-color: #2980B9; /* Slightly darker blue on hover */
        transform: scale(1.05);
    }

    /* Reduce Box Sizes */
    .gridview-style td, .gridview-style th {
        height: 36px; /* Adjusted height */
        line-height: 1.2;
    }

    /* Responsive Styling */
    @media screen and (max-width: 768px) {
        .gridview-style th,
        .gridview-style td {
            font-size: 0.8rem;
            padding: 6px;
        }
        .gridview-style {
            font-size: 0.85rem;
        }
    }

    @media screen and (max-width: 480px) {
        .gridview-style th,
        .gridview-style td {
            font-size: 0.75rem;
            padding: 4px;
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
    <div>Update Candidates</div>
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


  <form id="form1" runat="server">
    <div class="content" style="overflow-x: auto; padding: 20px;">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="CandidateId" DataSourceID="SqlDataSource2"
            AllowPaging="True" AllowSorting="True" CssClass="gridview-style" 
            OnRowEditing="GridView1_RowEditing" 
            OnRowUpdating="GridView1_RowUpdating" 
            OnRowCancelingEdit="GridView1_RowCancelingEdit" 
            OnRowDeleting="GridView1_RowDeleting">
            <Columns>
               
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
               
                <asp:BoundField DataField="ElectionId" HeaderText="ElectionId" 
                    SortExpression="ElectionId" />
                <asp:BoundField DataField="PartyId" HeaderText="PartyId" 
                    SortExpression="PartyId" />
                <asp:BoundField DataField="PartyName" HeaderText="PartyName" 
                    SortExpression="PartyName" />
                <asp:BoundField DataField="CandidateId" HeaderText="CandidateId" 
                    ReadOnly="True" SortExpression="CandidateId" />

                
                <asp:BoundField DataField="CandidateName" HeaderText="CandidateName" 
                    SortExpression="CandidateName" />
                <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                <asp:BoundField DataField="District" HeaderText="District" 
                    SortExpression="District" />
                <asp:BoundField DataField="DOB" HeaderText="DOB" SortExpression="DOB" />
                <asp:BoundField DataField="Gender" HeaderText="Gender" 
                    SortExpression="Gender" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="Mobile" HeaderText="Mobile" 
                    SortExpression="Mobile" />
                <asp:BoundField DataField="Image" HeaderText="Image" SortExpression="Image" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="DELETE FROM [Candidates] WHERE [CandidateId] = @CandidateId" 
            InsertCommand="INSERT INTO [Candidates] ([ElectionId], [PartyId], [PartyName], [CandidateId], [CandidateName], [State], [District], [DOB], [Gender], [Email], [Mobile], [Image]) VALUES (@ElectionId, @PartyId, @PartyName, @CandidateId, @CandidateName, @State, @District, @DOB, @Gender, @Email, @Mobile, @Image)" 
            SelectCommand="SELECT * FROM [Candidates]" 
            UpdateCommand="UPDATE [Candidates] SET [ElectionId] = @ElectionId, [PartyId] = @PartyId, [PartyName] = @PartyName, [CandidateName] = @CandidateName, [State] = @State, [District] = @District, [DOB] = @DOB, [Gender] = @Gender, [Email] = @Email, [Mobile] = @Mobile, [Image] = @Image WHERE [CandidateId] = @CandidateId">
            <DeleteParameters>
                <asp:Parameter Name="CandidateId" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ElectionId" Type="String" />
                <asp:Parameter Name="PartyId" Type="String" />
                <asp:Parameter Name="PartyName" Type="String" />
                <asp:Parameter Name="CandidateId" Type="String" />
                <asp:Parameter Name="CandidateName" Type="String" />
                <asp:Parameter Name="State" Type="String" />
                <asp:Parameter Name="District" Type="String" />
                <asp:Parameter Name="DOB" Type="String" />
                <asp:Parameter Name="Gender" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Mobile" Type="String" />
                <asp:Parameter Name="Image" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ElectionId" Type="String" />
                <asp:Parameter Name="PartyId" Type="String" />
                <asp:Parameter Name="PartyName" Type="String" />
                <asp:Parameter Name="CandidateName" Type="String" />
                <asp:Parameter Name="State" Type="String" />
                <asp:Parameter Name="District" Type="String" />
                <asp:Parameter Name="DOB" Type="String" />
                <asp:Parameter Name="Gender" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Mobile" Type="String" />
                <asp:Parameter Name="Image" Type="String" />
                <asp:Parameter Name="CandidateId" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="DELETE FROM [Candidates] WHERE [CandidateId] = @CandidateId" 
            SelectCommand="SELECT * FROM [Candidates] WHERE PartyId = @PartyId" 
            UpdateCommand="UPDATE [Candidates] SET [CandidateName] = @CandidateName, [State] = @State, [District] = @District, [DOB] = @DOB, [Gender] = @Gender, [Email] = @Email, [Mobile] = @Mobile WHERE [CandidateId] = @CandidateId">
            <SelectParameters>
                <asp:Parameter Name="PartyId" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="CandidateId" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="CandidateName" Type="String" />
                <asp:Parameter Name="State" Type="String" />
                <asp:Parameter Name="District" Type="String" />
                <asp:Parameter Name="DOB" Type="String" />
                <asp:Parameter Name="Gender" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Mobile" Type="String" />
                <asp:Parameter Name="CandidateId" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
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