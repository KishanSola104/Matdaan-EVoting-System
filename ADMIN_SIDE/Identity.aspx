<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Identity.aspx.cs" Inherits="Identity" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

     <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #111;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        form {
            background-color: #333;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 255, 255, 0.2);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }
        form h2 {
            color: #00FFFF;
            margin-bottom: 20px;
        }
        form input,
        form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #555;
            border-radius: 5px;
            background-color: #222;
            color: #fff;
        }
        form input:focus,
        form select:focus {
            border-color: #00FFFF;
            outline: none;
        }
        form input[type="submit"] {
            background-color: #00FFFF;
            color: #222;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        form input[type="submit"]:hover {
            background-color: #00e5e5;
        }
        label {
            display: block;
            text-align: left;
            font-size: 0.9em;
            margin-bottom: 5px;
            color: #ccc;
        }
    </style>
</head>
<body>
  <form id="Form1" runat="server">
   

    
        <h2>Insert Identity Data<asp:Label ID="lblMessage" runat="server"></asp:Label>
        </h2>

        <!-- Aadhar ID -->
        <label for="txtAadharID">Aadhar ID:</label>
        <asp:TextBox ID="txtAadharID" runat="server" placeholder="Enter User's Aadhar ID"></asp:TextBox>

        <!-- User's Name -->
        <label for="txtName">Name:</label>
        <asp:TextBox ID="txtName" runat="server" placeholder="Enter User's Name"></asp:TextBox>

        <!-- Date of Birth -->
        <label for="txtUserBirthdate">Date of Birth:</label>
        <input type="date" id="txtUserBirthdate" name="txtUserBirthdate" placeholder="YYYY-MM-DD" />

        <!-- Gender -->
        <label for="ddlAdminGender">Gender:</label>
        <asp:DropDownList ID="ddlAdminGender" runat="server">
            <asp:ListItem Text="Select Gender" Value="" />
            <asp:ListItem Text="Male" Value="Male" />
            <asp:ListItem Text="Female" Value="Female" />
            <asp:ListItem Text="Other" Value="Other" />
        </asp:DropDownList>

           <!-- State -->
            <div class="form-field">
                <label>State:</label>
                <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged"></asp:DropDownList>
            </div>

            <!-- District -->
            <div class="form-field">
                <label>District:</label>
                <asp:DropDownList ID="ddlDistrict" runat="server"></asp:DropDownList>
            </div>


        <!-- Submit Button -->
        <asp:Button ID="btnInsertAdmin" runat="server" Text="Insert Data" 
            onclick="btnInsertAdmin_Click" />
  
</form>

</body>
</html>
