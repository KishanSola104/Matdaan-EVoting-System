<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login Page</title>
   
 
  <style>

/* Gradient Background Animation */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background: #000; /* Base background color */
    overflow: hidden;
}

/* Bubble Animation */
body::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 20%, transparent 80%);
    z-index: 0;
    overflow: hidden;
    animation: bubbleBG 25s linear infinite;
}

@keyframes bubbleBG {
    from {
        transform: translateY(100%) scale(1);
    }
    to {
        transform: translateY(-100%) scale(1.5);
    }
}



@keyframes floatUp {
    0% {
        transform: translateY(0) scale(0.8);
        opacity: 1;
    }
    100% {
        transform: translateY(-1200px) scale(1.5);
        opacity: 0;
    }
}



.container {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    width: 100%;
    max-width: 1200px;
    padding: 20px;
}


/* Left-side text animations */
.left-side {
    max-width: 600px;
    text-align: left;
    margin-right: 40px;
    color: #fff;
}

/* Heading animations */
.animated-heading {
    font-size: 48px;
    color: #fff; /* Ensures the heading text color is fully visible */
    display: inline-block;
    white-space: nowrap;
}

/* Individual character styling for heading */
.animated-heading span {
    display: inline-block;
    opacity: 0;
    transform: rotate(0deg) translateX(-50px) scale(0.5);
    animation: orbitalMotion 1.5s cubic-bezier(0.6, -0.28, 0.735, 0.045) forwards;
}

/* Paragraph styling */
.animated-paragraph {
    font-size: 20px;
    color: #fff;
    opacity: 4;
    line-height: 1.6;
    background: linear-gradient(90deg, #FF9933, #FFFFFF, #138808);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    transform: translateY(50px);
    animation: colorPulse 2.5s ease-in-out forwards, waveSlide 2s ease-out forwards 1s;
}

/* Animation keyframes */
@keyframes colorPulse {
    0%, 100% {
        background-position: 0 50%;
    }
    50% {
        background-position: 100% 50%;
    }
}

@keyframes waveSlide {
    0% {
        transform: translateY(50px);
    }
    50% {
        transform: translateY(-10px);
    }
    100% {
        transform: translateY(0);
    }
}

@keyframes orbitalMotion {
    0% {
        opacity: 0;
        transform: rotate(-90deg) translateX(50px) scale(0.5);
    }
    50% {
        opacity: 0.7;
        transform: rotate(-30deg) translateX(15px) scale(1.2);
    }
    100% {
        opacity: 1;
        transform: rotate(0deg) translateX(0) scale(1);
    }
}


/* Login Box with Glassmorphism Effect */
.login-box {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(15px);
    border-radius: 15px;
    padding: 30px;
    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.2);
    width: 100%;
    max-width: 400px;
    margin: 0 auto;
    transform: translateY(-20px);
    animation: floatEffect 3s ease-in-out infinite;
    text-align:center;
}

/* Floating effect for login box */
@keyframes floatEffect {
    0%, 100% { transform: translateY(-20px); }
    50% { transform: translateY(-10px); }
}

/* Text input fields and submit button */
.login-box input[type="text"], .login-box input[type="password"] {
    width: 85%;
    padding: 12px;
    margin: 10px 0;
    border: 1px solid rgba(255, 255, 255, 0.3);
    border-radius: 5px;
    background: rgba(255, 255, 255, 0.1);
    color: #fff;
    font-size: 14px;
    transition: all 0.4s ease;
    margin-right:10%;
}

.login-box input[type="text"]:focus, .login-box input[type="password"]:focus {
    border-color: rgba(255, 255, 255, 0.5);
    box-shadow: 0px 0px 8px rgba(24, 119, 242, 0.5);
    outline: none;
}

.login-box input[type="submit"], .create-account {
    background-color: #1877f2;
    color: white;
    padding: 12px;
    width: 100%;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    outline: none;
    transition: transform 0.2s ease;
             top: 0px;
             left: 0px;
         }

.login-box input[type="submit"]:hover, .create-account:hover {
    transform: scale(1.03);
}

.login-box input[type="submit"]:active::after, .create-account:active::after {
    content: "";
    display: block;
    position: absolute;
    width: 200%;
    height: 200%;
    top: 50%;
    left: 50%;
    background: rgba(255, 255, 255, 0.5);
    border-radius: 50%;
    transform: translate(-50%, -50%) scale(0);
    animation: rippleEffect 0.6s ease-out;
}

/* Ripple animation */
@keyframes rippleEffect {
    from { transform: translate(-50%, -50%) scale(0); opacity: 1; }
    to { transform: translate(-50%, -50%) scale(1); opacity: 0; }
}

/* Forgot password link */
.forgot-password {
    display: block;
    text-align: center;
    margin-top: 10px;
    color: #ff8a00;
    text-decoration: none;
    font-size: 14px;
    opacity: 0.9;
    transition: opacity 0.3s ease;
}

.forgot-password:hover {
    opacity: 1;
    text-decoration: underline;
}

/* Responsive design adjustments */
@media (max-width: 768px) {
    .container {
        flex-direction: column;
        padding: 20px;
    }

    .login-box {
        max-width: 350px;
    }
}

@media (max-width: 480px) {
    .login-box h2 {
        font-size: 20px;
    }

    .login-box input[type="submit"], .create-account {
        font-size: 16px;
    }

    .left-side h1 {
        font-size: 36px;
    }

    .left-side p {
        font-size: 18px;
        line-height: 1.5;
    }
}

@media (max-width: 320px) {
    .login-box {
        padding: 20px;
        max-width: 90%;
    }

    .left-side h1 {
        font-size: 28px;
    }
}

@media (max-height: 420px) {
    .login-box {
        transform: translateY(-10px);
        padding: 15px;
    }

    .login-box h2 {
        font-size: 18px;
    }
}

@media (prefers-color-scheme: dark) {
    body {
        background: linear-gradient(-45deg, #333, #555, #777, #999);
    }

    .login-box {
        background: rgba(0, 0, 0, 0.5);
    }

    .left-side h1, .left-side p, .login-box h2, .login-box input, .login-box a, .forgot-password {
        color: #eee;
    }
}


 </style>



</head>

<body>
    <form id="form1" runat="server">
        <div class="container">
           
   <div class="left-side">
    <h1 class="animated-heading">E-VoteIndia</h1>
    <p class="animated-paragraph">Unity in diversity is the true essence of India!</p>
</div>



            <!-- Login form -->
            <div class="login-box">
                <h2 style="color:#fff">Login</h2>
                <asp:TextBox ID="txtEmail" runat="server" Placeholder="Voter ID or Email address " CssClass="input-box" TextMode="SingleLine"></asp:TextBox>
                <asp:TextBox ID="txtPassword" runat="server" Placeholder="Password" CssClass="input-box" TextMode="Password"></asp:TextBox>
                <asp:Button ID="btnLogin" runat="server" Text="Log in"  CssClass="input-box" onclick="btnLogin_Click" />
                <a href="forgot_password.aspx" style="color: #ff8a00; text-decoration: none;" 
   onmouseover="this.style.color='#ff4500'; this.style.textDecoration='underline';" 
   onmouseout="this.style.color='#ff8a00'; this.style.textDecoration='none';">
   Forgot Password?
</a>
 <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label>
               
                <asp:Button ID="new_acc" runat="server" Text="Create new account" class="create-account" onclick="new_acc_Click" />
            </div>
        </div>

      
    </form>
    <script>
document.addEventListener("DOMContentLoaded", () => {
    const heading = document.querySelector(".animated-heading");
    const text = heading.textContent;
    heading.textContent = "";

    const colors = ["#FF9933", "#FFFFFF", "#138808"]; // Indian flag colors

    // Split text into individual characters and animate each
    text.split("").forEach((char, index) => {
        const span = document.createElement("span");
        span.textContent = char;
        span.style.animationDelay = `${index * 0.2}s`; // Delay each character
        span.style.color = colors[index % colors.length]; // Cycle through colors
        heading.appendChild(span);
    });

    // Optional: Ensure paragraph animation triggers on load
    const paragraph = document.querySelector(".animated-paragraph");
    paragraph.style.animationPlayState = "running";
});

</script>
</body>
</html>