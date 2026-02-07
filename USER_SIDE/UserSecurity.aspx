<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserSecurity.aspx.cs" Inherits="UserSecurity" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>User Security Questions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #4CAF50;
            color: white;
            padding: 10px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }
        footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
        form {
            max-width: 400px;
            margin: 80px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background: #f9f9f9;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 5px;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <header>
        E-Vote India
    </header>

    <form id="securityQuestionsForm" runat="server">
        <h2>User Security Questions</h2>
        <p>
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </p>

        <label for="birthCity">What is your Birth City Name?</label>
        <asp:TextBox ID="txtBirthCity" runat="server" MaxLength="30" placeholder="Enter your answer" />

        <label for="firstSchool">What is your First School Name?</label>
        <asp:TextBox ID="txtFirstSchool" runat="server" MaxLength="30" 
            placeholder="Enter your answer" ontextchanged="txtFirstSchool_TextChanged" />

        <label for="favTeacher">What is your Favourite Teacher Name?</label>
        <asp:TextBox ID="txtFavTeacher" runat="server" MaxLength="30" placeholder="Enter your answer" />

        <label for="favTVShow">What is your Favourite TV Show Name?</label>
        <asp:TextBox ID="txtFavTVShow" runat="server" MaxLength="30" placeholder="Enter your answer" />

    <asp:Button ID="Button1" runat="server" Text="Submit" onclick="Button1_Click" />
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </form>

    <footer>
        &copy; 2024 E-Vote India. All rights reserved.
    </footer>
</body>
</html>
