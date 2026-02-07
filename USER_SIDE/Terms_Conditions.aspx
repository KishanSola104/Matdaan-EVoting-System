<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Terms_Conditions.aspx.cs" Inherits="Terms_Conditions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Terms and Conditions | Online Election Voting</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #212529;
        }

        header {
            background-color: #004085;
            color: white;
            padding: 20px 10px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            border-bottom: 5px solid #ffc107;
        }

        .content-container {
            max-width: 900px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        h1 {
            color: #004085;
            font-size: 28px;
            margin-bottom: 15px;
            border-bottom: 2px solid #ffc107;
            padding-bottom: 5px;
        }

        p, li {
            line-height: 1.6;
            font-size: 16px;
            margin-bottom: 15px;
        }

        ul {
            margin-left: 20px;
        }

        footer {
            background-color: #004085;
            color: white;
            text-align: center;
            padding: 10px 5px;
            font-size: 14px;
            border-top: 5px solid #ffc107;
            position: relative;
        }

        @media (max-width: 768px) {
            .content-container {
                padding: 15px;
            }

            header {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <header>
            Online Election Voting System - Terms and Conditions
        </header>

        <!-- Content Container -->
        <div class="content-container">
            <h1>Terms and Conditions</h1>
            <p>
                Welcome to the Online Election Voting System for Indian States. By accessing and using this website, you
                agree to abide by the following terms and conditions. Please read them carefully before proceeding.
            </p>

            <h2>1. General Terms</h2>
            <ul>
                <li>The Online Election Voting System is designed to facilitate secure and efficient voting for eligible citizens.</li>
                <li>Users must ensure their personal details are accurate and up-to-date for authentication purposes.</li>
                <li>The website is governed by the laws of India, and all disputes will be handled under Indian jurisdiction.</li>
            </ul>

            <h2>2. Eligibility</h2>
            <ul>
                <li>Only registered voters with valid identification are allowed to use the system.</li>
                <li>Impersonation or unauthorized access to another user’s account is strictly prohibited and may lead to legal action.</li>
            </ul>

            <h2>3. User Responsibilities</h2>
            <ul>
                <li>Users must keep their login credentials confidential to prevent unauthorized access.</li>
                <li>Any misuse of the system to manipulate election results will result in strict penalties, including legal action.</li>
                <li>It is the user’s responsibility to ensure they have stable internet connectivity during the voting process.</li>
            </ul>

            <h2>4. Privacy and Security</h2>
            <p>
                We take the privacy and security of your data seriously. Personal information collected through this system
                will only be used for verification and authentication purposes during the election process. Data will be handled in accordance
                with applicable data protection laws.
            </p>

            <h2>5. System Downtime</h2>
            <p>
                While we strive to ensure the system is available at all times, unforeseen technical issues may result in temporary downtime.
                We appreciate your patience during such situations.
            </p>

            <h2>6. Termination of Access</h2>
            <p>
                Any breach of these terms and conditions may result in the immediate termination of access to the system.
            </p>

            <h2>7. Changes to Terms</h2>
            <p>
                The terms and conditions may be updated from time to time to reflect changes in policy or legislation.
                Continued use of the system implies acceptance of these changes.
            </p>
      
      <h2>8. Contact Us</h2>
            <p>
         For any queries or concerns, please contact the Election Commission at 
         <a href="mailto:kirit4434@gmail.com" 
             style="color: #004085; text-decoration: underline; font-weight: bold; font-size: 18px;">
             kirit4434@gmail.com
             </a>.
        </p>


        </div>

        <!-- Footer -->
        <footer>
            © 2024-25 Online Election Voting System - Indian States | All Rights Reserved
        </footer>
    </form>
</body>
</html>
