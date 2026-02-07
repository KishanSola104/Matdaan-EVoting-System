<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin_login.aspx.cs" Inherits="admin_login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login Page</title>
    <style>
        /* Dark pulsating background */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: radial-gradient(circle at center, #111111, #000000 80%);
            background-size: 200% 200%;
            animation: pulseBG 10s infinite;
            overflow: hidden;
        }

        /* Background pulsing animation */
        @keyframes pulseBG {
            0%, 100% { background-size: 200% 200%; }
            50% { background-size: 220% 220%; }
        }

        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 100%;
            max-width: 1200px;
        }

        .left-side {
            text-align: center;
            margin-bottom: 20px;
        }

        .left-side h1 {
            color: #cfcfcf;
            font-size: 42px;
            opacity: 0;
            transform: translateY(-30px);
            animation: fadeSlideIn 1s forwards;
            animation-delay: 0.2s;
        }

        .left-side p {
            font-size: 18px;
            color: #aaaaaa;
            opacity: 0;
            transform: translateY(20px);
            animation: fadeSlideIn 1s forwards;
            animation-delay: 0.4s;
        }

        @keyframes fadeSlideIn {
            to { opacity: 1; transform: translateY(0); }
        }

        /* Neon effect for login box */
        .login-box {
            background: rgba(24, 24, 24, 0.9);
            border-radius: 12px;
            padding: 30px;
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
            box-shadow: 0px 0px 15px rgba(0, 255, 255, 0.6);
            border: 1px solid rgba(0, 255, 255, 0.5);
            transform: translateY(-20px);
            animation: floatEffect 3s ease-in-out infinite;
        }

        /* Float animation for login box */
        @keyframes floatEffect {
            0%, 100% { transform: translateY(-20px); }
            50% { transform: translateY(-10px); }
        }

        .login-box h2 {
            color: #00ffff;
            font-size: 26px;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Input fields with glowing border on focus */
        .login-box input[type="text"], .login-box input[type="password"] {
            width: 85%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #555555;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            font-size: 14px;
            transition: all 0.4s ease;
        }

        .login-box input[type="text"]:focus, .login-box input[type="password"]:focus {
            border-color: #00ffff;
            box-shadow: 0px 0px 8px rgba(0, 255, 255, 0.8);
            outline: none;
        }

        /* Button styling */
        .login-box input[type="submit"], .create-account {
            border: none;
            background-color: #00ffff;
            color: white;
            padding: 12px;
            width: 100%;
            
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            outline: none;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .login-box input[type="submit"]:hover, .create-account:hover {
            background-color: #00e5e5;
            transform: scale(1.02);
        }

        /* Subtle ripple effect on button click */
        .login-box input[type="submit"]:active::after, .create-account:active::after {
            content: "";
            display: block;
            position: absolute;
            width: 200%;
            height: 200%;
            top: 50%;
            left: 50%;
            background: rgba(255, 255, 255, 0.4);
            border-radius: 50%;
            transform: translate(-50%, -50%) scale(0);
            animation: rippleEffect 0.6s ease-out;
        }

        /* Ripple animation */
        @keyframes rippleEffect {
            from { transform: translate(-50%, -50%) scale(0); opacity: 1; }
            to { transform: translate(-50%, -50%) scale(1); opacity: 0; }
        }

        /* Link style */
        .login-box a {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #bbbbbb;
            text-decoration: none;
            font-size: 14px;
            opacity: 0.9;
            transition: opacity 0.3s ease;
        }

        .login-box a:hover {
            opacity: 1;
            text-decoration: underline;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }

            .login-box {
                width: 100%;
                max-width: 350px;
            }
        }

        @media (max-width: 480px) {
            .login-box h2 {
                font-size: 20px;
            }

            .login-box input[type="submit"], .create-account {
                font-size: 14px;
                padding: 8px;
            }

            .left-side h1 {
                font-size: 36px;
            }

            .left-side p {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Left side for large screens (like Facebook layout) -->
            <div class="left-side">
                <h1>E-VoteIndia</h1>
                <p>E-VoteIndia helps you Vote from your comfort place.</p>
            </div>

            <!-- Login form -->
            <div class="login-box">
                <h2>Admin Login</h2>
                <asp:TextBox ID="txtEmail" runat="server" Placeholder="Admin ID or Email address " CssClass="input-box" TextMode="SingleLine"></asp:TextBox>
                <asp:TextBox ID="txtPassword" runat="server" Placeholder="Password" CssClass="input-box" TextMode="Password"></asp:TextBox>
                <asp:Button ID="btnLogin" runat="server" Text="Log in" CssClass="input-box" onclick="btnLogin_Click" />
                <a href="AdminForgotPassword.aspx">Forgotten password?</a>

                <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
