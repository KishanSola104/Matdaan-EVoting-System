<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContactUs.aspx.cs" Inherits="ContactUs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
    body {
    background-color: #f5f5f5;
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}

.contact-container {
    width: 450px;
    margin: 50px auto;
    padding: 30px;
    background: #ffffff;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    text-align: center;
}

h2 {
    color: #333;
    margin-bottom: 10px;
}

p {
    font-size: 14px;
    color: #555;
    margin-bottom: 20px;
}

.input-field {
    width: 100%;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
    outline: none;
    font-size: 14px;
}

.message-box {
    height: 100px;
}

.submit-btn {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px;
    cursor: pointer;
    border-radius: 5px;
    margin-top: 10px;
    width: 100%;
    transition: 0.3s;
}

.submit-btn:hover {
    background-color: #0056b3;
}

.error-message {
    font-size: 12px;
    color: red;
    margin-bottom: 10px;
    display: block;
}

.message-label {
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 10px;
}

.back-link {
    display: inline-block;
    margin-top: 15px;
    text-decoration: none;
    color: #007bff;
    font-weight: bold;
}

.back-link:hover {
    text-decoration: underline;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="contact-container">
      <h2>E-Vote India</h2>
    <h2>Contact Us</h2>
    <p>If you have any queries or feedback, feel free to reach out to us.</p>

    <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>

    <div class="contact-form">
        <asp:TextBox ID="txtName" runat="server" CssClass="input-field" placeholder="Your Name"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtName" ErrorMessage="Name is Required" CssClass="error-message" runat="server" />

        <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" placeholder="Your Email"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtEmail" ErrorMessage="Email is Required" CssClass="error-message" runat="server" />

        <asp:TextBox ID="txtMessage" runat="server" CssClass="input-field message-box" TextMode="MultiLine" placeholder="Your Message"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtMessage" ErrorMessage="Message is Required" CssClass="error-message" runat="server" />

        <asp:Button ID="btnSubmit" runat="server" CssClass="submit-btn" Text="Send Message" OnClick="btnSubmit_Click" />
         <!-- Back Page Link -->
        <a href="javascript:history.back()" class="back-link">? Back</a>
      </div>
    </div>

    </form>
</body>

</html>
