using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
public partial class CastVote : System.Web.UI.Page
{
    private string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";
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

            string voterID1 = Session["VoterID"].ToString();
            LoadCandidates(voterID);
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

    private void LoadCandidates(string voterID)
    {
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

        string query = @"
            SELECT c.CandidateID, c.CandidateName, p.PartyName, 
                   ISNULL(c.Image, 'Images/default.png') AS Image,
                   ISNULL(p.PartyLogo, 'Images/default-logo.png') AS PartyLogo
            FROM Candidates c
            INNER JOIN Party p ON c.PartyID = p.PartyID
            WHERE c.District = (SELECT District FROM Voters WHERE VoterID = @VoterID);
        ";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@VoterID", voterID);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptCandidates.DataSource = dt;
                rptCandidates.DataBind();
            }
        }

        // Disable vote buttons if the voter has already voted
        if (HasAlreadyVoted(voterID))
        {
            foreach (RepeaterItem item in rptCandidates.Items)
            {
                Button btnVote = (Button)item.FindControl("btnVote");
                if (btnVote != null)
                {
                    btnVote.Enabled = false;
                    btnVote.Text = "Vote Submitted";
                    btnVote.CssClass = "btn btn-secondary mt-2";
                }
            }
        }
    }

    protected void SubmitVote(object sender, EventArgs e)
    {
        string voterID = Session["VoterID"].ToString();
        string candidateID = ((Button)sender).CommandArgument;

        if (HasAlreadyVoted(voterID))
        {
            Response.Write("<script>alert('You have already voted!');</script>");
            return;
        }

        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";
        string query = @"
            INSERT INTO Results (VoterID, CandidateID, PartyID, PartyName, CandidateName, District, Timestamp)
            SELECT @VoterID, c.CandidateID, c.PartyID, p.PartyName, c.CandidateName, c.District, GETDATE()
            FROM Candidates c
            INNER JOIN Party p ON c.PartyID = p.PartyID
            WHERE c.CandidateID = @CandidateID;
        ";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@VoterID", voterID);
                cmd.Parameters.AddWithValue("@CandidateID", candidateID);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // Disable voting buttons after voting
        foreach (RepeaterItem item in rptCandidates.Items)
        {
            Button btnVote = (Button)item.FindControl("btnVote");
            if (btnVote != null)
            {
                btnVote.Enabled = false;
                btnVote.Text = "Vote Submitted";
                btnVote.CssClass = "btn btn-secondary mt-2";
            }
        }

        Response.Write("<script>alert('Vote successfully submitted!');</script>");
    }

    private bool HasAlreadyVoted(string voterID)
    {
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";
        string query = "SELECT COUNT(*) FROM Results WHERE VoterID = @VoterID;";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@VoterID", voterID);
                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                return count > 0;
            }
        }
    }
   
    }

