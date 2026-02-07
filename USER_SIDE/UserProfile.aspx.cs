using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class UserProfile : System.Web.UI.Page
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


            string voterID1 = Session["VoterID"].ToString();

            // Retrieve voter information from the database
            GetVoterInformation(voterID1);
            string voterID = Session["VoterID"].ToString();
            AdminDetails voterDetails = GetVoterDetails(voterID);

            // Set voter name, fallback to "Voter" if null or empty
            lblAdminName.Text = !string.IsNullOrEmpty(voterDetails.VoterName) ? voterDetails.VoterName : "Voter";

            // Set voter image, fallback to "user.jpg" if null or empty
            imgAdminProfile.ImageUrl = !string.IsNullOrEmpty(voterDetails.ImageUrl) ? voterDetails.ImageUrl : "user.jpg";
        }
    }

    private void GetVoterInformation(string voterID)
    {
        // Connection string for the database (replace with your actual connection string)
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

        // SQL query to get the voter details based on VoterID
        string query = "SELECT VoterID, AadharID, Name, DOB, State, District, Gender, Image FROM Voters WHERE VoterID = @VoterID";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@VoterID", voterID);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                // Retrieve the voter's data from the database
                voterIDLabel.Text = reader["VoterID"].ToString();
                aadharIDLabel.Text = reader["AadharID"].ToString();
                voterNameLabel.Text = reader["Name"].ToString();
                dobLabel.Text = Convert.ToDateTime(reader["DOB"]).ToString("dd/MM/yyyy");
                stateLabel.Text = reader["State"].ToString();
                districtLabel.Text = reader["District"].ToString();
                voterGenderLabel.Text = reader["Gender"].ToString();

                // Profile image handling
                string voterImage = reader["Image"].ToString();
                VoterProfileImage.Src = !string.IsNullOrEmpty(voterImage) ? voterImage : "default.jpg";
                VoterProfileName.InnerText = voterNameLabel.Text; // Display name
            }

            reader.Close();
        }
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
