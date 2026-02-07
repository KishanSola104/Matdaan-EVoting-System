<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserElection.aspx.cs" Inherits="UserElection" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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





/* Footer Styles */
footer {
    background: #2E8B57;
    color: white;
    padding: 15px;
    font-size: 13px;
    width: calc(100% - 200px);
    left: 200px;
    margin-left:200px;
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

        <!-- Election Details Section -->
        <div class="election-card">
            <h2>Election Details</h2>
            <p><strong>Election Name:</strong> <asp:Label ID="lblElectionName" runat="server" /></p>
            <p><strong>State:</strong> <asp:Label ID="lblState" runat="server" /></p>
            <p><strong>Total Voters:</strong> <asp:Label ID="lblTotalVoters" runat="server" /></p>
            <p><strong>Date of Election:</strong> <asp:Label ID="lblDateOfElection" runat="server" /></p>
            <p><strong>Date of Result:</strong> <asp:Label ID="lblDateOfResult" runat="server" /></p>
        </div>

        <!-- Party Information -->
        <h2>Parties in the Election</h2>
        <asp:GridView ID="gvParties" runat="server" CssClass="party-table" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="PartyName" HeaderText="Party Name" />
                <asp:BoundField DataField="PartyLeader" HeaderText="Leader" />
                <asp:BoundField DataField="TotalCandidates" HeaderText="Total Candidates" />
            </Columns>
        </asp:GridView>

        <!-- Candidate Information -->
        <h2>Candidates Standing in Election</h2>
        <div class="candidate-grid">
            <asp:Repeater ID="rptCandidates" runat="server">
                <ItemTemplate>
                    <div class="candidate-card">
                       <img src='<%# ResolveUrl("~/" + Eval("Image").ToString()) %>' 
     alt="Candidate Photo" 
     onerror="this.onerror=null; this.src='Images/default.png';" />

                        <h3><%# Eval("CandidateName") %></h3>
                        <p><strong>Party:</strong> <%# Eval("PartyName") %></p>
                     
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>

            <style>
/* Full-page Layout Fix */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
}

/* Ensure Main Content Expands Fully */
.container {
    flex: 1;
    max-width: 1200px;
    margin: auto;
    padding: 20px;
    padding-top: 100px; /* Space for fixed header */
    padding-bottom: 60px; /* Space to prevent footer overlap */
}


/* Election Card Styling */
.election-card {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin-bottom: 20px;
}

/* Party Table Styling */
.party-table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
}

.party-table th, .party-table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
}

.party-table th {
    background: #007BFF;
    color: white;
}

/* Candidate Grid Styling */
.candidate-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-top: 20px;
}

/* Candidate Card */
.candidate-card {
    background: white;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
    text-align: center;
}

/* Candidate Image */
.candidate-card img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
}

/* Headers Styling */
h2, h3 {
    color: #333;
}

/* === Responsive Design === */
@media (max-width: 768px) {
    .container {
        padding: 15px;
    }
    
    .candidate-grid {
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    }
}

/* === Header, Sidebar & Footer Fixes === */

/* Header Fix */
.header 
{
    
    position: fixed;
    width: 100%;
    top: 0;
    left: 0;
    background: #333;
    color: white;
    padding: 15px 0;
    text-align: center;
    z-index: 1000;
}

/* Sidebar Fix */
.sidebar {
    position: fixed;
    width: 200px;
    height: 100vh;
    background: #222;
    color: white;
    top: 0;
    left: 0;
    padding: 20px;
    z-index: 999;
}

.container {
    margin-left: 270px; /* Adjusts content after sidebar */
}

/* Footer Fix */
.footer {
    width: 100%;
    background: #333;
    color: white;
    text-align: center;
    padding: 10px 0;
    margin-top: auto; /* Pushes footer to bottom */
    position: relative; /* Removes overlap effect */
}
            </style>

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
        <ul style="font-weight: lighter">
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
