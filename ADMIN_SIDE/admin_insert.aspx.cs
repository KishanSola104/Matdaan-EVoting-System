using System;
using System.Data.SqlClient;
using System.Text;
using System.Security.Cryptography;

public partial class admin_insert : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Leave this empty if no action is needed on page load
    }

    // Button click handler to insert admin info into the database
    protected void btnInsertAdmin_Click(object sender, EventArgs e)
    {
        // Get the values from the form
        string adminUsername = txtAdminUsername.Text.Trim();
        string adminEmail = txtAdminEmail.Text.Trim();
        string adminPassword = txtAdminPassword.Text.Trim();
        string adminMobile = txtAdminMobile.Text.Trim();
        string adminGender = ddlAdminGender.SelectedValue;
        string adminAddress = txtAdminAddress.Text.Trim();
        DateTime adminBirthdate;
        string adminImage = txtAdminImage.Text.Trim();

        // Check if the fields are not empty
        if (string.IsNullOrEmpty(adminUsername) || string.IsNullOrEmpty(adminEmail) || string.IsNullOrEmpty(adminPassword) ||
            string.IsNullOrEmpty(adminMobile) || string.IsNullOrEmpty(adminGender) || string.IsNullOrEmpty(adminAddress) ||
            !DateTime.TryParse(txtAdminBirthdate.Text, out adminBirthdate) || string.IsNullOrEmpty(adminImage))
        {
            Response.Write("<script>alert('Please fill in all fields correctly.');</script>");
            return;
        }

        // Hash the password
        string hashedPassword = HashPassword(adminPassword);

        // Insert the data into the database
        bool isInserted = InsertAdmin(adminUsername, adminEmail, hashedPassword, adminMobile, adminGender, adminAddress, adminBirthdate,adminImage);

        if (isInserted)
        {
            Response.Write("<script>alert('Admin inserted successfully.');</script>");
            ClearFields();
        }
        else
        {
            Response.Write("<script>alert('An error occurred while inserting the admin.');</script>");
        }
    }

    // Function to insert the admin into the database
    private bool InsertAdmin(string username, string email, string hashedPassword, string mobile, string gender, string address, DateTime birthdate , string image)
    {
        string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";
        string insertQuery = "INSERT INTO Admins (AdminName, AdminEmail, AdminPassword, AdminMobile, AdminGender, AdminAddress, AdminBirthdate,AdminImage) " +
                             "VALUES (@Username, @Email, @Password, @Mobile, @Gender, @Address, @Birthdate,@Image)";

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            try
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@Address", address);
                    cmd.Parameters.AddWithValue("@Birthdate", birthdate);
                    cmd.Parameters.AddWithValue("@Image", image);

                    cmd.ExecuteNonQuery();
                }
                return true;
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
                return false;
            }
        }
    }

    // Function to hash the password using SHA-256
    private string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder sb = new StringBuilder();
            foreach (byte b in hashBytes)
            {
                sb.Append(b.ToString("X2"));  // Convert byte array to hexadecimal string
            }
            return sb.ToString();
        }
    }

    // Function to clear all input fields
    private void ClearFields()
    {
        txtAdminUsername.Text = "";
        txtAdminEmail.Text = "";
        txtAdminPassword.Text = "";
        txtAdminMobile.Text = "";
        ddlAdminGender.SelectedIndex = 0;
        txtAdminAddress.Text = "";
        txtAdminBirthdate.Text = "";
        txtAdminImage.Text = "";
    }
}
