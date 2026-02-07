using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class UserElection : System.Web.UI.Page
{
    string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";
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
            LoadElectionDetails();
            LoadPartyDetails();
            LoadCandidateDetails();

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


    private void LoadElectionDetails()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT * FROM Election WHERE ElectionID = @ElectionID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ElectionID", "GUJRAT_01"); // Change as per your data

            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                lblElectionName.Text = reader["ElectionName"].ToString();
                lblState.Text = reader["StateName"].ToString();
                lblTotalVoters.Text = reader["TotalVoters"].ToString();
                lblDateOfElection.Text = Convert.ToDateTime(reader["DateOfElection"]).ToString("dd MMM yyyy");
                lblDateOfResult.Text = Convert.ToDateTime(reader["DateOfResult"]).ToString("dd MMM yyyy");
            }

            reader.Close();
        }
    }

    private void LoadPartyDetails()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT PartyName, PartyLeader, TotalCandidates FROM Party WHERE ElectionID = @ElectionID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ElectionID", "GUJRAT_01"); // Change as needed

            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvParties.DataSource = dt;
            gvParties.DataBind();
        }
    }

    private void LoadCandidateDetails()
    {
        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = "SELECT CandidateName, PartyName, Image FROM Candidates WHERE ElectionID = @ElectionID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ElectionID", "GUJRAT_01"); // Change as needed

            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptCandidates.DataSource = dt;
            rptCandidates.DataBind();
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