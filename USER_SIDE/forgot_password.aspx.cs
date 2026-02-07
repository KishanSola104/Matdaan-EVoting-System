using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;


public partial class forgot_password : System.Web.UI.Page
{
    private readonly string _connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        lblmsg.Visible = false;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Forgot_Pass_Login.aspx");
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string voterId = txtEmailOrMobile.Text.Trim();

        if (string.IsNullOrEmpty(voterId))
        {
            ShowMessage("Please enter a valid Voter ID.", System.Drawing.Color.Red);
            return;
        }

        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            const string query = "SELECT COUNT(*) FROM Users WHERE VoterID = @VoterID";

            try
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@VoterID", voterId);
                    int count = (int)cmd.ExecuteScalar();

                    if (count > 0)
                    {
                        Session["VoterID"] = voterId;
                        Response.Redirect("AllowsResetPassword.aspx");
                    }
                    else
                    {
                        ShowMessage("Voter ID not found. Please check and try again.", System.Drawing.Color.Red);
                    }
                }
            }
            catch (Exception)
            {
                ShowMessage("An error occurred. Please try again later.", System.Drawing.Color.Red);
            }
        }
    }

    private bool VerifyPassword(string enteredPassword, string storedHashedPassword)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] enteredPasswordBytes = Encoding.UTF8.GetBytes(enteredPassword);
            byte[] hashBytes = sha256.ComputeHash(enteredPasswordBytes);
            string enteredHashedPassword = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();

            return enteredHashedPassword.Equals(storedHashedPassword, StringComparison.OrdinalIgnoreCase);
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string voterId = txtEmailOrPhone.Text.Trim();
        string enteredPassword = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(voterId) || string.IsNullOrEmpty(enteredPassword))
        {
            ShowMessage("Please enter both fields.", System.Drawing.Color.Red);
            return;
        }

        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            const string query = "SELECT Password FROM Users WHERE VoterID = @VoterID";

            try
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@VoterID", voterId);
                    object result = cmd.ExecuteScalar();

                    if (result != null && VerifyPassword(enteredPassword, result.ToString()))
                    {
                        Session["VoterID"] = voterId;
                        Response.Redirect("UserDashboard.aspx");
                    }
                    else
                    {
                        ShowMessage("Invalid Voter ID or Password.", System.Drawing.Color.Red);
                    }
                }
            }
            catch (Exception)
            {
                ShowMessage("An error occurred while processing your request. Please try again later.", System.Drawing.Color.Red);
            }
        }
    }

    private void ShowMessage(string message, System.Drawing.Color color)
    {
        lblmsg.Visible = true;
        lblmsg.Text = message;
        lblmsg.ForeColor = color;
    }
}