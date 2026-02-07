using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Candidates : System.Web.UI.Page
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

            DropDownList1.DataBind();
            // Add a default "Select The Election" option to the dropdown
            DropDownList1.Items.Insert(0, new ListItem("Select The Election", ""));
            // Initial GridView population
            BindGrid();

        }
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Rebind the GridView with updated data based on the selected ElectionID
        BindGrid();
    }



    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Get the selected row
        GridViewRow selectedRow = GridView1.SelectedRow;

        // Example: Fetch data from the selected row
        string partyId = selectedRow.Cells[1].Text; // First column (Party ID)
        string electionId = selectedRow.Cells[2].Text; // Second column (Election ID)

        // Display the CRUD buttons (Add, Update, View, Cancel)
        CrudButtons.Visible = true;  // Show the CrudButtons panel

        // Perform your logic here
        Response.Write("Selected Party ID: " + partyId + ", Election ID: " + electionId);
    }


             protected void BindGrid()
             {
                 string selectedElectionID = DropDownList1.SelectedValue;

                 if (!string.IsNullOrEmpty(selectedElectionID))
                 {
                     string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

                     using (SqlConnection con = new SqlConnection(connectionString))
                     {
                         string query = "SELECT PartyId, ElectionId, PartyName, TotalCandidates, PartyLeader FROM Party WHERE ElectionID = @ElectionID";
                         SqlCommand command = new SqlCommand(query, con);
                         command.Parameters.AddWithValue("@ElectionID", selectedElectionID);

                         con.Open();

                         SqlDataAdapter adapter = new SqlDataAdapter(command);
                         DataTable dataTable = new DataTable();
                         adapter.Fill(dataTable);

                         GridView1.DataSource = dataTable;
                         GridView1.DataBind();
                     }
                 }
                 else
                 {
                     GridView1.DataSource = null;
                     GridView1.DataBind();
                 }
             }


             protected void Button1_Click(object sender, EventArgs e)
             {
                 // Get the selected row from the GridView
                 GridViewRow selectedRow = GridView1.SelectedRow;

                 if (selectedRow != null)
                 {
                     // Store relevant fields in session variables
                     Session["PartyId"] = selectedRow.Cells[1].Text; // Party ID
                     Session["ElectionId"] = selectedRow.Cells[2].Text; // Election ID
                     Session["PartyName"] = selectedRow.Cells[3].Text; // Party Name
                     Session["TotalCandidates"] = selectedRow.Cells[4].Text; // Total Candidates
                     Session["PartyLeader"] = selectedRow.Cells[5].Text; // Party Leader

                     // Redirect to the AddCandidates.aspx page
                     Response.Redirect("AddCandidates.aspx");
                 }
                 else
                 {
                     // Optionally, you can show an alert or message if no row is selected
                     // For example, using JavaScript:
                     ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a row to add candidates.');", true);
                 }
             }

             protected void Button2_Click(object sender, EventArgs e)
             {

                 // Get the selected row from the GridView
                 GridViewRow selectedRow = GridView1.SelectedRow;

                 if (selectedRow != null)
                 {
                     // Store relevant fields in session variables
                     Session["PartyId"] = selectedRow.Cells[1].Text; // Party ID
                     Session["ElectionId"] = selectedRow.Cells[2].Text; // Election ID
                     Session["PartyName"] = selectedRow.Cells[3].Text; // Party Name
                     Session["TotalCandidates"] = selectedRow.Cells[4].Text; // Total Candidates
                     Session["PartyLeader"] = selectedRow.Cells[5].Text; // Party Leader

                     // Redirect to the AddCandidates.aspx page
                     Response.Redirect("UpdateCandidate.aspx");
                 }
                 else
                 {
                     // Optionally, you can show an alert or message if no row is selected
                     // For example, using JavaScript:
                     ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a row to add candidates.');", true);
                 }
             }


             protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
             {
                 // Clear the selected index of the GridView
                 GridView1.SelectedIndex = -1;

                 // Hide CRUD buttons
                 CrudButtons.Visible = false;
             }
             protected void Button4_Click(object sender, EventArgs e)
             {
                 // Clear the selected index of the GridView when "Cancel" is clicked
                 GridView1.SelectedIndex = -1;

                 // Hide CRUD buttons
                 CrudButtons.Visible = false;
             }

}
