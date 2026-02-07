<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Party_Affi.aspx.cs" Inherits="Party_Affi" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Party Affidavits</title>
   <style>
   /* General Page Styling */
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(to right, #e3f2fd, #bbdefb);
    text-align: center;
    margin: 0;
    padding: 0;
}

/* Container for Party Cards */
.party-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 25px;
    padding: 40px;
}

/* Individual Party Card */
.party-card {
    width: 320px;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
    padding: 20px;
    text-align: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

/* Hover Effect for Cards */
.party-card:hover {
    transform: translateY(-5px);
    box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.3);
}

/* Party & Leader Images */
.party-card img {
    width: 110px;
    height: 110px;
    object-fit: cover;
    border-radius: 50%;
    border: 4px solid #64b5f6;
    margin: 10px auto;
    transition: transform 0.3s ease;
}

/* Image Hover Effect */
.party-card img:hover {
    transform: scale(1.1);
}

/* Party Name */
.party-card h3 {
    color: #1e88e5;
    font-size: 20px;
    font-weight: bold;
    margin-top: 10px;
}

/* Leader & Slogan */
.party-card p {
    font-size: 15px;
    color: #424242;
    margin: 8px 0;
}

/* Strong Tags Styling */
.party-card p strong {
    color: #1565c0;
    font-weight: 600;
}

/* Party Info */
.party-card .party-info {
    background: #e3f2fd;
    padding: 8px;
    border-radius: 6px;
    margin-top: 10px;
    font-size: 14px;
    font-weight: 500;
}
</style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>List of Political Parties</h2>
        <div class="party-container">
         <asp:Repeater ID="rptParties" runat="server">
    <ItemTemplate>
        <div class="party-card">
            <!-- Use correct paths -->
            <img src='<%# ResolveUrl("~/") + Eval("PartyLogo") %>' alt="Party Logo" />
            <h3><%# Eval("PartyName") %></h3>
            <p><strong>Leader:</strong> <%# Eval("PartyLeader") %></p>
            <img src='<%# ResolveUrl("~/") + Eval("LeaderPicture") %>' alt="Leader Picture" />
            <p><strong>Slogan:</strong> <%# Eval("PartySlogan") %></p>
            <p><strong>Established Year:</strong> <%# Eval("EstablishedYear") %></p>
            <p><strong>Total Candidates:</strong> <%# Eval("TotalCandidates") %></p>
        </div>
    </ItemTemplate>
</asp:Repeater>

        </div>
    </form>
</body>
</html>