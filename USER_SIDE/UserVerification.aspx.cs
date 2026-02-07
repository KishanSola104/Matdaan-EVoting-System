using System;
using System.Data.SqlClient;
using System.Web.UI;

public partial class UserVerification : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GenerateCaptcha();
        }
    }

    private void GenerateCaptcha()
    {
        Random rand = new Random();
        const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        string captcha = "";
        for (int i = 0; i < 6; i++)
        {
            captcha += chars[rand.Next(chars.Length)];
        }

        lblCaptcha.Text = captcha;
        Session["Captcha"] = captcha;
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        string aadharID = txtAadharID.Text.Trim();
        string userCaptcha = txtCaptcha.Text.Trim();

        if (string.IsNullOrEmpty(aadharID) || string.IsNullOrEmpty(userCaptcha))
        {
            Label1.Text = "Please enter both Aadhar ID and CAPTCHA.";
            Label1.ForeColor = System.Drawing.Color.Red;
            Label1.Visible = true;
            return;
        }

        if (Session["Captcha"] == null || userCaptcha != Session["Captcha"].ToString())
        {
            Label1.Text = "Incorrect CAPTCHA. Please try again.";
            Label1.ForeColor = System.Drawing.Color.Red;
            Label1.Visible = true;
            GenerateCaptcha();
            return;
        }

        string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT COUNT(*) FROM Voters WHERE AadharID = @AadharID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@AadharID", aadharID);

            try
            {
                conn.Open();
                int result = (int)cmd.ExecuteScalar();

                if (result > 0)
                {
                    Label1.Text = "You Are Verified.";
                    Label1.ForeColor = System.Drawing.Color.Green;
                    Label1.Visible = true;
                    btnVerify.Visible = false;
                    Button1.Visible = true;

                    // Store Aadhar ID in session
                    Session["VerifiedAadharID"] = aadharID;
                }
                else
                {
                    Label1.Text = "Aadhar ID not found in our records.";
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Label1.Text = "Error: " + ex.Message;
                Label1.Visible = true;
            }
        }
    }

    private void GenerateOTP()
    {
        Random rand = new Random();
        int otp = rand.Next(1000, 9999); // Generate a 4-digit OTP

        // Store OTP in session
        Session["OTP"] = otp;

        // Debugging: Ensure OTP is stored
        if (Session["OTP"] == null)
        {
            Label1.Text = "OTP generation failed. Try again.";
            Label1.ForeColor = System.Drawing.Color.Red;
            Label1.Visible = true;
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["VerifiedAadharID"] == null)
        {
            Label1.Text = "Session expired! Please verify your Aadhar again.";
            Label1.ForeColor = System.Drawing.Color.Red;
            Label1.Visible = true;
            return;
        }

        // Generate OTP
        GenerateOTP();

        // **Ensure both AadharID & OTP are stored before redirection**
        if (Session["OTP"] != null && Session["VerifiedAadharID"] != null)
        {
            // lblOTP.Visible = true;
            //  lblOTP.Text = "Your OTP is: " + Session["OTP"].ToString(); // Debugging only. Remove in production.

            // Display OTP in an alert box
            string otp = Session["OTP"].ToString();
            string script1 = "alert('Your OTP is: " + otp + "');";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowOTP", script1, true);


            // Redirect after 3 seconds
            string script = "<script type='text/javascript'>setTimeout(function() { window.location.href = 'OTP_Verification.aspx'; },1000);</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script);
        }
        else
        {
            Label1.Text = "Session error. Please try again.";
            Label1.ForeColor = System.Drawing.Color.Red;
            Label1.Visible = true;
        }
    }
}




