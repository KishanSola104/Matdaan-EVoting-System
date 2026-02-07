<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forgot_password.aspx.cs" Inherits="forgot_password" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Your Account</title>
   <style>
    /* Body background animation excluding navbar */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(270deg, #ff9a9e, #fad0c4, #a1c4fd, #c2e9fb);
        background-size: 1000% 1000%;
        animation: backgroundChange 20s ease infinite;
    }

    /* Navbar gradient remains static */
    .navbar {
        width: 100%;
        height: 70px;
        background: linear-gradient(to right, #1877f2, #165dd1);
        color: white;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        border-bottom: 1px solid #333;
        padding: 0 20px;
        box-sizing: border-box;
        animation: navbarSlideIn 1.2s ease-out forwards;
    }

    /* Background animation keyframes */
    @keyframes backgroundChange {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    /* Navbar Slide-in animation */
    @keyframes navbarSlideIn {
        0% { opacity: 0; transform: translateY(-20px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    /* Logo text glow */
    .logo {
        color: #fff;
        text-align: left;
        margin-right: auto;
        font-size: xx-large;
        font-weight: 700;
        animation: textGlow 1.5s ease-in-out infinite alternate;
    }

    /* Text glow effect */
    @keyframes textGlow {
        from { text-shadow: 0 0 5px rgba(255, 255, 255, 0.5); }
        to { text-shadow: 0 0 15px rgba(255, 255, 255, 1); }
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
        background-color: #1877f2;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        margin-right: 10px;
        overflow: hidden;
        position: relative;
    }

    /* Ripple effect on button */
    .navbar button:active::after, .container .buttons button:active::after {
        content: "";
        display: block;
        position: absolute;
        width: 300%;
        height: 300%;
        top: 50%;
        left: 50%;
        background: rgba(255, 255, 255, 0.6);
        border-radius: 50%;
        transform: translate(-50%, -50%) scale(0);
        animation: ripple 0.6s ease-out;
    }

    /* Ripple keyframes */
    @keyframes ripple {
        from { transform: translate(-50%, -50%) scale(0); opacity: 1; }
        to { transform: translate(-50%, -50%) scale(1); opacity: 0; }
    }

    .navbar button:hover {
        background-color: #165dd1;
    }

    .navbar a {
        text-decoration: none;
        color: #fff;
        font-size: 16px;
    }

    /* Main container styling */
    .container {
        max-width: 400px;
        margin: 50px auto;
        background: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        padding: 20px;
        text-align: left;
        animation: popIn 1.5s ease forwards;
        transform-origin: center;
    }

    /* Pop-in keyframes */
    @keyframes popIn {
        0% { opacity: 0; transform: scale(0.9); }
        100% { opacity: 1; transform: scale(1); }
    }

    .container h2 {
        font-size: 24px;
        margin-bottom: 20px;
        border-bottom: 1px solid black;
    }

    .container input[type="text"] {
        width: 90%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #dddfe2;
        border-radius: 4px;
        font-size: 16px;
    }

    .container .buttons {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }

    .container .buttons button {
        height: 60px;
        width: 100px;
        background-color: #1877f2;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
    }

    .container .buttons button.cancel-btn {
        background-color: #f0f0f0;
        color: #4b4f56;
    }

    .container .buttons button:hover {
        background-color: #165dd1;
    }

    .container .buttons button.cancel-btn:hover {
        background-color: #e0e0e0;
    }

    /* Responsive design using media queries */
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
            width: 90%;
            height: 20px;
        }

        .container {
            width: 95%;
            margin: 20px auto;
        }

        .container input[type="text"] {
            width: 80%;
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
            font-size: 18px;
        }

        .container .buttons button {
            height: 50px;
            font-size: 14px;
        }
    }
</style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <p class="logo">E-VoteIndia</p>
            <asp:TextBox ID="txtEmailOrPhone" runat="server" CssClass="login-input" placeholder="Voter ID  "></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="login-input" placeholder="Password"></asp:TextBox>
            <asp:Button ID="btnLogin" runat="server" Text="Log in" CssClass="login-button" 
                onclick="btnLogin_Click" />
            <a href="forgot_password.aspx" style="margin-left:20px; color:White;" target=_top>Forgotten account?</a>
            <br />
            
          
        </div>
       <center> <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label></center>
        <div class="container">
            <h2>Find Your Account</h2>
            <p>Please enter your Voter id</p>
            <asp:TextBox ID="txtEmailOrMobile" runat="server" CssClass="input-text" 
                placeholder="Voter ID "></asp:TextBox>
            <div class="buttons">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" onclick="btnCancel_Click" />
                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                    CssClass="search-button" onclick="btnSearch_Click" />
            </div>
        </div>
    </form>
</body>
</html>