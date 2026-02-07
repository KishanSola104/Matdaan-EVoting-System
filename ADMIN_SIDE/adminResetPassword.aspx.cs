using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

public partial class adminResetPassword : System.Web.UI.Page
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
            ProfilePic.Src = adminImage;
        }
    }

    protected void btnResetPassword_Click1(object sender, EventArgs e)
    {
        if (txtCurrentPassword.Text != "" && txtNewPassword.Text != "" && txtConfirmPassword.Text != "")
        {
            string currentPassword = txtCurrentPassword.Text;
            string newPassword = txtNewPassword.Text;
            string adminName = Session["AdminName"] as string;

            if (string.IsNullOrEmpty(adminName))
            {
                // Display an error if admin is not properly logged in
                lblMessage.Text = "Error: Admin session not found.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Verify if the current password is correct
            if (!IsCurrentPasswordValid(adminName, currentPassword))
            {
                lblMessage.Text = "The current password is incorrect.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Hash the new password
            string hashedNewPassword = HashPassword(newPassword);

            // Update the password in the database
            if (UpdatePassword(adminName, hashedNewPassword))
            {
                lblMessage.Text = "Password successfully updated!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMessage.Text = "Failed to update password. Please try again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblMessage.Text = "Fill Up The Requierd Fields.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
    private bool IsCurrentPasswordValid(string adminName, string currentPassword)
    {
        string hashedPassword = HashPassword(currentPassword);

        using (SqlConnection conn = new SqlConnection(@"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True"))
        {
            string query = "SELECT COUNT(1) FROM Admins WHERE AdminName = @AdminName AND AdminPassword = @Password";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@AdminName", adminName);
            cmd.Parameters.AddWithValue("@Password", hashedPassword);

            conn.Open();
            int count = (int)cmd.ExecuteScalar();
            conn.Close();

            return count == 1;
        }
    }

    private bool UpdatePassword(string adminName, string hashedNewPassword)
    {
        using (SqlConnection conn = new SqlConnection(@"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True"))
        {
            string query = "UPDATE Admins SET AdminPassword = @NewPassword WHERE AdminName = @AdminName";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@AdminName", adminName);
            cmd.Parameters.AddWithValue("@NewPassword", hashedNewPassword);

            conn.Open();
            int rowsAffected = cmd.ExecuteNonQuery();
            conn.Close();

            return rowsAffected > 0;
        }
    }

    private string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder builder = new StringBuilder();
            foreach (byte b in bytes)
            {
                builder.Append(b.ToString("x2"));
            }
            return builder.ToString();
        }
    }
}
