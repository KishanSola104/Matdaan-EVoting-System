using System;
using System.Net.Mail;

public partial class ContactUs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Text = "";
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string message = txtMessage.Text.Trim();

            string body = "Name: " + name + "<br>Email: " + email + "<br>Message: " + message;

            MailMessage mail = new MailMessage();
            mail.To.Add("admin@evoteindia.com"); // Replace with your email
            mail.From = new MailAddress(email);
            mail.Subject = "Contact Us Submission";
            mail.Body = body;
            mail.IsBodyHtml = true;

            SmtpClient smtp = new SmtpClient("smtp.yourdomain.com"); // Add your SMTP Config
            smtp.Send(mail);

            lblMessage.Text = "Your message has been sent successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            txtName.Text = "";
            txtEmail.Text = "";
            txtMessage.Text = "";
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Something went wrong! Please try again.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
}

