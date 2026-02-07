<%@ WebHandler Language="C#" Class="SavePartyDataHandler" %>

using System;
using System.Data.SqlClient;
using System.Web;

public class SavePartyDataHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            if (context.Session["SelectedElectionID"] == null)
            {
                context.Response.ContentType = "text/plain";
                context.Response.Write("Error: Election ID session data missing.");
                return;
            }

            string electionId = context.Session["SelectedElectionID"].ToString();
            string partyId = context.Request.Form["PartyID"];
            string partyName = context.Request.Form["PartyName"];
            string partyLeader = context.Request.Form["PartyLeader"];
            string partySlogan = context.Request.Form["PartySlogan"];
            string establishedYear = context.Request.Form["EstablishedYear"];
            string totalCandidatesStr = context.Request.Form["TotalCandidates"];
            HttpPostedFile partyLogo = context.Request.Files["PartyLogo"];
            HttpPostedFile leaderPicture = context.Request.Files["LeaderPicture"];

            if (string.IsNullOrEmpty(partyId) || string.IsNullOrEmpty(partyName) ||
                string.IsNullOrEmpty(partyLeader) || string.IsNullOrEmpty(partySlogan) ||
                string.IsNullOrEmpty(establishedYear) || string.IsNullOrEmpty(totalCandidatesStr) || 
                partyLogo == null || leaderPicture == null)
            {
                context.Response.ContentType = "text/plain";
                context.Response.Write("Error: Missing required form data.");
                return;
            }

           int totalCandidates;
        if (!int.TryParse(totalCandidatesStr, out totalCandidates))
        {
                context.Response.ContentType = "text/plain";
                context.Response.Write("Error: Invalid TotalCandidates value.");
                return;
            }

        string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check total allowed parties for this election
                int totalPartiesAllowed = 0;
                string checkTotalQuery = "SELECT TotalParties FROM Election WHERE ElectionID = @ElectionID";
                using (SqlCommand checkTotalCommand = new SqlCommand(checkTotalQuery, connection))
                {
                    checkTotalCommand.Parameters.AddWithValue("@ElectionID", electionId);
                    object result = checkTotalCommand.ExecuteScalar();
                    if (result != null)
                    {
                        totalPartiesAllowed = Convert.ToInt32(result);
                    }
                    else
                    {
                        context.Response.ContentType = "text/plain";
                        context.Response.Write("Error: Invalid Election ID.");
                        return;
                    }
                }

                // Count current parties for this election
                int currentPartyCount = 0;
                string countQuery = "SELECT COUNT(*) FROM Party WHERE ElectionID = @ElectionID";
                using (SqlCommand countCommand = new SqlCommand(countQuery, connection))
                {
                    countCommand.Parameters.AddWithValue("@ElectionID", electionId);
                    currentPartyCount = Convert.ToInt32(countCommand.ExecuteScalar());
                }

                // Check if the limit is reached
                if (currentPartyCount >= totalPartiesAllowed)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("Error: Party limit reached for this election.");
                    return;
                }

                // Save the uploaded files to the server
                string partyLogoFileName = System.IO.Path.GetFileName(partyLogo.FileName);
                string partyLogoPath = context.Server.MapPath("~/Uploads/" + partyLogoFileName);
                partyLogo.SaveAs(partyLogoPath);

                string leaderPictureFileName = System.IO.Path.GetFileName(leaderPicture.FileName);
                string leaderPicturePath = context.Server.MapPath("~/Uploads/" + leaderPictureFileName);
                leaderPicture.SaveAs(leaderPicturePath);

                // Insert new party data including TotalCandidates
                string insertQuery = @"
                    INSERT INTO Party (ElectionID, PartyID, PartyName, PartyLeader, LeaderPicture, PartySlogan, EstablishedYear, PartyLogo, TotalCandidates)
                    VALUES (@ElectionID, @PartyID, @PartyName, @PartyLeader, @LeaderPicture, @PartySlogan, @EstablishedYear, @PartyLogo, @TotalCandidates)";
                using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                {
                    insertCommand.Parameters.AddWithValue("@ElectionID", electionId);
                    insertCommand.Parameters.AddWithValue("@PartyID", partyId);
                    insertCommand.Parameters.AddWithValue("@PartyName", partyName);
                    insertCommand.Parameters.AddWithValue("@PartyLeader", partyLeader);
                    insertCommand.Parameters.AddWithValue("@LeaderPicture", "~/Uploads/" + leaderPictureFileName);
                    insertCommand.Parameters.AddWithValue("@PartySlogan", partySlogan);
                    insertCommand.Parameters.AddWithValue("@EstablishedYear", establishedYear);
                    insertCommand.Parameters.AddWithValue("@PartyLogo", "~/Uploads/" + partyLogoFileName);
                    insertCommand.Parameters.AddWithValue("@TotalCandidates", totalCandidates);

                    insertCommand.ExecuteNonQuery();
                }
            }

            context.Response.ContentType = "text/plain";
            context.Response.Write("Party data saved successfully.");
        }
        catch (Exception ex)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Error: " + ex.Message);
        }
    }

    public bool IsReusable
    {
        get { return false; }
    }
}
