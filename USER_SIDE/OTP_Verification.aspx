<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OTP_Verification.aspx.cs" Inherits="OTP_Verification" %>

<!DOCTYPE html>
<html>
<head>
    <title>OTP Verification</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
        }

        h2 {
            margin-bottom: 20px;
        }

        .otp-boxes {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .otp-box {
            width: 50px;
            height: 50px;
            font-size: 20px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .otp-box:focus {
            border-color: #4CAF50;
            outline: none;
        }

        .btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
            font-size: 16px;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .timer {
            margin-top: 10px;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>OTP Verification</h2>
            <p>
                <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
            </p>
            <p>Please enter the OTP sent to your registered number.</p>

            <div class="otp-boxes">
                <asp:TextBox ID="txtBox1" runat="server" MaxLength="1" CssClass="otp-box" oninput="moveToNextBox(this, 'txtBox2')" />
                <asp:TextBox ID="txtBox2" runat="server" MaxLength="1" CssClass="otp-box" oninput="moveToNextBox(this, 'txtBox3')" />
                <asp:TextBox ID="txtBox3" runat="server" MaxLength="1" CssClass="otp-box" oninput="moveToNextBox(this, 'txtBox4')" />
                <asp:TextBox ID="txtBox4" runat="server" MaxLength="1" CssClass="otp-box" oninput="moveToNextBox(this, null)" />
            </div>

            <asp:Button ID="btnVerifyOTP" runat="server" Text="Verify OTP" OnClick="btnVerifyOTP_Click" CssClass="btn" />

            <div class="timer" id="timer">15 seconds remaining</div>
        </div>
    </form>

    <script>
        let countdown = 15;
        const timerElement = document.getElementById('timer');

        const timer = setInterval(() => {
            countdown--;
            timerElement.textContent = countdown + " seconds remaining";
            if (countdown === 0) {
                clearInterval(timer);
                window.location.href = 'UserVerification.aspx';
            }
        }, 1000);

        function moveToNextBox(currentBox, nextBoxId) {
            if (currentBox.value.length === currentBox.maxLength) {
                if (nextBoxId) {
                    document.getElementById(nextBoxId).focus();
                }
            }
        }
    </script>
</body>
</html>
