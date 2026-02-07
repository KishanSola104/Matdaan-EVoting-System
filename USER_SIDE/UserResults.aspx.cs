using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class UserResults : System.Web.UI.Page
{  // Class to hold voter details
    public class AdminDetails
    {
        public string VoterName { get; set; }
        public string ImageUrl { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) // Runs only on first page load
        {
            LoadResults();
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

    private void LoadResults()
    {
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

        using (SqlConnection con = new SqlConnection(connStr))
        {
            string query = @"
            SELECT 
                R.CandidateID, 
                R.CandidateName, 
                R.PartyName, 
                R.PartyID, 
                C.District,  
                COUNT(*) AS TotalVotes
            FROM Results R
            JOIN Candidates C ON R.CandidateID = C.CandidateID  
            GROUP BY R.CandidateID, R.CandidateName, R.PartyName, R.PartyID, C.District
            ORDER BY TotalVotes DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            // ? Add required columns if missing
            if (!dt.Columns.Contains("VotePercentage"))
            {
                dt.Columns.Add("VotePercentage", typeof(double));
            }
            if (!dt.Columns.Contains("PartyLogo"))
            {
                dt.Columns.Add("PartyLogo", typeof(string));
            }

            // ? Calculate total votes
            int totalVotes = dt.AsEnumerable().Sum(row => row.Field<int>("TotalVotes"));

            // ? Compute Vote Percentage & Assign Party Logo
            string winnerPartyID = dt.Rows.Count > 0 ? dt.Rows[0]["PartyID"].ToString() : "";

            foreach (DataRow row in dt.Rows)
            {
                row["VotePercentage"] = totalVotes == 0 ? 0 : (Convert.ToInt32(row["TotalVotes"]) * 100.0) / totalVotes;

                string partyID = row["PartyID"].ToString();
                string logoQuery = "SELECT PartyLogo FROM Party WHERE PartyID = @PartyID";

                using (SqlCommand logoCmd = new SqlCommand(logoQuery, con))
                {
                    logoCmd.Parameters.AddWithValue("@PartyID", partyID);
                    con.Open();
                    object logoResult = logoCmd.ExecuteScalar();
                    con.Close();

                    row["PartyLogo"] = (logoResult != DBNull.Value) ? logoResult.ToString() : "Images/default.png";
                }
            }

            // ? Check for Draw Condition
            int highestVotes = dt.AsEnumerable().Max(row => row.Field<int>("TotalVotes"));
            var topParties = dt.AsEnumerable().Where(row => row.Field<int>("TotalVotes") == highestVotes).ToList();

            // ? Display Winner or Draw
            if (topParties.Count > 1)
            {
                winnerSection.Visible = true;
                winnerLogo.Src = "draw.png"; // Use a "Draw" image
                winnerName.InnerText = "Election Draw Between: " + string.Join(", ", topParties.Select(row => row["PartyName"].ToString()));
            }
            else if (topParties.Count == 1)
            {
                DataRow winnerRow = topParties[0];

                // ? Assign Special Logo for the Winner Party
                string selectedWinnerPartyID = winnerRow["PartyID"].ToString();
                string winnerLogoPath = winnerRow["PartyLogo"].ToString(); // Default logo

                switch (selectedWinnerPartyID)
                {
                    case "GUJ_P1":
                        winnerLogoPath = "KishanPartyLogo.jpeg";
                        break;
                    case "GUJ_P2":
                        winnerLogoPath = "ManavPartyLogo.jpeg";
                        break;
                    case "GUJ_P3":
                        winnerLogoPath = "KeyurPartyLogo.jpeg";
                        break;
                }

                winnerSection.Visible = true;
                winnerLogo.Src = winnerLogoPath;
                winnerName.InnerText = "Winner: " + winnerRow["PartyName"].ToString();

            }

        }
    }




    // Helper Function for Progress Bar Colors
    protected string GetProgressColor(int percentage)
    {
        if (percentage >= 70) return "#28a745"; // Green for High Votes
        if (percentage >= 40) return "#ffc107"; // Yellow for Moderate Votes
        return "#dc3545"; // Red for Low Votes
    }
}