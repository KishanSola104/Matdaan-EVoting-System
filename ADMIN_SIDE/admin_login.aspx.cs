using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

public partial class admin_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Clear the session on login page load
        Session.Clear();
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string inputEmail = txtEmail.Text.Trim();
        string inputPassword = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(inputEmail) || string.IsNullOrEmpty(inputPassword))
        {
            lblMessage.Text = "Please enter both email/username and password.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Visible = true;
            return;
        }

        string hashedPassword = HashPassword(inputPassword);

        // Validate credentials and get admin details
        var adminDetails = GetAdminDetails(inputEmail, hashedPassword);
        if (adminDetails != null)
        {
            // Set session variables
            Session["AdminID"] = inputEmail;
            Session["AdminName"] = adminDetails.Item1;  // Admin's name
            Session["AdminImage"] = adminDetails.Item2; // Admin's image URL

            Response.Redirect("adminDashboard.aspx");
        }
        else
        {
            lblMessage.Text = "Invalid email/username or password.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Visible = true;
        }
    }

    // Method to validate login and retrieve admin details
    private Tuple<string, string> GetAdminDetails(string emailOrUsername, string password)
    {
        string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";
        string query = "SELECT AdminName, AdminImage FROM Admins WHERE (AdminEmail = @EmailOrUsername OR AdminName = @EmailOrUsername) AND AdminPassword = @Password";

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@EmailOrUsername", emailOrUsername);
                cmd.Parameters.AddWithValue("@Password", password);

                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string adminName = reader["AdminName"].ToString();
                        string adminImage = reader["AdminImage"].ToString();
                        return Tuple.Create(adminName, adminImage);
                    }
                }
            }
        }
        return null;
    }


    private bool ValidateAdmin(string emailOrUsername, string password)
    {
        string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";
        string selectQuery = "SELECT AdminPassword FROM Admins WHERE AdminEmail = @EmailOrUsername OR AdminName = @EmailOrUsername";

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            try
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(selectQuery, con))
                {
                    cmd.Parameters.AddWithValue("@EmailOrUsername", emailOrUsername);
                    var result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        string storedHashedPassword = result.ToString();
                        return storedHashedPassword == password;
                    }
                    return false;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
                return false;
            }
        }
    }

    private string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder sb = new StringBuilder();
            foreach (byte b in hashBytes)
            {
                sb.Append(b.ToString("X2"));
            }
            return sb.ToString();
        }
    }
}
