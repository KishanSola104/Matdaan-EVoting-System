using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class UserSecurity : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(@"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True");
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check if the session contains the VoterID
        if (Session["VoterID"] != null)
        {
            // Retrieve the VoterID from the session
            string voterID = Session["VoterID"].ToString();

            // Set the Label text to display the Voter ID
            Label1.Text = "Your Voter ID is: " + voterID;
        }
        else
        {
            // Handle the case where the Voter ID is not found in session
            Label1.Text = "Voter ID not found. Please log in again.";
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            // Get the VoterID from the session
            string voterID = Session["VoterID"] as string;

            // Check if the VoterID exists in the session
            if (string.IsNullOrEmpty(voterID))
            {
                lblMessage.Text = "Voter ID not found. Please log in first.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Get the values entered in the form fields
            string birthCity = txtBirthCity.Text.Trim();
            string firstSchool = txtFirstSchool.Text.Trim();
            string favTeacher = txtFavTeacher.Text.Trim();
            string favTVShow = txtFavTVShow.Text.Trim();

            // Database connection string (update this with your connection string)
            string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

            // SQL query to insert data into the UserSecurity table
            string query = "INSERT INTO UserSecurity (VoterID, BirthCity, FirstSchool, FavTeacher, FavTVShow) " +
                           "VALUES (@VoterID, @BirthCity, @FirstSchool, @FavTeacher, @FavTVShow)";

            // Create and configure the SqlCommand
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add parameters to avoid SQL injection
                    cmd.Parameters.AddWithValue("@VoterID", voterID);
                    cmd.Parameters.AddWithValue("@BirthCity", birthCity);
                    cmd.Parameters.AddWithValue("@FirstSchool", firstSchool);
                    cmd.Parameters.AddWithValue("@FavTeacher", favTeacher);
                    cmd.Parameters.AddWithValue("@FavTVShow", favTVShow);

                    // Open the connection and execute the command
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    // Check if the record was inserted successfully
                    if (rowsAffected > 0)
                    {
                        // Store VoterID in Session
                        Session["VoterID"] = voterID;

                        // Show success message
                        lblMessage.Text = "Data inserted successfully! Redirecting to login page.";
                        lblMessage.ForeColor = System.Drawing.Color.Green;

                        // Redirect to login page after a short delay
                        Response.Redirect("login.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Data insertion failed. Please try again.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
        catch (SqlException sqlEx)
        {
            // Handle SQL exceptions (e.g., connection issues, SQL syntax errors)
            lblMessage.Text = "A database error occurred: " + sqlEx.Message;
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
        catch (Exception ex)
        {
            // Handle general exceptions
            lblMessage.Text = "An error occurred: " + ex.Message;
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
       
    }
    protected void txtFirstSchool_TextChanged(object sender, EventArgs e)
    {

    }
}