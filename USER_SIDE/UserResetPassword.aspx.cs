using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;

public partial class UserResetPassword : System.Web.UI.Page
{


    // Class to hold voter details
    public class AdminDetails
    {
        public string VoterName { get; set; }
        public string ImageUrl { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) // Runs only on first page load
        {
            // Validate session
            if (Session["VoterID"] == null || string.IsNullOrEmpty(Session["VoterID"].ToString()))
            {
                Response.Redirect("login.aspx"); // Redirect to login page if session is missing
                return;
            }

            string voterID = Session["VoterID"].ToString();
            AdminDetails voterDetails = GetVoterDetails(voterID);

            // Set voter name, fallback to "Voter" if null or empty
            lblAdminName.Text = !string.IsNullOrEmpty(voterDetails.VoterName) ? voterDetails.VoterName : "Voter";

            // Set voter image, fallback to "user.jpg" if null or empty
            imgAdminProfile.ImageUrl = !string.IsNullOrEmpty(voterDetails.ImageUrl) ? voterDetails.ImageUrl : "user.jpg";
        }
    }

    protected void btnResetPassword_Click(object sender, EventArgs e)
    {
        string voterID = Session["VoterID"].ToString();
        string currentPassword = txtCurrentPassword.Text;
        string newPassword = txtNewPassword.Text;
        string confirmPassword = txtConfirmPassword.Text;

        if (newPassword != confirmPassword)
        {
            lblMessage.Text = "New password and confirm password do not match!";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // Check if current password is correct
            string checkPasswordQuery = "SELECT COUNT(*) FROM Voters WHERE VoterID = @VoterID AND Password = @CurrentPassword";
            using (SqlCommand cmd = new SqlCommand(checkPasswordQuery, conn))
            {
                cmd.Parameters.AddWithValue("@VoterID", voterID);
                cmd.Parameters.AddWithValue("@CurrentPassword", currentPassword);

                int count = Convert.ToInt32(cmd.ExecuteScalar());
                if (count == 0)
                {
                    lblMessage.Text = "Current password is incorrect!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }

            // Update the password
            string updatePasswordQuery = "UPDATE Voters SET Password = @NewPassword WHERE VoterID = @VoterID";
            using (SqlCommand cmd = new SqlCommand(updatePasswordQuery, conn))
            {
                cmd.Parameters.AddWithValue("@VoterID", voterID);
                cmd.Parameters.AddWithValue("@NewPassword", newPassword);

                cmd.ExecuteNonQuery();
            }
        }

        lblMessage.Text = "Password reset successfully!";
        lblMessage.ForeColor = System.Drawing.Color.Green;
    }

    // Retrieves voter details from the database
    private AdminDetails GetVoterDetails(string voterID)
    {
        AdminDetails adminDetails = new AdminDetails
        {
            VoterName = "Voter", // Default name
            ImageUrl = "" // Default empty image URL
        };

        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Name, Image FROM Voters WHERE VoterID = @VoterID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@VoterID", voterID);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            adminDetails.VoterName = reader["Name"] != DBNull.Value ? reader["Name"].ToString() : "Voter";
                            adminDetails.ImageUrl = reader["Image"] != DBNull.Value ? reader["Image"].ToString() : "";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Log error for debugging
            System.Diagnostics.Debug.WriteLine("Database Error: " + ex.Message);
        }

        return adminDetails;
    }

    // Logout button click event
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("login.aspx"); // Redirect to login page
    }

}