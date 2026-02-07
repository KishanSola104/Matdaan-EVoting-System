<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserAboutUs.aspx.cs" Inherits="UserAboutUs" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
   
 
   
   <title>About Us - E-Vote India</title>
    <style>
       .about-container {
    max-width: 800px;
    margin: 40px auto;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    font-family: 'Arial', sans-serif;
    line-height: 1.6;
}

.about-container h2 {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
}

.about-container h3 {
    font-size: 20px;
    color: #444;
    margin-top: 20px;
}

.about-container p {
    font-size: 16px;
    color: #666;
    text-align: justify;
    margin-bottom: 15px;
}

.features-list {
    list-style-type: square;
    margin-left: 20px;
}

.features-list li {
    font-size: 16px;
    color: #444;
    margin-bottom: 5px;
}

/* Back Link Styling */
.back-link {
    display: inline-block;
    margin-top: 20px;
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
  <div class="about-container">
  <!-- Back Link to Previous Page -->
    <a href="javascript:history.back()" class="back-link">? Back</a>
    <h2>About E-Vote India</h2>
    <p>
        <strong>E-Vote India</strong> is a revolutionary online voting platform designed to bring <strong>transparency, security, 
        and accessibility</strong> to the election process. Our system allows registered voters to securely cast 
        their votes online in <strong>Indian State Elections</strong>.
    </p>
    
    <h3>Currently Serving Gujarat State Elections</h3>
    <p>
        We are proud to introduce our <strong>secure e-voting system</strong> in the <strong>Gujarat State Elections for MLA</strong>. 
        Our goal is to enable a <strong>safe and reliable</strong> voting process while preventing fraud and ensuring election integrity.
    </p>

    <h3>Why Choose E-Vote India?</h3>
    <ul class="features-list">
        <li>Secure and Encrypted Online Voting</li>
        <li>Accessible from Anywhere in Gujarat</li>
        <li>Verified Voter Authentication</li>
        <li>Real-time Vote Counting</li>
        <li>Fraud Prevention & Transparent Elections</li>
    </ul>
    
    <p>
        Our mission is to ensure <strong>fair elections</strong> using cutting-edge technology, making voting easier for citizens 
        while maintaining security and transparency.
    </p>

    
</div>

</body>

</html>