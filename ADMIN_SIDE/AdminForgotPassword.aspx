<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminForgotPassword.aspx.cs" Inherits="AdminForgotPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
      <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Your Account Admin </title>
<style>
    /* Body background animation excluding navbar */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(135deg, #8e44ad, #3498db, #e67e22, #2ecc71);
        background-size: 200% 200%;
        animation: backgroundSweep 15s linear infinite;
    }

    /* Navbar styling */
    .navbar {
        width: 100%;
        height: 70px;
        background: linear-gradient(90deg, #4a90e2, #1a75d2);
        color: white;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        border-bottom: 2px solid #444;
        padding: 0 20px;
        box-sizing: border-box;
        animation: navbarFadeSlide 1s ease-out forwards;
    }

    /* Background animation */
    @keyframes backgroundSweep {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    /* Navbar animation */
    @keyframes navbarFadeSlide {
        0% { opacity: 0; transform: translateY(-30px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    /* Logo bouncing animation */
    .logo {
        color: #fff;
        text-align: left;
        margin-right: auto;
        font-size: xx-large;
        font-weight: 700;
        animation: bounceEffect 2s infinite;
    }

    /* Bounce effect for logo */
    @keyframes bounceEffect {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-10px); }
    }

    .navbar input[type="text"], .navbar input[type="password"] {
        margin-right: 10px;
        padding: 10px;
        font-size: 16px;
        border-radius: 4px;
        border: 1px solid #dddfe2;
    }

    .navbar button {
        height: 60px;
        width: 100px;
        background: linear-gradient(135deg, #1e90ff, #007bff);
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        margin-right: 10px;
        position: relative;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        animation: buttonFadeIn 1s ease-in;
    }

    /* Button gradient hover effect */
    .navbar button:hover {
        background: linear-gradient(135deg, #007bff, #1e90ff);
        transform: scale(1.05);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
    }

    /* Button fade-in animation */
    @keyframes buttonFadeIn {
        0% { opacity: 0; transform: translateY(20px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    /* Main container styling */
    .container {
        max-width: 400px;
        margin: 50px auto;
        background: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
        padding: 20px;
        text-align: left;
        animation: containerPopIn 1s cubic-bezier(0.22, 1, 0.36, 1) forwards;
        transform-origin: center;
    }

    /* Pop-in animation */
    @keyframes containerPopIn {
        0% { opacity: 0; transform: scale(0.8) rotateX(-10deg); }
        100% { opacity: 1; transform: scale(1) rotateX(0); }
    }

    .container h2 {
        font-size: 26px;
        margin-bottom: 20px;
        border-bottom: 2px solid #3498db;
        padding-bottom: 5px;
        color: #333;
    }

    .container input[type="text"] {
        width: 90%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #dddfe2;
        border-radius: 6px;
        font-size: 16px;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .container .buttons {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }

    .container .buttons button {
        height: 50px;
        width: 110px;
        background: linear-gradient(135deg, #e74c3c, #c0392b);
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        animation: buttonScale 0.5s ease forwards;
    }

    /* Button hover effect */
    .container .buttons button:hover {
        background: linear-gradient(135deg, #c0392b, #e74c3c);
        transform: scale(1.1);
    }

    /* Button scaling animation */
    @keyframes buttonScale {
        0% { transform: scale(0.9); opacity: 0; }
        100% { transform: scale(1); opacity: 1; }
    }

    /* Responsive design */
    @media (max-width: 768px) {
        .navbar {
            flex-direction: column;
            align-items: flex-start;
            height: auto;
            padding: 10px;
        }

        .navbar .logo {
            margin-right: 0;
            font-size: large;
            margin-bottom: 10px;
        }

        .navbar input[type="text"], .navbar input[type="password"], .navbar button {
            margin-right: 0;
            margin-bottom: 10px;
            width: 100%;
        }

        .container {
            width: 95%;
            margin: 20px auto;
        }

        .container input[type="text"] {
            width: 100%;
        }

        .container .buttons {
            flex-direction: column;
            align-items: stretch;
        }

        .container .buttons button {
            width: 100%;
            margin-bottom: 10px;
        }
    }

    @media (max-width: 480px) {
        .navbar {
            height: auto;
            padding: 5px;
        }

        .navbar .logo {
            font-size: medium;
        }

        .navbar input[type="text"], .navbar input[type="password"], .navbar button {
            height: 40px;
            font-size: 14px;
        }

        .container {
            padding: 10px;
            width: 90%;
        }

        .container h2 {
            font-size: 20px;
        }

        .container .buttons button {
            height: 40px;
            font-size: 14px;
        }
    }
</style>


</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <p class="logo">E-VoteIndia Admin</p>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="login-input" placeholder="Admin ID or Email"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="login-input" placeholder="Password"></asp:TextBox>
            <asp:Button ID="btnLogin" runat="server" Text="Log in" CssClass="login-button" 
                onclick="btnLogin_Click" />
            <a href="AdminForgotPassword.aspx" style="margin-left:20px; color:White;" target=_top>Forgotten account?</a>
            <br />

                <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>

        </div>

        <div class="container">
            <h2>Find Your Account</h2>
            <p>Please enter your Admin id or email address  to search for your account.</p>
            <asp:TextBox ID="txtEmailOrID" runat="server" CssClass="input-text" 
                placeholder="Admin ID or Email address" 
                ></asp:TextBox>
            <div class="buttons">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" onclick="btnCancel_Click" />
                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                    CssClass="search-button" onclick="btnSearch_Click" />
                    <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
