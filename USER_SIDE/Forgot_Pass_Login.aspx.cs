using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

public partial class Forgot_Pass_Login:Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    private bool VerifyPassword(string enteredPassword, string storedHashedPassword)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] enteredPasswordBytes = Encoding.UTF8.GetBytes(enteredPassword);
            byte[] hashBytes = sha256.ComputeHash(enteredPasswordBytes);

            StringBuilder hashStringBuilder = new StringBuilder();
            foreach (byte b in hashBytes)
            {
                hashStringBuilder.Append(b.ToString("x2"));
            }

            string enteredHashedPassword = hashStringBuilder.ToString();
            return enteredHashedPassword.Equals(storedHashedPassword, StringComparison.OrdinalIgnoreCase);
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(voterID.Text) && !string.IsNullOrEmpty(password.Text))
        {
            string enteredVoterID = voterID.Text.Trim();
            string enteredPassword = password.Text;

            try
            {
                string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT Password FROM Users WHERE VoterID = @VoterID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.Add("@VoterID", SqlDbType.VarChar).Value = enteredVoterID;
                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            string storedHashedPassword = result.ToString();
                            if (VerifyPassword(enteredPassword, storedHashedPassword))
                            {
                                Session["VoterID"] = enteredVoterID;
                                Response.Redirect("UserDashboard.aspx");
                            }
                            else
                            {
                                lblmsg.Visible = true;
                                lblmsg.Text = "Invalid Voter ID or Password.";
                            }
                        }
                        else
                        {
                            lblmsg.Visible = true;
                            lblmsg.Text = "User not found.";
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                lblmsg.Visible = true;
                lblmsg.Text = "An error occurred. Please try again later." + "SQL Error: " + ex.Message;
                System.Diagnostics.Debug.WriteLine("SQL Error: " + ex.Message);
            }
        }
        else
        {
            lblmsg.Visible = true;
            lblmsg.Text = "Please enter both required fields.";
        }
    }
}
