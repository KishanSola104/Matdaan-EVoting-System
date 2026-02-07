using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class AddVoters : System.Web.UI.Page
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



            string selectedState = Session["SelectedState"] as string;
            string selectedDistrict = Session["SelectedDistrict"] as string;

            txtState.Text = selectedState;
            txtDistrict.Text = selectedDistrict;

            // Populate Day dropdown (1 to 31)
            for (int i = 1; i <= 31; i++)
            {
                ddlDay.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            // Populate Month dropdown (1 to 12)
            for (int i = 1; i <= 12; i++)
            {
                ddlMonth.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            // Populate Year dropdown (from 1900 to current year)
            for (int i = 1900; i <= DateTime.Now.Year; i++)
            {
                ddlYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }


        }

    }


 
// Submit Button Click
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            // Validate the form
            if (Page.IsValid)
            {
                // Retrieve values from the form
                string aadharID = txtAadharID.Text.Trim();
                string voterID = txtVoterID.Text.Trim();
                string name = txtName.Text.Trim();
                string day = ddlDay.SelectedValue;
                string month = ddlMonth.SelectedValue;
                string year = ddlYear.SelectedValue;
                string dob = year + "-" + month + "-" + day;
                string gender = ddlGender.SelectedValue;
                string state = txtState.Text.Trim();
                string district = txtDistrict.Text.Trim();

                string imagePath = "";
                if (fileUploadImage.HasFile)
                {
                    string folderPath = Server.MapPath("~/UserPictures/");
                    string fileName = voterID + "_" + fileUploadImage.FileName;
                    imagePath = "~/UserPictures/" + fileName;

                    // Ensure the directory exists
                    if (!System.IO.Directory.Exists(folderPath))
                    {
                        System.IO.Directory.CreateDirectory(folderPath);
                    }

                    // Save the uploaded file
                    fileUploadImage.SaveAs(folderPath + fileName);
                }

                // Insert the data into the database
                string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True"; // Define connection string


                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Voters (AadharID, VoterID, Name, DOB, Gender, State, District, Image) " +
                                   "VALUES (@AadharID, @VoterID, @Name, @DOB, @Gender, @State, @District, @Image)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@AadharID", aadharID);
                        cmd.Parameters.AddWithValue("@VoterID", voterID);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@DOB", dob);
                        cmd.Parameters.AddWithValue("@Gender", gender);
                        cmd.Parameters.AddWithValue("@State", state);
                        cmd.Parameters.AddWithValue("@District", district);
                        cmd.Parameters.AddWithValue("@Image", imagePath);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }

                Label1.Text = "Voter information added successfully!";
                Label1.ForeColor = System.Drawing.Color.Green;
            }
        }
        catch (SqlException ex)
        {
            Label1.Text = "Error In Inserting is "+ex.Message;
            Label1.ForeColor = System.Drawing.Color.Red;
        }
    }

    // Cancel Button Click
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        // Clear the form fields but keep the state and district
        txtAadharID.Text = string.Empty;
        txtVoterID.Text = string.Empty;
        txtName.Text = string.Empty;
        ddlDay.SelectedIndex = 0;
        ddlMonth.SelectedIndex = 0;
        ddlYear.SelectedIndex = 0;
        ddlGender.SelectedIndex = 0;
    }
    
   
}