<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminForgotPassLoginPage.aspx.cs" Inherits="AdminForgotPassLoginPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Log in to E-VoteIndia</title>
    <style>
        /* Exact styles applied based on the image provided */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            overflow: hidden; /* Prevent scroll during loading */
            animation: fadeIn 1s ease forwards; /* Fade in effect for the body */
            background-color: #f0f2f5;
            background: linear-gradient(45deg, #f0f2f5, #e7eff6, #d7e7f2, #c7dff7);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite; /* Background gradient animation */
        }

        /* Body fade-in animation */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Background gradient animation */
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
            animation: slideIn 1s ease forwards; /* Slide-in effect for the page */
        }

        /* Page slide-in animation */
        @keyframes slideIn {
            from { transform: translateY(100px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .login-box {
            background-color: white;
            padding: 20px;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            border-radius: 10px;
            animation: popIn 0.5s ease forwards; /* Pop-in effect for the login box */
            background: linear-gradient(45deg, #ffffff, #e7f3ff);
            background-size: 200% 200%;
            animation: boxGradient 10s ease infinite; /* Login box gradient animation */
        }

        /* Pop-in animation for the login box */
        @keyframes popIn {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }

        /* Login box gradient animation */
        @keyframes boxGradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .login-box h1 {
            text-align: center;
            font-size: 32px;
            color: #1877f2;
            margin-bottom: 20px;
            animation: bounce 1s infinite alternate; /* Bounce effect for the header */
        }

        /* Bounce animation for the header */
        @keyframes bounce {
            from { transform: translateY(0); }
            to { transform: translateY(-10px); }
        }

        .login-box input {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 1px solid #dddfe2;
            border-radius: 5px;
            transition: all 0.3s ease; /* Smooth transition for input fields */
        }

        .login-box input:hover {
            border-color: #1877f2; /* Change border color on hover */
            box-shadow: 0 0 5px rgba(24, 119, 242, 0.5); /* Add shadow effect on hover */
        }

        .login-box input[type="submit"] {
            background-color: #1877f2;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease; /* Smooth transition for button */
            animation: pulse 1s infinite alternate; /* Pulse effect for submit button */
        }

        /* Pulse animation for the submit button */
        @keyframes pulse {
            0% { transform: scale(1); }
            100% { transform: scale(1.05); }
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
            transition: color 0.3s ease; /* Smooth transition for forgot link */
        }

        .forgot-link a:hover {
            color: #155dbb; /* Change color on hover */
        }

        .separator {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 15px 0;
        }

        .separator::before,
        .separator::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #dadde1;
        }

        .separator:not(:empty)::before {
            margin-right: 10px;
        }

        .separator:not(:empty)::after {
            margin-left: 10px;
        }

        .create-account {
            display: block;
            width: 90%;
            padding: 12px;
            margin-top: 15px;
            text-align: center;
            background-color: #42b72a;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease; /* Smooth transition for create account link */
            animation: slideUp 1s forwards; /* Slide-up effect for create account link */
        }

        /* Slide-up animation for the create account link */
        @keyframes slideUp {
            from { transform: translateY(10px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .create-account:hover {
            background-color: #36a420;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .login-box {
                width: 90%; /* Adjust the width for tablets and small screens */
            }
            .login-box h1 {
                font-size: 28px; /* Reduce font size for the Facebook logo */
            }
            .login-box input {
                padding: 10px;
            }
            .login-box input[type="submit"] {
                padding: 10px;
            }
            .create-account {
                padding: 10px;
            }
        }

        @media (max-width: 480px) {
            .login-box {
                width: 100%; /* Full width on small mobile screens */
                padding: 15px;
            }
            .login-box h1 {
                font-size: 24px; /* Further reduce font size for mobile */
            }
            .login-box input {
                padding: 8px;
                font-size: 14px; /* Adjust input font size */
            }
            .login-box input[type="submit"] {
                padding: 8px;
                font-size: 14px;
            }
            .create-account {
                padding: 8px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-page">
            <div class="login-box">
                <h1>E-VoteIndia Admin</h1>
             <asp:TextBox ID="txtEmail" runat="server" Placeholder="Admin ID or Email address" CssClass="input-box" TextMode="SingleLine"></asp:TextBox>
                <asp:TextBox ID="txtPassword" runat="server" Placeholder="Password" CssClass="input-box" TextMode="Password"></asp:TextBox>
                <asp:Button ID="btnLogin" runat="server" Text="Log in" CssClass="input-box" onclick="btnLogin_Click" />

                  <a href="AdminForgotPassword.aspx">Forgotten password?</a>

                <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
   
               
            </div>
        </div>
    </form>
</body>
</html>
