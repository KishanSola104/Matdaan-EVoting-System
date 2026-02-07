using System;
using System.Web.UI;

public partial class OTP_Verification : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Check if session variables exist
            if (Session["OTP"] == null || Session["VerifiedAadharID"] == null)
            {
                Response.Redirect("UserVerification.aspx"); // Redirect if session expired
            }
        }
    }

    protected void btnVerifyOTP_Click(object sender, EventArgs e)
    {
        if (Session["OTP"] == null || Session["VerifiedAadharID"] == null)
        {
            Label1.Text = "Session expired! Please verify again.";
            Label1.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // Combine OTP from input fields
        string enteredOTP = txtBox1.Text.Trim() + txtBox2.Text.Trim() + txtBox3.Text.Trim() + txtBox4.Text.Trim();
        string sessionOTP = Session["OTP"].ToString();

        if (enteredOTP == sessionOTP)
        {
            Label1.Text = "OTP Verified Successfully!";
            Label1.ForeColor = System.Drawing.Color.Green;

            // Store Aadhar ID in session again to ensure it transfers
            string aadharID = Session["VerifiedAadharID"].ToString();
            Session["AadharID"] = aadharID; // Store Aadhar ID in session for Signup page

            // Redirect to Signup page
            Response.Redirect("Signup.aspx");
        }
        else
        {
            Label1.Text = "Invalid OTP! Please try again.";
            Label1.ForeColor = System.Drawing.Color.Red;
        }
    }
}
