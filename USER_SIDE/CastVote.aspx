<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CastVote.aspx.cs" Inherits="CastVote" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
     <title>User Dashboard - E-Vote India</title>
    <!-- Font Awesome Link -->
    
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

/* Main Content */
.main-content {
    margin-left: 200px;
    padding: 20px;
    transition: margin-left 0.3s;
    margin-top: 60px;
}

/* Footer Styles */
footer {
    background: #2E8B57;
    color: white;
    padding: 15px;
    font-size: 13px;
    width: calc(100% - 200px);
    left: 200px;
    position: Fixed;
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
/* Global Styling */
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

/* Main Layout - Prevents Overlapping */
.wrapper {
    display: flex;
    min-height: 100vh;
}

/* Sidebar */
.sidebar {
    width: 200px; /* Adjust according to your sidebar width */
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
   
    padding-top: 60px; /* Adjust to fit your layout */
}

/* Main Content (Prevents Overlapping) */
.main-content {
    margin-left: 240px; /* Adjust to match the sidebar width */
    padding: 50px 20px 20px; /* Prevents overlapping header/footer */
    width: calc(100% - 240px);
    box-sizing: border-box;
}

/* Candidate Grid */
.candidate-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 20px;
    padding: 20px;
}

/* Candidate Card */
.card {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 15px;
    flex: 1 1 calc(33.33% - 20px); /* 3 cards per row */
    text-align: center;
    transition: transform 0.3s ease-in-out;
    min-width: 250px;
    max-width: 350px;
}

.card:hover {
    transform: scale(1.03);
}

/* Candidate Image */
.card-img-top {
    width: 100%;
    height: 220px;
    object-fit: cover;
    border-radius: 5px;
    background-image:cover;
}

/* Candidate Name */
.card h5 {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin-top: 10px;
}

/* Party Name */
.card p {
    font-size: 14px;
    color: #666;
}

/* Vote Button */
.btn-success {
    background: #28a745;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    transition: background 0.3s;
}

.btn-success:hover {
    background: #218838;
}

/* Footer */
.footer {
  
   
    padding: 10px 0;
    position: fixed;
    width: 100%;
    bottom: 0;
}

/* Responsive Design */
@media (max-width: 1024px) {
    .main-content {
        margin-left: 0;
        width: 100%;
    }

    .candidate-container {
        justify-content: center;
    }

    .card {
        flex: 1 1 45%; /* 2 cards per row on tablets */
    }
}

@media (max-width: 768px) {
    .card {
        flex: 1 1 90%; /* 1 card per row on smaller screens */
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

<div class="main-content">
    <div class="candidate-container">
        <asp:Repeater ID="rptCandidates" runat="server">
            <ItemTemplate>
                <div class="card text-center p-3">
                    <!-- Candidate Image -->
                    <img src='<%# ResolveUrl("~/" + Eval("Image").ToString()) %>' 
                         class="card-img-top" 
                         alt="Candidate Photo"
                         onerror="this.onerror=null; this.src='Images/default.png';" />

                    <!-- Candidate Name -->
                    <h5><%# Eval("CandidateName") %></h5>
                    
                    <!-- Party Name -->
                    <p><%# Eval("PartyName") %></p>

                    <!-- Vote Button -->
                    <asp:Button ID="btnVote" runat="server" CssClass="btn btn-success mt-2"
                        Text="Submit Vote"
                        CommandArgument='<%# Eval("CandidateID") %>'
                        OnClick="SubmitVote"
                        OnClientClick='<%# "return confirmVote(\"" + Eval("PartyName") + "\", \"" + Eval("CandidateID") + "\");" %>' />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

<script>
    function confirmVote(partyName, candidateID) {
        return confirm("Do you want to submit your vote to " + partyName + "?");
    }
</script>



    
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
