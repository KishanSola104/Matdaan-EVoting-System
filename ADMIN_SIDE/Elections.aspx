<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Elections.aspx.cs" Inherits="Elections" MaintainScrollPositionOnPostback="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <title> Elections Page</title>
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
            overflow-y: auto; /* Enable scrolling for content */
        }

        .sidebar:hover ~ .content {
            margin-left: 220px; /* Adjust content margin when sidebar expands */
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


/* Reset default margin and padding for the body */
body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    height: 100%; /* Ensure the body takes full height */
    overflow-y: auto; /* Enable vertical scrolling */
}

/* Ensure the form container takes full height */
.signup-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background-color: white;
    padding: 20px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    width: 100%;
    max-width: 600px;
    margin: 30px auto;
    overflow: hidden; /* Prevent internal scrolling within the form */
}

/* Heading Style */
.signup-container h2 {
    font-size: 24px;
    margin-bottom: 20px;
}

/* Style for form fields */
.form-field {
    margin-bottom: 15px;
    width: 100%;
}

/* Style for labels */
.form-field label {
    font-size: 14px;
    color: #333;
    display: block;
    margin-bottom: 5px;
}

/* Style for input fields */
.form-field input, .form-field select {
    width: 90%;
    padding: 10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

/* Style for multi-column date dropdowns */
.dob-fields {
    display: flex;
    justify-content: space-between;
}

/* Responsive styling for date dropdowns */
.dob-fields select {
    width: 32%;
}

/* Button Style */
.signup-button {
    background-color: #4CAF50;
    color: white;
    font-weight:bolder;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    width: 25%;
    text-align:center;
}

/* Hover effect for the button */
.signup-button:hover {
    background-color:Aqua;
}

/* Media Queries for responsiveness */
@media (max-width: 768px) {
    .signup-container {
        padding: 15px;
        margin: 10px;
    }

    .dob-fields {
        flex-direction: column;
    }

    .dob-fields select {
        width: 100%;
        margin-bottom: 10px;
    }

    .signup-button {
        width: 100%;
    }
}

@media (max-width: 480px) {
    .signup-container {
        width: 90%;
        padding: 10px;
    }

    .form-field {
        margin-bottom: 10px;
    }

    .signup-button {
        font-size: 14px;
    }
}





/* Container that holds the buttons */
.form-field1 {
    margin-top: 15px;
    display: flex;
    gap: 10px;
    justify-content: center;
    flex-wrap: wrap; /* Allow the buttons to wrap on smaller screens */
    padding: 10px;
}

/* Style for individual buttons */
.signup-button {
    background-color: #4CAF50;
    color: white;
    font-weight: bolder;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    min-width: 150px; /* Ensure buttons have a minimum width */
    margin: 5px; /* Add spacing between buttons */
}

/* Hover effect for the button */
.signup-button:hover {
    background-color: Aqua;
}

/* Responsive Design */
@media (max-width: 1024px) {
    .form-field1 {
        flex-direction: row; /* Ensure buttons are in a row but can wrap */
    }
}

@media (max-width: 768px) {
    .form-field1 {
        flex-direction: column; /* Stack buttons vertically on smaller screens */
        align-items: center; /* Center buttons vertically */
    }

    .signup-button {
        width: 80%; /* Make the buttons smaller on smaller screens */
        font-size: 14px;
    }
}

@media (max-width: 480px) {
    .signup-button {
        width: 100%; /* Make buttons take full width on very small screens */
        font-size: 14px;
    }
}


/* Container for the GridView */
.gridview-container {
    overflow-x: auto; /* Enable horizontal scrolling if content overflows */
    margin: 20px auto; /* Center the grid container */
    padding: 10px;
}

/* Styling for GridView */
.gridview {
    width: 70%;
    max-width: 100%;
    border-collapse: collapse;
    font-size: 16px;
    text-align: left;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    margin-left: 15%;
}

/* GridView Header Styling */
.gridview th {
    background-color: #2d3436; /* Dark gray for headers */
    color: #ffffff; /* White text for contrast */
    font-weight: bold;
    padding: 10px;
    text-align: left;
    border: 1px solid #444; /* Border for better separation */
}

/* GridView Row Styling */
.gridview td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: left;
    word-wrap: break-word; /* Break long words */
}

/* Alternate Row Colors for Better Readability */
.gridview tr:nth-child(odd) {
    background-color: #f9f9f9; /* Light gray */
}

.gridview tr:nth-child(even) {
    background-color: #ffffff; /* White */
}

/* Hover Effect */
.gridview tr:hover {
    background-color: #dfe6e9; /* Light blue-gray for hover */
}

/* Dark Mode Styles for GridView */
body.dark-mode .gridview {
    background-color: #34495e;
    color: #ecf0f1;
    border: none;
}

body.dark-mode .gridview th {
    background-color: #2d3436;
    color: #ecf0f1; /* Light text color for contrast */
}

body.dark-mode .gridview tr:nth-child(odd) {
    background-color: #3b4a5a;
}

body.dark-mode .gridview tr:nth-child(even) {
    background-color: #2c3e50;
}

body.dark-mode .gridview tr:hover {
    background-color: #575757;
}

body.dark-mode .gridview td {
    border: 1px solid #495867; /* Slightly lighter border */
}

/* Focus State for Accessibility */
.gridview td:focus,
.gridview th:focus {
    outline: 2px solid #2980b9; /* Blue outline for focus */
}

/* Responsive Design - Adjustments for small screens */
@media (max-width: 768px) {
    .gridview {
        font-size: 14px; /* Slightly smaller font for mobile screens */
    }

    .gridview th, .gridview td {
        padding: 8px; /* Less padding on smaller screens */
    }
}

@media (max-width: 480px) {
    .gridview {
        font-size: 12px; /* Smaller font size for very small screens */
    }

    .gridview th, .gridview td {
        padding: 6px; /* Even less padding for very small screens */
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
<!-- Include Google Material Icons -->
     <!-- Include Font Awesome for Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<!-- Header -->
<div class="header">
    <div>Elections Page</div>
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
  <!-- Add Elections Container Content will come here  -->
  <form runat="server">
      <div class="signup-container">
         <center> <h2 style="color:Gray;">Manage Election Information</h2></center>
         <div class="form-field">
        <label for="ddlSate">Select The Election:</label>  
             <asp:DropDownList 
                ID="DropDownList1" runat="server" Height="29px" AutoPostBack="true" Width="200px" 
                 DataSourceID="SqlDataSource1" DataTextField="ElectionID" 
                 DataValueField="ElectionID" onselectedindexchanged="DropDownList1_SelectedIndexChanged" 
                 >
                  <asp:ListItem Text="Select The Election" runat="server"></asp:ListItem>
            </asp:DropDownList>
        
             <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                 SelectCommand="SELECT [ElectionID] FROM [Election]"></asp:SqlDataSource>
        
             <asp:Label ID="Label1" runat="server"></asp:Label>
</div>

 

          <!-- Election ID -->
            <div class="form-field">
                <label for="txtElectionID">Election ID:</label>
                <asp:TextBox ID="TextBox1" runat="server" placeholder="Enter Election ID"></asp:TextBox>
            </div>

            <!-- Election Name -->
            <div class="form-field">
                <label for="txtElectionName">Election Name:</label>
                <asp:TextBox ID="TextBox2" runat="server" placeholder="Enter Election Name"></asp:TextBox>
            </div>

               <!-- State -->
            <div class="form-field">
                <label>State:</label>
                <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged"></asp:DropDownList>
            </div>

                    <!-- Total No. of Parties -->
                 <div class="form-field">
                <label for="txtTotalNoOfParties">Total No. of Parties:</label>
                <asp:TextBox ID="TextBox3" runat="server" placeholder="Enter Total No. Of Parties" 
                         ontextchanged="TextBox3_TextChanged"></asp:TextBox>
            </div>

                <!-- Total No. of Candidates -->
                 <div class="form-field">
                <label for="txtTotalNoOfCandidates">Total No. of Candidates:</label>
                <asp:TextBox ID="TextBox4" runat="server" placeholder="Enter Total No. Of Candidates"></asp:TextBox>
            </div>

              <!-- Total No. of Voters -->
                 <div class="form-field">
                <label for="txtTotalNoOfVoters">Total No. of Voters:</label>
                <asp:TextBox ID="TextBox5" runat="server" placeholder="Enter Total No. Of Voters"></asp:TextBox>
            </div>
     
            <!-- Date of BElection -->
            <div class="form-field">
                <label>Date of Election:</label>
                <div class="dob-fields">
                    <asp:DropDownList ID="ddlDay" runat="server" Width="32%"></asp:DropDownList>
                    <asp:DropDownList ID="ddlMonth" runat="server" Width="32%"></asp:DropDownList>
                    <asp:DropDownList ID="ddlYear" runat="server" Width="32%"></asp:DropDownList>
                </div>
            </div>

              <!-- Date of Results -->
            <div class="form-field">
                <label>Date of Results:</label>
                <div class="dob-fields">
                    <asp:DropDownList ID="ddlDay1" runat="server" Width="32%"></asp:DropDownList>
                    <asp:DropDownList ID="ddlMonth1" runat="server" Width="32%"></asp:DropDownList>
                    <asp:DropDownList ID="ddlYear1" runat="server" Width="32%"></asp:DropDownList>
                </div>
            </div>
            

<!-- Sign Up Buttons -->
<div class="form-field1" style="margin-top: 15px; display: flex; gap: 10px; justify-content: center;">
    <asp:Button ID="btnSubmit1" runat="server" Text="Add Election" 
        CssClass="signup-button"   onclick="btnSubmit1_Click"  />
        <asp:Button ID="btnSubmit4" runat="server" Text="Update Election" 
        CssClass="signup-button" onclick="btnSubmit4_Click"   />
        <asp:Button ID="btnSubmit5" runat="server" Text="Delete Election" 
        CssClass="signup-button"   onclick="btnSubmit5_Click"   />
    <asp:Button ID="btnSubmit2" runat="server" Text="View Elections" 
        CssClass="signup-button"   onclick="btnSubmit2_Click"  />
    <asp:Button ID="btnSubmit3" runat="server" Text="Cancel" 
        CssClass="signup-button" onclick="btnSubmit3_Click"  />
         
          
   
</div>
        </div>


         <div class="gridview-container">
             <asp:GridView ID="GridView1" runat="server" class="gridview" 
                 AutoGenerateColumns="False" DataKeyNames="ElectionID" 
                 DataSourceID="SqlDataSource2">
                 <Columns>
                     <asp:BoundField DataField="ElectionID" HeaderText="ElectionID" ReadOnly="True" 
                         SortExpression="ElectionID" />
                     <asp:BoundField DataField="ElectionName" HeaderText="ElectionName" 
                         SortExpression="ElectionName" />
                     <asp:BoundField DataField="StateName" HeaderText="StateName" 
                         SortExpression="StateName" />
                     <asp:BoundField DataField="TotalParties" HeaderText="TotalParties" 
                         SortExpression="TotalParties" />
                     <asp:BoundField DataField="TotalCandidates" HeaderText="TotalCandidates" 
                         SortExpression="TotalCandidates" />
                     <asp:BoundField DataField="TotalVoters" HeaderText="TotalVoters" 
                         SortExpression="TotalVoters" />
                     <asp:BoundField DataField="DateOfElection" HeaderText="DateOfElection" 
                         SortExpression="DateOfElection" />
                     <asp:BoundField DataField="DateOfResult" HeaderText="DateOfResult" 
                         SortExpression="DateOfResult" />
                 </Columns>
             </asp:GridView>
     </div>
    
     <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
         ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
         DeleteCommand="DELETE FROM [Election] WHERE [ElectionID] = @ElectionID" 
         InsertCommand="INSERT INTO [Election] ([ElectionID], [ElectionName], [StateName], [TotalParties], [TotalCandidates], [TotalVoters], [DateOfElection], [DateOfResult]) VALUES (@ElectionID, @ElectionName, @StateName, @TotalParties, @TotalCandidates, @TotalVoters, @DateOfElection, @DateOfResult)" 
         SelectCommand="SELECT * FROM [Election]" 
         UpdateCommand="UPDATE [Election] SET [ElectionName] = @ElectionName, [StateName] = @StateName, [TotalParties] = @TotalParties, [TotalCandidates] = @TotalCandidates, [TotalVoters] = @TotalVoters, [DateOfElection] = @DateOfElection, [DateOfResult] = @DateOfResult WHERE [ElectionID] = @ElectionID">
         <DeleteParameters>
             <asp:Parameter Name="ElectionID" Type="String" />
         </DeleteParameters>
         <InsertParameters>
             <asp:Parameter Name="ElectionID" Type="String" />
             <asp:Parameter Name="ElectionName" Type="String" />
             <asp:Parameter Name="StateName" Type="String" />
             <asp:Parameter Name="TotalParties" Type="String" />
             <asp:Parameter Name="TotalCandidates" Type="String" />
             <asp:Parameter Name="TotalVoters" Type="String" />
             <asp:Parameter DbType="Date" Name="DateOfElection" />
             <asp:Parameter DbType="Date" Name="DateOfResult" />
         </InsertParameters>
         <UpdateParameters>
             <asp:Parameter Name="ElectionName" Type="String" />
             <asp:Parameter Name="StateName" Type="String" />
             <asp:Parameter Name="TotalParties" Type="String" />
             <asp:Parameter Name="TotalCandidates" Type="String" />
             <asp:Parameter Name="TotalVoters" Type="String" />
             <asp:Parameter DbType="Date" Name="DateOfElection" />
             <asp:Parameter DbType="Date" Name="DateOfResult" />
             <asp:Parameter Name="ElectionID" Type="String" />
         </UpdateParameters>
     </asp:SqlDataSource>



      
    </form>
  
   


    <!-- Footer Section -->
<div class="footer">
    <span class="material-icons">lock</span> All Rights Reserved &copy; E-VoteIndia
</div>
</form>

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

</body>
</html>
