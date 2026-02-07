<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserResults.aspx.cs" Inherits="UserResults" %>

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
    position: relative;
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
.header {
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

.party-logo {
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
        <h1 class="header">Gujarat State Election Results</h1>

        <!-- Winner Section -->
        <div class="winner-box" id="winnerSection" runat="server" visible="false">
            <img id="winnerLogo" runat="server" class="winner-logo" />
            <h2 id="winnerName" runat="server"></h2>
        </div>

        <!-- Election Results Table -->
        <div class="results-table">
            <asp:Repeater ID="rptResults" runat="server">
                <ItemTemplate>
                    <div class="result-card">
                        <img src='<%# ResolveUrl("~/" + Eval("PartyLogo")) %>' class="party-logo" alt="Party Logo" />
                        <p><b>Party:</b> <%# Eval("PartyName") %></p>
                        <p><b>District:</b> <%# Eval("District") %></p>
                        <p><b>Votes:</b> <%# Eval("TotalVotes") %></p>
                        <p><b>Vote Percentage:</b> <%# Eval("VotePercentage") %>%</p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>



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
