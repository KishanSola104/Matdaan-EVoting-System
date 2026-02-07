using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminLoginVerification : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        string correctVerificationPassword = "dnica";

        if (txtVerificationPassword.Text.Trim().ToLower() == correctVerificationPassword)
        {
            Response.Redirect("~/ADMIN_SIDE/admin_login.aspx"); // Redirect to the actual login page if password matches
        }
        else
        {
            lblMessage.Text = "Incorrect verification password. Please try again.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Visible = true;
        }
    }
}