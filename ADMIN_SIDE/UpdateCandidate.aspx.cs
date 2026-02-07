using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


public partial class UpdateCandidate : System.Web.UI.Page
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




            if (Session["PartyId"] != null)
            {
                SqlDataSource1.SelectParameters["PartyId"].DefaultValue = Session["PartyId"].ToString();
            }
            else
            {
                // Redirect to another page if PartyId is not available in the session
                Response.Redirect("ErrorPage.aspx");
            }
        }
    }


    // Event handler for entering edit mode
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        GridView1.DataBind();
    }

    // Event handler for canceling edit mode
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1; // Exit edit mode
        GridView1.DataBind();
    }

    // Event handler for updating a row
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        // Accessing updated values
        GridViewRow row = GridView1.Rows[e.RowIndex];
        string candidateId = GridView1.DataKeys[e.RowIndex].Value.ToString();
        string candidateName = ((TextBox)row.FindControl("txtCandidateName")).Text;
        string state = ((TextBox)row.FindControl("txtState")).Text;
        string district = ((TextBox)row.FindControl("txtDistrict")).Text;
        string dob = ((TextBox)row.FindControl("txtDOB")).Text;
        string gender = ((TextBox)row.FindControl("txtGender")).Text;
        string email = ((TextBox)row.FindControl("txtEmail")).Text;
        string mobile = ((TextBox)row.FindControl("txtMobile")).Text;

        // Updating the data using SqlDataSource
        SqlDataSource1.UpdateParameters["CandidateId"].DefaultValue = candidateId;
        SqlDataSource1.UpdateParameters["CandidateName"].DefaultValue = candidateName;
        SqlDataSource1.UpdateParameters["State"].DefaultValue = state;
        SqlDataSource1.UpdateParameters["District"].DefaultValue = district;
        SqlDataSource1.UpdateParameters["DOB"].DefaultValue = dob;
        SqlDataSource1.UpdateParameters["Gender"].DefaultValue = gender;
        SqlDataSource1.UpdateParameters["Email"].DefaultValue = email;
        SqlDataSource1.UpdateParameters["Mobile"].DefaultValue = mobile;

        SqlDataSource1.Update();

        GridView1.EditIndex = -1; // Exit edit mode
        GridView1.DataBind();
    }

    // Event handler for deleting a row
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string candidateId = GridView1.DataKeys[e.RowIndex].Value.ToString();
        SqlDataSource1.DeleteParameters["CandidateId"].DefaultValue = candidateId;
        SqlDataSource1.Delete();

        GridView1.DataBind();
    }
   
}