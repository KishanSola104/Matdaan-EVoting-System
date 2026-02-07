<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Forgot_Pass_Login.aspx.cs" Inherits="Forgot_Pass_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>Log in to E-VoteIndia</title>
  <style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(45deg, #f0f2f5, #e7eff6, #d7e7f2, #c7dff7);
        background-size: 400% 400%;
        animation: gradient 15s ease infinite;
    }
    
    @keyframes gradient {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }
    
    .login-page {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .login-box {
        background: white;
        padding: 20px;
        box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
        width: 400px;
        border-radius: 10px;
    }

    .login-box h1 {
        text-align: center;
        font-size: 28px;
        color: #1877f2;
        margin-bottom: 20px;
    }

    .login-box input {
        width: 100%;
        padding: 12px;
        margin: 8px 0;
        box-sizing: border-box;
        border: 1px solid #dddfe2;
        border-radius: 5px;
    }

    .login-box input[type="submit"] {
        background-color: #1877f2;
        color: white;
        border: none;
        cursor: pointer;
        padding: 12px;
        margin-top: 10px;
        width: 100%;
        border-radius: 5px;
    }

    .login-box input[type="submit"]:hover {
        background-color: #155dbb;
    }

    .forgot-link {
        text-align: center;
        margin-top: 10px;
    }

    .forgot-link a {
        color: #1877f2;
        text-decoration: none;
    }

    .separator {
        text-align: center;
        margin: 15px 0;
    }

    .create-account {
        display: block;
        width: 90%;
        padding: 12px;
        text-align: center;
        background-color: #42b72a;
        color: white;
        border-radius: 5px;
        text-decoration: none;
    }

    .create-account:hover {
        background-color: #36a420;
    }
  </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="login-page">
        <div class="login-box">
            <h1>E-VoteIndia</h1>
            <asp:TextBox ID="voterID" runat="server" CssClass="input" Placeholder="Voter ID"></asp:TextBox>
            <asp:TextBox ID="password" runat="server" CssClass="input" TextMode="Password" Placeholder="Password"></asp:TextBox>
            <asp:Button ID="btnLogin" runat="server" CssClass="button" Text="Log In" OnClick="btnLogin_Click" />

            <div class="forgot-link">
                <asp:HyperLink ID="forgotPassword" runat="server" NavigateUrl="forgot_password.aspx">Forgotten account?</asp:HyperLink>
                <br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
            </div>

            <div class="separator">or</div>

            <asp:HyperLink ID="createAccount" runat="server" CssClass="create-account" NavigateUrl="UserVerification.aspx">Create new account</asp:HyperLink>
        </div>
    </div>
</form>
</body>
</html>