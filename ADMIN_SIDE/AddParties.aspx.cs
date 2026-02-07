using System;
using System.Data.SqlClient;
using System.IO;
using System.Web;

public partial class AddParties : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Ensure AdminID session variable exists; if not, redirect to login
            if (Session["AdminID"] == null)
            {
                Response.Redirect("admin_login.aspx");
                return;
            }

            // Ensure necessary session variables are initialized
            string adminName = Session["AdminName"] as string ?? "Admin";
            string adminImage = Session["AdminImage"] as string ?? "default.jpg";
            AdminName.InnerText = adminName;
            ProfilePic.Src = adminImage;

            // Handle ElectionID session variable
            if (Session["SelectedElectionID"] == null)
            {
                Response.Write("<script>alert('Election ID is missing. Please select an election.'); window.location='select_election.aspx';</script>");
                return;
            }
            string electionID = Session["SelectedElectionID"].ToString();

            // Handle TotalParties session variable
            if (Session["TotalParties"] == null)
            {
                Response.Write("<script>alert('Total Parties count is missing. Please try again.'); window.location='select_election.aspx';</script>");
                return;
            }
            int totalParties = Convert.ToInt32(Session["TotalParties"]);

            // Pass values to JavaScript for dynamic form generation
            ElectionIDHiddenField.Value = electionID;
            TotalPartiesHiddenField.Value = totalParties.ToString();
        }
    }
}
