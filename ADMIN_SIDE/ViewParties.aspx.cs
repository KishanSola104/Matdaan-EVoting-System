using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class ViewParties : System.Web.UI.Page
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

            // Load the ElectionID from session
            if (Session["SelectedElectionID"] == null)
            {
                Response.Redirect("select_election.aspx");
                return;
            }

            string electionId = Session["SelectedElectionID"].ToString();

            // Load Party dropdown
            LoadPartyDropdown(electionId);

            // Populate Established Year Dropdown
            PopulateEstablishedYearDropdown();
        }
    }

    private void PopulateEstablishedYearDropdown()
    {
        for (int year = 2024; year >= 1949; year--)
        {
            txtEstablishedYear.Items.Add(new ListItem(year.ToString(), year.ToString()));
        }
    }

    private void LoadPartyDropdown(string electionId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True"))
            {
                string query = "SELECT PartyID, PartyName FROM Party WHERE ElectionID = @ElectionID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ElectionID", electionId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    ddlParty.DataSource = reader;
                    ddlParty.DataTextField = "PartyName";
                    ddlParty.DataValueField = "PartyID";
                    ddlParty.DataBind();

                    ddlParty.Items.Insert(0, new ListItem("-- Select Party --", ""));
                }
                else
                {
                    ddlParty.Items.Clear();
                    ddlParty.Items.Add(new ListItem("No parties available for this election.", ""));
                }

                con.Close();
            }
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('An error occurred: {ex.Message}');</script>");
        }
    }

    protected void ddlParty_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlParty.SelectedValue))
            return;

        string partyId = ddlParty.SelectedValue;

        try
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True"))
            {
                string query = "SELECT * FROM Party WHERE PartyID = @PartyID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@PartyID", partyId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtPartyName.Text = reader["PartyName"].ToString();
                    txtPartyLeader.Text = reader["PartyLeader"].ToString();
                    txtPartySlogan.Text = reader["PartySlogan"].ToString();
                    txtEstablishedYear.Text = reader["EstablishedYear"].ToString();
                    txtTotalCandidates.Text = reader["TotalCandidates"].ToString(); // New Field

                    imgLeaderPicture.ImageUrl = reader["LeaderPicture"].ToString();
                    imgPartyLogo.ImageUrl = reader["PartyLogo"].ToString();
                }
                con.Close();
            }
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
        }
    }

  
    protected void Button1_Click(object sender, EventArgs e)
    {
        // Reset the dropdown to its default value
        ddlParty.SelectedIndex = 0;

        // Clear the text fields
        txtPartyName.Text = string.Empty;
        txtPartyLeader.Text = string.Empty;
        txtPartySlogan.Text = string.Empty;
        txtTotalCandidates.Text = string.Empty; // New Field Reset

        // Reset the Established Year dropdown to the default value
        txtEstablishedYear.SelectedIndex = 0;

        // Clear uploaded images (if applicable)
        imgLeaderPicture.ImageUrl = string.Empty;
        imgPartyLogo.ImageUrl = string.Empty;
    }
}