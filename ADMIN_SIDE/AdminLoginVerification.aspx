<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminLoginVerification.aspx.cs" Inherits="AdminLoginVerification" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Admin Verification - E-VoteIndia</title>
   <style>
    /* Background Animation */
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(-45deg, #ff5c8e, #4e86fa, #00c3a2, #ffec61);
        background-size: 400% 400%;
        animation: gradientAnimation 10s ease infinite;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        color: #fff;
    }

    /* Container Styling */
    .container {
        background: rgba(0, 0, 0, 0.75);
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
        max-width: 450px;
        width: 90%;
        text-align: center;
        animation: fadeIn 1.5s ease-out;
    }

    /* Title Animation */
    h1 {
        font-size: 36px;
        color: #ffec61;
        margin-bottom: 20px;
        text-transform: uppercase;
        animation: fadeInFromTop 1s ease-in-out;
    }

    /* Instructions Label */
    #lblInstructions {
        font-size: 18px;
        margin-bottom: 20px;
        color: #cfcfcf;
        animation: fadeIn 1.5s ease-in-out;
    }

    /* Input Field Styling */
    .input-box {
        width: 80%;
        padding: 12px;
        margin: 15px 0;
        border-radius: 8px;
        background: rgba(255, 255, 255, 0.2);
        border: 1px solid rgba(255, 255, 255, 0.3);
        color: white;
        font-size: 16px;
        text-align: center;
        transition: box-shadow 0.3s ease, border-color 0.3s ease;
        animation: fadeIn 1.5s ease-in-out;
    }

    .input-box:focus {
        outline: none;
        box-shadow: 0 0 10px rgba(255, 236, 97, 0.7);
        border-color: #ffec61;
    }

    /* Button Styling */
    .btn-send-link {
        background-color: #ff5c8e;
        color: white;
        padding: 12px;
        width: 60%;
        border-radius: 8px;
        font-size: 18px;
        cursor: pointer;
        border: none;
        transition: background-color 0.3s ease, transform 0.2s ease;
        animation: fadeIn 1.5s ease-in-out;
    }

    .btn-send-link:hover {
        background-color: #ffec61;
        color: #000;
        transform: scale(1.05);
    }

    .btn-send-link:active {
        background-color: #ff5c8e;
    }

    /* Message Label */
    #lblMessage {
        margin-top: 20px;
        font-size: 16px;
        color: #ffec61;
        animation: fadeIn 2s ease-in-out;
    }

    /* Animations */
    @keyframes gradientAnimation {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    @keyframes fadeInFromTop {
        0% { opacity: 0; transform: translateY(-20px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    @keyframes fadeIn {
        0% { opacity: 0; transform: scale(0.9); }
        100% { opacity: 1; transform: scale(1); }
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        h1 {
            font-size: 28px;
        }

        #lblInstructions, .input-box {
            font-size: 16px;
        }

        .btn-send-link {
            width: 70%;
            font-size: 16px;
        }
    }

    @media (max-width: 480px) {
        h1 {
            font-size: 24px;
        }

        .container {
            padding: 20px;
        }

        .input-box {
            width: 90%;
        }

        .btn-send-link {
            width: 80%;
            padding: 10px;
        }
    }

    @media (max-height: 420px) {
        .container {
            padding: 20px;
            transform: scale(0.95);
        }

        h1 {
            font-size: 24px;
        }

        #lblInstructions, .btn-send-link {
            font-size: 14px;
        }
    }
</style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Admin Verification</h1>
            <asp:Label ID="lblInstructions" runat="server" Text="Please enter your personal verification password to continue."></asp:Label>
            
            <asp:TextBox ID="txtVerificationPassword" runat="server" CssClass="input-box" TextMode="Password" Placeholder="Verification Password"></asp:TextBox>
            <asp:Button ID="btnVerify" runat="server" Text="Verify" CssClass="btn-send-link" OnClick="btnVerify_Click" />
            
            <asp:Label ID="lblMessage" runat="server" ForeColor="Yellow" Font-Bold="True" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
