<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserVerification.aspx.cs" Inherits="UserVerification" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>User Verification</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

       /* Header Styling */
    header {
        width: 100%;
        background-color: #2ecc71; /* Bright green background */
        color: white;
        padding: 15px 30px;
        
        font-size: 18px;
    }

    header a {
        color: white;
        text-decoration: none;
        font-weight: bold;
        font-size: 16px;
        transition: color 0.3s ease;
    }

    header a:hover {
        color: #1abc9c; /* Lighter green for hover effect */
    }

    /* Content Section Styling */
    .content {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        padding: 40px;
        max-width: 500px;
        width: 100%;
        text-align: center;
            margin-left: 370px;
            margin-top:20px;
        }

    .content h2 {
        font-size: 28px;
        color: #333;
        margin-bottom: 15px;
    }

    .content p {
        font-size: 16px;
        color: #777;
        margin-bottom: 30px;
    }

    /* Form Controls (Textboxes) */
    .form-control {
        padding: 12px;
        font-size: 18px;
        width: 100%;
        max-width: 380px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 6px;
        background-color: #f9f9f9;
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    .form-control:focus {
        border-color: #2ecc71;
        background-color: #fff;
        box-shadow: 0px 0px 5px rgba(46, 204, 113, 0.3);
        outline: none;
    }

    /* Button Styling */
    #btnVerify ,  #Button1{
        padding: 12px 25px;
        background-color: #2ecc71;
        color: white;
        font-size: 20px;
        cursor: pointer;
        border: none;
        border-radius: 6px;
        width: 100%;
        max-width: 400px;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    #btnVerify:hover ,  #Button1 {
        background-color: #27ae60;
        transform: translateY(-2px); /* Hover effect with slight lift */
    }

    #btnVerify:active ,  #Button1{
        background-color: #1abc9c;
        transform: translateY(0); /* Button presses down on click */
    }

    /* Error Message Styling */
    .error-message {
        color: #e74c3c;
        font-size: 14px;
        margin-top: 10px;
        display: none;
    }

    /* CAPTCHA Section Styling */
    #captcha-image {
        font-size: 36px;
        font-weight: bold;
        color: #2ecc71;
        letter-spacing: 4px;
        background-color: #f0f0f0;
        padding: 20px;
        width: 100%;
        max-width: 250px;
        margin: 20px auto;
        text-align: center;
        border-radius: 6px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    }

    /* Footer Styling */
    footer {
        background-color: #2ecc71;
        color: white;
        padding: 12px 30px;
        text-align: center;
        font-size: 14px;
        position: absolute;
        bottom: 0;
        width: 100%;
        height:20px;
        display:flex;
        align-items:center;
        justify-content:center;
    }

    /* Responsive Design */
    @media screen and (max-width: 768px) {
        .content {
            padding: 25px;
            width: 90%;
        }

        .content h2 {
            font-size: 24px;
        }

        .content p {
            font-size: 14px;
        }

        .form-control {
            font-size: 16px;
            padding: 10px;
        }

        #btnVerify {
            font-size: 18px;
            padding: 10px 20px;
        }
    }

    </style>
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <header>
            <div>
                <a href="login.aspx"> Login</a>
 
            </div>
        </header>

        
        <!-- Content Section -->
        <div class="content">
         <!-- Error Message Label -->
           
            <h2>User Identity Verification</h2>
            <p>Please enter your Aadhar ID to verify your identity.</p>
            
            <!-- Aadhar ID TextBox -->
            &nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtAadharID" runat="server" CssClass="form-control" Placeholder="Enter Aadhar ID" />

            <!-- CAPTCHA Section: Change div to asp:Label -->
            <asp:Label ID="lblCaptcha" runat="server" CssClass="form-control" Text="Captcha will be here"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="txtCaptcha" runat="server" CssClass="form-control" Placeholder="Enter CAPTCHA" />

            <!-- Verify Identity Button -->
            <asp:Button ID="btnVerify" runat="server" Text="Verify Identity" OnClick="btnVerify_Click" CssClass="form-control"  />
            <asp:Button ID="Button1" runat="server" Text="Generate OTP"  Visible="false"  
                CssClass="form-control" onclick="Button1_Click"/>

           
            <br />
            <br />

           
            <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>
             <!-- Display OTP in Label -->
            <asp:Label ID="lblOTP" runat="server" CssClass="form-control" ForeColor="green" Visible="false"></asp:Label>
        </div>
        
        <!-- Footer Section -->
        <footer>
            <p>&copy; 2024 E-Vote India. All Rights Reserved.</p>
        </footer>
    </form>

     
</body>
</html>

