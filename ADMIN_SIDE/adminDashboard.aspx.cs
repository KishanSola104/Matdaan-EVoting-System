using System;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;



public partial class adminDashboard : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Ensure the admin is logged in
            if (Session["AdminID"] == null)
            {
                Response.Redirect("admin_login.aspx");
            }

            // Get admin name and image URL from session and display them
            string adminName = Session["AdminName"] as string ?? "Admin";
            string adminImage = Session["AdminImage"] as string ?? "default.jpg";

            AdminName.InnerText = adminName;
            ProfilePic.Src = adminImage; // Assuming 'ProfilePic' is the image ID


         
        }
    }


}
