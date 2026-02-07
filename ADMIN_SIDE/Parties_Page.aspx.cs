using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Parties_Page : System.Web.UI.Page
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

            // Optionally, you can initialize buttons' visibility here
            CrudButtons.Visible = false; // Initially hide buttons

            try
            {
                string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string q1 = "SELECT * FROM Election";

                    SqlCommand cmd = new SqlCommand(q1, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        Label1.Text = "There is no election.";
                        Label1.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        GridView1.DataBind();
                    }
                }
            }
            catch (SqlException ex)
            {
                // Log error on server side (example: log to file or database)
                Label1.Text = "An error occurred while loading data. Please try again later.";
            }
        }
    }


    // Event handler for GridView selection change
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Get the ElectionID of the selected row
        string electionId = GridView1.SelectedDataKey["ElectionID"].ToString();
        int totalParties =Convert.ToInt32(GridView1.SelectedDataKey["TotalParties"]);


        // Store the ElectionID in the session for future use
        Session["SelectedElectionID"] = electionId;
        Session["TotalParties"] = totalParties;

        // Display the CRUD buttons (Add, Update, View, Cancel)
        CrudButtons.Visible = true;  // Show the CrudButtons panel
    }

    // Add Party Data button click
    protected void btnAddParty_Click(object sender, EventArgs e)
    {
        // Check if the session variables are set
        if (Session["SelectedElectionID"] != null && Session["TotalParties"] != null)
        {
            // Retrieve the ElectionID and TotalParties from session variables
            string electionId = Session["SelectedElectionID"].ToString();
            int totalParties = Convert.ToInt32(Session["TotalParties"]);

            // You can now use electionId and totalParties as needed
            // For example, you might want to add a new party to the database here

            // Redirect to AddParties.aspx
            Response.Redirect("AddParties.aspx");
        }
        else
        {
            // Handle the case where session variables are not set
            Response.Write("Error: Election ID or Total Parties not set in session.");
        }
    }


    // On Button Click: Redirect to UpdateParties
    protected void btnUpdateParty_Click(object sender, EventArgs e)
    {
        if (Session["SelectedElectionID"] != null && Session["TotalParties"] != null)
        {
            string electionId = Session["SelectedElectionID"].ToString();
            int totalParties = Convert.ToInt32(Session["TotalParties"]);

            // Log or validate further if needed

            // Redirect to UpdateParties.aspx
            Response.Redirect("UpdateParties.aspx");
        }
        else
        {
            // Error handling: redirect back or show a proper message
            Response.Write("<script>alert('Error: Missing election information. Please select an election.'); window.location='select_election.aspx';</script>");
        }
    }


    // View Party Data button click
    protected void btnViewParty_Click(object sender, EventArgs e)
    {
        if (Session["SelectedElectionID"] != null && Session["TotalParties"] != null)
        {
            string electionId = Session["SelectedElectionID"].ToString();
            int totalParties = Convert.ToInt32(Session["TotalParties"]);

            // Log or validate further if needed

            // Redirect to UpdateParties.aspx
            Response.Redirect("ViewParties.aspx");
        }
        else
        {
            // Error handling: redirect back or show a proper message
            Response.Write("<script>alert('Error: Missing election information. Please select an election.'); window.location='select_election.aspx';</script>");
        }
    }

    // Cancel button click
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        // Clear the session that stores the selected ElectionID
        Session["SelectedElectionID"] = null;

        // Unselect the currently selected row in the GridView
        GridView1.SelectedIndex = -1;

        // Hide the CRUD buttons panel
        CrudButtons.Visible = false;
    }


 
}