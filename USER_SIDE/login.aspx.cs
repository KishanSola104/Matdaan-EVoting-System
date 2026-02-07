using System;
using System.Data.SqlClient;
using System.Web.UI;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblmsg.Visible = false; // Hide message on initial load
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtEmail.Text) && !string.IsNullOrEmpty(txtPassword.Text))
        {
            string enteredEmail = txtEmail.Text.Trim().ToLower();
            string enteredPassword = txtPassword.Text.Trim();

            // Admin login check
            if ((enteredEmail == "kishan" && enteredPassword == "22bca104") ||
                (enteredEmail == "manav" && enteredPassword == "22bca117"))
            {
                Response.Redirect("/Final_year_project/ADMIN_SIDE/AdminLoginVerification.aspx");
                return;
            }

            try
            {
                // Database connection string
                string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Fetch user password from database
                    string query = "SELECT Password FROM Users WHERE VoterID = @VoterID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@VoterID", enteredEmail);

                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            string storedPassword = result.ToString();

                            if (enteredPassword == storedPassword) // Direct password comparison
                            {
                                // Store Voter ID in session
                                Session["VoterID"] = enteredEmail;

                                // Redirect to User Dashboard
                                Response.Redirect("UserDashboard.aspx");
                            }
                            else
                            {
                                ShowMessage("Invalid Voter ID or Password.", System.Drawing.Color.Red);
                            }
                        }
                        else
                        {
                            ShowMessage("User not found.", System.Drawing.Color.Red);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred while processing your request. Please try again later.", System.Drawing.Color.Red);
                // Log the exception (optional)
                // Example: LogException(ex);
            }
        }
        else
        {
            ShowMessage("Please Enter Both Required Fields", System.Drawing.Color.Red);
        }
    }

    private void ShowMessage(string message, System.Drawing.Color color)
    {
        lblmsg.Visible = true;
        lblmsg.Text = message;
        lblmsg.ForeColor = color;
        lblmsg.Font.Bold = true;
    }

    protected void new_acc_Click(object sender, EventArgs e)
    {
        Response.Redirect("/Final_year_project/USER_SIDE/UserVerification.aspx");
    }
}
