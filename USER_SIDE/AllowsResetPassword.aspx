<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AllowsResetPassword.aspx.cs" Inherits="AllowsResetPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta charset="UTF-8">
   <title>Security Verification</title>
    <style>
  /* General Reset */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    color: #333;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* Navbar */
.navbar {
    width: 100%;
    background-color: #007bff;
    color: white;
    padding: 15px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.logo {
    font-size: 22px;
    font-weight: bold;
    margin: 0;
    width:80%;
    margin-left:20px;
}

.navbar a {
    color: white;
    text-decoration: none;
    font-size: 16px;
    margin-left: 20px;
}

.navbar a:hover {
    text-decoration: underline;
}

/* Container */
.container {
    background: #fff;
    padding: 20px;
    width: 350px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    margin-top: 30px;
}

/* Headings */
h2 {
    font-size: 20px;
    margin-bottom: 10px;
}

p {
    font-size: 14px;
    color: #555;
}

/* Labels */
asp\:Label {
    display: block;
    font-weight: bold;
    margin-top: 10px;
    text-align: left;
}

/* Input Fields */
.input-text {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-top: 5px;
    box-sizing: border-box;
}

/* Buttons */
.submit-btn, .reset-btn {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 5px;
    background: #007bff;
    color: white;
    font-size: 16px;
    cursor: pointer;
    margin-top: 15px;
}

.submit-btn:hover, .reset-btn:hover {
    background: #0056b3;
}

/* Error Messages */
.error {
    color: red;
    font-size: 14px;
    margin-top: 10px;
}

        
 
    </style>
</head>
<body>

  <div class="navbar">
            <p class="logo">E-VoteIndia</p>
           
            <a href="login.aspx" style="margin-left:20px; color:White;  " target=_top>Login</a>
            <br />
   
        </div>
  <form id="form1" runat="server">
    <div class="container">
        <h2>Security Verification</h2>
        <p>Answer the following security questions to reset your password.</p>

        <!-- Security Questions Panel -->
        <asp:Panel ID="pnlSecurityQuestions" runat="server">
            <asp:Label ID="lblQuestion1" runat="server"></asp:Label><br />
            <asp:TextBox ID="txtAnswer1" runat="server" CssClass="input-text"></asp:TextBox><br />

            <asp:Label ID="lblQuestion2" runat="server"></asp:Label><br />
            <asp:TextBox ID="txtAnswer2" runat="server" CssClass="input-text"></asp:TextBox><br />

            <asp:Button ID="btnSubmit" runat="server" Text="Verify & Continue" CssClass="submit-btn" OnClick="btnSubmit_Click" />
        </asp:Panel>

        <!-- Password Reset Panel -->
        <asp:Panel ID="pnlResetPassword" runat="server" Visible="false">
            <h2>Reset Your Password</h2>
            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="input-text" TextMode="Password" placeholder="New Password"></asp:TextBox><br />
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="input-text" TextMode="Password" placeholder="Confirm Password"></asp:TextBox><br />
            <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" CssClass="reset-btn" OnClick="btnResetPassword_Click" />
        </asp:Panel>

        <br /><br />
        <asp:Label ID="lblMessage" runat="server" CssClass="error"></asp:Label>
    </div>
</form>


</body>
</html>