using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class adminProfile : System.Web.UI.Page
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

            // Set profile image and name
           AdminProfileName.InnerText = adminName;  // Sets the name under profile image
           AdminProfileImage.Src = adminImage; // Sets the profile image source

            // Get the admin information from the database
            GetAdminInformation(adminName);
        }
    }

    private void GetAdminInformation(string adminName)
    {
        // Connection string for the database (replace with your actual connection string)
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

        // SQL query to get the admin details based on AdminName
        string query = "SELECT AdminName, AdminGender, AdminEmail, AdminMobile FROM Admins WHERE AdminName = @AdminName";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@AdminName", adminName);

            conn.Open();

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                // Retrieve the admin's data from the database
                string name = reader["AdminName"].ToString();
                string gender = reader["AdminGender"].ToString();
                string email = reader["AdminEmail"].ToString();
                string mobile = reader["AdminMobile"].ToString();

                // Set the text of the labels with the retrieved data
                adminNameLabel.Text = name;
                adminGenderLabel.Text = gender;
                adminEmailLabel.Text = email;
                adminMobileLabel.Text = mobile;
            }

            reader.Close();
        }
    }
}
